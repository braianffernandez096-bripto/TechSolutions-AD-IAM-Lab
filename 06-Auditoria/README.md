# 🔍 06 — Auditoría

Dos sistemas de auditoría independientes, configurados sobre GPO + SACL (System Access Control List): auditoría de archivos (quién toca qué en las carpetas compartidas) y auditoría de objetos de Active Directory (quién crea, modifica o elimina usuarios, grupos y equipos).

---

## 1️⃣ Auditoría de archivos

**GPO:** Configuración del equipo → Configuración de directivas de auditoría avanzada → Acceso a objetos → *"Sistema de archivos"* → Correcto y Erróneo.

**SACL:** en cada una de las 8 carpetas de `C:\Compartidos`, entrada de auditoría para "Todos", tipo "Todo", con Control total — para capturar tanto accesos legítimos como intentos denegados.

**Event IDs relevantes:**

| ID | Significado |
|---|---|
| 4663 | Se intentó tener acceso a un objeto |
| 4660 | Se eliminó un objeto |

---

## 2️⃣ Auditoría de objetos de Active Directory

Configurada en dos niveles, cada uno cubriendo un tipo de evento distinto.

### 🔹 Nivel 1 — Directory Service Changes (SACL directo sobre las OUs)

Configurado en las 13 OUs del dominio, con permisos ajustados según el tipo de objeto que contiene cada una (Usuario, Grupo o Equipo):

| OU | Tipo de objeto | Permisos auditados |
|---|---|---|
| Departamentos (01-08) | Usuario | Crear/Eliminar Usuario objetos, Escribir todas las propiedades, Eliminar, Eliminar subárbol, Modificar permisos |
| `09_Equipos`, `10_Servidores` | Equipo | Crear/Eliminar Equipo objetos, Escribir todas las propiedades, Eliminar, Eliminar subárbol, Modificar permisos |
| `11_Grupos` | Grupo | Crear/Eliminar Grupo objetos, **Escribir todas las propiedades** (ahí vive la membresía), Eliminar, Eliminar subárbol, Modificar permisos |
| `12_Service_Accounts`, `13_Disabled_Users` | Usuario | Igual que departamentos |

**Event IDs generados (categoría "Acceso de DS"):**

| ID | Significado | Validado en |
|---|---|---|
| 5136 | Se modificó un valor del objeto | Caso 3 — Leaver |
| 5137 | Se creó un objeto del servicio de directorio | — |
| 5141 | Se eliminó un objeto del servicio de directorio | Caso 6 — Disable/Delete User |

### 🔹 Nivel 2 — Account Management (GPO adicional, eventos legibles)

Subcategorías habilitadas en Configuración de directivas de auditoría avanzada → Administración de cuentas:

- Auditar la administración de cuentas de usuario
- Auditar la administración de grupos de seguridad

**Event IDs generados:**

| ID | Significado | Validado en |
|---|---|---|
| 4720 | Se creó una cuenta de usuario | Prueba de validación dedicada |
| 4722 | Se habilitó una cuenta de usuario | Prueba de validación dedicada |
| 4724 | Se intentó restablecer una contraseña | Caso 4 — Reset Password |
| 4725 | Se deshabilitó una cuenta de usuario | Prueba de validación dedicada |
| 4726 | Se eliminó una cuenta de usuario | Caso 6 — Disable/Delete User |
| 4728 | Se agregó un miembro a un grupo global | Prueba de validación dedicada |
| 4729 | Se quitó un miembro de un grupo global | Caso 3 — Leaver |
| 4738 | Se modificó una cuenta de usuario | Prueba de validación dedicada |
| 4740 | Se bloqueó una cuenta de usuario | Caso 5 — Unlock Account |
| 4767 | Se desbloqueó una cuenta de usuario | Caso 5 — Unlock Account |

Los IDs marcados como "Prueba de validación dedicada" se comprobaron reutilizando la cuenta `mlopez` para ejercitar el ciclo completo (creación → habilitación → alta en grupo → deshabilitación → modificación) en una sola sesión, específicamente para documentar que la auditoría de Administración de cuentas captura cada uno de estos eventos. No forman parte de la cronología real de los Casos 1, 2 y 3 — esa evidencia vive en la carpeta de cada caso.

---

## ✅ Validación

El sistema de auditoría queda demostrado en funcionamiento de dos formas: los Event IDs marcados con un Caso en la tabla tienen su captura dentro de la carpeta de ese caso, con el detalle de "Sujeto" que identifica quién ejecutó la acción; los marcados como "Prueba de validación dedicada" tienen su propia evidencia acá abajo.

---

## 📸 Evidencias

| # | Captura | Qué muestra |
|---|---|---|
| 1 | [`01-Evento-4720-Cuenta-Creada.png`](01-Evento-4720-Cuenta-Creada.png) | Event ID 4720 — creación de la cuenta `mlopez`, sujeto `TECHSOLUTIONS\Administrador`. |
| 2 | [`02-Evento-4722-Cuenta-Habilitada.png`](02-Evento-4722-Cuenta-Habilitada.png) | Event ID 4722 — habilitación de la cuenta `mlopez`. |
| 3 | [`03-Evento-4728-Alta-en-Grupo.png`](03-Evento-4728-Alta-en-Grupo.png) | Event ID 4728 — alta de `mlopez` como miembro de un grupo global. |
| 4 | [`04-Evento-4725-Cuenta-Deshabilitada.png`](04-Evento-4725-Cuenta-Deshabilitada.png) | Event ID 4725 — deshabilitación de la cuenta `mlopez`. |
| 5 | [`05-Evento-4738-Cuenta-Modificada.png`](05-Evento-4738-Cuenta-Modificada.png) | Event ID 4738 — modificación de la cuenta `mlopez`. |


---

# 🔎 Ampliación: auditoría orientada a detección

Además de la trazabilidad de IAM, se amplió la auditoría para poder detectar actividad sospechosa:

- Advanced Audit Policy completa vía `SEC-DC-Auditoria-Avanzada` (ver [`05-Group-Policy`](../05-Group-Policy/politicas.md)).
- SACL en la raíz del dominio para derechos extendidos de replicación.
- **Sysmon 15.22** con configuración SwiftOnSecurity v74 en DC01 y en Windows 10.

| Event ID | Qué registra | Para qué sirve |
|---|---|---|
| 4768 | TGT solicitado | `PreAuthType 0` indica una cuenta sin preautenticación |
| 4769 | Ticket de servicio | Cifrado `0x17` (RC4) es una señal de alerta |
| 4625 / 4776 / 4771 | Fallos de autenticación | Muchos usuarios distintos desde una IP = spraying |
| 4624 (tipo 3) | Logon de red | Correlación con los fallos |
| 4738 | Cuenta modificada | Cambios de flags (UAC) |
| 4662 | Acceso a objeto de directorio | GUIDs de replicación desde una cuenta que no es `$` |
| 5136 | Atributo de directorio modificado | Cambios en `nTSecurityDescriptor` de la raíz |
| Sysmon 1 / 3 / 22 | Proceso / red / DNS | Telemetría de endpoint |

**Limitaciones observadas:** con la configuración SwiftOnSecurity, Sysmon no ve tráfico SMB (lo maneja el proceso System) ni el tráfico LLMNR; en esos casos se prioriza la prevención por GPO y el log de seguridad.

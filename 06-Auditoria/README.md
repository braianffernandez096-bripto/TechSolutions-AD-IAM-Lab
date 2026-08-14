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
| 4720 | Se creó una cuenta de usuario | — |
| 4722 | Se habilitó una cuenta de usuario | — |
| 4724 | Se intentó restablecer una contraseña | Caso 4 — Reset Password |
| 4725 | Se deshabilitó una cuenta de usuario | — |
| 4726 | Se eliminó una cuenta de usuario | Caso 6 — Disable/Delete User |
| 4728 | Se agregó un miembro a un grupo global | — |
| 4729 | Se quitó un miembro de un grupo global | Caso 3 — Leaver |
| 4738 | Se modificó una cuenta de usuario | — |
| 4740 | Se bloqueó una cuenta de usuario | Caso 5 — Unlock Account |
| 4767 | Se desbloqueó una cuenta de usuario | Caso 5 — Unlock Account |

Los IDs marcados con "—" están documentados como referencia técnica (comportamiento estándar de Windows con esta configuración), sin una captura propia dentro de los 7 Casos IAM.

---

## ✅ Validación

El sistema de auditoría queda demostrado en funcionamiento por los propios Casos IAM: cada Event ID marcado como "Validado en" arriba tiene su captura del Visor de eventos dentro de la carpeta del caso correspondiente, incluyendo el detalle de "Sujeto" que identifica quién ejecutó la acción — la prueba de que la auditoría captura correctamente tanto la acción como al responsable.

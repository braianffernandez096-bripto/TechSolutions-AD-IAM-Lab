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

Se configuró en dos niveles, cada uno cubriendo un tipo de evento distinto — este fue el punto de mayor aprendizaje del proyecto, documentado abajo.

### 🔹 Nivel 1 — Directory Service Changes (SACL directo sobre las OUs)

Configurado en las 12 OUs del dominio, con permisos ajustados según el tipo de objeto que contiene cada una (Usuario, Grupo o Equipo). Detalle de qué se marcó en cada OU:

| OU | Tipo de objeto | Permisos auditados |
|---|---|---|
| Departamentos (01-08) | Usuario | Crear/Eliminar Usuario objetos, Escribir todas las propiedades, Eliminar, Eliminar subárbol, Modificar permisos |
| `09_Equipos`, `10_Servidores` | Equipo | Crear/Eliminar Equipo objetos, Escribir todas las propiedades, Eliminar, Eliminar subárbol, Modificar permisos |
| `11_Grupos` | Grupo | Crear/Eliminar Grupo objetos, **Escribir todas las propiedades** (crítico: ahí vive la membresía), Eliminar, Eliminar subárbol, Modificar permisos |
| `12_Service_Accounts`, `13_Disabled_Users` | Usuario | Igual que departamentos |

**Event IDs generados (categoría "Acceso de DS"):**

| ID | Significado |
|---|---|
| 5137 | Se creó un objeto del servicio de directorio |
| 5136 | Se modificó un valor del objeto |
| 5141 | Se eliminó un objeto del servicio de directorio |

### 🔹 Nivel 2 — Account Management (GPO adicional, eventos legibles)

Subcategorías habilitadas en Configuración de directivas de auditoría avanzada → Administración de cuentas:

- Auditar la administración de cuentas de usuario
- Auditar la administración de grupos de seguridad

**Event IDs generados:**

| ID | Significado | ¿Confirmado con captura en este proyecto? |
|---|---|---|
| 4720 | Se creó una cuenta de usuario | No — la subcategoría se habilitó después de las altas realizadas |
| 4722 | Se habilitó una cuenta de usuario | No probado — no se ejecutó ningún caso de reactivación de cuenta |
| 4724 | Se intentó restablecer una contraseña | ✅ Sí (Caso 4 — Reset Password) |
| 4725 | Se deshabilitó una cuenta de usuario | ✅ Sí (Caso 3 — Leaver, con una prueba posterior a habilitar la subcategoría) |
| 4726 | Se eliminó una cuenta de usuario | ✅ Sí (Caso 6 — Disable/Delete User) |
| 4728 / 4729 | Miembro agregado / quitado de un grupo global | No — reportado como faltante en el Caso 2, subcategoría habilitada recién después |
| 4738 | Se modificó una cuenta de usuario | No confirmado explícitamente |
| 4740 | Se bloqueó una cuenta de usuario | ✅ Sí (Caso 5 — Unlock Account) |
| 4767 | Se desbloqueó una cuenta de usuario | ✅ Sí (Caso 5 — Unlock Account) |

Los IDs marcados como "No" o "No probado" son correctos como referencia técnica (es el comportamiento documentado de Windows), pero no tienen una captura propia de este proyecto respaldándolos. Si querés evidencia completa de los siete, alcanza con repetir una alta, una habilitación de cuenta y un cambio de grupo ahora que ambas subcategorías de Administración de cuentas ya están activas — a partir de esa fecha, cualquier acción nueva sí las genera.

---

## 🛠️ Lecciones de troubleshooting (vale la pena documentarlas)

Durante la configuración surgieron varios problemas reales, resueltos uno por uno — son justamente el tipo de diagnóstico que se espera de un administrador de IAM:

1. **"No me aparece el 4720/4726" tras habilitar solo Directory Service Changes.** Causa: 4720/4726 pertenecen a la categoría *Account Management*, no a *DS Changes* — son subcategorías independientes de auditoría, cada una con sus propios Event IDs. Solución: habilitar también "Auditar la administración de cuentas de usuario".
2. **"No me aparece el 5141" (eliminación) aunque sí aparecían 5136 y 5137.** Causa: se había marcado *"Eliminar Usuario objetos"* (DeleteChild, un permiso acotado por tipo de objeto), pero el evento 5141 depende del permiso genérico **"Eliminar"** y **"Eliminar subárbol"**, entradas separadas en la misma lista de permisos. Solución: sumar esas dos entradas al SACL.
3. **Eventos no retroactivos.** Una GPO habilitada después de que ocurrió una acción no genera el evento correspondiente en retrospectiva — hay que esperar el ciclo de refresco (o reiniciar el DC) y volver a probar con una acción nueva.
4. **Auditoría diferenciada por sensibilidad.** Se decidió sumar auditoría de lectura (no solo escritura) específicamente en la carpeta y OU de `Direccion`, por tratarse de información más sensible — un ejemplo concreto de auditoría basada en riesgo, no aplicada de forma uniforme sin criterio.

---

## 📸 Evidencias

Ver [`evidencias/`](evidencias/): capturas del Visor de eventos para cada Event ID relevante, incluyendo el detalle de "Sujeto" que identifica quién ejecutó cada acción.

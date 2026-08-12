# 📸 Evidencias — File Server

Esta carpeta contiene las evidencias correspondientes a la implementación del servidor de archivos del laboratorio TechSolutions.

Las capturas documentan la estructura de recursos compartidos, la configuración SMB, los permisos NTFS y la validación del modelo de control de acceso mediante grupos de Active Directory.

---

## 📁 01 — Estructura de recursos compartidos

**Archivo:** [`01-Estructura-Compartidos.png`](01-Estructura-Compartidos.png)

Esta evidencia muestra la estructura de carpetas creada dentro de:

```text
C:\Compartidos
Ciberseguridad
Direccion
Finanzas
IT
Marketing
Operaciones
RRHH
Ventas
```

---

## ⚙️ 02 — Configuración del recurso compartido

**Archivo:** [`02-Configuracion-Compartidos.png`](02-Configuracion-Compartidos.png)

Esta captura muestra la configuración de "Uso compartido avanzado", con "Compartir esta carpeta" habilitado sobre la raíz `Compartidos` y el límite de usuarios simultáneos configurado — el paso previo necesario para que el recurso sea accesible por red antes de aplicar el control de acceso real vía NTFS.

---

## 🔐 03 — Permisos NTFS

**Archivo:** [`03-Permisos-NTFS.png`](03-Permisos-NTFS.png)

Entrada de permiso para la carpeta `IT`, asignada al grupo `DL_IT_RW`: **Modificar** habilitado (con Lectura y ejecución, Mostrar el contenido de la carpeta, Lectura y Escritura marcados automáticamente), y **Control total** explícitamente sin marcar — respetando el principio de mínimo privilegio necesario para el trabajo diario, sin sobre-otorgar permisos. El mismo patrón se replicó de forma idéntica en las 8 carpetas del recurso compartido.

---

## ✅ 04 — Acceso concedido

**Archivo:** [`04-Acceso-Permitido.png`](04-Acceso-Permitido.png)

Acceso vía red a `\\DC01\Compartidos\IT`, confirmando que un usuario con membresía en `DL_IT_RW` (a través de su Grupo Global correspondiente) puede ingresar y visualizar el contenido de la carpeta.

---

## ✏️ 05 — Acceso concedido (escritura)

**Archivo:** [`05-Acceso-Permitido-1.png`](05-Acceso-Permitido-1.png)

Guardado del archivo `Prueba-IT.txt` desde el Bloc de notas, con el contenido "Esto es una prueba." Esta captura es la prueba fuerte de que el permiso otorgado es realmente de escritura y no solo de lectura — completa lo mostrado en la evidencia 04.

---

## 🚫 06 — Acceso denegado

**Archivo:** [`06-Acceso-Denegado.png`](06-Acceso-Denegado.png)

Intento de acceso a `\\DC01\Compartidos\Marketing` desde un usuario sin membresía en `DL_Marketing_RW`. Windows rechaza la conexión con el mensaje "No tiene permiso para obtener acceso a \\DC01\Compartidos\Marketing" — confirma el aislamiento entre carpetas de distintos departamentos, el objetivo central del modelo AGDLP aplicado en este proyecto.

---

## 🗑️ 07 — Prueba de eliminación (borrado de archivo)

**Archivos:** [`07-Eliminación-Solicitada.png`](07-Eliminación-Solicitada.png), [`08-Eliminación-Confirmada.png`](08-Eliminación-Confirmada.png)

Estas dos capturas documentan el borrado del archivo de prueba `Prueba-IT`, completando la validación del permiso **Modificar** otorgado a `DL_IT_RW`: no solo se puede crear y editar (evidencias 04 y 05), también eliminar.

- **[`07-Eliminación-Solicitada.png`](07-Eliminación-Solicitada.png)** — cuadro de confirmación de Windows al eliminar `Prueba-IT` (Documento de texto, 19 bytes, modificado 11/8/2026 19:53).
- **[`08-Eliminación-Confirmada.png`](08-Eliminación-Confirmada.png)** — la carpeta `IT` vacía inmediatamente después, confirmando que la eliminación se ejecutó.

---

## 🌐 08 — Verificación de recursos compartidos activos

**Archivo:** [`09-Recursos-Compartidos-Verificados.png`](09-Recursos-Compartidos-Verificados.png)

Salida de `Get-SmbShare | Format-Table Name, Path, Description` en `DC01`, usada para auditar todos los recursos compartidos activos del servidor. Esta verificación detectó que las 8 carpetas de departamento habían quedado compartidas también de forma individual (además de la raíz `Compartidos`) — un resto de la etapa de configuración inicial, sin impacto en el acceso real gracias al NTFS, pero inconsistente con el diseño documentado de un único punto de entrada. Se corrigió dando de baja los 8 recursos individuales con `Remove-SmbShare`, dejando únicamente `Compartidos` (más los recursos administrativos estándar de Windows/AD: `ADMIN$`, `C$`, `IPC$`, `NETLOGON`, `SYSVOL`).

---

## 📊 Cobertura de validación

| Validación | Evidencia |
|---|---|
| Estructura de carpetas creada | [`01-Estructura-Compartidos.png`](01-Estructura-Compartidos.png) |
| Recurso compartido configurado | [`02-Configuracion-Compartidos.png`](02-Configuracion-Compartidos.png) |
| Permisos NTFS asignados (Modificar, sin Control total) | [`03-Permisos-NTFS.png`](03-Permisos-NTFS.png) |
| Acceso concedido | [`04-Acceso-Permitido.png`](04-Acceso-Permitido.png) |
| Acceso concedido — escritura | [`05-Acceso-Permitido-1.png`](05-Acceso-Permitido-1.png) |
| Acceso denegado a otro departamento | [`06-Acceso-Denegado.png`](06-Acceso-Denegado.png) |
| Acceso concedido — eliminación | [`07-Eliminación-Solicitada.png`](07-Eliminación-Solicitada.png), [`08-Eliminación-Confirmada.png`](08-Eliminación-Confirmada.png) |
| Único punto de entrada verificado (sin shares redundantes) | [`09-Recursos-Compartidos-Verificados.png`](09-Recursos-Compartidos-Verificados.png) |

Cada fila de esta tabla corresponde a una afirmación de [`04-File-Server/README.md`](../README.md) — crear, modificar, eliminar y aislamiento entre departamentos — respaldada con su captura correspondiente, incluyendo la verificación final de que el diseño documentado coincide con la implementación real.

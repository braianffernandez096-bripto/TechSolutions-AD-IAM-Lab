# 🟢 Caso 1 — Joiner (alta de usuario)

**Ticket REQ-001**

| Campo | Detalle |
|---|---|
| Solicitante | Recursos Humanos (Julieta Castro, responsable de Marketing) |
| Vía | Formulario de alta de personal |
| Fecha | 07/08/2026 |
| Descripción | Ingresa María López como Analista de Marketing. Reporta a Julieta Castro. Requiere cuenta de dominio, acceso a la carpeta compartida de Marketing y equipo asignado. |
| Acción solicitada | Alta de usuario en OU `06_Marketing`, asignación al grupo `GG_Marketing`, contraseña temporal con cambio obligatorio en el primer inicio de sesión. |
| Prioridad | Alta (debe estar operativa el día de ingreso) |

---

## 🛠️ Pasos de resolución

1. **Crear el usuario** en la OU `06_Marketing` vía Usuarios y equipos de Active Directory: nombre, apellido, login siguiendo la convención existente.
2. **Contraseña temporal**, con "El usuario debe cambiar la contraseña en el siguiente inicio de sesión" tildado — nunca se deja como definitiva.
3. **Datos organizacionales**: pestaña Organización → Puesto, Departamento, Manager.
4. **Grupo**: pestaña Miembro de → agregar `GG_Marketing`.

---

## 🔄 Corrección durante el proceso

El usuario se creó inicialmente por error en la OU `02_RRHH` en lugar de `06_Marketing`. Se detectó al revisar el DN del objeto y se corrigió moviendo el usuario a la OU correcta — el acceso a la carpeta ya funcionaba igual (depende del grupo `GG_Marketing`, no de la OU), pero la ubicación en el directorio importa para la organización general y para que las GPOs vinculadas por departamento apliquen correctamente.

---

## ✅ Validación

- ✅ Pantalla de "Debe cambiar la contraseña" en el primer inicio de sesión.
- ✅ Acceso concedido a `\\DC01\Compartidos\Marketing`.
- ✅ Acceso denegado a otra carpeta de departamento (ej. Ciberseguridad).

# 📸 Evidencias

| # | Captura | Qué muestra |
|---|---|---|
| 1 | [`01-Ticket-REQ-001.png`](01-Ticket-REQ-001.png) | Ticket REQ-001 tal como llegaría la solicitud. |
| 2 | [`02-Alta-Usuario-Datos-Basicos.png`](02-Alta-Usuario-Datos-Basicos.png) | Asistente "Nuevo objeto: Usuario" — nombre, apellido, login `mlopez`, creado en `techsolutions.local/TechSolutions/06_Marketing`. |
| 3 | [`03-Alta-Usuario-Contrasena-Temporal.png`](03-Alta-Usuario-Contrasena-Temporal.png) | Contraseña temporal con "El usuario debe cambiar la contraseña en el siguiente inicio de sesión" tildado. |
| 4 | [`04-Alta-Usuario-Resumen.png`](04-Alta-Usuario-Resumen.png) | Resumen final del asistente antes de "Finalizar": `mlopez@techsolutions.local`, cambio de contraseña obligatorio. |
| 5 | [`05-Propiedades-Organizacion.png`](05-Propiedades-Organizacion.png) | Pestaña Organización: Puesto "Analista de Marketing", Departamento "Marketing", Administrador "Julieta Castro". |
| 6 | [`06-Propiedades-Miembro-Grupo.png`](06-Propiedades-Miembro-Grupo.png) | Pestaña Miembro de: `GG_Marketing` + `Usuarios del dominio`. |
| 7 | [`07-Primer-Login-Banner.png`](07-Primer-Login-Banner.png) | Banner legal de inicio de sesión, primer contacto de María con el equipo. |
| 8 | [`08-Primer-Login-Credenciales.png`](08-Primer-Login-Credenciales.png) | Pantalla de login con `mlopez` y la contraseña temporal. |
| 9 | [`09-Primer-Login-Cambio-Contrasena-Obligatorio.png`](09-Primer-Login-Cambio-Contrasena-Obligatorio.png) | "Se debe cambiar la contraseña del usuario antes de iniciar sesión" — confirma que el forzado de cambio funcionó en la práctica, no solo en la configuración. |
| 10 | [`10-Acceso-Concedido-Marketing.png`](10-Acceso-Concedido-Marketing.png) | `\\DC01\Compartidos\Marketing` accesible sin error (carpeta vacía, pero navega sin bloqueo). |
| 11 | [`11-Acceso-Denegado-Ciberseguridad.png`](11-Acceso-Denegado-Ciberseguridad.png) | `\\DC01\Compartidos\Ciberseguridad` — "Windows no puede obtener acceso", confirma que el acceso está acotado solo al departamento de María. |

---

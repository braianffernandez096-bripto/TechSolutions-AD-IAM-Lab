# 🟠 Caso 7 — Delegación de permisos

A diferencia de los seis casos anteriores, este no es una acción puntual sobre un usuario — es una configuración de gobernanza que se usa una y otra vez. Es también el tema que más se pregunta en entrevistas de AD, porque separa a quien entiende el principio de **mínimo privilegio** de quien simplemente otorga Admin de Dominio a todo el mundo.

**Ticket REQ-007**

| Campo | Detalle |
|---|---|
| Solicitante | Gerencia de IT |
| Vía | Solicitud de mejora de procesos |
| Fecha | 09/08/2026 |
| Descripción | El equipo de soporte de Nivel 1 (Helpdesk) no puede resolver resets de contraseña ni desbloqueos sin escalar a un Administrador de Dominio. Se solicita delegarles esa capacidad puntual, sin privilegios administrativos completos. |
| Acción solicitada | Delegar el restablecimiento de contraseñas y desbloqueo de cuentas, acotado a tareas comunes, sin acceso a crear/eliminar usuarios ni modificar grupos. |
| Prioridad | Media |

---

## 🛠️ Pasos de resolución

1. **Crear un grupo dedicado** `SG_Delegados_Helpdesk` (nunca delegar directo a una persona — delegar a un grupo permite rotar personal sin reconfigurar permisos).
2. **Asistente de delegación de control**, vinculado a la OU raíz `TechSolutions` (para que el Helpdesk pueda asistir a cualquier departamento):
   - Agregar `SG_Delegados_Helpdesk`.
   - Tarea común: *"Restablecer contraseñas de usuario y forzar el cambio de contraseña en el siguiente inicio de sesión"*.

---

## ✅ Validación (sin necesidad de RSAT ni login como el usuario delegado)

Se usó **Comprobación de acceso eficaz** (Advanced Security Settings → pestaña "Acceso eficaz") sobre un usuario de prueba, seleccionando al miembro de `SG_Delegados_Helpdesk`:

- ✅ **Restablecer contraseña** — permiso concedido.
- ✅ **Eliminar** / **Crear objetos secundarios** — permiso **no** concedido.

Esta técnica confirma exactamente qué puede y qué no puede hacer el grupo delegado, sin necesidad de credenciales adicionales ni de iniciar sesión como otro usuario — más prolija que la validación por login directo.

---

## 🔍 Evidencia de auditoría

**Event ID 4724**, ejecutado posteriormente por un miembro real del grupo delegado — el campo "Sujeto" muestra al usuario de Helpdesk en lugar de `TECHSOLUTIONS\Administrador`, demostrando trazabilidad real sin necesidad de compartir la cuenta de Administrador.

---

## 📸 Evidencias

5 capturas, numeradas directo en esta carpeta (sin subcarpeta `Evidencias/`):

| # | Captura | Qué muestra |
|---|---|---|
| 1 | [`01-Ticket-REQ-007.png`](01-Ticket-REQ-007.png) | Ticket REQ-007. |
| 2 | [`02-Asistente-Delegacion-Tareas.png`](02-Asistente-Delegacion-Tareas.png) | Asistente de delegación, tarea "Restablecer contraseñas..." tildada (única tarea seleccionada). |
| 3 | [`03-Asistente-Delegacion-Finalizado.png`](03-Asistente-Delegacion-Finalizado.png) | Resumen final: `SG_Delegados_Helpdesk`, tarea delegada. |
| 4 | [`04-Miembro-Grupo-Pablo-Torres.png`](04-Miembro-Grupo-Pablo-Torres.png) | Pablo Torres como miembro de `SG_Delegados_Helpdesk`. |
| 5 | [`05-Validacion-Acceso-Efectivo.png`](05-Validacion-Acceso-Efectivo.png) | Acceso efectivo de Pablo Torres: todo denegado salvo "Cambiar contraseña" / "Restablecer contraseña". |

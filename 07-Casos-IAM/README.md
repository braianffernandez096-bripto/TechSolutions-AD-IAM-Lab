## 🎫 07 — Casos reales de IAM

Siete casos operativos resueltos siguiendo un formato de ticket, replicando el trabajo diario de un administrador de IAM. Los primeros tres comparten protagonista para dar continuidad narrativa al ciclo de vida completo de un empleado: **María López**, quien ingresa a Marketing, es promovida a Ventas, y finalmente se desvincula de la empresa. Los Casos 4 y 5 comparten su propia continuidad menor: **Belen Ruiz**, a quien se le restablece la contraseña y al día siguiente se le bloquea la cuenta por probar esa contraseña nueva sin recordarla bien — más dos casos operativos independientes (6 y 7).

---

## 📋 Índice de casos

| # | Caso | Protagonista | Carpeta |
|---|---|---|---|
| 1 | Joiner (alta de usuario) | María López | [`01-Joiner`](01-Joiner/) |
| 2 | Mover (transferencia de departamento) | María López | [`02-Mover`](02-Mover/) |
| 3 | Leaver (baja de usuario) | María López | [`03-Leaver`](03-Leaver/) |
| 4 | Reset Password | Belen Ruiz | [`04-Restablecer-pass`](04-Restablecer-pass/) |
| 5 | Unlock Account | Belen Ruiz | [`05-Unlock-Account`](05-Unlock-Account/) |
| 6 | Disable vs. Delete User | Cuenta de prueba | [`06-Eliminacion-de-Cuenta`](06-Eliminacion-de-Cuenta/) |
| 7 | Delegación de permisos | Equipo de Helpdesk (IT) | [`07-Delegacion-de-Permisos`](07-Delegacion-de-Permisos/) |

---

## 📑 Formato de cada caso

Cada carpeta contiene un `README.md` con:

1. **🎫 Ticket** — contexto de la solicitud, como llegaría en un sistema real de gestión de tickets.
2. **🛠️ Pasos de resolución** — la acción tomada en Active Directory.
3. **✅ Validación** — prueba de que la resolución funcionó (y, cuando aplica, prueba de que el acceso quedó correctamente acotado).
4. **🔍 Evidencia de auditoría** — el Event ID correspondiente, demostrando trazabilidad de quién ejecutó la acción.
5. **📸 Evidencias** — capturas numeradas y nombradas, listadas en una tabla al final del README, sueltas directo en la carpeta de cada caso.

Este formato está pensado para conectar directamente con el próximo proyecto ([`10-Service-Desk`](../10-Service-Desk/)), donde estos mismos procesos se van a gestionar formalmente vía Jira.

# ⚫ Caso 6 — Disable vs. Delete User

## ⚖️ La diferencia

**Deshabilitar** es reversible: la cuenta, sus atributos y su historial siguen existiendo, simplemente no puede iniciar sesión. Es siempre el primer paso en cualquier baja (ver [Caso 3 — Leaver](../03-Leaver/)).

**Eliminar** es irreversible: el objeto desaparece del directorio junto con su SID (identificador único de seguridad). Si más adelante se crea un usuario nuevo con el mismo login, **no** hereda nada del anterior — para AD es un objeto completamente distinto, aunque el nombre de inicio de sesión se vea igual.

---

## 📅 Cuándo se justifica cada uno

- **Deshabilitar:** inmediatamente en toda baja, sin excepción.
- **Eliminar:** solo después de un período de retención definido por política (30-90 días típicamente), sin litigios ni investigaciones pendientes, y con cualquier recurso dependiente (buzón, archivos personales) ya liberado o reasignado.

> Este laboratorio no tiene habilitada la Papelera de reciclaje de Active Directory, así que el borrado es realmente irreversible — igual que en cualquier dominio real sin esa protección activada.

**Ticket REQ-006**

| Campo | Detalle |
|---|---|
| Solicitante | Administrador de IAM (revisión periódica de bajas) |
| Vía | Revisión trimestral de la OU `13_Disabled_Users` |
| Fecha | 09/08/2026 |
| Descripción | Se revisa la OU de cuentas deshabilitadas y se identifica una cuenta de prueba que superó el período de retención simulado, sin restricciones para su eliminación. |
| Verificación previa | Sin litigios pendientes. Sin recursos dependientes. Autorizado por política de retención. |
| Acción solicitada | Eliminación definitiva del objeto de usuario. |
| Prioridad | Baja (mantenimiento programado) |

---

## 🛠️ Pasos de resolución

1. Confirmar que la cuenta cumple los criterios de retención.
2. Usuarios y equipos de Active Directory → clic derecho → **Eliminar** → confirmar advertencia.

---

## 🔍 Evidencia de auditoría

- **Event ID 4726** — se eliminó una cuenta de usuario (evento legible).
- **Event ID 5141** — objeto eliminado (respaldo técnico).

---

## 📸 Evidencias

4 capturas, numeradas directo en esta carpeta (sin subcarpeta `Evidencias/`):

| # | Captura | Qué muestra |
|---|---|---|
| 1 | [`01-Ticket-REQ-006.png`](01-Ticket-REQ-006.png) | Ticket REQ-006. |
| 2 | [`02-Confirmacion-Eliminar-Usuario.png`](02-Confirmacion-Eliminar-Usuario.png) | "¿Está seguro de que desea eliminar Usuario con el nombre 'Test 01'?" |
| 3 | [`03-Evento-Auditoria-4726-Eliminacion.png`](03-Evento-Auditoria-4726-Eliminacion.png) | Evento 4726 — se eliminó una cuenta de usuario. |
| 4 | [`04-Evento-Auditoria-5141-Objeto-Eliminado.png`](04-Evento-Auditoria-5141-Objeto-Eliminado.png) | Evento 5141 — objeto movido a `Deleted Objects`. |

> Pendiente: la vista de la OU `13_Disabled_Users` ya sin la cuenta `Test 01` (post-eliminación). No se tomó la captura; los eventos 4726/5141 ya respaldan la eliminación por sí solos.

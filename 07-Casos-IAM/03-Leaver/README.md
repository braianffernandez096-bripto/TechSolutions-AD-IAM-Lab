# 🔴 Caso 3 — Leaver (baja de usuario)

**Ticket REQ-003**

| Campo | Detalle |
|---|---|
| Solicitante | Recursos Humanos |
| Vía | Notificación de desvinculación |
| Fecha | 08/08/2026 |
| Descripción | María López (Coordinadora de Ventas) presenta su renuncia voluntaria, efectivo hoy. Se solicita revocar todos los accesos de forma inmediata. |
| Verificación | Confirmado con RRHH y manager directo. |
| Acción solicitada | Deshabilitar la cuenta, remover de todos los grupos, mover a la OU `13_Disabled_Users`, documentar el motivo en la descripción del objeto. |
| Prioridad | Alta (revocación inmediata de accesos) |

---

## 🛠️ Pasos de resolución (el orden importa)

1. **Deshabilitar la cuenta primero, siempre.** Corta el acceso de forma inmediata, antes de cualquier otro paso de limpieza.
2. **Quitar de todos los grupos** (queda solo "Usuarios del dominio", que no se puede remover).
3. **Mover a la OU `13_Disabled_Users`.**
4. **Documentar el motivo** en el campo Descripción: `Baja - Renuncia Voluntaria - 08/08/2026 - Procesado por Administrador`.

---

## 💡 Por qué deshabilitar y no eliminar

Deshabilitar es reversible y corta el acceso al instante. Eliminar es irreversible y se reserva para después de un período de retención — ver el análisis completo en el [Caso 6](../06-Eliminacion-de-Cuenta/).

---

## ✅ Validación

✅ Intento de inicio de sesión rechazado con el mensaje "La cuenta está deshabilitada. Póngase en contacto con el administrador del sistema."

---

## 🔍 Evidencia de auditoría

Tres eventos capturados, en el mismo orden cronológico en que ocurrieron (20:51 → 21:01 → 21:33):

- **Event ID 4729** — se quitó un miembro de un grupo global con seguridad habilitada (`GG_Ventas`). Confirmado.
- **Event ID 5139** — objeto movido de OU (`Anterior DN: OU=07_Ventas` → `Nuevo DN: OU=13_Disabled_Users`). Confirmado.
- **Event ID 5136** — modificación de propiedades (descripción del motivo de baja). Confirmado, con el DN ya en `OU=13_Disabled_Users`.

**Event ID 4725** ("se deshabilitó una cuenta de usuario") — **no capturado**. Es el evento más directo para este paso puntual pero no se tomó la captura; queda pendiente para completar la trazabilidad de punta a punta.

---

## 📸 Evidencias

12 capturas, numeradas directo en esta carpeta (sin subcarpeta `Evidencias/`):

| # | Captura | Qué muestra |
|---|---|---|
| 1 | [`01-Ticket-REQ-003.png`](01-Ticket-REQ-003.png) | Ticket REQ-003. |
| 2 | [`02-Menu-Contextual-Deshabilitar.png`](02-Menu-Contextual-Deshabilitar.png) | Clic derecho → "Deshabilitar cuenta". |
| 3 | [`03-Cuenta-Deshabilitada-Confirmacion.png`](03-Cuenta-Deshabilitada-Confirmacion.png) | "El objeto María López ha sido deshabilitado". |
| 4 | [`04-Quitar-Grupo-Confirmacion.png`](04-Quitar-Grupo-Confirmacion.png) | "¿Desea quitar María López de los grupos seleccionados?" |
| 5 | [`05-Miembro-Grupo-Removido.png`](05-Miembro-Grupo-Removido.png) | Pestaña Miembro de, ya sin `GG_Ventas`. |
| 6 | [`06-Dialogo-Mover-Disabled-Users.png`](06-Dialogo-Mover-Disabled-Users.png) | Destino `13_Disabled_Users` seleccionado. |
| 7 | [`07-OU-Disabled-Users-Confirmado.png`](07-OU-Disabled-Users-Confirmado.png) | María López ahora en `13_Disabled_Users`. |
| 8 | [`08-Propiedades-Descripcion-Baja.png`](08-Propiedades-Descripcion-Baja.png) | Descripción: "Baja - Renuncia Voluntaria - 08/08/2026 - Procesado...". |
| 9 | [`09-Evento-Auditoria-4729-Baja-Grupo.png`](09-Evento-Auditoria-4729-Baja-Grupo.png) | Evento 4729 — baja del grupo `GG_Ventas`. |
| 10 | [`10-Evento-Auditoria-5139-Movimiento-OU.png`](10-Evento-Auditoria-5139-Movimiento-OU.png) | Evento 5139 — movimiento de OU. |
| 11 | [`11-Evento-Auditoria-5136-Cambio-Propiedades.png`](11-Evento-Auditoria-5136-Cambio-Propiedades.png) | Evento 5136 — cambio de descripción. |
| 12 | [`12-Login-Cuenta-Deshabilitada.png`](12-Login-Cuenta-Deshabilitada.png) | Validación final: login rechazado. |

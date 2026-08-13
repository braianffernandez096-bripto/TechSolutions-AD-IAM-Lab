# 🔵 Caso 2 — Mover (transferencia de departamento)

**Ticket REQ-002**

| Campo | Detalle |
|---|---|
| Solicitante | Recursos Humanos |
| Vía | Notificación de cambio de puesto |
| Fecha | 07/08/2026 |
| Descripción | María López (Analista de Marketing) es promovida a Coordinadora de Ventas, efectivo hoy. Se requiere revocar los accesos de Marketing y otorgar los de Ventas. |
| Acción solicitada | Mover el objeto de la OU `06_Marketing` a `07_Ventas`; quitar del grupo `GG_Marketing` y agregar a `GG_Ventas`; actualizar Puesto, Departamento y Manager. |
| Prioridad | Media |

---

## 🛠️ Pasos de resolución

1. **Mover la OU**: clic derecho sobre el usuario → Mover... → `07_Ventas`.
2. **Actualizar grupos**: pestaña Miembro de → agregar `GG_Ventas`, quitar `GG_Marketing`.
3. **Actualizar datos organizacionales**: Puesto → "Coordinadora de Ventas", Departamento → "Ventas", nuevo Manager si corresponde.

---

## ✅ Validación

El paso crítico de este caso no es solo confirmar el acceso nuevo — es confirmar que el acceso viejo **se revocó**:

1. Cierre de sesión completo del usuario (no alcanza con bloquear pantalla — el token de grupos se arma en el logon) y reinicio de sesión.
2. ✅ Acceso concedido a `\\DC01\Compartidos\Ventas`.
3. ✅ Acceso denegado a `\\DC01\Compartidos\Marketing`.

---

## 🔍 Evidencia de auditoría

- **Event ID 5139** — objeto movido de OU (`Anterior DN: OU=06_Marketing` → `Nuevo DN: OU=07_Ventas`). Confirmado.
- **Event ID 5136** — modificación de propiedades (Puesto, Departamento). **Pendiente** — no se tomó la captura en su momento; queda como evidencia a completar más adelante.
- **Event ID 4728 / 4729** — alta y baja de membresía de grupo. En el momento de este caso, la subcategoría "Administración de grupos de seguridad" todavía no estaba habilitada, así que estos dos no quedaron registrados para este movimiento puntual. Se habilitó recién en el Caso 3 — a partir de ahí, cualquier alta/baja de grupo nueva sí genera estos eventos.

---

## 📸 Evidencias

10 capturas, numeradas directo en esta carpeta (sin subcarpeta `Evidencias/`):

| # | Captura | Qué muestra |
|---|---|---|
| 1 | [`01-Ticket-REQ-002.png`](01-Ticket-REQ-002.png) | Ticket REQ-002. |
| 2 | [`02-Menu-Contextual-Mover.png`](02-Menu-Contextual-Mover.png) | Clic derecho → "Mover..." sobre María López en `06_Marketing`. |
| 3 | [`03-Dialogo-Mover-Destino-Ventas.png`](03-Dialogo-Mover-Destino-Ventas.png) | Cuadro "Mover", destino `07_Ventas` seleccionado. |
| 4 | [`04-OU-Marketing-Sin-Maria-Lopez.png`](04-OU-Marketing-Sin-Maria-Lopez.png) | `06_Marketing` ya sin María López — confirma que salió de la OU. |
| 5 | [`05-OU-Ventas-Con-Maria-Lopez.png`](05-OU-Ventas-Con-Maria-Lopez.png) | `07_Ventas` ahora con María López — confirma el ingreso a la OU. |
| 6 | [`06-Miembro-Grupo-GG-Ventas.png`](06-Miembro-Grupo-GG-Ventas.png) | Pestaña Miembro de: `GG_Ventas` agregado (y `GG_Marketing` ya no figura). |
| 7 | [`07-Propiedades-Organizacion-Actualizada.png`](07-Propiedades-Organizacion-Actualizada.png) | Puesto "Coordinadora de Ventas", Departamento "Ventas". |
| 8 | [`08-Acceso-Concedido-Ventas.png`](08-Acceso-Concedido-Ventas.png) | `\\DC01\Compartidos\Ventas` accesible. |
| 9 | [`09-Acceso-Denegado-Marketing.png`](09-Acceso-Denegado-Marketing.png) | `\\DC01\Compartidos\Marketing` — acceso denegado. |
| 10 | [`10-Evento-Auditoria-5139.png`](10-Evento-Auditoria-5139.png) | Evento 5139 con el DN anterior y nuevo. |

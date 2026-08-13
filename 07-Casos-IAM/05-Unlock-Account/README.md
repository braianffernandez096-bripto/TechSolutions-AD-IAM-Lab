# 🟣 Caso 5 — Unlock Account

**Ticket REQ-005**

| Campo | Detalle |
|---|---|
| Solicitante | Belen Ruiz (Graphic Designer) |
| Vía | Llamada a Mesa de Ayuda |
| Fecha | 09/08/2026 |
| Descripción | La usuaria intentó iniciar sesión varias veces con una contraseña que creía correcta (la había cambiado recientemente y no la recordaba bien) y ahora su cuenta figura bloqueada. |
| Verificación de identidad | Confirmada telefónicamente. |
| Acción solicitada | Desbloquear la cuenta. No requiere reset de contraseña, la usuaria ya recuerda la contraseña correcta. |
| Prioridad | Alta (no puede trabajar) |

---

> Continuidad con el [Caso 4](../04-Reset-Password/): es la misma usuaria (Belen Ruiz) a la que se le había restablecido la contraseña un día antes. El bloqueo es consecuencia directa de eso — probó varias veces la contraseña nueva sin recordarla bien, hasta activar el umbral de bloqueo.

## 🛠️ Pasos de resolución

1. **Generar el bloqueo real**: 5 intentos fallidos de login desde el cliente Windows 10, activando el umbral configurado en la Default Domain Policy (ver [`05-Group-Policy`](../../05-Group-Policy/)).
2. **Confirmar el bloqueo** en Usuarios y equipos de Active Directory (menú contextual "Desbloquear cuenta", o pestaña Cuenta con el checkbox tildado).
3. **Desbloquear** — clic en "Desbloquear cuenta".

---

## ✅ Validación

✅ Inicio de sesión exitoso con la contraseña correcta, sin pedir cambio (a diferencia del Caso 4, acá la contraseña no cambió, solo se liberó el bloqueo).

---

## 🔍 Evidencia de auditoría

- **Event ID 4740** — se bloqueó una cuenta de usuario (el momento del incidente).
- **Event ID 4767** — se desbloqueó una cuenta de usuario (la resolución).

Ambos eventos juntos muestran el ciclo completo incidente → resolución con timestamps, evidencia particularmente sólida de trazabilidad.

---

## 📸 Evidencias

6 capturas, numeradas directo en esta carpeta (sin subcarpeta `Evidencias/`):

| # | Captura | Qué muestra |
|---|---|---|
| 1 | [`01-Ticket-REQ-005.png`](01-Ticket-REQ-005.png) | Ticket REQ-005. |
| 2 | [`02-Login-Cuenta-Bloqueada.png`](02-Login-Cuenta-Bloqueada.png) | "La cuenta a que se hace referencia está bloqueada y no se puede utilizar." |
| 3 | [`03-Propiedades-Desbloquear-Cuenta.png`](03-Propiedades-Desbloquear-Cuenta.png) | Pestaña Cuenta, checkbox "Desbloquear cuenta" tildado. |
| 4 | [`04-Login-Exitoso-Bienvenida.png`](04-Login-Exitoso-Bienvenida.png) | "Te damos la bienvenida" — login exitoso tras el desbloqueo. |
| 5 | [`05-Evento-Auditoria-4740-Bloqueo.png`](05-Evento-Auditoria-4740-Bloqueo.png) | Evento 4740 — se bloqueó la cuenta. |
| 6 | [`06-Evento-Auditoria-4767-Desbloqueo.png`](06-Evento-Auditoria-4767-Desbloqueo.png) | Evento 4767 — se desbloqueó la cuenta. |

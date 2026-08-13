# 🟡 Caso 4 — Reset Password

**Ticket REQ-004**

| Campo | Detalle |
|---|---|
| Solicitante | Belen Ruiz (Graphic Designer) |
| Vía | Llamada telefónica a Mesa de Ayuda |
| Fecha | 08/08/2026 |
| Descripción | El usuario informa que olvidó su contraseña tras las vacaciones y no puede iniciar sesión. No presenta bloqueo de cuenta, solo desconoce la contraseña actual. |
| Verificación de identidad | Confirmada telefónicamente — nombre completo, departamento y legajo. |
| Acción solicitada | Restablecer contraseña con cambio obligatorio en el próximo inicio de sesión. |
| Prioridad | Media |

---

## 🔒 Por qué la verificación de identidad importa

Antes de resetear cualquier contraseña, siempre se verifica que quien la solicita es realmente el dueño de la cuenta — es el paso que evita que alguien tome una cuenta ajena por ingeniería social simplemente llamando y pidiendo un reset.

---

## 🛠️ Pasos de resolución

1. Usuarios y equipos de Active Directory → clic derecho sobre el usuario → **Restablecer contraseña...**
2. Contraseña temporal nueva.
3. Tildar **"El usuario debe cambiar la contraseña en el siguiente inicio de sesión"**.

---

## ✅ Validación

1. ✅ Inicio de sesión con la contraseña temporal → solicita cambio inmediato.
2. ✅ Después del cambio, acceso normal a su carpeta de departamento, sin cambios respecto a antes.

---

## 🔍 Evidencia de auditoría

**Event ID 4724** — "Se intentó restablecer la contraseña de una cuenta", con el sujeto que ejecutó la acción.

---

## 📸 Evidencias

7 capturas, numeradas directo en esta carpeta (sin subcarpeta `Evidencias/`):

| # | Captura | Qué muestra |
|---|---|---|
| 1 | [`01-Ticket-REQ-004.png`](01-Ticket-REQ-004.png) | Ticket REQ-004. |
| 2 | [`02-Restablecer-Contrasena-Dialogo.png`](02-Restablecer-Contrasena-Dialogo.png) | Cuadro "Restablecer contraseña", cambio obligatorio tildado. |
| 3 | [`03-Contrasena-Cambiada-Confirmacion.png`](03-Contrasena-Cambiada-Confirmacion.png) | "Se ha cambiado la contraseña para Belen Ruiz". |
| 4 | [`04-Login-Otro-Usuario-Bruiz.png`](04-Login-Otro-Usuario-Bruiz.png) | Inicio de sesión con la contraseña temporal. |
| 5 | [`05-Login-Cambio-Contrasena-Obligatorio.png`](05-Login-Cambio-Contrasena-Obligatorio.png) | "Se debe cambiar la contraseña del usuario antes de iniciar sesión". |
| 6 | [`06-Evento-Auditoria-4724-Reset-Password.png`](06-Evento-Auditoria-4724-Reset-Password.png) | Evento 4724 — intento de restablecimiento de contraseña. |
| 7 | [`07-Evento-Auditoria-5136-Cambio-Contrasena.png`](07-Evento-Auditoria-5136-Cambio-Contrasena.png) | Evento 5136 — cambio de propiedades asociado. |

> Nota: el ticket quedó redactado con el puesto en inglés ("Graphic Designer"), a diferencia del resto del laboratorio que usa los puestos en español. Se mantiene tal cual figura en la captura original.

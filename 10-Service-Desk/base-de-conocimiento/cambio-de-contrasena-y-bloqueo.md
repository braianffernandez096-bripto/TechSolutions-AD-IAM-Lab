# Cómo cambiar tu contraseña y qué hacer si tu cuenta se bloquea

> Artículo publicado en la base de conocimiento de Jira Service Management (portal de clientes) a pedido del IT Manager (TSD-21). Basado en los casos reales de la semana: TSD-1, TSD-8, TSD-11 y TSD-17.

## Requisitos de la contraseña

- Mínimo **12 caracteres**.
- Combinar al menos 3 de estos tipos: mayúsculas, minúsculas, números y símbolos.
- **No** puede contener tu nombre ni tu usuario.
- No podés repetir ninguna de tus últimas **24** contraseñas.
- Vence cada **42 días**; el sistema te avisa antes.
- **Consejo:** usá una frase de tres palabras sin relación más un número (por ejemplo, `Mate-Bici-Nube47`). Es fácil de recordar y difícil de adivinar.

## Cómo cambiarla

1. Presioná **Ctrl + Alt + Supr** → **Cambiar una contraseña**.
2. Ingresá la actual y después dos veces la nueva.
3. Si es tu primer inicio de sesión, el sistema te lo pide solo.

## Si tu cuenta se bloquea

- Se bloquea después de **5 intentos fallidos en 15 minutos** y se desbloquea sola a los **15 minutos**.
- Si la necesitás antes, abrí un ticket en el portal o llamá a la Mesa de Ayuda. **Vamos a verificar tu identidad** antes de desbloquearla.
- Si se bloquea y **vos no estabas intentando entrar**, avisanos de inmediato: puede ser que alguien esté probando tu contraseña.

## Importante

- La Mesa de Ayuda **nunca** te va a pedir tu contraseña por correo, chat ni teléfono.
- Si recibís un correo que te pide "validar tu cuenta" en un enlace, no lo abras y reenvialo a la Mesa de Ayuda.

---

*Valores tomados de la política del dominio (`Get-ADDefaultDomainPasswordPolicy`): MinPasswordLength 12, ComplexityEnabled, PasswordHistoryCount 24, MaxPasswordAge 42 días, LockoutThreshold 5, LockoutDuration y ObservationWindow 15 min.*

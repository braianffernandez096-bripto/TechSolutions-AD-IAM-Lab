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

---

## 🔍 Evidencia de auditoría

**Event ID 5137** — creación del objeto de usuario, con el sujeto `TECHSOLUTIONS\Administrador` como responsable de la acción. **Sin captura confirmada todavía** — el intento de capturarla trajo un evento con datos inconsistentes (ver nota en [`Evidencias/README.md`](Evidencias/README.md)); queda pendiente tomarla de nuevo filtrando puntualmente por este Event ID y confirmando el DN final antes de guardarla.

> Nota: el evento **4720** (versión más legible del mismo hecho) no quedó registrado para esta alta puntual, porque la subcategoría de auditoría que lo genera ("Administración de cuentas de usuario") recién se habilitó más adelante, durante el Caso 3. Los eventos de auditoría no son retroactivos — a partir de esa habilitación, cualquier alta nueva sí queda registrada también con el 4720.

---

## 📸 Evidencias

Ver [`Evidencias/`](Evidencias/): 11 capturas — ticket, asistente de alta (datos, contraseña temporal, resumen), propiedades de organización, membresía de grupo, primer login completo (banner, credenciales, cambio de contraseña obligatorio) y validación de acceso (concedido en Marketing, denegado en Ciberseguridad). Queda pendiente la captura del evento de auditoría (5137).

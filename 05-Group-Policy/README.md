# 📜 05 — Group Policy (GPO)

Directivas centralizadas para administración y cumplimiento del dominio. Detalle completo, con evidencia de consola, en [`politicas.md`](politicas.md).

---

## 📋 GPOs en alcance

Inventario completo del dominio (5 GPOs, [`Evidencias/00-Inventario-GPOs.png`](Evidencias/00-Inventario-GPOs.png)): 3 en esta carpeta, `GPO_Auditoria_Objetos` documentada en [`06-Auditoria`](../06-Auditoria/), y `Default Domain Controllers Policy` fuera de alcance (sin configuración custom).

| GPO | Vinculada a | Propósito |
|---|---|---|
| `GPO - Windows10 - Banner Legal` | `TechSolutions/09_Equipos/Windows10` | Aviso legal antes del inicio de sesión en equipos cliente Windows 10 |
| `GPO_Restriccion_Ventas` | OU `07_Ventas` | Bloquea el acceso a Configuración de PC y Panel de control para ese departamento |
| `Default Domain Policy` | Raíz del dominio | Bloqueo de cuenta (5 intentos / 15 min, sin excepción de rango) + bloqueo de pantalla por inactividad (600 seg) |

---

## 🌳 Por qué Default Domain Policy para el bloqueo de cuenta

Las directivas de cuenta (bloqueo y contraseñas) solo tienen efecto real si están definidas en una GPO vinculada en la **raíz del dominio** — por eso se configuró directamente sobre Default Domain Policy en vez de crear una GPO nueva vinculada a una OU, donde no habría surtido efecto.

---

## 📸 Evidencias

Ver [`Evidencias/`](Evidencias/): 8 capturas de consola — el inventario inicial de GPOs más una por cada sección de `politicas.md`, tomadas de cero para esta versión de la documentación. El comportamiento end-user de estas mismas políticas (banner en pantalla de login, mensaje de bloqueo tras 5 intentos, restricción de Panel de Control en Ventas) se documenta como evidencia dentro de los tickets de [`07-Casos-IAM`](../07-Casos-IAM/), no acá.

---

## 🚀 Siguiente paso

La auditoría también se configura en gran parte vía GPO — se documentó por separado en [`06-Auditoria`](../06-Auditoria/) por la extensión y complejidad propia del tema.

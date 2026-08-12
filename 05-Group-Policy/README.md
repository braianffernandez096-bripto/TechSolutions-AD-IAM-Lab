# 📜 05 — Group Policy (GPO)

Directivas centralizadas para administración y cumplimiento del dominio. Detalle completo de cada una en [`politicas.md`](politicas.md).

---

## 📋 GPOs implementadas

| GPO | Vinculada a | Propósito |
|---|---|---|
| Banner legal (`GPO - Windows10 - Banner Legal`) | `TechSolutions/09_Equipos/Windows10` | Mensaje de aviso legal antes del inicio de sesión — solo en equipos cliente Windows 10, no en el DC |
| Bloqueo de cuenta (`Default Domain Policy`) | Raíz del dominio | Umbral de 5 intentos fallidos, bloqueo de 15 minutos — sin excepción para la cuenta de administrador, misma política sin importar el rango |
| Restricción por departamento (`GPO_Restriccion_Ventas`) | OU `07_Ventas` (ejemplo) | Bloqueo del Panel de Control / Configuración para el departamento |
| Bloqueo de pantalla por inactividad (`Default Domain Policy`) | Raíz del dominio | `Inicio de sesión interactivo: límite de inactividad del equipo` = 600 seg (10 min), todo el dominio incluido el DC |

---

## 🌳 Por qué Default Domain Policy para el bloqueo de cuenta

Las directivas de cuenta (bloqueo y contraseñas) solo tienen efecto si están definidas en una GPO vinculada en la **raíz del dominio** — por eso se editó la Default Domain Policy directamente, en vez de crear una GPO nueva vinculada a una OU (donde no habría tenido efecto).

---

## 🔍 Redundancia detectada y corregida

Una revisión del RSoP del cliente Windows 10 encontró que `GPO - Windows10 - Screen Lock Policy` (vinculada al mismo lugar que el banner, `09_Equipos/Windows10`) duplicaba tanto el aviso legal como el bloqueo por inactividad, este último por un mecanismo clásico (protector de pantalla) distinto al moderno ya definido en Default Domain Policy — mismo valor (600 seg), dos caminos técnicos distintos. Se hizo backup de la GPO y se eliminó tras confirmar que no tenía ninguna otra configuración. Proceso completo con capturas antes/después en [`evidencias/`](evidencias/); razonamiento de la decisión en [`../09-Documentacion/decisiones-de-diseno.md`](../09-Documentacion/decisiones-de-diseno.md) y [`../09-Documentacion/lecciones-aprendidas.md`](../09-Documentacion/lecciones-aprendidas.md).

---

## 📸 Evidencias

Ver [`evidencias/`](evidencias/) — 11 capturas: el proceso completo de auditoría y consolidación de GPOs (antes/después, capturas 1-9) más la configuración real de bloqueo de cuenta y restricción de Ventas (capturas 10-11). El comportamiento end-user de estas mismas políticas (banner en pantalla de login, mensaje de bloqueo tras 5 intentos fallidos, restricción del Panel de Control bloqueada en Ventas) se documenta como evidencia dentro de los tickets de [`07-Casos-IAM`](../07-Casos-IAM/), no acá.

---

## 🚀 Siguiente paso

La auditoría también se configura en gran parte vía GPO — se documentó por separado en [`06-Auditoria`](../06-Auditoria/) por la extensión y complejidad propia del tema.

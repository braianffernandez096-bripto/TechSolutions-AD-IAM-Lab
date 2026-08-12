# 📜 05 — Group Policy (GPO)

Directivas centralizadas para administración, seguridad y cumplimiento del dominio. Detalle completo de cada configuración en [`politicas.md`](politicas.md).

Las tres GPOs de esta carpeta fueron verificadas contra la consola real de Administración de directivas de grupo — no solo documentadas, sino confirmadas subcategoría por subcategoría en el caso de la auditoría, y con su valor exacto en el caso del bloqueo de pantalla.

---

## 📋 GPOs implementadas

| GPO | Vinculada a | Propósito |
|---|---|---|
| Default Domain Policy | Raíz del dominio (`techsolutions.local`) | Banner legal, bloqueo de cuenta (5 intentos / 15 min) y bloqueo de pantalla por inactividad (600 segundos) — las tres configuradas dentro de esta misma GPO |
| GPO_Restriccion_Ventas | OU `07_Ventas` | Bloqueo del Panel de Control / Configuración para el departamento |
| GPO_Auditoria_Objetos | OU `Domain Controllers` | Auditoría avanzada: Directory Service Changes, Account Management y Sistema de archivos — ver [`06-Auditoria`](../06-Auditoria/) |

---

## 🌳 Por qué Default Domain Policy concentra tres directivas distintas

Las directivas de cuenta (bloqueo de cuenta, contraseñas) y de seguridad local (mensaje de inicio de sesión, límite de inactividad) solo tienen efecto garantizado si están definidas en una GPO vinculada en la **raíz del dominio** — por eso las tres se configuraron directamente en la Default Domain Policy, en vez de crear GPOs separadas vinculadas a una OU (donde el bloqueo de cuenta, en particular, no habría tenido efecto).

El bloqueo de pantalla en particular usa `Inicio de sesión interactivo: límite de inactividad del equipo` (Directivas locales → Opciones de seguridad) — el mecanismo nativo de seguridad de Windows para forzar el bloqueo tras inactividad, en vez de depender de la configuración de protector de pantalla. Al estar en la raíz del dominio, aplica por herencia a todos los equipos: departamentos, cliente Windows 10, y el propio `DC01`.

---

## 🔍 Sobre GPO_Auditoria_Objetos

Vinculada específicamente a la OU `Domain Controllers` (no a la raíz del dominio ni a `TechSolutions`), porque las subcategorías de auditoría de Directory Service Changes necesitan aplicarse a nivel de controlador de dominio para generar los eventos correspondientes. Se verificó subcategoría por subcategoría que únicamente están activas *"Auditar cambios de servicio de directorio"* y *"Auditar sistema de archivos"* (ambas en Aciertos y errores), y que *"Auditoría: forzar la configuración de subcategorías..."* está habilitada en Opciones de seguridad, para que la configuración avanzada tenga prioridad sobre cualquier directiva de auditoría básica. Detalle completo de qué genera cada una en [`06-Auditoria`](../06-Auditoria/).

---

## 📸 Evidencias

Ver [`evidencias/`](evidencias/): vínculo de Default Domain Policy en la raíz del dominio, vínculo de GPO_Restriccion_Ventas en `07_Ventas`, vínculo de GPO_Auditoria_Objetos en `Domain Controllers`, banner en pantalla de login, mensaje de bloqueo tras 5 intentos fallidos, restricción del Panel de Control bloqueada en Ventas, configuración del límite de inactividad (600 segundos), y las subcategorías de auditoría avanzada configuradas.

---

## 🚀 Siguiente paso

La auditoría también se configura en gran parte vía GPO — se documentó por separado en [`06-Auditoria`](../06-Auditoria/) por la extensión y complejidad propia del tema.

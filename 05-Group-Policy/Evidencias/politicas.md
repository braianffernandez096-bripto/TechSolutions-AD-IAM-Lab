# 📜 Detalle de políticas

## 1️⃣ Banner legal de inicio de sesión

**GPO:** `GPO - Windows10 - Banner Legal`

**Ubicación:** Configuración del equipo → Directivas → Configuración de Windows → Configuración de seguridad → Directivas locales → Opciones de seguridad.

- **Inicio de sesión interactivo: título del mensaje** → `Bienvenidos a TechSolutions S.A.`
- **Inicio de sesión interactivo: texto del mensaje** → Aviso de propiedad de la empresa, acceso restringido y monitoreo/auditoría de actividad.

**Vínculo confirmado (pestaña Ámbito de la GPO):** `techsolutions.local/TechSolutions/09_Equipos/Windows10` — no la raíz del dominio. Filtrado de seguridad: Usuarios autentificados.

Alcance real: aplica a los equipos cliente Windows 10 de esa OU, **no** al DC (que no tiene un vínculo propio de esta GPO — solo recibe lo que está vinculado en la raíz, que es únicamente `Default Domain Policy`). Es un alcance razonable: el aviso legal de inicio de sesión tiene sentido en estaciones de trabajo de usuario final, no necesariamente como prioridad en el propio controlador de dominio.

Evidencia: [`evidencias/02-antes-banner-legal-ambito-vinculo-windows10.png`](evidencias/02-antes-banner-legal-ambito-vinculo-windows10.png) y [`evidencias/09-despues-banner-legal-ambito-confirmado.png`](evidencias/09-despues-banner-legal-ambito-confirmado.png).

---

## 2️⃣ Bloqueo de cuenta

**Ubicación:** Default Domain Policy → Configuración del equipo → Directivas de cuenta → Directiva de bloqueo de cuenta.

| Parámetro | Valor |
|---|---|
| Umbral de bloqueo de cuenta | 5 intentos de inicio de sesión no válidos |
| Duración del bloqueo de cuenta | 15 minutos |
| Restablecer recuentos de bloqueo de cuenta tras | 15 minutos |
| Permitir bloqueo de la cuenta del administrador | Habilitado |

La cuenta `Administrador` local queda sujeta a la misma directiva de bloqueo que cualquier otra cuenta — por defecto Windows la exime de bloqueo por intentos fallidos (para evitar que un atacante deje sin acceso administrativo al equipo bloqueándola a propósito). Acá se decidió habilitar la excepción a esa exención intencionalmente: ver razonamiento en [`../09-Documentacion/decisiones-de-diseno.md`](../09-Documentacion/decisiones-de-diseno.md).

Evidencia: [`evidencias/10-bloqueo-cuenta-default-domain-policy.png`](evidencias/10-bloqueo-cuenta-default-domain-policy.png).

---

## 3️⃣ Restricción por departamento (ejemplo: Ventas)

**GPO:** `GPO_Restriccion_Ventas`

**Ubicación:** GPO vinculada a la OU `07_Ventas` → Configuración de usuario → Plantillas administrativas → Panel de control → *"Prohibir el acceso a Configuración de PC y a Panel de control"* → Habilitado. Configuración del equipo: no definida (es una directiva puramente de usuario).

Es una directiva de **usuario**, no de equipo — viaja con la cuenta sin importar desde qué PC del dominio se loguee. Validado: un usuario de Ventas recibe el mensaje "Esta operación ha sido cancelada debido a las restricciones especificadas para este equipo"; un usuario de otro departamento no tiene esa restricción.

Evidencia: [`evidencias/11-restriccion-ventas-panel-control-habilitado.png`](evidencias/11-restriccion-ventas-panel-control-habilitado.png).

---

## 4️⃣ Bloqueo de pantalla por inactividad

**GPO:** `Default Domain Policy`

**Ubicación:** Configuración del equipo → Directivas → Configuración de Windows → Configuración de seguridad → Directivas locales → Opciones de seguridad → **Inicio de sesión interactivo: límite de inactividad del equipo**.

| Parámetro | Valor |
|---|---|
| Tiempo de inactividad | 600 segundos (10 minutos) |
| Vínculo | Raíz del dominio (`techsolutions.local`) |
| Alcance | Todo el dominio, incluido el propio DC |

Se optó por este mecanismo (moderno, vía Opciones de seguridad) en lugar del clásico basado en protector de pantalla porque no depende de que esa función esté disponible o habilitada en cada equipo, y porque al estar en Default Domain Policy cubre también el DC sin necesidad de un vínculo adicional.

> Durante la revisión previa a esta documentación se detectó una segunda GPO (`GPO - Windows10 - Screen Lock Policy`) que implementaba el mismo bloqueo por la vía clásica (protector de pantalla + contraseña, 600 seg) vinculada solo a `09_Equipos/Windows10`, además de duplicar el banner legal de la sección 1. Se hizo backup y se eliminó tras confirmar que no tenía ninguna otra configuración — detalle completo en [`../09-Documentacion/lecciones-aprendidas.md`](../09-Documentacion/lecciones-aprendidas.md) y [`../09-Documentacion/decisiones-de-diseno.md`](../09-Documentacion/decisiones-de-diseno.md).

Evidencia: ver [`evidencias/`](evidencias/) — capturas 01 a 09 documentan el antes/después completo de esta consolidación.

---

## ✅ Validación general

Cada política se probó desde el cliente Windows 10 con al menos un usuario afectado y, cuando correspondía, un usuario de control (de otro departamento) para confirmar que el alcance quedó correctamente acotado.

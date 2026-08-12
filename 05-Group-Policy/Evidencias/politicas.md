# 📜 Detalle de políticas

> Reconstruido desde cero verificando cada GPO directo en la consola. Se documenta GPO por GPO a medida que se confirma.

---

## 1️⃣ Banner legal de inicio de sesión

**GPO:** `GPO - Windows10 - Banner Legal`

**Ámbito (vínculos):**

| Ubicación | Exigido | Vínculo habilitado | Ruta |
|---|---|---|---|
| Windows10 | No | Sí | `techsolutions.local/TechSolutions/09_Equipos/Windows10` |

**Filtrado de seguridad:** Usuarios autentificados.

**Configuración** — Configuración del equipo → Directivas → Configuración de Windows → Configuración de seguridad → Directivas locales/Opciones de seguridad → Inicio de sesión interactivo:

| Directiva | Configuración |
|---|---|
| Título del mensaje | `Bienvenido a TechSolutions S.A.` |
| Texto del mensaje | Este equipo es propiedad de TechSolutions S.A. El acceso está permitido únicamente a personal autorizado. Toda actividad realizada en este equipo puede ser registrada, supervisada y auditada conforme a las políticas de seguridad de la organización. Si usted no está autorizado, cierre esta sesión inmediatamente. |

**Alcance de esta GPO puntual:** aplica a los equipos cliente Windows 10 dentro de `09_Equipos/Windows10` (no está vinculada en la raíz). El DC también termina recibiendo un banner, pero por una fuente distinta — ver el hallazgo de duplicación al final de este documento (sección "⚠️ Hallazgo").

**Evidencia:** [`evidencias/01-Banner-Legal-Ambito.png`](evidencias/01-Banner-Legal-Ambito.png), [`evidencias/02-Banner-Legal-Configuracion.png`](evidencias/02-Banner-Legal-Configuracion.png).

---

## 2️⃣ Restricción por departamento (ejemplo: Ventas)

**GPO:** `GPO_Restriccion_Ventas`

**Ámbito (vínculos):**

| Ubicación | Exigido | Vínculo habilitado | Ruta |
|---|---|---|---|
| 07_Ventas | No | Sí | `techsolutions.local/TechSolutions/07_Ventas` |

**Filtrado de seguridad:** Usuarios autentificados.

**Configuración:**

| Ámbito | Configuración |
|---|---|
| Configuración del equipo | No definida |
| Configuración del usuario → Plantillas administrativas → Panel de control → *"Prohibir el acceso a Configuración de PC y a Panel de control"* | Habilitado |

Es una directiva de **usuario**, no de equipo — viaja con la cuenta sin importar desde qué PC del dominio se loguee.

**Evidencia:** [`evidencias/03-Restriccion-Ventas-Ambito.png`](evidencias/03-Restriccion-Ventas-Ambito.png), [`evidencias/04-Restriccion-Ventas-Configuracion.png`](evidencias/04-Restriccion-Ventas-Configuracion.png).

## 3️⃣ Bloqueo de cuenta

**GPO:** `Default Domain Policy`

**Ámbito (vínculos):**

| Ubicación | Exigido | Vínculo habilitado | Ruta |
|---|---|---|---|
| techsolutions.local | No | Sí | `techsolutions.local` (raíz del dominio) |

**Filtrado de seguridad:** Usuarios autentificados.

**Configuración** — Configuración del equipo → Directivas de cuenta → Directiva de bloqueo de cuenta:

| Directiva | Configuración |
|---|---|
| Umbral de bloqueo de cuenta | 5 intentos de inicio de sesión no válidos |
| Duración del bloqueo de cuenta | 15 minutos |
| Restablecer recuentos de bloqueo de cuenta tras | 15 minutos |
| Permitir bloqueo de la cuenta del administrador | Habilitado |

Las directivas de cuenta (bloqueo, contraseñas) solo tienen efecto real si están definidas en una GPO vinculada en la **raíz del dominio** — por eso se configuró directamente sobre Default Domain Policy en vez de crear una GPO nueva vinculada a una OU.

La cuenta `Administrador` local queda sujeta a la misma directiva de bloqueo que cualquier otra cuenta — por defecto Windows la exime de bloqueo por intentos fallidos (para que un atacante no pueda dejar sin acceso administrativo al equipo bloqueándola a propósito). Acá se decidió habilitar la excepción a esa exención a propósito: la política aplica sin distinción de rango, y el riesgo de quedar sin acceso administrativo está mitigado porque no depende de esa única cuenta (existe `Admins. del dominio` y la delegación a `SG_Delegados_Helpdesk`).

**Evidencia:** [`evidencias/05-Vinculo-Default-Domain-Policy.png`](evidencias/05-Vinculo-Default-Domain-Policy.png), [`evidencias/06-Bloqueo-Cuenta-15min.png`](evidencias/06-Bloqueo-Cuenta-15min.png).

## 4️⃣ Bloqueo de pantalla por inactividad

**GPO:** `Default Domain Policy`

**Configuración** — Configuración del equipo → Directivas locales/Opciones de seguridad → Otro:

| Directiva | Configuración |
|---|---|
| Inicio de sesión interactivo: límite de inactividad del equipo | 600 segundos (10 minutos) |

**Vínculo:** raíz del dominio (`techsolutions.local`) — ver Ámbito en la sección 3, misma GPO. **Alcance:** todo el dominio, incluido el DC.

**Evidencia:** [`evidencias/08-Limite-Inactividad-600s.png`](evidencias/08-Limite-Inactividad-600s.png).

---

## ⚠️ Hallazgo: banner duplicado también dentro de Default Domain Policy

Al revisar la Configuración completa de `Default Domain Policy` apareció **un tercer lugar** con el mismo banner de inicio de sesión ya documentado en la sección 1:

| Directiva | Configuración |
|---|---|
| Inicio de sesión interactivo: título del mensaje | `Bienvenido a TechSolutions S.A.` |
| Inicio de sesión interactivo: texto del mensaje | Idéntico, palabra por palabra, al de `GPO - Windows10 - Banner Legal` |

Como `Default Domain Policy` está vinculada en la **raíz del dominio**, este banner sí llega a todos los equipos, incluido el DC — lo que además corrige lo que se dijo en la sección 1 ("no aplica al DC"): en realidad **sí llega**, solo que por esta GPO, no por `Banner Legal`.

Con esto, `GPO - Windows10 - Banner Legal` (vinculada solo a `09_Equipos/Windows10`) queda redundante: cualquier equipo de esa OU ya recibe el mismo banner, con el mismo texto, desde la raíz. Es el mismo patrón de redundancia que ya se resolvió con `GPO - Windows10 - Screen Lock Policy`.

**Evidencia:** [`evidencias/07-Banner-Duplicado-Default-Domain-Policy.png`](evidencias/07-Banner-Duplicado-Default-Domain-Policy.png).

**Decisión:** por ahora se deja documentado tal cual está en la consola (banner duplicado, sin conflicto funcional porque el texto es idéntico) y se sigue con el resto de la documentación. Queda pendiente para una pasada de consolidación posterior — mismo criterio que en su momento se aplicó con `Screen Lock Policy`.

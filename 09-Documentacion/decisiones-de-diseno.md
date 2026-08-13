# 🧠 Decisiones de diseño

Registro de las decisiones más relevantes tomadas durante el proyecto, con su justificación — el tipo de razonamiento que se espera poder explicar en una entrevista técnica.

---

## 🔹 Por qué AGDLP y no asignar permisos directo a usuarios

Asignar permisos NTFS directamente a cuentas individuales escala mal: cada alta, baja o cambio de puesto requeriría tocar permisos carpeta por carpeta. Con AGDLP, el acceso se administra exclusivamente moviendo membresías de grupo — los permisos NTFS no se vuelven a tocar una vez configurados.

---

## 🔹 Por qué la estructura de 13 OUs

Separar OUs de negocio (departamentos, con usuarios) de OUs técnicas (equipos, servidores, grupos, cuentas de servicio, bajas) permite aplicar GPOs de forma selectiva sin que una política de escritorio termine afectando, por ejemplo, cuentas de servicio.

---

## 🔹 Por qué el recurso compartido queda permisivo y el control real está en NTFS

El permiso de recurso compartido (Share) solo aplica en acceso por red; NTFS aplica siempre. Concentrar el control de acceso en NTFS permite aplicar el modelo AGDLP con precisión, en vez de duplicar lógica de control en dos capas distintas.

---

## 🔹 Por qué se quitó el grupo "Usuarios" de cada carpeta departamental

Por defecto, las carpetas heredan una entrada de "Usuarios" (dominio completo) con acceso de lectura — dejarla activa anula el aislamiento por departamento que es el objetivo central del proyecto. Se corrigió deshabilitando herencia y dejando solo el `DL_<Departamento>_RW` correspondiente. Ver detalle en [`../04-File-Server/permisos-ntfs.md`](../04-File-Server/permisos-ntfs.md).

---

## 🔹 Por qué auditoría diferenciada en Dirección

Auditar lecturas en todo el dominio genera un volumen de eventos que dificulta encontrar lo relevante. Se decidió auditar solo escrituras/eliminaciones de forma general, y sumar auditoría de lectura específicamente donde la sensibilidad de la información lo justifica (Dirección) — una decisión de auditoría basada en riesgo, no aplicada uniformemente sin criterio.

---

## 🔹 Por qué delegar a un grupo y no a una persona

Delegar permisos administrativos directo a una cuenta individual obliga a reconfigurar todo si esa persona cambia de rol o se va de la empresa. Delegar a un grupo (`SG_Delegados_Helpdesk`) permite rotar personal simplemente cambiando membresías, sin tocar la delegación en sí.

---

## 🔹 Por qué no se usó la Papelera de reciclaje de AD en este laboratorio

Se dejó deshabilitada intencionalmente para que el Caso 6 (Disable vs. Delete) demuestre la irreversibilidad real de una eliminación — igual que en cualquier dominio real donde esa protección no esté activada. Queda documentado como mejora futura conocida, no como omisión no advertida.

---

## 🔹 Por qué se consolidó a un solo mecanismo de bloqueo de pantalla y un solo lugar para el banner legal

Una revisión del RSoP combinado del cliente Windows 10 mostró dos GPOs distintas resolviendo lo mismo: `GPO - Windows10 - Banner Legal` y `GPO - Windows10 - Screen Lock Policy` traían el mismo aviso legal, y esta última además implementaba un bloqueo por protector de pantalla clásico (600 seg) que duplicaba, con el mismo valor pero por un camino técnico distinto, el `Inicio de sesión interactivo: límite de inactividad del equipo` ya definido en Default Domain Policy.

Se optó por dejar el mecanismo **moderno** (Opciones de seguridad, en Default Domain Policy) porque ya cubre todo el dominio — incluido el DC — sin depender de que el protector de pantalla esté disponible o habilitado en cada equipo. El mecanismo clásico (protector de pantalla + contraseña) es más frágil: depende de una función que un usuario o una imagen corporativa distinta podría deshabilitar sin tocar ninguna GPO.

Confirmado que `GPO - Windows10 - Screen Lock Policy` no tenía ningún otro ajuste configurado más allá del banner duplicado y el bloqueo redundante, se eliminó la GPO completa en vez de dejarla vacía y vinculada (una GPO sin configuración vinculada no aporta nada y es ruido en cualquier reporte de RSoP futuro) o simplemente desvincularla (el objeto seguiría existiendo sin ningún vínculo ni plan de reutilización). Antes de eliminarla se generó una copia de seguridad desde GPMC, como práctica estándar antes de cualquier baja de GPO — el mismo criterio de "backup antes de borrar" que ya se aplica en el resto del proyecto.

Verificado después con `gpresult` en el cliente: un solo aviso legal y un solo mecanismo de timeout de inactividad en el resultado combinado.

---

## 🔹 Por qué se habilitó "Permitir bloqueo de la cuenta del administrador"

Por defecto, Windows exime a la cuenta local `Administrador` de la directiva de bloqueo por intentos fallidos — es una protección pensada para que un atacante no pueda dejar sin acceso administrativo a un equipo simplemente escribiendo mal la contraseña de esa cuenta a propósito, repetidas veces.

En este proyecto se decidió revertir esa excepción a propósito: la directiva de bloqueo de cuenta (5 intentos, 15 minutos) aplica **sin distinción de rango** — un Gerente y un empleado de cualquier nivel quedan sujetos exactamente a la misma política. Mantener una cuenta exenta por defecto contradice ese criterio: precisamente las cuentas con más privilegio son las que más conviene proteger contra ataques de fuerza bruta, no las que conviene eximir.

El riesgo que la exención por defecto busca evitar (quedarse sin ningún acceso administrativo si la cuenta de administrador se bloquea) está mitigado en este entorno porque el acceso administrativo no depende de una sola cuenta: existe el grupo `Admins. del dominio` con membresía propia, y la delegación a `SG_Delegados_Helpdesk` (Caso 7) permite operaciones administrativas acotadas sin depender de la cuenta `Administrador` local. Si esa cuenta puntual se bloquea, sigue habiendo caminos de acceso administrativo alternativos para desbloquearla.

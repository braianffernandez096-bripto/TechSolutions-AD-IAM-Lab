# 🧪 Preparación del laboratorio

Antes de cargar los tickets de cada día, corré la preparación de ese día (la hace "el mundo", no vos como agente). Si un paso falla, avisame antes de seguir.

| Día | Dónde | Preparación |
|---|---|---|
| 1 | DC01 | `(Get-ADDefaultDomainPasswordPolicy).LockoutThreshold` → pasame el número (si es `0`, no hay bloqueo de cuentas y adaptamos el ticket 1) |
| 1 | Kali | `for i in 1 2 3 4 5 6; do nxc smb 192.168.64.132 -u lsilva -p "Vacaciones$i!"; done` |
| 1 | DC01 | `Remove-ADGroupMember GG_Finanzas -Members cfernandez -Confirm:$false` |
| 2 a 3 | — | Sin preparación |
| 4 | WIN10 (sesión de un usuario) | `Start-Process powershell -WindowStyle Hidden -ArgumentList '-NoProfile -Command while($true){}'` |
| 5 | Kali | Repetí el comando del día 1 contra `lsilva` |

---

> Esta preparación la ejecuta "el mundo" antes de cada día; el agente de Help Desk trabaja los tickets sin usar esa información. El día 4, la preparación se corrió primero en una sesión que había quedado abierta con `ptorres`, lo que terminó apareciendo en Wazuh como un hallazgo dentro de la simulación (TSD-20).

## Texto original de los tickets


### 📅 Día 1 — Lunes

**T1 · Luciana Silva** · Portal
> **Asunto:** No puedo entrar a la compu
> Hola, volví hoy de vacaciones y cuando pongo mi contraseña me sale que la cuenta está bloqueada. Probé varias veces porque no me acordaba bien cuál era. Tengo que cargar pagos a proveedores antes del mediodía. ¡Gracias!

**T2 · Mariana Díaz** · Portal
> **Asunto:** Alta de nuevo ingreso
> Buen día. El lunes que viene ingresa **Tomás Rivas** como **HR Assistant** en Recursos Humanos, reporta a Gabriela Herrera. Necesita usuario, correo y acceso a la carpeta compartida de RRHH. Gracias.

**T3 · Carlos Fernandez** · Portal
> **Asunto:** Acceso denegado carpeta Finanzas
> Desde esta mañana no puedo abrir la carpeta de Finanzas en el compartido, me sale "acceso denegado". El viernes funcionaba. Necesito el archivo de conciliación bancaria.

**T4 · Camila Ortiz** · Portal
> **Asunto:** Error en mi puesto
> Hola! En el directorio de la empresa figura mi puesto como "Fronted Developer". Es "Frontend". No es urgente, pero queda feo en las firmas. 🙂

**T5 · Roxana Fernandez** · Por mail a la mesa de ayuda
> **Asunto:** Mi usuario
> Hola. Noté que mi usuario es "Roxfernandez" y el del resto del equipo es la inicial y el apellido. ¿Lo pueden cambiar para que sea igual al de todos? Gracias. Roxana

---

### 📅 Día 2 — Martes

**T6 · Pedro Castillo** · Por teléfono
> **Asunto:** Olvidé mi contraseña
> (Llamada) "Hola, soy Pedro de Finanzas, me olvidé la contraseña y hoy tengo que liquidar sueldos. ¿Me la podés resetear y decírmela ahora por teléfono?"

**T7 · Nahuel Molina** · Portal
> **Asunto:** Permisos de administrador
> Necesito ser administrador de mi computadora para instalar Spotify y una extensión para descargar videos de YouTube para las capacitaciones. ¿Me dan los permisos?

**T8 · Diego Pérez** · Portal
> **Asunto:** Acceso para Ana a carpeta de Dirección
> Ana Gómez necesita **solo lectura** de la carpeta de Dirección para preparar el cierre trimestral. Lo apruebo yo como su jefe. Gracias.

**T9 · Paula Benítez** · Portal
> **Asunto:** Mail raro de soporte
> Hola, me llegó un mail de "Soporte IT TechSolutions" que decía que mi buzón estaba lleno y que validara mi cuenta en un link. Entré y puse mi usuario y contraseña, después me pareció raro porque la página era fea. ¿Era de ustedes?

**T10 · Carlos Fernandez** · Portal
> **Asunto:** Sigo sin poder entrar a Finanzas
> Ayer me avisaron que estaba resuelto lo de la carpeta pero sigo con "acceso denegado". No apagué la compu desde ayer porque estaba con un proceso largo.

**T11 · Sebastián Morales** · Portal
> **Asunto:** Reporte de cuentas inactivas
> Para la revisión trimestral de accesos, necesito el listado de cuentas **habilitadas** que no inician sesión hace más de 90 días, con su área. Puede ser en CSV.

---

### 📅 Día 3 — Miércoles

**T12 · Sofía Álvarez (SOC)** · Portal
> **Asunto:** Alerta Wazuh 100211 — password spraying
> Wazuh disparó la regla de password spraying desde 192.168.64.128 contra varias cuentas del dominio. Desde Help Desk: verifiquen si quedó alguna cuenta bloqueada y **no desbloqueen ninguna sin confirmar antes con el titular** por un canal conocido. Pasennos el listado de cuentas afectadas.

**T13 · Pedro Castillo** · Portal
> **Asunto:** Programa para abrir un .rar
> Un proveedor nos mandó la documentación en un archivo .rar y no lo puedo abrir. ¿Me instalan algo para descomprimirlo?

**T14 · Mariana Díaz** · Portal
> **Asunto:** Baja de Nahuel Molina
> Nahuel Molina termina su contrato este **viernes a las 18 h**. Por favor gestionen la baja de sus accesos. Su equipo lo devuelve el mismo viernes.

**T15 · Gabriela Herrera** · Por teléfono, a nombre de **Tomás Rivas**
> **Asunto:** Tomás no puede entrar
> (Llamada) "Tomás vino a conocer la oficina y probó su usuario con la contraseña que le dieron, pero le pide algo de cambiar contraseña y después le da error. ¿Pueden verlo?"

**T16 · Luis Suárez** · Portal
> **Asunto:** Acceso temporal para David
> Necesito que David Soule tenga acceso a la carpeta de Finanzas **hasta el 31 de diciembre** para revisar el presupuesto anual. Lo apruebo como CFO.

---

### 📅 Día 4 — Jueves

**T17 · Diego Pérez** · Portal
> **Asunto:** Cambio de área de Ana Gómez
> A partir del lunes, Ana Gómez pasa a Recursos Humanos como **Payroll Specialist**, reportando a Gabriela Herrera. Gabriela está al tanto.

**T18 · Federico Acosta** · Portal
> **Asunto:** PC muy lenta
> Desde esta mañana mi PC (WIN10) está lentísima, el ventilador no para y no abrí nada pesado. ¿Pueden revisarla?

**T19 · Giovanni Lo Celso (supervisor)** · Interno
> **Asunto:** Artículo de base de conocimiento
> Esta semana tuvimos varios pedidos de contraseña. Armá un artículo en la base de conocimiento: cómo cambiar la contraseña, requisitos de la política del dominio y qué hacer si la cuenta se bloquea.

**T20 · Nicolas Romero** · Portal
> **Asunto:** Acceso a carpeta de Ciberseguridad
> Para un proyecto de integración con el SIEM necesito acceso a la carpeta de Ciberseguridad. ¿Me lo pueden habilitar hoy?

**T21 · Gabriela Herrera** · Portal
> **Asunto:** Consulta sobre accesos
> ¿Es posible que el acceso de Tomás a la carpeta de RRHH sea solo de lectura durante el primer mes? Después le daríamos permisos completos.

---

### 📅 Día 5 — Viernes

**T22 · Sofía Álvarez (SOC)** · Por teléfono, **urgente**
> **Asunto:** Contención — cuenta de Carlos Fernandez
> (Llamada) "Detectamos actividad sospechosa con la cuenta de Carlos Fernandez desde un host desconocido. Necesitamos que la **deshabiliten ya**, sin avisarle todavía, y nos confirmen la hora exacta. Después la investigamos."

**T23 · Luciana Silva** · Por teléfono
> **Asunto:** Otra vez bloqueada
> (Llamada) "Me volvió a pasar lo del lunes, estoy bloqueada otra vez y te juro que hoy no me equivoqué con la contraseña."

**T24 · Mariana Díaz** · Portal (recordatorio)
> **Asunto:** RE: Baja de Nahuel Molina
> Les recuerdo que hoy a las 18 h es el último día de Nahuel. ¿Está todo listo?

**T25 · Giovanni Lo Celso (supervisor)** · Interno
> **Asunto:** Informe semanal
> Antes de irte, mandame el resumen de la semana: tickets recibidos y resueltos, cumplimiento de SLA, escalamientos y qué te parece que hay que mejorar.

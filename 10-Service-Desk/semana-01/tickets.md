# 🎫 Tickets de la semana 1

SLA en formato *tiempo restante* al cerrar el reloj (negativo = incumplido). "—" = Jira no registró ese SLA. Las respuestas de otras áreas (SOC, IAM, gerentes, usuarios) son simuladas; los comandos y la evidencia son del laboratorio real.

## Día 1

| Clave | Solicitante | Tipo · Prioridad | SLA 1.ª resp. / resol. | Resolución |
|---|---|---|---|---|
| TSD-1 | Luciana Silva | Incidente · High | 0:33 / 0:54 | **Hecho.** El bloqueo no lo causó la usuaria: 6 fallos automatizados desde 192.168.64.128 (4625, tipo 3, sin equipo). Identidad verificada por devolución de llamada, reset con cambio obligatorio, escalado al SOC en TSD-7 |
| TSD-2 | Mariana Díaz (RRHH) | Solicitud · Medium | 0:34 / 2:41 | **Hecho.** Alta de `trivas` en `02_RRHH`, `GG_RRHH`, contraseña temporal entregada a la gerente. Fecha de vencimiento cargada (día de ingreso) |
| TSD-3 | Carlos Fernandez | Incidente · High | 0:37 / 0:48 | **Hecho.** Removido de `GG_Finanzas` (4729) por `adm.bfernandez` sin ticket. Confirmado con el gerente, restaurado, informado al SOC |
| TSD-4 | — | — | — | Duplicado de carga de TSD-3, archivado |
| TSD-5 | Camila Ortiz | Solicitud · Low | 0:40 / 6:47 | **Hecho.** Corrección del puesto "Fronted" → "Frontend Developer" |
| TSD-6 | Roxana Fernandez (CEO) | Solicitud · Low | 0:39 / 6:39 | **Hecho.** Cambio de `sAMAccountName` aprobado por el IT Manager y ejecutado en la ventana del viernes. SID sin cambios |
| TSD-7 | Help Desk (interno) | Incidente · Highest | n/a / 0:37 | **Hecho.** Ticket del incidente de seguridad; reunió TSD-1, 3, 8, 11, 14, 20, 24 y 25. Cerrado por el SOC |

## Día 2

| Clave | Solicitante | Tipo · Prioridad | SLA 1.ª resp. / resol. | Resolución |
|---|---|---|---|---|
| TSD-8 | Pedro Castillo | Solicitud · High | **-0:23** / 1:03 | **Hecho.** Pedido telefónico: no se dictó la contraseña. Devolución de llamada, reset con cambio obligatorio. 2 fallos previos desde la IP del atacante, informados al TSD-7 |
| TSD-9 | Nahuel Molina | Solicitud · Low | 0:50 / 6:50 | **Rechazado.** Permisos de administrador para Spotify y una extensión de descarga: sin justificación, software no aprobado. Alternativa para los videos de capacitación |
| TSD-10 | Diego Pérez | Solicitud · Medium | **-0:01** / 2:55 | **Hecho.** El jefe de la solicitante no es el dueño de la carpeta de Dirección: aprobó el COO. IAM creó `DL_Direccion_R` (lectura); vencimiento 31/12 |
| TSD-11 | Paula Benítez | Incidente · Highest | 0:13 / 0:40 | **Hecho.** Credenciales entregadas en phishing. Reclasificado a P1, reset inmediato, sin logons sospechosos en el DC, escalado al SOC (dominio bloqueado, 4 destinatarios más) |
| TSD-12 | Carlos Fernandez | Incidente · High | **-0:23** / 1:03 | **Hecho.** La membresía estaba bien: no había cerrado sesión después del cambio del TSD-3 |
| TSD-13 | Sebastián Morales | Solicitud · Medium | **-0:08** / 2:47 | **Hecho.** CSV de 38 cuentas inactivas (+90 días), 33 sin inicio de sesión desde la carga masiva. Detectados errores de datos en AD |

## Día 3

| Clave | Solicitante | Tipo · Prioridad | SLA 1.ª resp. / resol. | Resolución |
|---|---|---|---|---|
| TSD-14 | Sofía Álvarez (SOC) | Incidente · Highest | **-0:08** / 0:36 | **Hecho.** Spraying contra ~92 cuentas (24/11), usuarios inexistentes (25/11), ataques dirigidos. **Logons exitosos** con `ptorres` y `dvera` → deshabilitadas y reseteadas a las 18:05:31 |
| TSD-15 | Pedro Castillo | Solicitud · Medium | **-0:15** / 2:40 | **Hecho.** `.rar` de un proveedor: verificado por el teléfono del registro de proveedores y analizado por el SOC. Se pidió reenvío en `.zip` en lugar de instalar software |
| TSD-16 | Mariana Díaz (RRHH) | Solicitud · Medium | 0:17 / 3:15 | **Hecho.** Baja programada: expiración automática como respaldo; el viernes, deshabilitada, sin grupos, movida a `13_Disabled_Users`, grupos previos en la descripción |
| TSD-17 | Gabriela Herrera (por Tomás) | Incidente · Medium | 0:38 / 3:22 | **Hecho.** Sin fallos de logon: la contraseña nueva no cumplía la política. Se guió al usuario, sin reset |
| TSD-18 | Luis Suárez (CFO) | Solicitud · Medium | 0:17 / 2:52 | **Hecho.** Aprobación válida del dueño del recurso. IAM creó `DL_Finanzas_R`; `dsoule` con lectura hasta el 31/12 |

## Día 4

| Clave | Solicitante | Tipo · Prioridad | SLA 1.ª resp. / resol. | Resolución |
|---|---|---|---|---|
| TSD-19 | Diego Pérez | Solicitud · Medium | 0:56 / 3:24 | **Hecho.** Cambio de área de `agomez` a RRHH. Se quitaron `GG_Finanzas` **y** el acceso temporal `DL_Direccion_R` (acumulación de accesos). Ejecutado en la ventana del viernes |
| TSD-20 | Federico Acosta | Incidente · High | — / 1:30 | **Hecho.** `powershell` oculto con bucle infinito documentado antes de terminarlo; validado con el usuario y el SOC. En Wazuh: `ptorres` ejecutó lo mismo **después de deshabilitada** |
| TSD-21 | Giovanni Lo Celso | Solicitud · Low | — / 6:32 | **Hecho.** [Artículo de base de conocimiento](../base-de-conocimiento/cambio-de-contrasena-y-bloqueo.md) publicado en el portal |
| TSD-22 | Nicolas Romero | Solicitud · Medium | — / 3:23 | **Rechazado** por el Security Manager (información sensible). La documentación necesaria se compartió por otra vía |
| TSD-23 | Gabriela Herrera | Solicitud · Low | 1:55 / 7:22 | **Hecho.** `trivas` pasa de `GG_RRHH` a `DL_RRHH_R` (lectura) durante la capacitación; revisión el 30/12 |

## Día 5

| Clave | Solicitante | Tipo · Prioridad | SLA 1.ª resp. / resol. | Resolución |
|---|---|---|---|---|
| TSD-24 | Sofía Álvarez (SOC) | Incidente · Highest | 0:10 / 0:50 | **Hecho.** Pedido telefónico verificado por devolución de llamada. `cfernandez` deshabilitada a las 14:24:28, sin sesiones abiertas. Causa (SOC): credenciales entregadas en el phishing del TSD-11 |
| TSD-25 | Luciana Silva | Incidente · High | — / 3:47 | **Hecho.** Nuevo bloqueo desde la misma IP: el atacante seguía en la red. Desbloqueo sin reset (todos los intentos fallaron). El dato permitió al SOC ubicar la notebook no autorizada |
| (T24) | Mariana Díaz | — | — | Recordatorio de la baja: agregado al TSD-16, **no** se abrió un ticket nuevo |
| TSD-26 | Giovanni Lo Celso | Solicitud · Medium | 0:39 / — | [Informe semanal](informe-semanal.md) |

## Lecciones que dejó cada error

| Error | Ticket | Qué se cambió |
|---|---|---|
| Incidente cargado como solicitud | TSD-1, TSD-11 | Clasificar al crear: "puse mi contraseña" o "no puedo entrar" son incidentes |
| Acuse de recibo tardío | TSD-8, 10, 12, 13, 14, 15 | El acuse se manda en el triaje, antes de investigar |
| Ticket cerrado sin confirmación del usuario | TSD-3 → TSD-12 | Si la solución depende del usuario, esperar su confirmación |
| Contención sin cerrar sesiones | TSD-14 → TSD-20 | Deshabilitar + cerrar sesiones activas + reiniciar el equipo |

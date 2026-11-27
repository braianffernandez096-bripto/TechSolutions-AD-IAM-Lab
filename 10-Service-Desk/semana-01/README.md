# 📅 Semana 1 — Diario de trabajo

25 tickets en 5 días simulados (TSD-1 a TSD-26). Lo que empezó como un bloqueo de cuenta "común" el lunes terminó en un **incidente de seguridad**: password spraying desde un equipo no autorizado, 4 cuentas comprometidas y una campaña de phishing.

- 📊 Métricas, SLA y mejoras: [`informe-semanal.md`](informe-semanal.md)
- 🎫 Cada ticket con su resolución: [`tickets.md`](tickets.md)
- 🧪 Cómo se simuló cada problema en el laboratorio: [`preparacion-laboratorio.md`](preparacion-laboratorio.md)

## Resultado

| Métrica | Valor |
|---|---|
| Tickets | 25 (10 incidentes, 15 solicitudes) |
| Resueltos | 24 · 2 rechazados con alternativa ofrecida |
| SLA de resolución | **100 %** |
| SLA de primera respuesta | **70 %** (6 incumplimientos, misma causa: acuse tardío en lotes con un P1) |
| Escalamientos | 7 al SOC · 3 a IAM · 1 al IT Manager |

## 🛠️ Configuración de Jira

![Proyecto TSD en Jira Service Management](Evidencias/01-jira-proyecto-tsd.png)

| SLA de primera respuesta | Condiciones |
|---|---|
| ![Objetivos por prioridad](Evidencias/02-sla-primera-respuesta-objetivos.png) | ![Iniciar, pausar, finalizar](Evidencias/03-sla-primera-respuesta-condiciones.png) |

| SLA de resolución (pausa en espera del cliente) | Resoluciones creadas |
|---|---|
| ![Condiciones del SLA de resolución](Evidencias/04-sla-resolucion-condiciones.png) | ![Hecho, Duplicado, Rechazado…](Evidencias/05-resoluciones.png) |

## Día 1 — Un bloqueo que no fue culpa de la usuaria

**TSD-1:** Luciana dice que se equivocó de contraseña. La evidencia dice otra cosa: 6 fallos en 6 segundos, por red, desde una IP que no es ningún puesto de la empresa.

| Estado de la cuenta | Origen de los fallos (4625) |
|---|---|
| ![Cuenta de lsilva](Evidencias/06-tsd1-estado-cuenta-lsilva.png) | ![6 fallos desde 192.168.64.128](Evidencias/07-tsd1-origen-4625-ip.png) |

Se verificó la identidad por devolución de llamada, se reseteó con cambio obligatorio y se abrió un ticket aparte para el SOC (**TSD-7**).

![TSD-7: escalamiento al SOC](Evidencias/08-tsd7-escalamiento-soc.png)

| Reset | Resuelto dentro del SLA |
|---|---|
| ![Reset de lsilva](Evidencias/09-tsd1-reset.png) | ![TSD-1 cerrado](Evidencias/10-tsd1-resuelto-sla.png) |

**TSD-3:** "acceso denegado, el viernes funcionaba". La causa fue que una cuenta privilegiada lo sacó de su grupo **sin ticket**, 18 segundos después del ataque a Luciana. Se confirmó con el gerente, se restauró y se informó al SOC.

| Grupos y permisos de la carpeta | Evento 4729 | Quién lo hizo |
|---|---|---|
| ![Cuenta y ACL](Evidencias/11-tsd3-cuenta-y-acl.png) | ![4729](Evidencias/12-tsd3-evento-4729.png) | ![adm.bfernandez](Evidencias/13-tsd3-quien-quito-grupo.png) |

**TSD-2** (alta de Tomás Rivas) y **TSD-6** (cambio de usuario de la CEO, aprobado y programado fuera de horario, con el SLA en pausa):

| Alta | Cambio programado |
|---|---|
| ![trivas creado](Evidencias/14-tsd2-alta-trivas.png) | ![SLA en pausa](Evidencias/15-tsd6-cambio-programado-pausa.png) |

## Día 2 — Phishing y presión por teléfono

![Cola del día 2](Evidencias/16-dia2-cola-carga.png)

**TSD-11 (P1):** una usuaria ingresó sus credenciales en un sitio falso. Reclasificado a incidente Highest, contención inmediata (reset), revisión de inicios de sesión y escalamiento al SOC.

![TSD-11 en Highest con el SLA en pausa](Evidencias/17-tsd11-phishing-p1.png)

**TSD-8:** un pedido de reset "por teléfono, decime la contraseña ahora". Devolución de llamada al interno registrado, contraseña entregada fuera del ticket, y un hallazgo: la **misma IP del atacante** había probado contra esta cuenta dos días antes.

![Fallos contra pcastillo desde la IP del atacante](Evidencias/18-tsd8-fallos-ip-atacante.png)

**TSD-10:** un gerente aprueba un acceso a una carpeta que no es suya, y pide "solo lectura" cuando ese permiso no existe. Se pidió la aprobación del dueño del recurso y IAM creó un grupo de lectura.

| Permisos de Dirección antes | Grupo de lectura creado |
|---|---|
| ![Solo DL_Direccion_RW](Evidencias/19-tsd10-acl-direccion.png) | ![DL_Direccion_R](Evidencias/20-tsd10-dl-direccion-r.png) |

También: permisos de administrador rechazados con alternativa (TSD-9), un usuario que no había cerrado sesión (TSD-12) y un reporte de 38 cuentas inactivas con errores de datos detectados (TSD-13).

## Día 3 — La alerta del SIEM y la pregunta correcta

![Cola del día 3](Evidencias/21-dia3-cola-carga.png)

**TSD-14:** el SOC pide revisar una alerta de Wazuh (regla 100211). "No hay cuentas bloqueadas" habría cerrado el ticket, pero la pregunta correcta fue **¿algún intento funcionó?**

| Inicios exitosos desde la IP | Cuentas comprometidas | Antes o después del reset |
|---|---|---|
| ![4624 desde 192.168.64.128](Evidencias/22-tsd14-logons-exitosos.png) | ![ptorres y dvera](Evidencias/23-tsd14-cuentas-comprometidas.png) | ![Fechas de acceso](Evidencias/24-tsd14-fechas-accesos.png) |

| Contención | Lección: SLA de primera respuesta incumplido |
|---|---|
| ![Cuentas deshabilitadas a las 18:05:31](Evidencias/25-tsd14-contencion.png) | ![-8 min en un P1](Evidencias/26-tsd14-sla-primera-respuesta-incumplido.png) |

También: diagnóstico sin reset de un empleado nuevo cuya contraseña no cumplía la política (TSD-17), baja programada con expiración automática (TSD-16) y acceso temporal de solo lectura aprobado por el dueño del recurso (TSD-18).

| Política de contraseñas | Expiración programada | Lectura en Finanzas |
|---|---|---|
| ![Política](Evidencias/27-tsd17-politica-contrasenas.png) | ![nmolina expira 27/11 18:00](Evidencias/28-tsd16-expiracion-programada.png) | ![DL_Finanzas_R](Evidencias/29-tsd18-dl-finanzas-r.png) |

## Día 4 — Evidencia antes que limpieza

![Cola del día 4 con prioridades](Evidencias/30-dia4-cola-prioridades.png)

**TSD-20:** una PC lenta en el equipo de un Threat Hunter. El proceso se documentó **antes** de terminarlo, y la búsqueda en Wazuh trajo un hallazgo inesperado: la cuenta comprometida `ptorres` ejecutó el mismo proceso **después de deshabilitada**. Deshabilitar una cuenta no cierra las sesiones abiertas.

| Proceso oculto | Evidencia en Wazuh (Sysmon ID 1) |
|---|---|
| ![powershell con bucle infinito](Evidencias/31-tsd20-proceso-sospechoso.png) | ![Dos ejecuciones: facosta y ptorres](Evidencias/32-tsd20-wazuh-sysmon.png) |

**TSD-19 (cambio de área):** la empleada había acumulado un acceso temporal que ya no correspondía. **TSD-23:** solo lectura para un empleado en capacitación. **TSD-21:** artículo de base de conocimiento publicado.

| Accesos antes del cambio | Solo lectura en RRHH | Artículo publicado |
|---|---|---|
| ![GG_Finanzas + DL_Direccion_R](Evidencias/33-tsd19-accesos-ana.png) | ![DL_RRHH_R](Evidencias/34-tsd23-dl-rrhh-r.png) | ![Base de conocimiento](Evidencias/35-tsd21-articulo-kb-publicado.png) |

## Día 5 — Contención, cierre del incidente y ventana de cambios

![Cola del día 5](Evidencias/36-dia5-cola-carga.png)

**TSD-24:** pedido urgente del SOC por teléfono, verificado por devolución de llamada antes de actuar. **TSD-25:** la usuaria del lunes, bloqueada otra vez desde la misma IP: el atacante seguía conectado. Ese dato le permitió al SOC ubicar y retirar una notebook no autorizada.

| Contención de cfernandez | Bloqueo recurrente desde la misma IP |
|---|---|
| ![cfernandez deshabilitada](Evidencias/37-tsd24-contencion-cfernandez.png) | ![6 fallos el 27/11](Evidencias/38-tsd25-lsilva-bloqueo-recurrente.png) |

**Ventana de cambios (18:00):**

| Baja de Nahuel | Cambio de área de Ana | Cambio de usuario (mismo SID) |
|---|---|---|
| ![Deshabilitado y en 13_Disabled_Users](Evidencias/39-ventana-baja-nahuel.png) | ![Solo GG_RRHH](Evidencias/40-ventana-mover-ana.png) | ![rfernandez, SID ...-1122](Evidencias/41-ventana-rename-roxana-sid.png) |

![Cola al cierre de la semana](Evidencias/42-cola-final.png)

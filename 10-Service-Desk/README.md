# 🎟️ 10 — Service Desk: simulación de Help Desk L1 con Jira

Simulación de **trabajo real de mesa de ayuda nivel 1** sobre el dominio de este laboratorio (`techsolutions.local`), gestionada en **Jira Service Management**. Cada día llega un lote de tickets de empleados reales del dominio; se clasifican, se priorizan, se resuelven en las VMs (DC01, WIN10, Wazuh) y se documentan con SLA, notas internas y escalamientos.

El objetivo no es "cerrar tickets", sino mostrar **criterio**: verificar identidad antes de un reset, pedir la aprobación del dueño del recurso, aplicar mínimo privilegio, reconocer un incidente de seguridad detrás de un pedido común y escalarlo a tiempo.

## 🧭 Cómo funciona

| Elemento | Implementación |
|---|---|
| Herramienta | Jira Service Management (proyecto `TSD`, plantilla de soporte de TI) |
| Rol | Agente Help Desk L1. Escalamiento a SOC (Sofía Álvarez), IAM (Lucía Cabrera) e IT Manager (Giovanni Lo Celso) |
| Clientes | 19 empleados reales del dominio, cargados como clientes de Jira |
| Tipos | Incidentes (`[System] Incident`) y solicitudes de servicio (`[System] Service request`) |
| Etiquetas | `dia-01` … `dia-05` por día simulado, `interno` para tickets de la propia mesa |
| Resoluciones | Hecho, Duplicado, Rechazado, No se reproduce, Cancelado por el usuario |
| Base de conocimiento | Confluence integrado al portal ([artículo publicado](base-de-conocimiento/cambio-de-contrasena-y-bloqueo.md)) |

### SLA (calendario 24x7)

| Prioridad | Primera respuesta | Resolución |
|---|---|---|
| Highest (P1) | 15 min | 1 h |
| High (P2) | 30 min | 2 h |
| Medium (P3) | 1 h | 4 h |
| Low (P4) | 2 h | 8 h |

El SLA de resolución se pausa en *Esperando por el cliente* y *Pending* (por ejemplo, un cambio programado o una aprobación pendiente).

### Matriz de prioridad

| Prioridad | Criterio |
|---|---|
| Highest | Incidente de seguridad activo o muchas personas sin poder trabajar |
| High | Una persona sin poder trabajar, o un usuario VIP con impacto |
| Medium | Trabaja con dificultad, o pedido con fecha cercana |
| Low | Consultas y cambios menores sin urgencia |

## 📅 Semanas

| Semana | Tickets | SLA 1.ª respuesta | SLA resolución | Detalle |
|---|---|---|---|---|
| [Semana 1](semana-01/) | 25 | 70 % | 100 % | Incidente de seguridad: password spraying, 4 cuentas comprometidas y un equipo no autorizado en la red |

## 🔗 Relación con el resto del laboratorio

- Los procedimientos de alta, cambio de área, baja, reset y desbloqueo son los de [`07-Casos-IAM`](../07-Casos-IAM/), ahora ejecutados como tickets.
- Los permisos siguen el modelo [`03-IAM-AGDLP`](../03-IAM-AGDLP/). Esta semana se crearon tres grupos de solo lectura (`DL_Direccion_R`, `DL_Finanzas_R`, `DL_RRHH_R`).
- Las alertas y la evidencia de procesos vienen de [`13-Wazuh-SIEM`](../13-Wazuh-SIEM/) (reglas 100211, 100203, 100221 y Sysmon).

> 🔒 Laboratorio aislado con fines educativos. Los usuarios, los incidentes y las respuestas de otras áreas (SOC, IAM, gerentes) son simulados; los comandos y la evidencia del dominio son reales.

# 📊 Informe semanal — Mesa de Ayuda L1 · Semana 1

**Para:** Giovanni Lo Celso (IT Manager) · **De:** Braian Fernandez (Help Desk L1) · **Período:** días 1 a 5 (TSD-1 a TSD-26)
**Fuente:** exportación de Jira Service Management (`project = TSD`)

---

## 1. Resumen ejecutivo

- **25 tickets** gestionados: 24 resueltos y 1 en curso (este informe).
- **SLA de resolución: 100 % cumplido** (25 de 25 dentro del objetivo).
- **SLA de primera respuesta: 70 % cumplido** (14 de 20 medidos, sin contar tickets internos). Es el punto a mejorar.
- **Incidente de seguridad de la semana:** un equipo no autorizado conectado a la red hizo password spraying contra unas 92 cuentas y comprometió 2 (`ptorres`, `dvera`). Help Desk lo detectó a partir de un bloqueo de cuenta "común" (TSD-1), lo escaló al SOC y aplicó la contención. Además, una campaña de phishing comprometió las credenciales de 2 usuarios más (`pbenitez`, `cfernandez`).

## 2. Volumen

| Día | Tickets | Claves |
|---|---|---|
| Día 1 | 6 | TSD-1, 2, 3, 5, 6, 7 |
| Día 2 | 6 | TSD-8 a TSD-13 |
| Día 3 | 5 | TSD-14 a TSD-18 |
| Día 4 | 5 | TSD-19 a TSD-23 |
| Día 5 | 3 | TSD-24, 25, 26 |
| **Total** | **25** | TSD-4 fue un duplicado de carga, archivado |

| Por tipo | Cantidad | | Por prioridad | Cantidad |
|---|---|---|---|---|
| Incidentes | 10 | | Highest (P1) | 4 |
| Solicitudes de servicio | 15 | | High (P2) | 5 |
| | | | Medium (P3) | 11 |
| | | | Low (P4) | 5 |

**Resoluciones:** 22 *Hecho* · 2 *Rechazado* (TSD-9, permisos de administrador; TSD-22, acceso a Ciberseguridad sin aprobación del dueño) · 1 en curso.

## 3. Cumplimiento de SLA

| SLA | Objetivo (P1 / P2 / P3 / P4) | Cumplidos | Incumplidos | % |
|---|---|---|---|---|
| Primera respuesta | 15 min / 30 min / 1 h / 2 h | 14 | 6 | **70 %** |
| Resolución | 1 h / 2 h / 4 h / 8 h | 25 | 0 | **100 %** |

**Incumplimientos de primera respuesta y causa**

| Ticket | Prioridad | Excedido | Causa |
|---|---|---|---|
| TSD-8 | High | 23 min | Lote de 6 tickets del día 2: el acuse se envió después de atender el P1 (TSD-11) |
| TSD-12 | High | 23 min | Misma causa |
| TSD-13 | Medium | 8 min | Misma causa |
| TSD-10 | Medium | 1 min | Misma causa |
| TSD-14 | Highest | 8 min | Se priorizó el análisis técnico antes del acuse de recibo |
| TSD-15 | Medium | 15 min | Acuse demorado durante la contención del TSD-14 |

*No se cuenta el TSD-7 (ticket interno abierto por Help Desk; el SLA de primera respuesta no aplica). En TSD-20, 21, 22 y 25 Jira no registró el SLA de primera respuesta (ajuste de configuración en curso).*

**Patrón:** los incumplimientos aparecen cuando entran varios tickets juntos y uno es urgente. El acuse de recibo se manda ticket por ticket, a medida que se trabajan, en lugar de **en el momento del triaje**.

## 4. Escalamientos y aprobaciones

| Destino | Tickets | Motivo |
|---|---|---|
| SOC (Sofía Álvarez) | TSD-7, 11, 14, 15, 20, 24, 25 | Accesos no autorizados, phishing, cuentas comprometidas, adjunto de un proveedor, proceso sospechoso |
| IAM (Lucía Cabrera) | TSD-10, 18, 23 | Grupos de **solo lectura** que no existían (`DL_Direccion_R`, `DL_Finanzas_R`, `DL_RRHH_R`) |
| IT Manager | TSD-6 | Aprobación de un cambio en una cuenta VIP (ventana programada) |
| Dueños de recursos | TSD-10, 18, 22, 23 | Aprobación de accesos: Dirección, Finanzas, Ciberseguridad, RRHH |

## 5. Incidente de seguridad (TSD-7)

| Fecha | Hecho | Detectado en |
|---|---|---|
| 24/11 | Password spraying desde 192.168.64.128 contra ~92 cuentas; accesos exitosos con `ptorres` y `dvera` | TSD-14 (revisión de 4624/4625) |
| 25/11 | Prueba de usuarios inexistentes (alerta Wazuh 100211); Kerberoasting y DCSync con `ptorres` (Wazuh 100203/100221) | TSD-14, SOC |
| 26/11 | Bloqueo de `lsilva` desde la misma IP; cambio de grupo de `cfernandez` sin ticket | TSD-1, TSD-3 |
| 26/11 | Phishing "Soporte IT": `pbenitez` entrega credenciales; `cfernandez` también, sin reportarlo | TSD-11, TSD-24 |
| 26/11 18:05 | Contención: `ptorres` y `dvera` deshabilitadas | TSD-14 |
| 27/11 | `ptorres` ejecuta un proceso en WIN10 **después** de deshabilitada (sesión abierta) | TSD-20 (Sysmon en Wazuh) |
| 27/11 14:14 | Nuevo bloqueo de `lsilva`: el atacante sigue activo | TSD-25 |
| 27/11 14:40 | El SOC ubica y retira la notebook no autorizada (sala de reuniones, 2.º piso) | TSD-7 |

**Cuentas afectadas:** `ptorres`, `dvera` y `cfernandez` (deshabilitadas, se rehabilitan el lunes con credenciales nuevas); `pbenitez` (contraseña reseteada el 26/11).

## 6. Cambios realizados en el dominio

- **Altas:** `trivas` (Tomás Rivas, RRHH).
- **Bajas:** `nmolina` (deshabilitado, sin grupos, en `13_Disabled_Users`).
- **Cambios de área:** `agomez` (Finanzas → RRHH; se quitaron `GG_Finanzas` y `DL_Direccion_R`).
- **Accesos temporales con vencimiento:** `dsoule` en `DL_Finanzas_R` (31/12); `trivas` en `DL_RRHH_R` (30/12, después vuelve a `GG_RRHH`).
- **Datos corregidos:** puesto de `cortiz`; usuario de Roxana Fernandez (`Roxfernandez` → `rfernandez`, mismo SID).
- **Base de conocimiento:** publicado "Cómo cambiar tu contraseña y qué hacer si tu cuenta se bloquea".

## 7. Mejoras propuestas

1. **Acuse de recibo en el triaje.** Al recibir un lote, mandar el acuse a todos los tickets antes de trabajar el primero. Es la causa de 6 de los 6 incumplimientos.
2. **Procedimiento de contención completo.** Deshabilitar la cuenta no cierra las sesiones abiertas (caso `ptorres` en WIN10). Agregar: cerrar sesiones activas, reiniciar el equipo afectado y tener en cuenta los tickets Kerberos vigentes (hasta 10 h).
3. **Grupos de solo lectura por departamento.** Esta semana hubo 3 pedidos de lectura y no existía ningún grupo. Proponer a IAM un `DL_<Área>_R` para cada carpeta.
4. **Revisión de accesos temporales.** Crear recordatorios para los vencimientos del 30/12 y el 31/12.
5. **Calidad de datos en AD.** Corregir `cmedina` (Department "Venta") y `nsosa` (Title "Sales Represantive"), y revisar los 38 usuarios inactivos con Sebastián Morales.
6. **Capacitación anti-phishing** para toda la empresa (pedido del SOC): 2 usuarios entregaron credenciales y solo 1 lo reportó.
7. **Configuración de Jira:** que los tickets internos queden fuera del SLA de primera respuesta (etiqueta `interno`) y revisar por qué 4 tickets no registraron ese SLA.

## 8. Lo que funcionó bien

- **Correlación entre tickets:** un bloqueo de cuenta (TSD-1), un acceso denegado (TSD-3) y una alerta del SIEM (TSD-14) terminaron vinculados en un mismo incidente.
- **Verificación de identidad** antes de cada reset y en cada pedido telefónico (TSD-1, 8, 24, 25).
- **Mínimo privilegio:** ningún acceso se otorgó sin la aprobación del dueño del recurso, y siempre con el permiso más bajo que alcanzaba.
- **Preservación de evidencia:** el proceso sospechoso del TSD-20 se documentó antes de terminarlo.

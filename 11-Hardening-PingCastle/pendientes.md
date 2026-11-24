# 📌 Pendientes y límites conocidos

Lo que quedó abierto, con su motivo. Documentarlo es parte del trabajo.

| Hallazgo | Estado | Motivo / plan |
|---|---|---|
| Un solo controlador de dominio (+5) | Abierto | Limitación de recursos del host. En producción se agregaría un segundo DC. |
| Windows 10 sin soporte (+5) | Abierto | Se resuelve al migrar el cliente a Windows 11 en la fase de Microsoft 365. |
| Auditoría de PowerShell | Pendiente | Candidata a una GPO nueva (Script Block Logging). |
| `Authenticated Users` puede crear registros DNS | Informativo | Revisar permisos de la zona. |
| `dsHeuristics` (CVE-2021-42291) | Informativo | Revisar y documentar. |
| NetCease | Pendiente | Limitar enumeración de sesiones SMB. |
| `Authenticated Users` en Pre-Windows 2000 Compatible Access | Informativo | Evaluar impacto antes de quitarlo. |
| Bind anónimo a rootDSE | Informativo | Comportamiento por defecto de AD. |

> La re-auditoría final (misma versión 4.1.2.0) se hará al cierre de todas las fases del laboratorio.

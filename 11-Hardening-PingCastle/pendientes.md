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
| Sesión nula (`Null Auth: True` en NetExec) | Revisado, sin exposición | El DC acepta abrir la sesión anónima (comportamiento normal de un DC), pero no entrega datos: `rpcclient enumdomusers` → `ACCESS_DENIED`, LDAP anónimo exige bind (`000004DC`), `RestrictAnonymousSAM = 1`, `EveryoneIncludesAnonymous = 0`, `dsHeuristics` por defecto y Pre-Windows 2000 solo con *Usuarios autentificados*. `NullSessionPipes` = `netlogon,samr,lsarpc` es el valor por defecto de un DC. |
| `DoesNotRequirePreAuth` en `svc_backup` | Corregido | Se encontró activo al validar la regla `100202` de Wazuh, pese a que el escenario 02 lo daba por quitado. Se desactivó y se verificó. Conviene incluir `Get-ADUser -Filter 'DoesNotRequirePreAuth -eq $true'` en cada re-auditoría. |

> Se hizo una re-auditoría intermedia después de la fase de Wazuh (score 5, ver [`README.md`](README.md#-re-auditoría-después-de-las-pruebas-con-wazuh)). La re-auditoría final (misma versión 4.1.2.0) se hará al cierre de todas las fases del laboratorio, después de migrar el cliente a Windows 11.

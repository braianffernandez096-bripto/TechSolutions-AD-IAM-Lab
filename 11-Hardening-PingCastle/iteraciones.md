# 🔁 Iteraciones de hardening

| Iter. | Foco | Cambios principales | Stale / Priv. / Anom. | Score |
|---|---|---|---|---|
| Baseline | Línea base | Informe inicial | — / — / — | 70 |
| 1 y 1b | Auditoría | Advanced Audit Policy completa, log de 512 MB, auditoría de línea de comandos (GPO `SEC-DC-Auditoria-Avanzada`) | 46 / 60 / 70 | 70 |
| 1c | Auditoría | Ajustes de auditoría (el bloque "Audit" del modelo de riesgo pasa a azul) | 46 / 60 / 60 | 60 |
| 2 | Quick wins | Spooler detenido y deshabilitado, contraseña mínima de 12, `MachineAccountQuota` en 0, Papelera de reciclaje de AD habilitada | — / 40 / 40 | 40 |
| 3 | Admin nominal | Cuenta `adm.bfernandez` en OU `11_Cuentas-Admin`, con `AccountNotDelegated`, para tareas administrativas | 31 / 30 / 40 | 40 |
| 4 | Protected Users | Admin nominal y cuenta integrada en el grupo Protected Users | 31 / 20 / 40 | 40 |
| 5 | GPO de hardening | GPO `SEC-Dominio-Hardening`: NTLMv2 only y Hardened UNC Paths | 16 / 20 / 35 | 35 |
| 6 | Backup | Backup de AD (cierra la regla de último backup) | 16 / 20 / 20 | 20 |
| 7 | Post-pruebas | Remediación de hallazgos tras las pruebas de seguridad: `krbtgt` reseteado dos veces (versión 4), ACL excesiva removida | — / 0 / 20 | 20 |
| 8 | LAPS + FGPP | Windows LAPS en OU `Windows10`, PSO de 25 caracteres para cuentas de servicio | — / 0 / 5 | 5 |
| 9 | LLMNR/mDNS | LLMNR, mDNS y NBT-NS deshabilitados por GPO | 5 / 0 / 5 | 5 |
| 10 | Re-auditoría post-SIEM | Sin cambios de hardening: verificación tras repetir los ataques para validar las reglas de Wazuh. Se corrigió `DoesNotRequirePreAuth` en `svc_backup` (estaba activo pese a la iteración 7) y se revisó la sesión nula de SMB/LDAP | 5 / 0 / 5 | 5 |

> Las columnas son los tres indicadores de PingCastle que cambian entre iteraciones (Stale Objects, Privileged Accounts, Anomalies; Trusts fue 0 siempre). "—" indica que ese valor no se registró en el video del informe. Evidencias: [`Evidencias/`](Evidencias/).

## Comandos clave

```powershell
# Cuentas de servicio: cifrado AES
Set-ADUser svc_sql -KerberosEncryptionType AES128,AES256

# Fine-Grained Password Policy
New-ADFineGrainedPasswordPolicy -Name "PSO-Cuentas-Servicio" -Precedence 10 -MinPasswordLength 25 -ComplexityEnabled $true -PasswordHistoryCount 24 -MinPasswordAge "1.00:00:00" -MaxPasswordAge "365.00:00:00" -LockoutThreshold 5 -LockoutDuration "00:15:00" -LockoutObservationWindow "00:15:00" -ReversibleEncryptionEnabled $false
Add-ADFineGrainedPasswordPolicySubject -Identity "PSO-Cuentas-Servicio" -Subjects "SG-Cuentas-Servicio"

# Windows LAPS
Update-LapsADSchema -Verbose
Set-LapsADComputerSelfPermission -Identity "OU=Windows10,OU=09_Equipos,OU=TechSolutions,DC=techsolutions,DC=local"
New-GPO -Name "SEC-LAPS-Estaciones"

# LLMNR / mDNS
Set-GPRegistryValue -Name "SEC-Dominio-Hardening" -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -ValueName EnableMulticast -Type DWord -Value 0
Set-GPRegistryValue -Name "SEC-Dominio-Hardening" -Key "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -ValueName EnableMDNS -Type DWord -Value 0
```

# 🔁 Iteraciones de hardening

| Iter. | Foco | Cambios principales | Score |
|---|---|---|---|
| Baseline | Línea base | Informe inicial | 70 |
| 1 | Auditoría | Advanced Audit Policy completa, log de 512 MB, auditoría de línea de comandos (GPO `SEC-DC-Auditoria-Avanzada`) | _completar_ |
| 2 | Hardening | Correcciones iniciales de configuración | _completar_ |
| 3 | Admin nominal | Cuenta `adm.bfernandez` para tareas administrativas | _completar_ |
| 4 | Protected Users | Admin nominal en el grupo Protected Users | _completar_ |
| 5 | Hardening por GPO | GPO `SEC-Dominio-Hardening` (HardenedPaths, LmCompatibilityLevel 5) | _completar_ |
| 6 | Backup / cuentas de servicio | Cuentas de servicio reorganizadas, contraseñas aleatorias, flags corregidos | 20 |
| 7 | Post-pruebas | Remediación de hallazgos tras las pruebas de seguridad, `krbtgt` reseteado dos veces, ACL excesivas eliminadas | 20 |
| 8 | LAPS + FGPP | Windows LAPS en OU `Windows10`, PSO de 25 caracteres para cuentas de servicio | 5 |
| 9 | LLMNR/mDNS | LLMNR, mDNS y NBT-NS deshabilitados por GPO | 5 |

> Completá los scores de las iteraciones 1 a 5 con los informes guardados en `C:\Tools` de DC01.

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

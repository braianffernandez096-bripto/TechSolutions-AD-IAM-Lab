# 🎯 12 — Ataque y Detección

Cinco escenarios ejecutados desde una VM Kali contra `techsolutions.local`, con el foco puesto en lo que importa a un analista SOC: **qué evento queda, en qué campo se ve y cómo se corta**.

Cada escenario sigue el mismo ciclo:

```text
Prueba (Kali) → Qué registró el DC / el endpoint → Detección → Defensa aplicada → Re-test
```

## 🧪 Entorno

| VM | Rol |
|---|---|
| DC01 (Windows Server 2022) | Dominio, Security log, Sysmon 15.22 |
| Windows 10 22H2 | Cliente de dominio, Sysmon 15.22 |
| Kali Linux | Máquina de pruebas (misma red NAT, aislada) |

Telemetría: Advanced Audit Policy (GPO `SEC-DC-Auditoria-Avanzada`) + Sysmon con configuración SwiftOnSecurity v74.

## 🗺️ Matriz resumen

| # | Escenario | MITRE ATT&CK | Evento clave | Defensa |
|---|---|---|---|---|
| 01 | [Kerberoasting](01-Kerberoasting/) | T1558.003 | 4769 con cifrado `0x17` | Contraseña larga aleatoria + AES-only + PSO de 25 |
| 02 | [AS-REP Roasting](02-ASREP-Roasting/) | T1558.004 | 4768 con `PreAuthType 0`, 4738 | Preautenticación obligatoria + contraseña robusta |
| 03 | [Password Spraying](03-Password-Spraying/) | T1110.003 | 4625 / 4776 / 4771 (muchos usuarios, una IP) | Contraseñas no predecibles, bloqueo, alerta por patrón |
| 04 | [DCSync / abuso de ACL](04-DCSync-ACL-Abuse/) | T1003.006, T1222.001 | 5136, 4662 con GUIDs de replicación | Quitar ACL excesiva, reset de `krbtgt` x2 |
| 05 | [LLMNR Poisoning](05-LLMNR-Poisoning/) | T1557.001 | Sysmon 22 (limitado) | GPO: LLMNR, mDNS y NBT-NS off |

## 🛰️ Detección automática

Las detecciones de estos escenarios se automatizaron en Wazuh con reglas propias, validadas repitiendo cada ataque: ver [`13-Wazuh-SIEM`](../13-Wazuh-SIEM/).

## 🧰 Utilidades de detección (PowerShell en DC01)

Función auxiliar para leer campos del XML de un evento:

```powershell
function Get-EvData($e){
  $x=[xml]$e.ToXml(); $h=@{}
  $x.Event.EventData.Data | ForEach-Object { $h[$_.Name]=$_.'#text' }
  [pscustomobject]$h | Add-Member TimeCreated $e.TimeCreated -PassThru
}
```

Cada escenario usa esta función con su propia consulta.

## 🔒 Antes de publicar capturas

- Difuminar hashes, contraseñas y direcciones IP completas.
- No subir archivos `.evtx` ni `Credenciales-*.csv` (cubierto por `.gitignore`).
- Las contraseñas débiles mencionadas pertenecen a cuentas de laboratorio creadas a propósito y ya remediadas.

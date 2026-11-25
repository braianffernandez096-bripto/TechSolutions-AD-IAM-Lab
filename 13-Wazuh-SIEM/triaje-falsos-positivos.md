# 🧹 Triaje de falsos positivos

Registro de las alertas que aparecieron al enrolar los agentes, cómo se decidió que eran ruido y cómo se silenciaron **sin apagar la regla original**.

## Triage 001 — El SCA del propio agente dispara reglas de Sysmon

### Qué se vio

Al conectar DC01 con Sysmon, el panel mostró decenas de alertas de las reglas del ruleset estándar:

| Regla | Descripción | MITRE |
|---|---|---|
| `92205` | Archivo `.ps1` creado en una ubicación sospechosa de `SystemTemp` | T1059.001 |
| `92066` | `SecEdit.exe` "en una ubicación sospechosa" lanzado por `powershell.exe` | T1059.001 |

En un SOC esto no se descarta por intuición: se mira quién lo lanzó, desde dónde y con qué línea de comandos.

### Evidencia

| Campo | Valor observado | Qué indica |
|---|---|---|
| `user` / `parentUser` | `NT AUTHORITY\SYSTEM` | Corre como servicio, no un usuario |
| `currentDirectory` | `C:\Program Files (x86)\ossec-agent\` | Lo lanza el agente de Wazuh |
| `parentImage` | `C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe` | PowerShell de **32 bits**, el mismo bitness que el agente |
| `parentCommandLine` | `powershell secedit /export /cfg $env:TEMP\secpol.cfg; Get-Content … \| Select-String "<política>"; Remove-Item …` | Consulta una política de contraseñas o bloqueo y borra el archivo |
| Políticas consultadas | `PasswordHistorySize`, `MaximumPasswordAge`, `MinimumPasswordLength`, `LockoutDuration`, `LockoutBadCount`, `ResetLockoutCount` | Son los chequeos del benchmark CIS de Windows Server 2022 |
| `targetFilename` (92205) | `…\SystemTemp\__PSScriptPolicyTest_*.ps1` | Archivo de prueba que PowerShell crea al evaluar la política de scripts |

### Conclusión

Es el módulo **SCA (Security Configuration Assessment)** del agente evaluando la política CIS de Windows Server 2022. No es actividad maliciosa: es el agente auditando la propia máquina. El patrón es repetible y fácil de distinguir de un ataque real.

### Decisión

No se deshabilitan `92205` ni `92066`: siguen detectando PowerShell sospechoso en cualquier otro contexto. Se agregan dos reglas hijas de **nivel 0** con condiciones lo bastante estrechas como para no abrir un hueco:

| Regla | Condiciones (todas deben cumplirse) |
|---|---|
| `100290` | Padre `92205` **y** `targetFilename` dentro de `SystemTemp` con el nombre `__PSScriptPolicyTest_*.ps1` |
| `100291` | Padre `92066` **y** `currentDirectory` contiene `ossec-agent` **y** `parentCommandLine` es `secedit /export /cfg …(secpol\|secexport).cfg` |

Un atacante que ejecute `secedit` o PowerShell desde otra carpeta, o con otra línea de comandos, **sigue generando la alerta original**.

### Verificación

Se forzó un escaneo SCA reiniciando el servicio del agente en DC01 y se contrastó contra Sysmon:

| Medición | Resultado |
|---|---|
| `Get-WinEvent` sobre Sysmon (ID 1), últimos 15 min: procesos `secedit /export` | **20** (el último a las 13:22:15) |
| Wazuh, mismos 15 min: alertas `92066` / `92205` de DC01 | **0** |

Antes del afinado, un solo escaneo generaba unas 9 alertas `92066`.

### Lo que salió mal en el primer intento

La primera versión de `100291` filtraba por `secexport\.cfg`, porque ese era el nombre que tenía el evento de la primera tanda. En el escaneo siguiente cada chequeo usaba `secpol.cfg` y las alertas **siguieron apareciendo**. Se corrigió con el regex `(secpol|secexport)` y se volvió a probar.

Lección: un silenciador se valida con un **escaneo nuevo**, no con el evento con el que se escribió. Si no se hubiera repetido el escaneo, la regla habría quedado "desplegada" sin hacer nada.

### Estado

| Regla | Estado |
|---|---|
| `100291` | ✅ validada en vivo (20 `secedit`, 0 alertas) |
| `100290` | ⚠️ validada contra el evento real de la primera tanda; en los dos escaneos posteriores el SCA no volvió a generar el `__PSScriptPolicyTest`, así que no se pudo repetir en vivo |

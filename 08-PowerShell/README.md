# ⚡ PowerShell — Automatización de Active Directory

## 📌 Descripción

En esta fase se implementó automatización administrativa mediante PowerShell ISE para realizar tareas de gestión sobre Active Directory. El objetivo fue reducir tareas manuales y demostrar la utilización de PowerShell como herramienta de administración dentro del entorno Windows Server 2022. La automatización se integra con el laboratorio de Active Directory e IAM desarrollado en las fases anteriores — retoma directamente el Caso 1 — Joiner (alta manual) y el Caso 3 — Leaver (baja de María López), ahora resueltos a escala.

---

## 🎯 Objetivos

- Utilizar PowerShell para administrar Active Directory.
- Automatizar altas de usuario en lote, en vez de repetir el asistente gráfico del Caso 1 uno por uno.
- Crear las cuentas ya habilitadas, con contraseña temporal y cambio obligatorio en el próximo inicio de sesión.
- Asignar automáticamente cada usuario al grupo de seguridad de su departamento.
- Automatizar el reporte de cuentas deshabilitadas, en vez de la revisión manual descripta en el Caso 6.
- Reducir la intervención manual en tareas repetitivas de administración.
- Documentar el proceso de automatización con evidencia real de ejecución.

---

## 🛠️ Entorno utilizado

| Componente | Configuración |
|---|---|
| Sistema operativo | Windows Server 2022 |
| Directorio | Active Directory Domain Services |
| Dominio | `techsolutions.local` |
| Herramienta | PowerShell ISE |
| Módulo | `ActiveDirectory` |
| Automatización | Gestión de usuarios y grupos |

---

## 🧩 Automatización implementada

Dos scripts, dos procesos manuales distintos convertidos en automáticos:

```text
1. Alta masiva          CSV → PowerShell ISE → Active Directory → Usuario creado + habilitado → Grupo asignado → Validación
2. Reporte de bajas      Active Directory → PowerShell ISE → Filtro de cuentas deshabilitadas → Reporte_Bajas.csv
```

### 1️⃣ `Scripts/01-Crear-Usuarios-AD.ps1` — Alta masiva de usuarios

Lee `Ejemplos/Nuevos-Usuarios-Ejemplo.csv` y crea cada usuario en su OU, con contraseña temporal, cambio obligatorio en el próximo login, y lo agrega al grupo `GG_<Departamento>` correspondiente. Antes de crear, valida que la cuenta no exista ya (evita duplicar altas si el script se corre dos veces sobre el mismo CSV).

```powershell
Import-Module ActiveDirectory

$csvPath = "C:\Scripts\NuevosUsuarios.csv"
$usuarios = Import-Csv -Path $csvPath

foreach ($usuario in $usuarios) {
    $ouPath = "OU=$($usuario.OU),OU=TechSolutions,DC=techsolutions,DC=local"
    $upn = "$($usuario.SamAccountName)@techsolutions.local"

    if (Get-ADUser -Filter "SamAccountName -eq '$($usuario.SamAccountName)'" -ErrorAction SilentlyContinue) {
        Write-Host "Ya existe: $($usuario.SamAccountName), se omite." -ForegroundColor Yellow
        continue
    }

    $securePassword = ConvertTo-SecureString "Bienvenido123!" -AsPlainText -Force

    New-ADUser -Name "$($usuario.Nombre) $($usuario.Apellido)" `
               -GivenName $usuario.Nombre `
               -Surname $usuario.Apellido `
               -SamAccountName $usuario.SamAccountName `
               -UserPrincipalName $upn `
               -Path $ouPath `
               -AccountPassword $securePassword `
               -ChangePasswordAtLogon $true `
               -Enabled $true `
               -Title $usuario.Puesto `
               -Department $usuario.Departamento

    Add-ADGroupMember -Identity "GG_$($usuario.Departamento)" -Members $usuario.SamAccountName

    Write-Host "Creado y agregado a GG_$($usuario.Departamento): $($usuario.SamAccountName)" -ForegroundColor Green
}
```

**Resultado verificado en ADUC:** `04_IT/HelpDesk` (Sofia Torres, Pablo Torres, Lucía Romero) y `08_Operaciones` (Sergio Fontana, Natalia Campos, Martin Gimenez, Mariana Rojas, Lucas Fernandez), cada uno en su grupo correspondiente.

> ⚠️ Contraseña temporal hardcodeada en texto plano (`"Bienvenido123!"`). Válido para este laboratorio; en un entorno real conviene generarla aleatoria por usuario y no dejarla fija ni versionada junto con el script.

### 2️⃣ `Scripts/02-Reporte-Bajas-AD.ps1` — Reporte de cuentas deshabilitadas

Consulta todas las cuentas con `Enabled -eq $false` en todo el árbol de OUs de `TechSolutions` (no solo `13_Disabled_Users`, así que encuentra cualquier cuenta deshabilitada esté donde esté), trae la descripción y fecha del último cambio, y exporta a CSV ordenado por baja más reciente primero.

```powershell
Import-Module ActiveDirectory

$reporte = Get-ADUser -Filter {Enabled -eq $false} `
    -SearchBase "OU=TechSolutions,DC=techsolutions,DC=local" `
    -Properties Description, whenChanged |
    Select-Object Name, SamAccountName, Description, whenChanged |
    Sort-Object whenChanged -Descending

$reporte | Format-Table -AutoSize
$reporte | Export-Csv -Path "C:\Scripts\Reporte_Bajas.csv" -NoTypeInformation -Encoding UTF8
```

**Resultado verificado:** una fila — María López (`mlopez`), con la descripción `Baja - Renuncia Voluntaria - 08/08/2026- Procesado por Administrador`. Es la misma baja documentada en el Caso 3, ahora capturada por un reporte automatizado en vez de una revisión manual.

---

## 🔧 Mejoras sugeridas (no implementadas todavía)

Quedan anotadas para no perderlas, pero el script documentado arriba es el que realmente se ejecutó — estas son ideas para una próxima iteración, no cambios ya aplicados:

- **Manejo de error en `Add-ADGroupMember`**: si el CSV trae un departamento sin un grupo `GG_<Departamento>` existente, el script corta con una excepción no controlada en vez de loguear el problema y seguir con el siguiente usuario.
- **Idempotencia parcial**: el chequeo de "¿ya existe?" evita duplicar el alta, pero si una corrida anterior falló justo después de crear el usuario y antes de agregarlo al grupo, una corrida nueva lo salta sin corregir la membresía faltante.

---

## ✅ Validación

- Usuarios creados en la OU correcta, habilitados y con la membresía de grupo correcta (verificado en ADUC tras la ejecución).
- Reporte de bajas devolvió únicamente la baja real documentada en el Caso 3.

---

## 📸 Evidencias

Ver `Evidencias/` para el detalle capturado de cada corrida.

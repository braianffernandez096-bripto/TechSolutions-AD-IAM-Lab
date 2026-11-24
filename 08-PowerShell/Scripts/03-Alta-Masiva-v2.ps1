<#
.SYNOPSIS
    Alta masiva de empleados en Active Directory (v2).

.DESCRIPTION
    Evolucion de 01-Crear-Usuarios-AD.ps1. Cambios:
      - Password temporal ALEATORIA por usuario (se exporta a un CSV fuera del repo).
      - Manejo de errores por usuario: un fallo se registra y el script sigue con el siguiente.
      - Idempotente: si el usuario ya existe, igual corrige su membresia de grupo faltante.
      - Grupo explicito en el CSV (columna Grupo), ya que Ciberseguridad usa GG_SOC, GG_BlueTeam, etc.
      - Asigna Manager (segunda pasada, cuando ya existen todos los usuarios).
      - Soporta -WhatIf para ver que haria sin cambiar nada.
      - UPN configurable (-UpnSuffix) para la futura sincronizacion con Microsoft 365.

    Columnas del CSV: Nombre, Apellido, SamAccountName, Departamento, Puesto, OU, Grupo, Manager
    La columna OU es relativa a -BaseDN. Para una sub-OU: "HelpDesk,OU=04_IT".

.EXAMPLE
    .\03-Alta-Masiva-v2.ps1 -CsvPath C:\Scripts\Empleados-50.csv -WhatIf
    .\03-Alta-Masiva-v2.ps1 -CsvPath C:\Scripts\Empleados-50.csv
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][string]$CsvPath,
    [string]$UpnSuffix = 'techsolutions.local',
    [string]$BaseDN = 'OU=TechSolutions,DC=techsolutions,DC=local',
    [string]$Company = 'TechSolutions S.A.',
    [string]$CredentialsOut = (Join-Path $env:USERPROFILE 'Credenciales-Temporales.csv')
)

Import-Module ActiveDirectory

function New-RandomPassword {
    param([int]$Length = 16)
    $upper  = 'ABCDEFGHJKLMNPQRSTUVWXYZ'
    $lower  = 'abcdefghijkmnopqrstuvwxyz'
    $digit  = '23456789'
    $symbol = '!@#$%&*?'
    $all    = $upper + $lower + $digit + $symbol
    $rng    = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    $pick = {
        param([string]$set)
        $b = New-Object byte[] 1
        do { $rng.GetBytes($b) } while ($b[0] -ge (256 - (256 % $set.Length)))
        $set[$b[0] % $set.Length]
    }
    $chars = @(& $pick $upper; & $pick $lower; & $pick $digit; & $pick $symbol)
    while ($chars.Count -lt $Length) { $chars += (& $pick $all) }
    -join ($chars | Sort-Object { Get-Random })
}

$cacheGrupos = @{}
function Get-MiembrosGrupo {
    param([string]$Grupo)
    if (-not $cacheGrupos.ContainsKey($Grupo)) {
        $cacheGrupos[$Grupo] = @(Get-ADGroupMember -Identity $Grupo -ErrorAction Stop |
                                 Select-Object -ExpandProperty SamAccountName)
    }
    return $cacheGrupos[$Grupo]
}

$usuarios   = Import-Csv -Path $CsvPath -Encoding UTF8
$credenciales = @()
$creados = 0; $existentes = 0; $errores = 0

foreach ($u in $usuarios) {
    $sam    = $u.SamAccountName.Trim()
    $nombre = "$($u.Nombre) $($u.Apellido)"
    $ouPath = "OU=$($u.OU),$BaseDN"
    $upn    = "$sam@$UpnSuffix"

    try {
        $existe = Get-ADUser -Filter "SamAccountName -eq '$sam'" -ErrorAction SilentlyContinue

        if ($existe) {
            Write-Host "Ya existe: $sam (se verifica el grupo)" -ForegroundColor Yellow
            $existentes++
        }
        elseif ($PSCmdlet.ShouldProcess($sam, "Crear usuario en $ouPath")) {
            $plain = New-RandomPassword
            New-ADUser -Name $nombre `
                       -DisplayName $nombre `
                       -GivenName $u.Nombre `
                       -Surname $u.Apellido `
                       -SamAccountName $sam `
                       -UserPrincipalName $upn `
                       -EmailAddress $upn `
                       -Path $ouPath `
                       -AccountPassword (ConvertTo-SecureString $plain -AsPlainText -Force) `
                       -ChangePasswordAtLogon $true `
                       -Enabled $true `
                       -Title $u.Puesto `
                       -Department $u.Departamento `
                       -Company $Company `
                       -ErrorAction Stop
            $credenciales += [pscustomobject]@{
                SamAccountName = $sam; UPN = $upn; PasswordTemporal = $plain
            }
            $creados++
            Write-Host "Creado: $sam" -ForegroundColor Green
        }

        # Membresia de grupo (tambien se corrige en usuarios que ya existian)
        if ($u.Grupo) {
            $miembros = Get-MiembrosGrupo -Grupo $u.Grupo
            if ($miembros -notcontains $sam) {
                if ($PSCmdlet.ShouldProcess($sam, "Agregar a $($u.Grupo)")) {
                    Add-ADGroupMember -Identity $u.Grupo -Members $sam -ErrorAction Stop
                    $cacheGrupos[$u.Grupo] += $sam
                    Write-Host "  -> agregado a $($u.Grupo)" -ForegroundColor Green
                }
            }
        }
    }
    catch {
        $errores++
        Write-Host "ERROR con ${sam}: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Segunda pasada: Manager (ya existen todos los usuarios)
foreach ($u in $usuarios | Where-Object { $_.Manager }) {
    try {
        if ($PSCmdlet.ShouldProcess($u.SamAccountName, "Asignar manager $($u.Manager)")) {
            Set-ADUser -Identity $u.SamAccountName -Manager $u.Manager -ErrorAction Stop
        }
    }
    catch {
        $errores++
        Write-Host "ERROR manager de $($u.SamAccountName) ($($u.Manager)): $($_.Exception.Message)" -ForegroundColor Red
    }
}

if ($credenciales.Count -gt 0) {
    $credenciales | Export-Csv -Path $CredentialsOut -NoTypeInformation -Encoding UTF8
    Write-Host "`nCredenciales temporales guardadas en: $CredentialsOut" -ForegroundColor Cyan
    Write-Host "NO subir ese archivo a GitHub. Borrarlo cuando ya no se necesite." -ForegroundColor Cyan
}
Write-Host "`nResumen -> creados: $creados | ya existian: $existentes | errores: $errores"

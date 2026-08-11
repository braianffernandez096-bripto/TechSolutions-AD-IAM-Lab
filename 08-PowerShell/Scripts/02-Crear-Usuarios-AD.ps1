Import-Module ActiveDirectory

$csvPath = "C:\Scripts\NuevosUsuarios.csv"
$usuarios = Import-Csv -Path $csvPath

$securePassword = Read-Host "Ingrese la contraseña inicial" -AsSecureString

foreach ($usuario in $usuarios) {

    $ouPath = "OU=$($usuario.OU),OU=TechSolutions,DC=techsolutions,DC=local"
    $upn = "$($usuario.SamAccountName)@techsolutions.local"

    if (Get-ADUser -Filter "SamAccountName -eq '$($usuario.SamAccountName)'" -ErrorAction SilentlyContinue) {

        Write-Host "Ya existe: $($usuario.SamAccountName), se omite." -ForegroundColor Yellow
        continue
    }

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

    Add-ADGroupMember -Identity "GG_$($usuario.Departamento)" `
                      -Members $usuario.SamAccountName

    Write-Host "Creado y agregado a GG_$($usuario.Departamento): $($usuario.SamAccountName)" `
               -ForegroundColor Green
}

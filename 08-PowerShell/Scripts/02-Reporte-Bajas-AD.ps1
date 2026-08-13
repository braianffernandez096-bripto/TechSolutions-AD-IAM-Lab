Import-Module ActiveDirectory

$reporte = Get-ADUser -Filter {Enabled -eq $false} `
    -SearchBase "OU=TechSolutions,DC=techsolutions,DC=local" `
    -Properties Description, whenChanged |
    Select-Object Name, SamAccountName, Description, whenChanged |
    Sort-Object whenChanged -Descending

$reporte | Format-Table -AutoSize
$reporte | Export-Csv -Path "C:\Scripts\Reporte_Bajas.csv" -NoTypeInformation -Encoding UTF8

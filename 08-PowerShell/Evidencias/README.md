# 📸 Evidencias — Automatización PowerShell

Esta carpeta contiene las evidencias de la automatización desarrollada mediante PowerShell ISE para la administración de usuarios y grupos en Active Directory.

Las capturas documentan el flujo completo, en dos tramos:

```text
Alta masiva:       CSV → PowerShell ISE → Creación de usuarios → Asignación de OU → Asignación de grupo → Validación en ADUC
Reporte de bajas:  PowerShell ISE → Consulta de cuentas deshabilitadas → Exportación a CSV
```

| # | Captura | Qué muestra |
|---|---|---|
| 1 | `01-Ejecucion-Script.png` | `01-Crear-Usuarios-AD.ps1` en PowerShell ISE, consola confirmando `Creado y agregado a GG_IT: storres` / `GG_Operaciones: mgimenez`. |
| 2 | `02-Usuario-Creado-1.png` | `04_IT/HelpDesk` en ADUC con los usuarios creados por el script (Sofia Torres, Pablo Torres, Lucía Romero). |
| 3 | `03-Usuario-Creado-2.png` | `08_Operaciones` en ADUC con los usuarios creados por el script (Sergio Fontana, Natalia Campos, Martin Gimenez, Mariana Rojas, Lucas Fernandez). |
| 4 | `04-Ejecucion-Script-Reporte.png` | `02-Reporte-Bajas-AD.ps1` en PowerShell ISE, consola con el resultado en tabla (María López / `mlopez`). |
| 5 | `05-Reporte-Bajas-CSV.png` | `Reporte_Bajas.csv` abierto en el Bloc de notas — el archivo exportado real. |

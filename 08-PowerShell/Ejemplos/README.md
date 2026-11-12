#### 📁 Formato de entrada (`Ejemplos/Nuevos-Usuarios-Ejemplo.csv`)

Archivo de ejemplo reducido (2 filas) para ilustrar las columnas que espera el script. La corrida real documentada en las evidencias usó un CSV más amplio, con los 8 usuarios que terminaron en `04_IT/HelpDesk` y `08_Operaciones`.

| Columna | Descripción | Ejemplo |
|---|---|---|
| `Nombre` | Nombre de pila | `Sofia` |
| `Apellido` | Apellido | `Torres` |
| `SamAccountName` | Login de dominio | `storres` |
| `Departamento` | Arma el nombre del grupo (`GG_<Departamento>`) y llena el atributo `Department` | `IT` |
| `Puesto` | Atributo `Title` | `Soporte Técnico` |
| `OU` | OU de destino, relativa a `OU=TechSolutions,DC=techsolutions,DC=local` | `04_IT` |

```csv
Nombre,Apellido,SamAccountName,Departamento,Puesto,OU
Sofia,Torres,storres,IT,Soporte Técnico,04_IT
Martin,Gimenez,mgimenez,Operaciones,Analista de Operaciones,08_Operaciones
```

> **Nota sobre la columna `OU`:** el script arma la ruta como `OU=<valor>,OU=TechSolutions,DC=techsolutions,DC=local`. Con `04_IT` el usuario queda directamente en `04_IT`. Para ubicarlo en una sub-OU como `04_IT/HelpDesk`, el valor debe indicar la ruta de adentro hacia afuera: `HelpDesk,OU=04_IT`.

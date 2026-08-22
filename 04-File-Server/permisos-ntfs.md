# Permisos NTFS — proceso de configuración y limpieza

## Estado inicial (heredado del padre)

Al crear cada subcarpeta dentro de `C:\Compartidos`, hereda por defecto las entradas de permiso del padre, típicamente:

- `DL_<Departamento>_RW` — Modificar
- `SYSTEM` — Control total
- `Administradores` — Control total
- `Usuarios (dominio)` — Lectura y ejecución ⚠️
- `Usuarios (dominio)` — Especial ⚠️
- `CREATOR OWNER` — Control total (solo subcarpetas y archivos)

Las dos entradas marcadas con ⚠️ son el problema: el grupo "Usuarios" equivale a *todos los usuarios del dominio*. Dejarlas anula el propósito de todo el modelo AGDLP — cualquier persona podría leer el contenido de cualquier carpeta de cualquier departamento.

## Proceso de corrección (aplicado a las 8 carpetas)

1. **Propiedades → Seguridad → Opciones avanzadas.**
2. **Deshabilitar herencia** → "Convertir los permisos heredados en permisos explícitos en este objeto".
3. Seleccionar ambas entradas de **"Usuarios"** → **Quitar**.
4. Confirmar que quedan únicamente 4 entradas: `DL_<Departamento>_RW` (Modificar), `SYSTEM` (Control total), `Administradores` (Control total), `CREATOR OWNER` (Control total, solo subcarpetas y archivos).
5. **No** volver a habilitar la herencia — eso restauraría el grupo "Usuarios" y anularía la corrección.

## Por qué se conserva CREATOR OWNER

No es una cuenta real — es un marcador de posición que Windows reemplaza dinámicamente por quien crea cada archivo o subcarpeta, dándole control únicamente sobre lo que esa persona creó. Es comportamiento estándar de NTFS y no rompe el aislamiento por departamento.

## Consecuencia aceptada: pérdida de propagación desde el padre

Al convertir los permisos en explícitos, cambios futuros en `C:\Compartidos` (el padre) ya no se propagan automáticamente a las subcarpetas — hay que replicarlos a mano si corresponde. Es el costo esperado de tener aislamiento real por departamento.

## Caso especial: cuentas de servicio

Cualquier cuenta de servicio (backups, antivirus, etc.) que dependiera del acceso genérico del grupo "Usuarios" pierde ese acceso con esta corrección, y necesita una entrada explícita propia si la necesita — evitando así permisos amplios innecesarios también para procesos automatizados.

# Permisos de recurso compartido vs. Permisos NTFS

Una de las preguntas clásicas de entrevista para roles de AD/IAM: *"¿Cuál es la diferencia entre los permisos NTFS y los permisos de un recurso compartido?"*

## Permisos de recurso compartido (Share Permissions)

- Se aplican **solo** cuando se accede por red (`\\DC01\Compartidos\...`).
- No tienen efecto si se accede al archivo localmente en el propio servidor.
- Son más simples: Lectura, Cambiar, Control total.

## Permisos NTFS

- Se aplican **siempre**, tanto en acceso local como remoto.
- Son mucho más granulares (Modificar, Lectura y ejecución, Escritura, permisos especiales por atributo, etc.).
- Es donde vive realmente el control de acceso fino en este proyecto.

## Cómo se combinan

El permiso **efectivo** es el más restrictivo entre ambos. En este laboratorio, el recurso compartido se dejó permisivo (acceso amplio a nivel de red) y **todo** el control real de acceso se implementó a nivel NTFS — es el enfoque recomendado en la práctica, porque NTFS es donde se puede aplicar el modelo AGDLP con precisión.

## Aplicado a este proyecto

| Nivel | Configuración |
|---|---|
| Share (`Compartidos`) | Amplio — el filtro no ocurre acá |
| NTFS (cada subcarpeta) | Restringido a `DL_<Departamento>_RW` únicamente |

Resultado: aunque cualquiera pueda "ver" el recurso compartido por red, solo quien tenga el permiso NTFS correspondiente puede efectivamente entrar a cada subcarpeta.

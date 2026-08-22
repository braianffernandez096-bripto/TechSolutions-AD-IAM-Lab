# 🗄️ 04 — File Server: Recursos Compartidos y Permisos NTFS

## 📌 Descripción

En esta fase se implementó un servidor de archivos para el entorno empresarial simulado de TechSolutions.

El objetivo fue centralizar los recursos compartidos de los diferentes departamentos y aplicar controles de acceso mediante permisos NTFS y grupos de seguridad de Active Directory.

La implementación está integrada con el modelo IAM/AGDLP desarrollado previamente en [`03-IAM-AGDLP`](../03-IAM-AGDLP/).

---

## 🎯 Objetivos

- Centralizar los recursos compartidos por departamento en un único servidor de archivos, con un único punto de entrada de red.
- Aplicar permisos NTFS exclusivamente a través de grupos de seguridad (Domain Local), nunca directo a usuarios.
- Controlar el acceso siguiendo el principio de mínimo privilegio.
- Validar que el acceso quede correctamente concedido y denegado según corresponda.

---

## 🏗️ Arquitectura

El control de acceso a cada recurso compartido sigue el mismo modelo AGDLP detallado en [`03-IAM-AGDLP`](../03-IAM-AGDLP/), aplicado acá a nivel de archivo:

```text
Usuario
   │
   ▼
Global Group (GG_Departamento)
   │
   ▼
Domain Local Group (DL_Departamento_RW)
   │
   ▼
Permiso NTFS sobre la carpeta compartida
```

Ejemplo concreto aplicado a este servidor:

```text
Usuario (Ventas)
   │
   ▼
GG_Ventas
   │
   ▼
DL_Ventas_RW
   │
   ▼
NTFS: Modificar sobre \\DC01\Compartidos\Ventas
```

El servidor de archivos (`DC01`) expone un único recurso compartido en la raíz (`Compartidos`); todo el control de acceso real ocurre a nivel NTFS sobre cada subcarpeta, no a nivel de recurso compartido.

---

## 🗂️ Estructura de carpetas

```text
C:\Compartidos
├── Direccion
├── RRHH
├── Finanzas
├── IT
├── Ciberseguridad
├── Marketing
├── Ventas
└── Operaciones
```

---

## 📤 Compartir el recurso

La carpeta raíz `Compartidos` se compartió con permisos de recurso compartido (Share Permissions) amplios — el control de acceso real se hace a nivel NTFS, no a nivel de recurso compartido. Ver el detalle de la diferencia entre ambos en [`share-permissions.md`](share-permissions.md).

> ⚠️ **Hallazgo corregido:** durante la validación con `Get-SmbShare` se detectó que las 8 carpetas de departamento habían quedado compartidas también de forma individual, además de la raíz — un resto de la configuración inicial, sin impacto real en el acceso (el NTFS seguía siendo el permiso efectivo) pero inconsistente con el diseño de un único punto de entrada. Se corrigió dando de baja esos 8 recursos con `Remove-SmbShare`.

---

## 🔐 Permisos NTFS por carpeta

Cada subcarpeta se configuró siguiendo el mismo proceso:

1. Asignar al grupo `DL_<Departamento>_RW` con permiso **Modificar**.
2. Deshabilitar la herencia y convertir los permisos heredados en explícitos.
3. Quitar el grupo genérico "Usuarios" (que de otra forma daría acceso de lectura a todo el dominio, anulando el aislamiento).
4. Dejar únicamente: `DL_<Departamento>_RW`, `SYSTEM`, `Administradores` y `CREATOR OWNER`.

---

## ✅ Validación de acceso

Para cada departamento se validó, desde el cliente Windows 10:

- ✅ Un usuario del departamento puede entrar, crear, modificar y borrar archivos en su carpeta.
- ✅ El mismo usuario recibe **Acceso denegado** al intentar entrar a la carpeta de otro departamento.

---

## 📸 Evidencias

Ver [`evidencias/README.md`](evidencias/README.md) para el detalle completo: estructura, configuración del recurso compartido, permisos NTFS, acceso concedido/denegado, prueba de eliminación, y la verificación final de recursos compartidos activos.

---

## 🚀 Siguiente paso

Con el control de acceso funcionando, se completaron las políticas de grupo — ver [`05-Group-Policy`](../05-Group-Policy/).

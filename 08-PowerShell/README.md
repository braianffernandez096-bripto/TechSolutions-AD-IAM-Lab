# ⚡ PowerShell — Automatización de Active Directory

## 📌 Descripción

En esta fase se implementó automatización administrativa mediante PowerShell ISE para realizar tareas de gestión sobre Active Directory.

El objetivo fue reducir tareas manuales y demostrar la utilización de PowerShell como herramienta de administración y automatización dentro del entorno Windows Server 2022.

La automatización fue integrada con el laboratorio de Active Directory e IAM desarrollado en las fases anteriores.

---

# 🎯 Objetivos

- Utilizar PowerShell para administrar Active Directory.
- Automatizar tareas administrativas repetitivas.
- Habilitar cuentas de usuario mediante PowerShell.
- Asignar usuarios a los grupos de seguridad correspondientes.
- Reducir la intervención manual en tareas de administración.
- Validar posteriormente los cambios realizados.
- Documentar el proceso de automatización.

---

# 🛠️ Entorno utilizado

| Componente | Configuración |
|---|---|
| Sistema operativo | Windows Server 2022 |
| Directorio | Active Directory Domain Services |
| Dominio | `techsolutions.local` |
| Herramienta | PowerShell ISE |
| Automatización | Gestión de usuarios y grupos |
| Directorio | Active Directory |

---

# 🧩 Automatización implementada

La automatización desarrollada permite realizar tareas de administración de usuarios dentro del dominio.

El flujo general implementado es:

```text
Solicitud / usuario
        ↓
PowerShell ISE
        ↓
Active Directory
        ↓
Habilitación de cuenta
        ↓
Asignación al grupo correspondiente
        ↓
Validación

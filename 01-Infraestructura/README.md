# 🏗️ Infraestructura del Laboratorio

## 📌 Descripción

Esta sección documenta la infraestructura utilizada como base para la implementación del laboratorio de Active Directory e IAM de TechSolutions.

El entorno fue construido en una infraestructura virtualizada utilizando VMware, con el objetivo de simular una red empresarial pequeña y controlada para realizar pruebas de administración de sistemas, gestión de identidades, políticas de seguridad, permisos y auditoría.

---

## 🎯 Objetivo

El objetivo de esta fase fue preparar la infraestructura necesaria para implementar posteriormente:

- Active Directory Domain Services (AD DS)
- DNS
- Gestión de usuarios y grupos
- Group Policy
- Recursos compartidos
- Permisos NTFS
- Auditoría
- Automatización mediante PowerShell

---

# 🖥️ Componentes del laboratorio

| Equipo | Sistema Operativo | Función |
|---|---|---|
| DC01 | Windows Server 2022 | Controlador de dominio / DNS / GPO |
| Cliente Windows 10 | Windows 10 | Equipo cliente unido al dominio |

---

# 🌐 Configuración de red

La infraestructura utiliza una red privada de laboratorio:

```text
Red:
192.168.x.x

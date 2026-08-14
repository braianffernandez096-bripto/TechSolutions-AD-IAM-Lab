# 🔐 TechSolutions — Active Directory & IAM Lab
![Estado](https://img.shields.io/badge/Estado-Completado-brightgreen)
![Windows Server](https://img.shields.io/badge/Windows%20Server-2022-blue)
![Active Directory](https://img.shields.io/badge/Active%20Directory-AD%20DS-blue)
![IAM](https://img.shields.io/badge/IAM-AGDLP-purple)
![PowerShell](https://img.shields.io/badge/PowerShell-Automatización-blue)
---
## 📌 Descripción
Este proyecto consiste en la implementación de un laboratorio empresarial de Active Directory e Identity and Access Management (IAM) utilizando Windows Server 2022.

El objetivo principal fue simular un entorno corporativo en el que se gestionan identidades, accesos, grupos, equipos, políticas de seguridad, recursos compartidos y procesos completos del ciclo de vida de los usuarios.

El laboratorio fue diseñado y validado en un entorno virtualizado, reproduciendo procedimientos habituales de administración de sistemas, soporte IT e IAM.

---

## 🎯 Objetivos del proyecto
- Implementar un dominio empresarial con Active Directory Domain Services.
- Diseñar una estructura organizada de Unidades Organizativas (OU).
- Crear y administrar usuarios y grupos.
- Implementar el modelo de permisos **AGDLP**.
- Configurar recursos compartidos y permisos NTFS.
- Implementar políticas de seguridad mediante Group Policy.
- Configurar auditoría de eventos relacionados con Active Directory.
- Simular procesos de alta, transferencia y baja de usuarios.
- Implementar procedimientos de restablecimiento de contraseña y desbloqueo de cuentas.
- Configurar delegación administrativa para un equipo de Helpdesk.
- Automatizar tareas administrativas mediante PowerShell.
- Validar cada implementación mediante pruebas y evidencias.
---
## 🏗️ Arquitectura del laboratorio
El entorno representa una infraestructura empresarial simplificada basada en Windows Server 2022 y clientes Windows unidos al dominio.
```text
                         ┌────────────────────────────┐
                         │       TECHSOLUTIONS        │
                         │      Active Directory      │
                         │                            │
                         │   techsolutions.local      │
                         └─────────────┬──────────────┘
                                       │
             ┌─────────────────────────┼─────────────────────────┐
             │                         │                         │
             ▼                         ▼                         ▼
      ┌──────────────┐        ┌────────────────┐        ┌──────────────┐
      │    Usuarios  │        │     Grupos     │        │    Equipos   │
      │              │        │                │        │              │
      │   OUs        │        │ GG / DL        │        │ Windows 10   │
      │ Departamentos│        │ AGDLP          │        │ Windows 11   │
      └──────────────┘        └───────┬────────┘        │ Servidores   │
                                      │                 └──────────────┘
                                      ▼
                              ┌─────────────────┐
                              │  File Server    │
                              │                 │
                              │ NTFS / Recursos │
                              └─────────────────┘
```
---
## 🗂️ Índice
| Carpeta | Contenido |
|---|---|
| [`01-Infraestructura`](01-Infraestructura/) | Instalación de Windows Server 2022, AD DS, DNS |
| [`02-Active-Directory`](02-Active-Directory/) | Unidades Organizativas, usuarios, grupos globales |
| [`03-IAM-AGDLP`](03-IAM-AGDLP/) | Grupos Domain Local y modelo AGDLP completo |
| [`04-File-Server`](04-File-Server/) | Carpetas compartidas, permisos NTFS, control de acceso |
| [`05-Group-Policy`](05-Group-Policy/) | GPOs: banner legal, bloqueo de cuenta, restricciones |
| [`06-Auditoria`](06-Auditoria/) | Auditoría de archivos y de objetos de Active Directory |
| [`07-Casos-IAM`](07-Casos-IAM/) | 7 casos reales resueltos: Joiner, Mover, Leaver, Reset Password, Unlock Account, Disable/Delete User, Delegación de permisos |
| [`08-PowerShell`](08-PowerShell/) | Scripts de automatización (alta masiva, reporte de bajas) |
| [`09-Documentacion`](09-Documentacion/) | Arquitectura y decisiones de diseño |
| [`10-Service-Desk`](10-Service-Desk/) | Próximo proyecto — Mesa de ayuda con Jira sobre este mismo entorno (no iniciado) |
---
## 🎯 Habilidades demostradas
- Instalación y configuración de Active Directory Domain Services.
- Diseño de estructura organizativa (OUs) a escala empresarial.
- Gestión de identidades: ciclo de vida completo de usuario (Joiner-Mover-Leaver).
- Modelo de control de acceso AGDLP.
- Permisos NTFS y de recurso compartido, y la diferencia entre ambos.
- Group Policy Objects: seguridad, restricciones, cumplimiento.
- Auditoría de Active Directory (SACL, Advanced Audit Policy, análisis de Event IDs).
- Delegación de permisos siguiendo el principio de mínimo privilegio.
- Automatización con PowerShell (alta masiva, reportes).
- Documentación técnica orientada a portafolio.
---
## ✅ Estado del proyecto
Laboratorio de IAM + Active Directory (carpetas `01` a `09`): **completo**.
Próximo paso: proyecto de Soporte IT con Jira, construido sobre este mismo entorno (ver [`10-Service-Desk`](10-Service-Desk/)).

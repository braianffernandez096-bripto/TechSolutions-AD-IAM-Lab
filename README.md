# TechSolutions-AD-IAM-Lab
Laboratorio empresarial de Active Directory e IAM con Windows Server 2022, AGDLP, GPO, permisos NTFS, auditoría y automatización con PowerShell.


# 🔐 TechSolutions — Active Directory & IAM Lab

## 🏢 Laboratorio empresarial de Active Directory y Gestión de Identidades

![Estado](https://img.shields.io/badge/Estado-Completado-brightgreen)
![Windows Server](https://img.shields.io/badge/Windows%20Server-2022-blue)
![Active Directory](https://img.shields.io/badge/Active%20Directory-AD%20DS-blue)
![IAM](https://img.shields.io/badge/IAM-AGDLP-purple)
![PowerShell](https://img.shields.io/badge/PowerShell-Automatización-blue)

---

## 📌 Descripción

Este proyecto consiste en la implementación de un laboratorio empresarial de **Active Directory e Identity and Access Management (IAM)** utilizando **Windows Server 2022**.

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

# 🏗️ Arquitectura del laboratorio

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

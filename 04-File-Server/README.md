# 🗄️ File Server — Recursos Compartidos y Permisos NTFS

## 📌 Descripción

En esta fase se implementó un servidor de archivos para el entorno empresarial simulado de TechSolutions.

El objetivo fue centralizar los recursos compartidos de los diferentes departamentos y aplicar controles de acceso mediante permisos NTFS y grupos de seguridad de Active Directory.

La implementación se encuentra integrada con el modelo IAM/AGDLP desarrollado previamente.

---

# 🎯 Objetivos

- Implementar una estructura centralizada de recursos compartidos.
- Organizar los recursos por departamento.
- Aplicar permisos NTFS mediante grupos de seguridad.
- Evitar asignaciones directas de permisos a usuarios individuales.
- Controlar el acceso a los recursos mediante grupos de Active Directory.
- Aplicar permisos de modificación sobre los recursos autorizados.
- Validar accesos permitidos.
- Validar accesos denegados.
- Aplicar el principio de mínimo privilegio.

---

# 🏗️ Arquitectura

La estructura implementada sigue el siguiente modelo:

```text
Active Directory
      │
      ▼
Global Groups (GG)
      │
      ▼
Domain Local Groups (DL)
      │
      ▼
Permisos NTFS
      │
      ▼
File Server
      │
      ▼
Recursos compartidos

# 🔐 IAM — Modelo AGDLP

## 📌 Descripción

En esta fase se implementó un modelo de gestión de identidades y accesos (IAM) utilizando Active Directory y el principio AGDLP.

El objetivo fue separar la identidad de los usuarios de los permisos asignados a los recursos, evitando asignar permisos directamente a las cuentas individuales.

La implementación permite administrar los accesos mediante grupos de seguridad y mantener una estructura escalable.

---

# 🎯 Objetivos

- Implementar el modelo AGDLP.
- Separar usuarios de permisos sobre recursos.
- Utilizar Global Groups (GG) para representar funciones o departamentos.
- Utilizar Domain Local Groups (DL) para asignar permisos sobre recursos.
- Centralizar la administración de accesos.
- Aplicar permisos mediante grupos en lugar de usuarios individuales.
- Validar los accesos permitidos y denegados.

---

# 🧩 ¿Qué es AGDLP?

AGDLP es un modelo utilizado en Active Directory para estructurar la asignación de permisos.

La lógica implementada es:

```text
Accounts
   ↓
Global Groups
   ↓
Domain Local Groups
   ↓
Permissions

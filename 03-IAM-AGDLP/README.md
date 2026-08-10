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

```
# 📊 Matriz de asignación AGDLP

La relación entre los Global Groups (GG) y los Domain Local Groups (DL) fue implementada siguiendo el modelo AGDLP.

Los usuarios pertenecen a Global Groups según su función o departamento. Estos grupos son posteriormente incorporados a los Domain Local Groups, que son los grupos utilizados para asignar permisos sobre los recursos.

| Global Group | Domain Local Group | Recurso | Acceso |
|---|---|---|---|
| `GG_Direccion` | `DL_Direccion_RW` | Dirección | Modificar |
| `GG_Finanzas` | `DL_Finanzas_RW` | Finanzas | Modificar |
| `GG_Helpdesk` | `DL_IT_RW` | IT | Modificar |
| `GG_Infraestructura` | `DL_IT_RW` | IT | Modificar |
| `GG_IT` | `DL_IT_RW` | IT | Modificar |
| `GG_IT_Admins` | `DL_IT_RW` | IT | Modificar |
| `GG_RRHH` | `DL_RRHH_RW` | RRHH | Modificar |
| `GG_Marketing` | `DL_Marketing_RW` | Marketing | Modificar |
| `GG_Ventas` | `DL_Ventas_RW` | Ventas | Modificar |
| `GG_Operaciones` | `DL_Operaciones_RW` | Operaciones | Modificar |
| `GG_SOC` | `DL_Ciberseguridad_RW` | Ciberseguridad | Modificar |
| `GG_BlueTeam` | `DL_Ciberseguridad_RW` | Ciberseguridad | Modificar |
| `GG_ThreatHunting` | `DL_Ciberseguridad_RW` | Ciberseguridad | Modificar |
| `GG_IAM` | `DL_Ciberseguridad_RW` | Ciberseguridad | Modificar |

### Resumen de acceso

Todos los recursos departamentales fueron configurados con permisos de modificación para sus respectivos Domain Local Groups.

La asignación de permisos no se realiza directamente sobre las cuentas de usuario, sino mediante la pertenencia a los grupos de seguridad.

---

# 🔗 Flujo de acceso

La implementación sigue la siguiente estructura:

```text
Usuario
   │
   ▼
Global Group (GG_*)
   │
   ▼
Domain Local Group (DL_*)
   │
   ▼
Recurso compartido
   │
   ▼
Permisos NTFS

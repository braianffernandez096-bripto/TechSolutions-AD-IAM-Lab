# 🏗️ Arquitectura general

## 🗺️ Diagrama lógico

techsolutions.local
                           |
                        DC01
                (Windows Server 2022)
                AD DS + DNS + GPO
                           |
    +---------------------+---------------------+
    |                                             |
    OU: TechSolutions Cliente
| Windows 10
+-----+------------------------------+ (unido al dominio)
| | | | | |
01_ 02_ 03_ ... 09_ 11_
Direccion RRHH Finanzas Equipos Grupos
(usuarios) (GG_* y DL_*)


---

## 🔄 Flujo de autenticación y acceso
Usuario inicia sesión en cliente Windows 10
↓
DC01 valida credenciales (Kerberos)
↓
Se arma el token de acceso con las membresías de grupo (GG_)
↓
Usuario solicita acceso a \DC01\Compartidos<Departamento>
↓
Se evalúa: Share Permissions (amplio) + NTFS (restringido vía DL__RW)
↓
Acceso concedido solo si el usuario pertenece al GG correspondiente


---

## 🧩 Componentes

| Componente | Rol |
|---|---|
| DC01 | Controlador de dominio, DNS, GPO, File Server |
| Cliente Windows 10 | Estación de trabajo de usuario final |
| `C:\Compartidos` | Recurso compartido con estructura por departamento |
| GPOs | Banner legal, bloqueo de cuenta, restricciones, auditoría |

Diagrama de red físico/topológico: agregar imagen propia en `../02-Active-Directory/evidencias/` o en esta misma carpeta si se genera uno.

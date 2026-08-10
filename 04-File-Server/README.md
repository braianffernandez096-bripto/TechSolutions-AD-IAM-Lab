# 🏗️ 01 — Infraestructura

Base del laboratorio: instalación y configuración inicial del controlador de dominio.

---

## 🛠️ Qué se hizo

1. **Instalación de Windows Server 2022** desde cero.
2. **Cambio de nombre del servidor** a `DC01`.
3. **Configuración de IP estática** — un controlador de dominio no puede depender de DHCP.
4. **Configuración de DNS** propio, integrado con AD.
5. **Promoción a Controlador de Dominio** — instalación del rol AD DS y creación del bosque/dominio `techsolutions.local`.
6. **Cliente Windows 10** unido al dominio, apuntando al DNS de `DC01`.

---

## ✅ Validaciones realizadas

- Resolución de nombres del dominio funcionando correctamente.
- Inicio de sesión con usuarios del dominio desde el cliente Windows 10.
- Verificación de `whoami`, `LOGONSERVER` y `USERDOMAIN` desde el cliente.

---

## 📸 Evidencias

> Agregá acá las capturas de la instalación de Windows Server 2022, la configuración de IP/DNS, la promoción a controlador de dominio, y la unión del cliente Windows 10 ([`evidencias/`](evidencias/)).

---

## 🚀 Siguiente paso

Con la infraestructura base funcionando, se construyó la estructura organizativa completa en [`02-Active-Directory`](../02-Active-Directory/).

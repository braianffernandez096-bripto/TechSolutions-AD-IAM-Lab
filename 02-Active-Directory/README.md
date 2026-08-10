# 📸 Evidencias

## 1. Estructura general de Active Directory

La estructura del dominio fue organizada mediante Unidades Organizativas (OU), separando las diferentes áreas y funciones de la organización.

![Estructura general de Active Directory](Evidencias/01-estructura-active-directory.png)

---

## 2. Organización de equipos

Los equipos fueron separados en la OU `09_Equipos`, utilizando sub-OUs según el tipo de equipo y sistema operativo.

![Organización de equipos](evidencias/02-organizacion-equipos.png)

---

## 3. Organización de grupos

Los grupos de seguridad fueron centralizados en la OU `11_Grupos`, diferenciando los Global Groups (GG) de los Domain Local Groups (DL).

![Organización de grupos](evidencias/03-organizacion-grupos.png)

---

## 4. Organización de usuarios

Los usuarios fueron ubicados dentro de las OUs correspondientes a sus departamentos, permitiendo posteriormente asociarlos a los grupos globales correspondientes.

![Organización de usuarios](evidencias/04-organizacion-usuarios.png)
El dominio utilizado en el laboratorio es:

```text
techsolutions.local

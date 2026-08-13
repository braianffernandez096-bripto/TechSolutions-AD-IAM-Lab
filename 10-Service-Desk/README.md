# 🎟️ 10 — Service Desk (próximo proyecto)

> **Estado: no iniciado.** Esta carpeta es un placeholder intencional, no una sección incompleta del laboratorio de IAM.

---

## 📌 Qué va a contener

Un segundo proyecto, construido **sobre la misma infraestructura** de este laboratorio (`techsolutions.local`), que va a implementar:

- Gestión de tickets con **Jira**
- Registro y resolución de incidentes
- Solicitudes de acceso formalizadas (conectando directo con los [7 Casos de IAM](../07-Casos-IAM/) ya resueltos)
- Gestión de cambios

---

## 🔄 Ejemplo de flujo previsto

```
INC-001
El usuario Laura Fernández olvidó su contraseña.
   ↓
Buscar usuario en Active Directory
   ↓
Reset Password (mismo procedimiento del Caso 4)
   ↓
Obligar cambio de contraseña
   ↓
Documentar en Jira
   ↓
Cerrar ticket
```

Todo el trabajo de Soporte IT se va a apoyar sobre el entorno de Active Directory e IAM construido en este repositorio — es la razón por la que los 7 casos de IAM ya se documentaron con formato de ticket desde el principio.

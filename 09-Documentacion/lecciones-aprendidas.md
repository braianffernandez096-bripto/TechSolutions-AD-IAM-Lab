# 💡 Lecciones aprendidas

Problemas reales encontrados durante el proyecto y cómo se resolvieron — documentados a propósito, porque el proceso de diagnóstico es tan valioso como el resultado final.

---

## 🔸 Auditoría de AD tiene subcategorías independientes con Event IDs propios

Habilitar "Directory Service Changes" no genera los eventos legibles de "Account Management" (4720, 4725, 4726, 4738...) — son categorías separadas de la Configuración de directivas de auditoría avanzada, cada una con su propio conjunto de Event IDs. Hubo que habilitar ambas por separado para tener cobertura completa.

---

## 🔸 El evento 5141 (eliminación) requiere el permiso genérico "Eliminar", no el específico por clase

Marcar "Eliminar Usuario objetos" (DeleteChild, acotado por tipo de objeto) no es suficiente para que se registre el evento 5141 — hace falta además el permiso genérico "Eliminar" y "Eliminar subárbol" en el SACL.

---

## 🔸 Las GPOs de dominio no aplican retroactivamente

Habilitar una directiva de auditoría después de que ya ocurrió la acción que se quería auditar no genera el evento en retrospectiva. Cualquier prueba de validación debe hacerse *después* de confirmar que la GPO ya tomó efecto (esperando el ciclo de refresco o reiniciando el DC).

---

## 🔸 Los controladores de dominio restringen el inicio de sesión interactivo por defecto

Al intentar validar una delegación de permisos iniciando sesión directamente en el DC como el usuario delegado, Windows lo rechazó — es una restricción de seguridad esperada (los DCs no deben aceptar logons interactivos de cuentas comunes). La validación correcta se hizo con RSAT desde el cliente, o alternativamente con la **Comprobación de acceso eficaz** desde el propio DC sin necesidad de loguearse como otro usuario — técnica que terminó siendo la solución más prolija.

---

## 🔸 RSAT en Windows 10 no siempre se instala desde "Características opcionales"

En versiones de Windows 10 anteriores a la integración de RSAT como Feature on Demand, hace falta el paquete `.msu` independiente desde el Centro de descargas de Microsoft — y después de instalarlo, hay que habilitarlo explícitamente en "Activar o desactivar las características de Windows" (no se activa solo).

---

## 🔸 Los reportes con `Get-ADUser -Filter` sin acotar el `SearchBase` traen cuentas de sistema

Un reporte de "cuentas deshabilitadas" sobre todo el dominio devuelve también `krbtgt` e `Invitado` (deshabilitadas por defecto, no son bajas reales). Acotar la búsqueda con `-SearchBase` a la OU organizativa evita ese ruido sin depender de listas de exclusión frágiles.

---

## 🔸 El RSoP combinado detecta redundancia entre GPOs que por separado parecen correctas

Revisando el reporte de `gpresult` del cliente Windows 10 aparecieron dos GPOs distintas resolviendo lo mismo: `GPO - Windows10 - Banner Legal` y `GPO - Windows10 - Screen Lock Policy` tenían el **mismo aviso legal** configurado (ambas vinculadas a `09_Equipos/Windows10`), y por separado, `Screen Lock Policy` implementaba un bloqueo de pantalla por protector de pantalla clásico (600 seg) que duplicaba — con el mismo valor, pero por un mecanismo técnico distinto — el `Inicio de sesión interactivo: límite de inactividad del equipo` ya definido en Default Domain Policy.

Cada GPO, revisada de forma aislada, estaba bien configurada. La redundancia solo se hizo visible al mirar el **resultado combinado** (RSoP), no la configuración de cada GPO por separado. Quedó como criterio: antes de dar por cerrada cualquier configuración de GPOs múltiples sobre el mismo vínculo, generar el RSoP del equipo cliente y revisar que cada ajuste tenga una sola GPO "ganadora" y no dos GPOs distintas llegando al mismo resultado por caminos separados — la duplicación no rompe nada funcionalmente, pero se lee como falta de organización.

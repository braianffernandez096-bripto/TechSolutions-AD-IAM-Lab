# 📓 Notas operativas

Cosas que no estaban en la guía y que conviene saber para operar este laboratorio.

## 1. Agentes en `Disconnected` después de reiniciar la VM de Wazuh

**Síntoma:** al reiniciar `ubuntusoc`, todos los agentes quedan `Disconnected` aunque los contenedores figuren `Up`. En el log del manager aparecen rechazos de `wazuh-authd` por "Duplicate agent name".

**Solución que funcionó:** reiniciar el contenedor del manager.

```bash
sudo docker restart single-node-wazuh.manager-1
sleep 40
sudo docker exec single-node-wazuh.manager-1 /var/ossec/bin/agent_control -l
```

La causa raíz no se confirmó. Se descartó que `wazuh-remoted` estuviera caído (el estado lo mostraba corriendo).

## 2. El agente no puede ser más nuevo que el manager

El agente local de `ubuntusoc` se instaló en 4.14.10 mientras el manager es 4.14.7, y el log mostraba la incompatibilidad. El repositorio APT ya solo ofrece 4.14.10 y 4.14.11, así que se bajó el `.deb` de la versión del manager y se congeló:

```bash
wget https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.14.7-1_amd64.deb
sudo dpkg -i wazuh-agent_4.14.7-1_amd64.deb
sudo apt-mark hold wazuh-agent
```

`dpkg -i` conserva la configuración y el registro del agente. El `hold` evita que `apt upgrade` lo vuelva a subir.

## 3. Horarios: UTC vs. hora local

- La marca de tiempo de una alerta (`timestamp`) es el momento de **ingesta** en el manager, en UTC.
- La hora real del evento está en `data.win.system.systemTime`, también en UTC.
- El laboratorio está en UTC-3: `15:03 UTC` es `12:03` en el dashboard del navegador.
- Los logs del manager (`ossec.log`) también están en UTC.

## 4. Nombres de campo en las reglas

En las reglas personalizadas los campos **no llevan el prefijo `data.`** que se ve en el dashboard, y la primera letra del nombre XML se pasa a minúscula:

| Dashboard / evento XML | En la regla |
|---|---|
| `data.win.eventdata.TicketEncryptionType` | `win.eventdata.ticketEncryptionType` |
| `data.win.eventdata.PreAuthType` | `win.eventdata.preAuthType` |
| `data.win.eventdata.IpAddress` | `win.eventdata.ipAddress` |
| `data.win.eventdata.ServiceName` | `win.eventdata.serviceName` |

Además, en los valores de Sysmon las barras invertidas llegan **dobladas** (`C:\\Windows\\…`); por eso los filtros por ruta usan `.+` o `\\+` en lugar de una barra simple.

Otras cosas útiles: `negate="yes"` junto con `type="pcre2"` en un `<field>` permite excluir (por ejemplo cuentas de equipo, que terminan en `$`), y `$(campo)` dentro de `<description>` inserta el valor real en la alerta.

## 5. Recolección de Sysmon en los agentes de Windows

Se agregó este bloque a `ossec.conf` de DC01 y WIN10 (antes del último `</ossec_config>`) y se reinició `WazuhSvc`:

```xml
<localfile>
  <location>Microsoft-Windows-Sysmon/Operational</location>
  <log_format>eventchannel</log_format>
</localfile>
```

Hay que editar el archivo como **administrador**: con un usuario estándar la lectura y la escritura fallan en silencio y el script puede informar un éxito que no ocurrió.

## 6. Si un agente está apagado

El agente conserva los eventos mientras no tiene conexión y los entrega cuando vuelve. WIN10 aparece `Disconnected` cuando la VM está apagada; no es una falla.

## 7. Advertencia conocida, sin impacto

El log del manager muestra "Too many fields for JSON decoder" para algunos eventos de Windows con muchos campos. No afectó a ninguna de las reglas validadas; queda como punto a investigar.

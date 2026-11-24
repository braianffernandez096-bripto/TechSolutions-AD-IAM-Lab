# 🛡️ 11 — Hardening con PingCastle

Auditoría de seguridad de `techsolutions.local` con **PingCastle 4.1.2.0** y una serie de iteraciones de hardening, midiendo el score después de cada cambio.

## 📈 Resultado

| Momento | Score global (Basic) |
|---|---|
| Baseline | **70** |
| Iteración 6 | 20 |
| Iteración 7 | 20 |
| Iteración 8 | 5 |
| Iteración 9 | **5** |

> El score global de PingCastle es el **máximo** de cuatro indicadores (Stale Objects, Privileged Accounts, Trusts, Anomalies). Bajarlo exige cerrar el peor indicador, no mejorar el promedio.

## 🧭 Metodología

1. Ejecutar PingCastle (misma versión siempre) y guardar el informe de cada iteración.
2. Elegir los hallazgos de mayor impacto.
3. Aplicar el cambio y documentar el comando.
4. Volver a medir.

Detalle de cada iteración: [`iteraciones.md`](iteraciones.md). Lo que quedó sin cerrar y por qué: [`pendientes.md`](pendientes.md).

## 🗂️ Evidencias

Capturas y GIFs en [`Evidencias/`](Evidencias/) (ver [`Evidencias/README.md`](Evidencias/README.md)).

# 📚 09 — Documentación

Cierre del proyecto: la arquitectura general, el registro de decisiones de diseño con su justificación, y las lecciones aprendidas resolviendo problemas reales durante la construcción del laboratorio — el tipo de contenido pensado para explicar en una entrevista técnica, no solo para dejar constancia de qué se hizo.

---

## 📋 Contenido

| Documento | Qué cubre |
|---|---|
| [`arquitectura.md`](arquitectura.md) | Diagrama lógico del dominio, flujo de autenticación y acceso (Kerberos → token de grupo → Share + NTFS), y los componentes principales. |
| [`decisiones-de-diseno.md`](decisiones-de-diseno.md) | Por qué AGDLP, por qué 13 OUs, por qué el share queda permisivo y el control real está en NTFS, por qué auditoría diferenciada en Dirección, y otras decisiones clave con su justificación. |
| [`lecciones-aprendidas.md`](lecciones-aprendidas.md) | Problemas reales encontrados durante el proyecto (auditoría con subcategorías independientes, GPOs no retroactivas, RSoP detectando GPOs redundantes, entre otros) y cómo se diagnosticaron y resolvieron. |

---

## 🔗 Por qué separar estos tres documentos

`arquitectura.md` explica **cómo está armado** el sistema, `decisiones-de-diseno.md` explica **por qué se armó así** en vez de otra forma posible, y `lecciones-aprendidas.md` documenta **qué salió distinto a lo esperado** en el camino. Son tres preguntas distintas — mezclarlas en un solo archivo haría más difícil encontrar la respuesta puntual que alguien está buscando.

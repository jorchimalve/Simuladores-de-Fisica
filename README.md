# Colección de simuladores de física HTML

Repositorio de prácticas interactivas de física desarrolladas con HTML, CSS y JavaScript. Cada simulador vive en su propia carpeta y usa una interfaz visual común basada en la plantilla oficial del proyecto.

## Estructura

```text
.
|-- index.html
|-- README.md
|-- .gitignore
|-- assets/
|   |-- css/
|   |   |-- site.css
|   |   `-- simulator-base.css
|   `-- js/
|       `-- simulator-theme.js
|-- plantilla-base/
|   |-- index.html
|   |-- script.js
|   |-- style.css
|   `-- plantilla-base.html
|-- simuladores/
|   `-- nombre_del_simulador/
|       `-- index.html
`-- tools/
```

## Simuladores incluidos

- Vectores en el espacio 3D
- Máquina de Atwood
- Gráfico de cajas y bigotes
- Plano inclinado con masa colgante
- MRU y MRUV con fotopuertas
- Conservación de la energía en pista
- Movimiento parabólico
- Hidrostática y manómetro en U
- Lentes ópticas
- Ley de Hooke y movimiento armónico simple
- Péndulo simple
- Regresión lineal por mínimos cuadrados
- Rozamiento en plano horizontal

## Convenciones del proyecto

- Un simulador por carpeta dentro de `simuladores/`.
- Cada simulador debe tener un `index.html`.
- Los estilos compartidos están en `assets/css/simulator-base.css`.
- El cambio de tema compartido está en `assets/js/simulator-theme.js`.
- La plantilla de referencia está en `plantilla-base/`.
- No usar nombres de archivos nuevos con espacios, tildes o caracteres especiales.
- Mantener el footer común:

```text
© 2026 Simuladores de Física - Desarrollado por MSc. Jorge Chimarro Alvear
```

## Identidad visual

Los simuladores usan una estructura común:

- header con título, subtítulo y switch de modo oscuro;
- panel lateral de controles;
- bloque `.buttons` para acciones principales;
- área principal de canvas, gráfico, tabla o escena;
- tarjetas de resultados;
- instrucciones breves;
- footer común.

Los checkboxes solo se mantienen para opciones booleanas reales, por ejemplo mostrar vectores, mostrar trayectoria, activar rozamiento o mostrar capas visuales. Las acciones de zoom, centrado o ajuste visual deben usar el botón `Ajustar vista`.

## Preparación para GitHub

Antes de publicar:

1. Verificar que cada carpeta de `simuladores/` tenga `index.html`.
2. Revisar que no existan archivos temporales, copias o respaldos.
3. Confirmar que los HTML conserven `<meta charset="UTF-8">`.
4. Probar modo claro y modo oscuro.
5. Probar botones, sliders, exportación CSV y exportación PNG cuando existan.
6. Confirmar que no se hayan alterado fórmulas, cálculos ni comportamiento físico.

## Herramientas locales

Los scripts de `tools/` ayudan a aplicar formato o revisar estilos comunes. Usarlos solo como apoyo y revisar los cambios antes de publicarlos.

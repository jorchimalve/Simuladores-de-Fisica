# Simuladores de Física

Colección de simuladores interactivos de física desarrollados con HTML, CSS y JavaScript para apoyar prácticas de aula, demostraciones conceptuales y exploración visual de fenómenos físicos.

## Objetivos

- Reunir simuladores de física en una estructura limpia y fácil de mantener.
- Ofrecer prácticas interactivas ejecutables directamente desde el navegador.
- Mantener una identidad visual común con modo claro y modo oscuro.
- Facilitar la observación, medición y exportación de datos cuando el simulador lo permite.

## Características

- Interfaz unificada para todos los simuladores.
- Panel lateral de controles con sliders, inputs y botones consistentes.
- Área principal de simulación con canvas, gráficas, tablas o escena 3D.
- Modo oscuro integrado.
- Botón `Ajustar vista` en los simuladores con canvas o escena.
- Exportación CSV en prácticas que generan datos.
- Exportación PNG cuando la práctica lo incluye.
- Estructura pensada para GitHub Pages o uso local.

## Simuladores disponibles

- Vectores en el espacio 3D.
- Máquina de Atwood.
- Diagrama de cajas y bigotes.
- Equilibrio en plano inclinado.
- MRU-MRUV.
- Conservación de la energía en pista.
- Movimiento parabólico.
- Hidrostática y manómetro en U.
- Lentes ópticas delgadas.
- Ley de Hooke y movimiento armónico simple.
- Péndulo simple.
- Regresión lineal por mínimos cuadrados.
- Rozamiento en plano horizontal.

## Tecnologías utilizadas

- HTML5.
- CSS3.
- JavaScript.
- Canvas.
- WebGL / Three.js en el simulador de vectores 3D.
- Chart.js no es una dependencia global del proyecto; las gráficas actuales se resuelven principalmente con Canvas.

## Estructura

```text
Simuladores-de-Fisica/
|-- README.md
|-- LICENSE
|-- index.html
|-- plantilla-base.html
|-- assets/
|   |-- css/
|   |-- js/
|   `-- img/
|-- plantilla-base/
|   |-- index.html
|   |-- style.css
|   `-- script.js
|-- simuladores/
|   |-- simulador_3_d_de_vectores_en_el_espacio_arrastre_modulo/
|   |-- simulador_atwood_consistente/
|   |-- simulador_cajas_y_bigotes/
|   |-- simulador_conservacion_de_la_energia_en_pista_sin_cono_rozamiento/
|   |-- simulador_de_movimiento_parabolico/
|   |-- simulador_equilibrio_en_plano_inclinado/
|   |-- simulador_hidrostatica_manometro_u/
|   |-- simulador_lentes_opticas/
|   |-- simulador_ley_de_hooke/
|   |-- simulador_mru_mruv/
|   |-- simulador_pendulo_simple/
|   |-- simulador_regresion_lineal_minimos_cuadrados/
|   `-- simulador_rozamiento/
`-- tools/
```

Cada simulador tiene su propio `index.html` dentro de una carpeta independiente.

## Cómo ejecutar localmente

Opción rápida:

1. Descarga o clona el repositorio.
2. Abre `index.html` en un navegador moderno.
3. Entra al simulador desde la portada.

Opción con servidor local:

```powershell
python -m http.server 8000
```

Luego abre:

```text
http://localhost:8000
```

## Compatibilidad

Recomendado para navegadores modernos:

- Google Chrome.
- Microsoft Edge.
- Mozilla Firefox.
- Safari actualizado.

Algunos simuladores usan canvas, descarga de archivos o WebGL, por lo que se recomienda permitir JavaScript en el navegador.

## Modo oscuro

Todos los simuladores incluyen un switch visible de modo oscuro. El tema cambia fondo, paneles, canvas, textos, bordes y elementos gráficos.

## Licencia

Este proyecto se distribuye bajo la licencia MIT. Consulta el archivo `LICENSE`.

## Autor

Desarrollado por

MSc. Jorge Chimarro Alvear

# Simuladores de Física

Colección de simuladores interactivos de física desarrollados con HTML5, CSS3 y JavaScript. El proyecto está preparado como sitio estático para GitHub Pages, de modo que cada práctica puede abrirse directamente desde el navegador sin instalar dependencias ni descargar archivos adicionales.

## Sitio web

URL esperada de GitHub Pages:

https://jorchimalve.github.io/Simuladores-de-Fisica/

Configurar GitHub Pages con:

- Branch: `main`
- Folder: `/ (root)`

## Objetivos

- Reunir simuladores de física en una estructura limpia y fácil de mantener.
- Ofrecer prácticas interactivas ejecutables directamente desde el navegador.
- Mantener una identidad visual común con modo claro y modo oscuro.
- Facilitar observación, medición y exportación de datos cuando el simulador lo permite.

## Características

- Portal principal con buscador, categorías y tarjetas de acceso.
- Un simulador por carpeta, cada uno con su propio `index.html`.
- Interfaz consistente basada en `plantilla-base.html`.
- Modo oscuro en el portal y en los simuladores.
- Visualización mediante Canvas y WebGL cuando corresponde.
- Exportación CSV en prácticas que generan datos.
- Exportación PNG en simuladores que incluyen captura de gráfica o canvas.
- Rutas relativas compatibles con GitHub Pages.

## Simuladores disponibles

| Categoría | Simulador |
| --- | --- |
| Vectores | Vectores en el espacio 3D |
| Dinámica | Máquina de Atwood |
| Estadística | Diagrama de cajas y bigotes |
| Dinámica | Equilibrio en plano inclinado |
| Cinemática | MRU-MRUV |
| Energía | Conservación de la energía en pista |
| Cinemática | Movimiento parabólico |
| Fluidos | Hidrostática y manómetro en U |
| Óptica | Lentes ópticas |
| Movimiento Armónico Simple | Ley de Hooke y movimiento armónico simple |
| Movimiento Armónico Simple | Péndulo simple |
| Elasticidad | Ley de Hooke y movimiento armónico simple |
| Estadística | Regresión lineal por mínimos cuadrados |
| Dinámica | Rozamiento en plano horizontal |

### Movimiento Armónico Simple

- Ley de Hooke y movimiento armónico simple.
- Péndulo simple.

### Elasticidad

- Ley de Hooke y movimiento armónico simple.

El simulador de Ley de Hooke se incluye en las categorías Elasticidad y Movimiento Armónico Simple porque permite analizar tanto la relación fuerza-deformación como la oscilación de un sistema masa-resorte.

## Tecnologías utilizadas

- HTML5
- CSS3
- JavaScript
- Canvas
- WebGL / Three.js en el simulador de vectores 3D
- Chart.js si se incorpora en futuras prácticas

## Estructura del repositorio

```text
Simuladores-de-Fisica/
|-- README.md
|-- LICENSE
|-- index.html
|-- plantilla-base.html
|-- .nojekyll
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

## Cómo ejecutar localmente

1. Clonar o descargar el repositorio.
2. Iniciar un servidor HTTP local desde la raíz del proyecto:

```powershell
python -m http.server 8000
```

3. Abrir en el navegador:

```text
http://localhost:8000
```

No se recomienda abrir los archivos con doble clic local, porque algunas rutas y recursos se validan mejor mediante HTTP.

## Compatibilidad

Recomendado para navegadores modernos:

- Google Chrome
- Microsoft Edge
- Mozilla Firefox
- Safari actualizado

Algunos simuladores usan Canvas, descarga de archivos o WebGL, por lo que JavaScript debe estar habilitado.

## Licencia

Este proyecto se distribuye bajo la licencia MIT. Consulta el archivo `LICENSE`.

## Autor

Desarrollado por

MSc. Jorge Chimarro Alvear

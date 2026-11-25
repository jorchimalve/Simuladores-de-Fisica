# Plantilla base

Carpeta de referencia para crear nuevos simuladores con la identidad visual compartida, inspirada en Biot–Savart.

Flujo sugerido:

1. Copiar esta carpeta.
2. Pegar la copia dentro de `simuladores/`.
3. Renombrar la carpeta con un identificador corto, en minúsculas y sin espacios.
4. Mantener `index.html` como archivo principal.
5. Mantener los enlaces a `../../assets/css/simulator-base.css` y `../../assets/js/simulator-theme.js` desde cada simulador para conservar el encabezado, la navegación de Inicio, el tema y los estilos comunes.

La plantilla agrega automáticamente la identidad institucional y el botón de Inicio cuando se usa dentro de `simuladores/<carpeta>/`. Si se crea una estructura distinta, revisa la ruta del enlace de Inicio en `assets/js/simulator-theme.js`.

# Medición de visitas

**Estado de publicación:** el cambio local incluye los 14 simuladores. El pull request incluye el portal y 13 simuladores; el HTML de Misión Laboratorio UCE (arcade), de más de 1 MB, no pudo subirse porque supera el límite de revisión automática del conector. Antes de publicar la colección completa, subir manualmente el archivo modificado de la descarga a `simuladores/simulador_mision_laboratorio_uce_arcade_rpg/index.html`. Las pruebas del pull request excluyen expresamente esa página pendiente.

La integración está lista pero **desactivada** hasta configurar un sitio real de GoatCounter. No se muestran ceros ni cifras de ejemplo como datos reales.

GitHub Pages es un alojamiento estático: no permite guardar un contador compartido entre todos los visitantes. `localStorage` solo mediría un navegador. Las estadísticas de tráfico del repositorio tampoco miden las visitas a GitHub Pages. Por eso se requiere un servicio de medición o un servidor propio; no hay un contador global fiable exclusivamente con estos archivos.

## Activación

1. Crear un sitio en https://www.goatcounter.com/ para este proyecto. La creación de cuenta corresponde al propietario. No entregar contraseñas ni claves API.
2. En `assets/js/analytics-config.js`, cambiar `site: ""` por la dirección pública asignada, por ejemplo `site: "https://TU-CODIGO.goatcounter.com"` (sin `/count`). El ejemplo no corresponde a una cuenta existente.
3. En GoatCounter, activar **Allow adding visitor counts on your website** para permitir los contadores públicos. Mantener **Settings → Data collection → Sessions** activo para deduplicar las visitas por página y sesión.
4. Integrar el cambio en `main`. Confirmar que Pages publica desde esa rama y la raíz del repositorio, o que el flujo de despliegue vigente incluye los archivos añadidos.
5. Abrir el portal y dos simuladores en el sitio publicado. Comprobar las rutas en el panel de GoatCounter. Recargar una misma página y verificar la deduplicación con Sessions activo. Consultar los contadores después de que expire la caché, que puede durar hasta cuatro horas.

## Qué significan las cifras

- **Visitas por simulador:** visitas registradas a esa ruta. Con Sessions activo, volver a cargar una página dentro de la sesión no añade otra visita para esa página.
- **Total del sitio:** contador `TOTAL` de GoatCounter, que incluye portal y simuladores. Una persona que abre varias páginas puede aportar varias visitas al total.
- **Personas únicas:** estas cifras no identifican personas ni son un conteo histórico de usuarios únicos. GoatCounter estima sesiones mediante información de conexión y navegador, con una ventana de ocho horas. Navegadores, redes compartidas y sesiones nuevas limitan esa estimación. El panel del proveedor permite analizar sesiones; no usar `count_unique` como otra métrica: es un alias de `count`.
- La medición empieza al activarla. No recupera visitas anteriores ni convierte las estrellas o descargas de GitHub en visitas.
- Bloqueadores, JavaScript deshabilitado, fallos de conexión y filtros del proveedor pueden impedir el registro. No es un censo exacto.

## Integración y fallos

Los 14 simuladores y el portal cargan los mismos dos scripts diferidos y una hoja de estilos. Las plantillas no generan visitas. Se normalizan `/index.html` y `/` a la misma ruta; consultas y fragmentos no crean simuladores distintos. Las tarjetas del portal muestran las visitas sin registrar una visita al simulador hasta abrirlo.

Solo el origen de producción envía datos. Las vistas previas y localhost no cargan el servicio ni consultan sus contadores. Si hay errores, se muestra **No disponible**, nunca un cero supuesto. La configuración vacía no realiza llamadas externas. No se añaden cookies, identificadores locales ni credenciales desde este código.

El panel conserva los colores del sitio y ofrece enlaces para descargar el código y la configuración. El dashboard del propietario requiere iniciar sesión; no se hace público automáticamente.

## Pruebas

Ejecutar `npm install`, `npx playwright install chromium` y `npm test`. GitHub Actions ejecuta estas pruebas automáticamente en los pull requests. El archivo utiliza un navegador Chromium instalado; puede indicarse mediante `CHROME_PATH`. Las pruebas interceptan el servicio: no generan visitas reales. Incluyen cobertura de las 15 páginas, rutas canónicas, configuración pendiente, éxito, errores, bloqueo del script, vista previa y temas/móvil.

Fuentes oficiales:
- https://docs.github.com/en/pages/getting-started-with-github-pages/what-is-github-pages
- https://www.goatcounter.com/help/start
- https://www.goatcounter.com/help/visitor-counter
- https://www.goatcounter.com/help/sessions
- https://www.goatcounter.com/help/js

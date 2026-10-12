(function () {
  "use strict";
  if (window.simulatorVisitsLoaded) return;
  window.simulatorVisitsLoaded = true;
  const config = window.simulatorAnalytics || {};
  const scriptURL = document.currentScript.src;
  const root = new URL("../../", scriptURL);
  const canonical = (path) => path.replace(/index\.html$/, "");
  const path = canonical(location.pathname);
  const base = config.basePath || root.pathname;
  const isPortal = path === base;
  if (!isPortal && !path.startsWith(base + "simuladores/")) return;

  function element(tag, text, className) {
    const node = document.createElement(tag);
    node.textContent = text;
    if (className) node.className = className;
    return node;
  }
  const panel = element("section", "", "visits-panel");
  panel.setAttribute("aria-label", "Estadísticas de visitas");
  panel.append(element("h2", "Visitas registradas"));
  const pending = "Pendiente de activación";
  const targets = [];
  function counter(parent, label, counterPath, className) {
    const row = element("p", "", className);
    row.append(element("span", label + ": "));
    const value = element("span", pending);
    row.append(value);
    parent.append(row);
    targets.push({ value, path: counterPath });
  }
  if (!isPortal) counter(panel, "Este simulador", path);
  counter(panel, "Total del sitio (portal y simuladores)", "TOTAL");
  panel.append(element("p", "Las visitas no equivalen a personas únicas. Una persona puede visitar varias páginas. El registro empieza al activar la medición; no incluye visitas históricas. Los contadores pueden tardar hasta 4 horas en actualizarse.", "visits-note"));
  const status = element("p", "Medición pendiente de activación.", "visits-note");
  panel.append(status);
  const downloads = element("p", "Código del contador: ");
  for (const [file, label] of [["visits.js", "Descargar código"], ["analytics-config.js", "Descargar configuración"]]) {
    const link = element("a", label);
    link.href = new URL("assets/js/" + file, root).href;
    link.download = file;
    downloads.append(link, document.createTextNode(" · "));
  }
  panel.append(downloads);
  const footer = document.querySelector(".site-footer, .sim-footer");
  if (footer) footer.before(panel);
  else document.body.append(panel);
  if (isPortal) {
    document.querySelectorAll(".simulator-card").forEach((card) => {
      const link = card.querySelector('a[href*="simuladores/"]');
      if (link) counter(card, "Visitas", canonical(new URL(link.href).pathname), "visits-card");
    });
  }

  // No envía visitas ni consulta contadores en pruebas locales o vistas previas.
  if (location.origin !== config.productionOrigin) {
    status.textContent = "Vista previa: no se envían visitas.";
    return;
  }
  let site;
  try {
    site = new URL(config.site);
    if (site.protocol !== "https:" || !/^[a-z0-9-]+\.goatcounter\.com$/.test(site.hostname) || site.username || site.password || site.port || site.pathname !== "/" || site.search || site.hash) return;
  } catch (_) { return; }
  const tracker = document.createElement("script");
  tracker.async = true;
  tracker.src = "https://gc.zgo.at/count.js";
  tracker.setAttribute("data-goatcounter", site.origin + "/count");
  tracker.setAttribute("data-goatcounter-settings", JSON.stringify({ path, no_events: true }));
  tracker.onerror = () => { status.textContent = "No se pudo cargar la medición. Un bloqueo de red puede impedir el registro."; };
  tracker.onload = () => { status.textContent = "Medición configurada con GoatCounter. Visitas deduplicadas por página y sesión si la opción Sessions está activa."; };
  document.head.append(tracker);
  const dashboard = element("a", "Panel del propietario (requiere iniciar sesión)");
  dashboard.href = site.origin;
  dashboard.target = "_blank";
  dashboard.rel = "noopener noreferrer";
  panel.append(dashboard);
  targets.forEach(async ({ value, path: counterPath }) => {
    value.textContent = "Cargando…";
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), 8000);
    try {
      const response = await fetch(site.origin + "/counter/" + encodeURIComponent(counterPath) + ".json", { signal: controller.signal, credentials: "omit" });
      if (!response.ok) throw new Error("Counter unavailable");
      const data = await response.json();
      // count_unique es un alias de count, NO una métrica de personas únicas.
      if (typeof data.count !== "string" || !/^\d[\d\s.,\u00a0\u202f]*$/.test(data.count)) throw new Error("Invalid counter");
      value.textContent = data.count;
    } catch (_) {
      value.textContent = "No disponible";
      value.title = "Puede faltar la activación de contadores públicos, datos registrados o conexión. No significa cero visitas.";
    } finally { clearTimeout(timeout); }
  });
})();

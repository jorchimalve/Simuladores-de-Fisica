const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { chromium } = require('playwright');
const root = path.resolve(__dirname, '..');
const base = '/Simuladores-de-Fisica/';
const origin = 'https://jorchimalve.github.io';
const pages = ['index.html', ...fs.readdirSync(path.join(root, 'simuladores'), { withFileTypes: true }).filter(x => x.isDirectory()).map(x => `simuladores/${x.name}/index.html`)];

test('visitas: cobertura, rutas, errores, vistas previas y diseño', async () => {
  const browser = await chromium.launch({ headless: true, ...(process.env.CHROME_PATH ? { executablePath: process.env.CHROME_PATH } : {}) });
  try {
    async function setup({ configured = false, failure = false, blocked = false, local = false, invalid = false } = {}) {
      const context = await browser.newContext();
      const page = await context.newPage();
      const requests = [];
      await context.route('**/*', async route => {
        const url = new URL(route.request().url());
        if (url.hostname === 'gc.zgo.at') {
          requests.push(url.href);
          if (blocked) return route.abort();
          return route.fulfill({ contentType: 'text/javascript', body: 'window.testTrackerSettings = JSON.parse(document.currentScript.getAttribute("data-goatcounter-settings"));' });
        }
        if (url.hostname === 'test.goatcounter.com') {
          requests.push(url.href);
          return route.fulfill({ status: failure ? 404 : 200, contentType: 'application/json', body: JSON.stringify({ count: invalid ? '<img src=x>' : '1,234', count_unique: '999' }) });
        }
        if (url.origin !== (local ? 'http://localhost:8000' : origin)) return route.abort();
        let rel = decodeURIComponent(url.pathname).slice(base.length);
        if (!rel || rel.endsWith('/')) rel += 'index.html';
        if (rel.includes('..')) return route.abort();
        let body = fs.readFileSync(path.join(root, rel));
        if (configured && rel === 'assets/js/analytics-config.js') body = Buffer.from(body.toString().replace('site: ""', 'site: "https://test.goatcounter.com"'));
        const types = { '.html': 'text/html', '.js': 'text/javascript', '.css': 'text/css' };
        return route.fulfill({ body, contentType: types[path.extname(rel)] || 'application/octet-stream' });
      });
      return { context, page, requests, url: (rel) => (local ? 'http://localhost:8000' : origin) + base + rel };
    }
    const pending = await setup();
    assert.equal(pages.length, 15);
    // Arcade se distribuye en la descarga local: su subida remota está pendiente.
    for (const rel of pages.filter(p => !p.includes('arcade_rpg'))) {
      await pending.page.goto(pending.url(rel));
      await pending.page.locator('.visits-panel').waitFor();
      assert.equal(await pending.page.locator('.visits-panel').count(), 1, rel);
      assert.match(await pending.page.locator('.visits-panel').innerText(), /Pendiente de activación/);
    }
    assert.equal(pending.requests.length, 0);
    await pending.context.close();

    const active = await setup({ configured: true });
    await active.page.goto(active.url('index.html'));
    await active.page.waitForFunction(() => [...document.querySelectorAll('.visits-card')].every(n => n.textContent.includes('1,234')));
    assert.equal(await active.page.locator('.visits-card').count(), 14);
    assert.equal(active.requests.filter(x => x.includes('gc.zgo.at')).length, 1);
    assert.equal(active.requests.filter(x => x.includes('/counter/')).length, 15);
    assert.equal(await active.page.evaluate(() => window.testTrackerSettings.path), base);
    assert.ok(active.requests.some(x => x.endsWith('/counter/TOTAL.json')));
    for (const rel of ['simuladores/simulador_mru_mruv/index.html?x=1#test', 'simuladores/simulador_mru_mruv/']) {
      await active.page.goto(active.url(rel));
      await active.page.waitForFunction(() => window.testTrackerSettings);
      assert.equal(await active.page.evaluate(() => window.testTrackerSettings.path), base + 'simuladores/simulador_mru_mruv/');
    }
    await active.context.close();

    for (const options of [{ configured: true, failure: true }, { configured: true, invalid: true }, { configured: true, blocked: true }, { configured: true, local: true }]) {
      const scenario = await setup(options);
      await scenario.page.goto(scenario.url('index.html'));
      if (options.local) {
        assert.equal(scenario.requests.length, 0);
        assert.match(await scenario.page.locator('.visits-panel').innerText(), /Vista previa/);
      } else if (options.blocked) {
        await scenario.page.waitForFunction(() => document.querySelector('.visits-panel').textContent.includes('No se pudo cargar'));
      } else {
        await scenario.page.waitForFunction(() => document.querySelector('.visits-panel').textContent.includes('No disponible'));
      }
      // El buscador del portal sigue funcionando aunque falle la medición.
      await scenario.page.locator('#searchInput').fill('Atwood');
      assert.equal(await scenario.page.locator('.simulator-card:visible').count(), 1);
      await scenario.context.close();
    }

    const visual = await setup();
    await visual.page.goto(visual.url('index.html'));
    await visual.page.locator('#themeSwitch').check();
    assert.equal(await visual.page.evaluate(() => document.body.classList.contains('dark')), true);
    await visual.page.setViewportSize({ width: 390, height: 844 });
    assert.equal(await visual.page.evaluate(() => document.documentElement.scrollWidth <= innerWidth), true);
    await visual.page.locator('.visits-panel').scrollIntoViewIfNeeded();
    if (process.env.VISITS_SCREENSHOT) await visual.page.screenshot({ path: process.env.VISITS_SCREENSHOT });
    await visual.context.close();
  } finally { await browser.close(); }
});

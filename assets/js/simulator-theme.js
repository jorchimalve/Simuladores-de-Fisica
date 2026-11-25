(function () {
  const themeSwitch = document.getElementById("themeSwitch");
  const header = document.querySelector(".sim-header");

  if (header) {
    const titleGroup = header.querySelector(".sim-title-group");
    const themeToggle = header.querySelector(".theme-toggle");

    if (titleGroup && !titleGroup.querySelector(".sim-eyebrow")) {
      const eyebrow = document.createElement("p");
      eyebrow.className = "sim-eyebrow";
      eyebrow.textContent = "Universidad Central del Ecuador · Centro de Física";
      titleGroup.prepend(eyebrow);
    }

    if (!header.querySelector(".sim-home-link, .home-link, [data-sim-home]")) {
      const homeLink = document.createElement("a");
      homeLink.className = "sim-home-link";
      homeLink.href = window.location.pathname.includes("/simuladores/") ? "../../index.html" : "../index.html";
      homeLink.setAttribute("aria-label", "Volver al inicio de Simuladores de Física");
      homeLink.innerHTML = '<svg viewBox="0 0 24 24" aria-hidden="true" focusable="false"><path d="m3.5 10.8 8.5-7 8.5 7" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/><path d="M5.7 9.5v10.1h12.6V9.5M9.3 19.6v-6.2h5.4v6.2" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/></svg><span>Inicio</span>';

      if (themeToggle) header.insertBefore(homeLink, themeToggle);
      else header.append(homeLink);
    }
  }

  window.simulatorTheme = {
    isDark() {
      return document.body.classList.contains("dark");
    },
    canvas() {
      return this.isDark() ? "#111827" : "#ffffff";
    },
    text() {
      return this.isDark() ? "#f1f5f9" : "#111827";
    },
    softText() {
      return this.isDark() ? "#cbd5e1" : "#475569";
    },
    border() {
      return this.isDark() ? "#334155" : "#dbe3ee";
    },
    panel() {
      return this.isDark() ? "#1e293b" : "#ffffff";
    }
  };

  if (themeSwitch) {
    themeSwitch.addEventListener("change", () => {
      document.body.classList.toggle("dark", themeSwitch.checked);
      window.dispatchEvent(new CustomEvent("simulator-theme-change", {
        detail: { dark: themeSwitch.checked }
      }));

      requestAnimationFrame(() => {
        document.querySelectorAll("canvas").forEach((canvas) => {
          canvas.style.background = window.simulatorTheme.canvas();
        });

        for (const fn of ["draw", "render", "schedule", "update", "compute"]) {
          if (typeof window[fn] === "function") {
            try {
              window[fn]();
            } catch (_) {
              // Some simulators keep drawing functions inside closures.
            }
          }
        }

        window.dispatchEvent(new Event("resize"));
      });
    });
  }

  function runViewAdjustment() {
    const calls = ["fitView", "autoFit", "resize", "draw", "render", "update", "compute", "schedule"];

    window.dispatchEvent(new CustomEvent("simulator-fit-view"));

    for (const fn of calls) {
      if (typeof window[fn] === "function") {
        try {
          window[fn]();
        } catch (_) {
          // Some simulators keep their drawing state inside closures.
        }
      }
    }

    window.dispatchEvent(new Event("resize"));
  }

  document.addEventListener("click", (event) => {
    const button = event.target.closest("[data-fit-view]");
    if (!button) return;
    event.preventDefault();
    runViewAdjustment();
  });
})();

(function () {
  const themeSwitch = document.getElementById("themeSwitch");

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

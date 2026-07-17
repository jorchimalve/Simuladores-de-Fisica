const canvas = document.querySelector("#simulationCanvas");
const context = canvas.getContext("2d");
const parameterInput = document.querySelector("#parameterInput");
const parameterValue = document.querySelector("#parameterValue");
const startButton = document.querySelector("#startButton");
const resetButton = document.querySelector("#resetButton");
const themeButton = document.querySelector("#themeButton");

function draw() {
  context.clearRect(0, 0, canvas.width, canvas.height);

  const value = Number(parameterInput.value);
  const radius = 16 + value * 0.45;

  context.fillStyle = "#d8e2ea";
  context.fillRect(0, canvas.height - 80, canvas.width, 2);

  context.fillStyle = "#1769aa";
  context.beginPath();
  context.arc(canvas.width / 2, canvas.height / 2, radius, 0, Math.PI * 2);
  context.fill();
}

parameterInput.addEventListener("input", () => {
  parameterValue.value = parameterInput.value;
  draw();
});

startButton.addEventListener("click", draw);
resetButton.addEventListener("click", draw);
themeButton.addEventListener("click", () => {
  const isDark = document.body.classList.toggle("dark");
  themeButton.setAttribute("aria-pressed", String(isDark));
  themeButton.textContent = isDark ? "Modo claro" : "Modo oscuro";
  draw();
});

draw();

$RootPath = Split-Path -Parent $PSScriptRoot
$SimRoot = Join-Path $RootPath 'simuladores'
$Utf8 = New-Object System.Text.UTF8Encoding($false)

$Simulators = @{
  'simulador_3_d_de_vectores_en_el_espacio_arrastre_modulo' = @{
    Title = 'Vectores en el espacio 3D'
    Desc = 'Analiza componentes, m&oacute;dulo, direcci&oacute;n y proyecciones vectoriales en un entorno tridimensional.'
    Area = 'Vectores'
  }
  'simulador_atwood_consistente' = @{
    Title = 'M&aacute;quina de Atwood'
    Desc = 'Estudia aceleraci&oacute;n, tensi&oacute;n y equilibrio din&aacute;mico en dos masas unidas por una polea.'
    Area = 'Din&aacute;mica'
  }
  'simulador_cajas_y_bigotes' = @{
    Title = 'Diagrama de cajas y bigotes'
    Desc = 'Interpreta mediana, cuartiles, dispersi&oacute;n y valores at&iacute;picos en datos experimentales.'
    Area = 'Estad&iacute;stica'
  }
  'simulador_equilibrio_en_plano_inclinado' = @{
    Title = 'Equilibrio en plano inclinado'
    Desc = 'Relaciona tensi&oacute;n, peso y componentes de fuerza en un carrito con masa colgante.'
    Area = 'Equilibrio'
  }
  'simulador_mru_mruv' = @{
    Title = 'MRU-MRUV'
    Desc = 'Compara movimiento uniforme y acelerado mediante mediciones virtuales de posici&oacute;n y tiempo.'
    Area = 'Cinem&aacute;tica'
  }
  'simulador_conservacion_de_la_energia_en_pista_sin_cono_rozamiento' = @{
    Title = 'Conservaci&oacute;n de la energ&iacute;a en pista'
    Desc = 'Observa el intercambio entre energ&iacute;a potencial y cin&eacute;tica en una trayectoria sin rozamiento.'
    Area = 'Energ&iacute;a'
  }
  'simulador_de_movimiento_parabolico' = @{
    Title = 'Movimiento parab&oacute;lico'
    Desc = 'Explora trayectoria, alcance y altura m&aacute;xima variando velocidad inicial, &aacute;ngulo y gravedad.'
    Area = 'Cinem&aacute;tica'
  }
  'simulador_hidrostatica_manometro_u' = @{
    Title = 'Hidrost&aacute;tica y man&oacute;metro en U'
    Desc = 'Calcula diferencias de presi&oacute;n a partir de densidad, gravedad y altura de columnas de fluido.'
    Area = 'Fluidos'
  }
  'simulador_lentes_opticas' = @{
    Title = 'Lentes &oacute;pticas delgadas'
    Desc = 'Visualiza rayos, foco e imagen para sistemas de una o varias lentes delgadas.'
    Area = '&Oacute;ptica'
  }
  'simulador_ley_de_hooke' = @{
    Title = 'Ley de Hooke y movimiento arm&oacute;nico simple'
    Desc = 'Relaciona elongaci&oacute;n, fuerza restauradora, energ&iacute;a y oscilaci&oacute;n de un sistema masa-resorte.'
    Area = 'Oscilaciones'
  }
  'simulador_pendulo_simple' = @{
    Title = 'P&eacute;ndulo simple'
    Desc = 'Analiza periodo, longitud, masa y &aacute;ngulo con registro de datos y gr&aacute;fica experimental.'
    Area = 'Oscilaciones'
  }
  'simulador_regresion_lineal_minimos_cuadrados' = @{
    Title = 'Regresi&oacute;n lineal por m&iacute;nimos cuadrados'
    Desc = 'Ajusta datos experimentales, calcula pendiente e intercepto e interpreta el coeficiente R&sup2;.'
    Area = 'Estad&iacute;stica'
  }
  'simulador_rozamiento' = @{
    Title = 'Rozamiento en plano horizontal'
    Desc = 'Compara rozamiento est&aacute;tico y cin&eacute;tico al variar fuerza aplicada, masa y coeficientes.'
    Area = 'Din&aacute;mica'
  }
}

function Remove-LegacyPresentation {
  param([string]$Html)

  $Html = [regex]::Replace($Html, '(?is)<style\b[^>]*>.*?</style>', '')
  $Html = [regex]::Replace($Html, '(?is)<header\b[^>]*>.*?</header>', '', 1)
  $Html = [regex]::Replace($Html, '(?is)<footer\b[^>]*>.*?</footer>', '')
  $Html = [regex]::Replace($Html, '(?is)<section\s+class=["'']instructions\s+sim-instructions["''][^>]*>.*?</section>', '')
  $Html = [regex]::Replace($Html, '(?is)<script\s+src=["'']\.\./\.\./assets/js/simulator-theme\.js["'']>\s*</script>', '')
  $Html = [regex]::Replace($Html, '(?is)<link\s+rel=["'']stylesheet["'']\s+href=["'']\.\./\.\./assets/css/simulator-base\.css["'']\s*/?>', '')

  return $Html
}

function Ensure-Head {
  param(
    [string]$Html,
    [string]$Title,
    [string]$Desc
  )

  if ($Html -match '(?is)<title[^>]*>.*?</title>') {
    $Html = [regex]::Replace($Html, '(?is)<title[^>]*>.*?</title>', "<title>$Title</title>", 1)
  } else {
    $Html = [regex]::Replace($Html, '(?i)</head>', "  <title>$Title</title>`r`n</head>", 1)
  }

  if ($Html -match '(?is)<meta\s+name=["'']description["''][^>]*>') {
    $Html = [regex]::Replace($Html, '(?is)<meta\s+name=["'']description["''][^>]*>', "<meta name=""description"" content=""$Desc"">", 1)
  } else {
    $Html = [regex]::Replace($Html, '(?i)</head>', "  <meta name=""description"" content=""$Desc"">`r`n</head>", 1)
  }

  if ($Html -notmatch '(?is)<link\s+rel=["'']stylesheet["'']\s+href=["'']\.\./\.\./assets/css/simulator-base\.css["'']') {
    $Html = [regex]::Replace($Html, '(?i)</head>', "  <link rel=""stylesheet"" href=""../../assets/css/simulator-base.css"">`r`n</head>", 1)
  }

  return $Html
}

function Ensure-Body {
  param(
    [string]$Html,
    [string]$Title,
    [string]$Desc
  )

  $Header = @"
<header class="sim-header">
  <div class="sim-title-group">
    <h1>$Title</h1>
    <p class="sim-subtitle">$Desc</p>
  </div>
  <label class="theme-toggle">
    <span>Modo oscuro</span>
    <input type="checkbox" id="themeSwitch">
  </label>
</header>
"@

  $Html = [regex]::Replace($Html, '(?i)<body([^>]*)>', "<body`$1>`r`n$Header", 1)

  $Instructions = @"
<section class="instructions sim-instructions" aria-label="Instrucciones de la practica">
  <h3>Instrucciones</h3>
  <ul>
    <li>Ajusta los par&aacute;metros desde el panel de controles.</li>
    <li>Observa la respuesta del simulador y compara los resultados.</li>
    <li>Usa las herramientas de exportaci&oacute;n cuando la pr&aacute;ctica las incluya.</li>
  </ul>
</section>
"@

  $Footer = @"
<footer class="sim-footer">
  &copy; 2026 Simuladores de F&iacute;sica &mdash; Desarrollado por <strong>MSc. Jorge Chimarro Alvear</strong>
</footer>
<script src="../../assets/js/simulator-theme.js"></script>
"@

  $Html = [regex]::Replace($Html, '(?i)</body>', "$Instructions`r`n$Footer`r`n</body>", 1)
  return $Html
}

Get-ChildItem -Directory -LiteralPath $SimRoot | ForEach-Object {
  if (-not $Simulators.ContainsKey($_.Name)) { return }

  $IndexPath = Join-Path $_.FullName 'index.html'
  if (-not (Test-Path -LiteralPath $IndexPath)) { return }

  $Info = $Simulators[$_.Name]
  $Html = [System.IO.File]::ReadAllText($IndexPath, [System.Text.Encoding]::UTF8)
  $Html = Remove-LegacyPresentation -Html $Html
  $Html = Ensure-Head -Html $Html -Title $Info.Title -Desc $Info.Desc
  $Html = Ensure-Body -Html $Html -Title $Info.Title -Desc $Info.Desc
  [System.IO.File]::WriteAllText($IndexPath, $Html, $Utf8)
}

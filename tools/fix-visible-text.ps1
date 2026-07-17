$RootPath = Split-Path -Parent $PSScriptRoot
$SimRoot = Join-Path $RootPath 'simuladores'
$Utf8 = New-Object System.Text.UTF8Encoding($false)

$Files = Get-ChildItem -Recurse -File -Filter index.html -LiteralPath $SimRoot
$Bad = [string][char]0xFFFD

$Pairs = @(
  @('Condici-n', 'Condici&oacute;n'),
  @('Convenci-n', 'Convenci&oacute;n'),
  @('convenci-n', 'convenci&oacute;n'),
  @('Dise-o', 'Dise&ntilde;o'),
  @('s-lo', 's&oacute;lo'),
  @('Posici-n', 'Posici&oacute;n'),
  @('posici-n', 'posici&oacute;n'),
  @('Tama-o', 'Tama&ntilde;o'),
  @('tama-o', 'tama&ntilde;o'),
  @('-ptico', '&oacute;ptico'),
  @('din-micamente', 'din&aacute;micamente'),
  @('im-genes', 'im&aacute;genes'),
  @('cin-tica', 'cin&eacute;tica'),
  @('cin-tico', 'cin&eacute;tico'),
  @('est-tico', 'est&aacute;tico'),
  @('Per-odo', 'Per&iacute;odo'),
  @('per-odo', 'per&iacute;odo'),
  @('Gu-a', 'Gu&iacute;a'),
  @('Gr-fica', 'Gr&aacute;fica'),
  @('gr-fica', 'gr&aacute;fica'),
  @('Mini-gr-fica', 'Mini-gr&aacute;fica'),
  @('mini-gr-fica', 'mini-gr&aacute;fica'),
  @('-ltimos', '&uacute;ltimos'),
  @('hist-rico', 'hist&oacute;rico'),
  @('oscilaci-n', 'oscilaci&oacute;n'),
  @('elongaci-n', 'elongaci&oacute;n'),
  @('instant-neo', 'instant&aacute;neo'),
  @('cuadr-tico', 'cuadr&aacute;tico'),
  @('medici-n', 'medici&oacute;n'),
  @('detenci-n', 'detenci&oacute;n'),
  @('exportaci-n', 'exportaci&oacute;n'),
  @('simulaci-n', 'simulaci&oacute;n'),
  @('aceleraci-n', 'aceleraci&oacute;n'),
  @('tensi-n', 'tensi&oacute;n'),
  @('presi-n', 'presi&oacute;n'),
  @('variaci-n', 'variaci&oacute;n'),
  @('man-metro', 'man&oacute;metro'),
  @('hidrost-tica', 'hidrost&aacute;tica'),
  @('f?sica', 'f&iacute;sica'),
  @('F?sica', 'F&iacute;sica'),
  @('simulaci?n', 'simulaci&oacute;n'),
  @('direcci?n', 'direcci&oacute;n'),
  @('fricci?n', 'fricci&oacute;n'),
  @('est?tica', 'est&aacute;tica'),
  @('est?tico', 'est&aacute;tico'),
  @('posici?n', 'posici&oacute;n'),
  @('im?genes', 'im&aacute;genes'),
  @('?rea', '&aacute;rea'),
  @('?ngulo', '&Aacute;ngulo'),
  @('?ltimos', '&uacute;ltimos'),
  @('m-s pesada', 'm&aacute;s pesada'),
  @('m-s ', 'm&aacute;s '),
  @('m?s', 'm&aacute;s'),
  @('est?', 'est&aacute;'),
  @('instant�neo', 'instant&aacute;neo'),
  @('cuadr�tico', 'cuadr&aacute;tico'),
  @('m�s', 'm&aacute;s'),
  @('est�', 'est&aacute;'),
  @('est�tico', 'est&aacute;tico'),
  @('cin�tica', 'cin&eacute;tica'),
  @('oscilaci�n', 'oscilaci&oacute;n'),
  @('elongaci�n', 'elongaci&oacute;n'),
  @('per�odo', 'per&iacute;odo'),
  @('Per�odo', 'Per&iacute;odo'),
  @('mini-gr�fica', 'mini-gr&aacute;fica'),
  @('Mini-gr�fica', 'Mini-gr&aacute;fica'),
  @('Gr�fica', 'Gr&aacute;fica'),
  @('gr�fica', 'gr&aacute;fica'),
  @('�ltimos', '&uacute;ltimos')
)

$ButtonPairs = @(
  @('Iniciar ?', 'Iniciar'),
  @('Simular ?', 'Simular'),
  @('Pausar ?', 'Pausar'),
  @('Pausa ?', 'Pausar'),
  @('Reiniciar ?', 'Reiniciar'),
  @('Descargar CSV ?', 'Descargar CSV'),
  @('Exportar PNG ?', 'Exportar PNG'),
  @('Guardar PNG ?', 'Exportar PNG'),
  @('Generar boxplot ?', 'Simular'),
  @('Limpiar ?', 'Limpiar'),
  @('Limpiar datos ?', 'Limpiar datos'),
  @('Exportar resumen CSV ?', 'Descargar CSV'),
  @('Exportar datos ordenados ?', 'Descargar CSV'),
  @('Exportar resultados CSV ?', 'Descargar CSV'),
  @('Calcular regresi&oacute;n ?', 'Simular'),
  @('Calcular regresión ?', 'Simular'),
  @('Verificar respuestas ?', 'Verificar respuestas'),
  @('Borrar respuestas ??', 'Borrar respuestas')
)

foreach ($File in $Files) {
  $Text = [System.IO.File]::ReadAllText($File.FullName, [System.Text.Encoding]::UTF8)

  foreach ($Pair in $Pairs) {
    $Text = $Text.Replace($Pair[0], $Pair[1])
  }

  foreach ($Pair in $ButtonPairs) {
    $Text = $Text.Replace($Pair[0], $Pair[1])
  }

  $Text = $Text.Replace("'Reanudar ?'", "'Reanudar'")
  $Text = $Text.Replace('"Reanudar ?"', '"Reanudar"')
  $Text = $Text.Replace("'Simular ?'", "'Simular'")
  $Text = $Text.Replace('"Simular ?"', '"Simular"')
  $Text = $Text.Replace("'Iniciar ?'", "'Iniciar'")
  $Text = $Text.Replace('"Iniciar ?"', '"Iniciar"')
  $Text = $Text.Replace('? Equilibrio', 'Equilibrio')
  $Text = $Text.Replace('? derecha', 'derecha')
  $Text = $Text.Replace('? izquierda', 'izquierda')
  $Text = $Text.Replace('? equilibrio', 'equilibrio')
  $Text = $Text.Replace('? Correcto', 'Correcto')
  $Text = $Text.Replace('? Incorrecto.', 'Incorrecto.')

  $Text = $Text.Replace('Ángulo del plano ? (°)', '&Aacute;ngulo del plano &theta; (&deg;)')
  $Text = $Text.Replace('m-g ? M-g-sin?', 'm&middot;g &asymp; M&middot;g&middot;sin&theta;')
  $Text = $Text.Replace('M-g-sin?', 'M&middot;g&middot;sin&theta;')
  $Text = $Text.Replace('m = M-sin?', 'm = M&middot;sin&theta;')
  $Text = $Text.Replace('m &gt; M-sin? ?', 'm &gt; M&middot;sin&theta; &rarr;')
  $Text = $Text.Replace('m &lt; M-sin? ?', 'm &lt; M&middot;sin&theta; &rarr;')
  $Text = $Text.Replace('sin?', 'sin&theta;')
  $Text = $Text.Replace('?t desde anterior', '&Delta;t desde anterior')
  $Text = $Text.Replace('Viento (m/s) +? cola / -? frente', 'Viento (m/s) + cola / - frente')
  $Text = $Text.Replace('?ngulo instant&aacute;neo (?)', '&Aacute;ngulo instant&aacute;neo (&theta;)')
  $Text = $Text.Replace('?ngulo instantáneo (?)', '&Aacute;ngulo instant&aacute;neo (&theta;)')
  $Text = $Text.Replace('Velocidad angular inicial ?0 (rad/s)', 'Velocidad angular inicial &omega;0 (rad/s)')
  $Text = $Text.Replace('<span>? (rad)</span>', '<span>&theta; (rad)</span>')
  $Text = $Text.Replace('<span>? (rad/s)</span>', '<span>&omega; (rad/s)</span>')
  $Text = $Text.Replace('>? (°) + |v| (m/s)<', '>&theta; (&deg;) + |v| (m/s)<')
  $Text = $Text.Replace('>? (°)<', '>&theta; (&deg;)<')
  $Text = $Text.Replace('Gu&iacute;a del ?ngulo', 'Gu&iacute;a del &aacute;ngulo')
  $Text = $Text.Replace('Guía del ?ngulo', 'Gu&iacute;a del &aacute;ngulo')
  $Text = $Text.Replace('?: ${thMin.toFixed(1)}', '&theta;: ${thMin.toFixed(1)}')
  $Text = $Text.Replace('?<sub>s</sub>', '&mu;<sub>s</sub>')
  $Text = $Text.Replace('?<sub>k</sub>', '&mu;<sub>k</sub>')
  $Text = $Text.Replace('F = &mu;<sub>s</sub>N ? sin movimiento', 'F = &mu;<sub>s</sub>N &rarr; sin movimiento')
  $Text = $Text.Replace('&mu;<sub>s</sub>N ? movimiento', '&mu;<sub>s</sub>N &rarr; movimiento')
  $Text = $Text.Replace('Eje X? (m)', 'Eje X (m)')

  $Text = $Text.Replace("medici$($Bad)n", 'medici&oacute;n')
  $Text = $Text.Replace("Posici$($Bad)n", 'Posici&oacute;n')
  $Text = $Text.Replace("posici$($Bad)n", 'posici&oacute;n')
  $Text = $Text.Replace("Convenci$($Bad)n", 'Convenci&oacute;n')
  $Text = $Text.Replace("simulaci$($Bad)n", 'simulaci&oacute;n')
  $Text = $Text.Replace("direcci$($Bad)n", 'direcci&oacute;n')
  $Text = $Text.Replace("fricci$($Bad)n", 'fricci&oacute;n')
  $Text = $Text.Replace("Aceleraci$($Bad)n", 'Aceleraci&oacute;n')
  $Text = $Text.Replace("instant$($Bad)neo", 'instant&aacute;neo')
  $Text = $Text.Replace("cuadr$($Bad)tico", 'cuadr&aacute;tico')
  $Text = $Text.Replace("tama$($Bad)o", 'tama&ntilde;o')
  $Text = $Text.Replace("pr$($Bad)ctica", 'pr&aacute;ctica')
  $Text = $Text.Replace("$($Bad)ptico", '&oacute;ptico')
  $Text = $Text.Replace("din$($Bad)micamente", 'din&aacute;micamente')
  $Text = $Text.Replace("Per$($Bad)odo", 'Per&iacute;odo')
  $Text = $Text.Replace("per$($Bad)odo", 'per&iacute;odo')
  $Text = $Text.Replace("Mini-gr$($Bad)fica", 'Mini-gr&aacute;fica')
  $Text = $Text.Replace("mini-gr$($Bad)fica", 'mini-gr&aacute;fica')
  $Text = $Text.Replace("Gr$($Bad)fica", 'Gr&aacute;fica')
  $Text = $Text.Replace("gr$($Bad)fica", 'gr&aacute;fica')
  $Text = $Text.Replace("$($Bad)ltimos", '&uacute;ltimos')
  $Text = $Text.Replace("cin$($Bad)tica", 'cin&eacute;tica')
  $Text = $Text.Replace("m$($Bad)s", 'm&aacute;s')
  $Text = $Text.Replace("est$($Bad)", 'est&aacute;')

  $Text = [regex]::Replace($Text, '<button([^>]*id=["'']runTests["''][^>]*)>', '<button$1 hidden>')
  $Text = [regex]::Replace($Text, '<div([^>]*id=["'']tests["''][^>]*)>', '<div$1 hidden>')
  $Text = [regex]::Replace($Text, '<section([^>]*id=["'']tests["''][^>]*)>', '<section$1 hidden>')
  $Text = [regex]::Replace($Text, '<details([^>]*)>\s*<summary>Resultados de pruebas.*?</summary>', '<details$1 hidden><summary>Resultados de pruebas</summary>', 'Singleline')
  $Text = [regex]::Replace($Text, '<h2([^>]*)>Pruebas rápidas</h2>', '<h2$1 hidden>Pruebas rápidas</h2>')

  [System.IO.File]::WriteAllText($File.FullName, $Text, $Utf8)
}

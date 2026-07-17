$RootPath = Split-Path -Parent $PSScriptRoot
$SimRoot = Join-Path $RootPath 'simuladores'
$Utf8 = New-Object System.Text.UTF8Encoding($false)

Get-ChildItem -Recurse -File -Filter index.html -LiteralPath $SimRoot | ForEach-Object {
  $Text = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)

  $Text = $Text.Replace("grd.addColorStop(0,'#0b1020'); grd.addColorStop(1,'#0c152b');", "const canvasBg = document.body.classList.contains('dark') ? '#111827' : '#ffffff'; grd.addColorStop(0, canvasBg); grd.addColorStop(1, canvasBg);")
  $Text = $Text.Replace("grd.addColorStop(0, '#0b1020');`r`n      grd.addColorStop(1, '#0c152b');", "const canvasBg = document.body.classList.contains('dark') ? '#111827' : '#ffffff';`r`n      grd.addColorStop(0, canvasBg);`r`n      grd.addColorStop(1, canvasBg);")
  $Text = $Text.Replace("grd.addColorStop(0,'#0b1020');`r`n      grd.addColorStop(1,'#0c152b');", "const canvasBg = document.body.classList.contains('dark') ? '#111827' : '#ffffff';`r`n      grd.addColorStop(0, canvasBg);`r`n      grd.addColorStop(1, canvasBg);")
  $Text = $Text.Replace("bg.addColorStop(0,'#0b1020');`r`n      bg.addColorStop(1,'#0c152b');", "const canvasBg = document.body.classList.contains('dark') ? '#111827' : '#ffffff';`r`n      bg.addColorStop(0, canvasBg);`r`n      bg.addColorStop(1, canvasBg);")
  $Text = $Text.Replace("const grd=ctx.createLinearGradient(0,0,0,H); grd.addColorStop(0,'#0b1020'); grd.addColorStop(1,'#0c152b'); ctx.fillStyle=grd; ctx.fillRect(0,0,W,H);", "const grd=ctx.createLinearGradient(0,0,0,H); const canvasBg = document.body.classList.contains('dark') ? '#111827' : '#ffffff'; grd.addColorStop(0, canvasBg); grd.addColorStop(1, canvasBg); ctx.fillStyle=grd; ctx.fillRect(0,0,W,H);")
  $Text = $Text.Replace("function clear(){ const grd=ctx.createLinearGradient(0,0,0,H); grd.addColorStop(0,'#0b1020'); grd.addColorStop(1,'#0c152b'); ctx.fillStyle=grd; ctx.fillRect(0,0,W,H); }", "function clear(){ const grd=ctx.createLinearGradient(0,0,0,H); const canvasBg = document.body.classList.contains('dark') ? '#111827' : '#ffffff'; grd.addColorStop(0, canvasBg); grd.addColorStop(1, canvasBg); ctx.fillStyle=grd; ctx.fillRect(0,0,W,H); }")
  $Text = $Text.Replace("const grd=ctx.createLinearGradient(0,0,0,h); grd.addColorStop(0,'#0b1020'); grd.addColorStop(1,'#0c152b'); ctx.fillStyle=grd; ctx.fillRect(0,0,w,h);", "const grd=ctx.createLinearGradient(0,0,0,h); const canvasBg = document.body.classList.contains('dark') ? '#111827' : '#ffffff'; grd.addColorStop(0, canvasBg); grd.addColorStop(1, canvasBg); ctx.fillStyle=grd; ctx.fillRect(0,0,w,h);")

  $Text = $Text.Replace("ctx.fillStyle='#0e1630';", "ctx.fillStyle=document.body.classList.contains('dark') ? '#1e293b' : '#ffffff';")
  $Text = $Text.Replace("ctx.fillStyle = '#0b1020';", "ctx.fillStyle = document.body.classList.contains('dark') ? '#f1f5f9' : '#111827';")
  $Text = $Text.Replace("ctx.strokeStyle = '#0b1020';", "ctx.strokeStyle = document.body.classList.contains('dark') ? '#334155' : '#111827';")
  $Text = $Text.Replace("ctx.strokeStyle = '#0c152b';", "ctx.strokeStyle = document.body.classList.contains('dark') ? '#334155' : '#dbe3ee';")
  $Text = $Text.Replace("ctx.strokeStyle='#0c152b';", "ctx.strokeStyle=document.body.classList.contains('dark') ? '#334155' : '#dbe3ee';")

  [System.IO.File]::WriteAllText($_.FullName, $Text, $Utf8)
}

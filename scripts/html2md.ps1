param([string]$Root = "sources")
function Convert-HtmlToMd($html) {
  $t = $html
  $t = [regex]::Replace($t, '(?is)<script.*?</script>', '')
  $t = [regex]::Replace($t, '(?is)<style.*?</style>', '')
  $t = [regex]::Replace($t, '(?is)<head.*?</head>', '')
  $t = [regex]::Replace($t, '(?is)<nav.*?</nav>', '')
  $t = [regex]::Replace($t, '(?is)<footer.*?</footer>', '')
  $t = [regex]::Replace($t, '(?i)<h1[^>]*>', "`n# ")
  $t = [regex]::Replace($t, '(?i)<h2[^>]*>', "`n## ")
  $t = [regex]::Replace($t, '(?i)<h3[^>]*>', "`n### ")
  $t = [regex]::Replace($t, '(?i)<li[^>]*>', "`n- ")
  $t = [regex]::Replace($t, '(?i)</p>', "`n`n")
  $t = [regex]::Replace($t, '(?i)<br[^>]*>', "`n")
  $t = [regex]::Replace($t, '(?s)<[^>]+>', ' ')
  $t = [System.Net.WebUtility]::HtmlDecode($t)
  $t = [regex]::Replace($t, '[ \t]+', ' ')
  $t = [regex]::Replace($t, '(\r?\n){3,}', "`n`n")
  return $t.Trim()
}
$files = Get-ChildItem $Root -Recurse -Filter *.html
foreach ($f in $files) {
  $md = Convert-HtmlToMd (Get-Content $f.FullName -Raw)
  $out = [IO.Path]::ChangeExtension($f.FullName, '.md')
  Set-Content -Path $out -Value $md -Encoding UTF8
  Remove-Item $f.FullName
}
"converted $($files.Count) files"

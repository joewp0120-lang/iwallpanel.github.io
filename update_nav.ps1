$root = "d:\iwallpanel\WH iwallpanel"
$css = @"
  /* Dropdown Styles */
  .dropdown{position:relative;display:inline-block}
  .dropdown-content{display:none;position:absolute;background-color:#0b1b2b;min-width:220px;box-shadow:0 8px 16px rgba(0,0,0,0.2);z-index:1000;border:1px solid rgba(255,255,255,0.1);border-radius:4px;top:100%;left:0}
  .dropdown-content a{color:#cfe0ff;padding:12px 16px;text-decoration:none;display:block;margin:0;text-align:left;border-bottom:1px solid rgba(255,255,255,0.05)}
  .dropdown-content a:last-child{border-bottom:none}
  .dropdown-content a:hover{background-color:rgba(255,255,255,0.1);color:#fff;text-decoration:none}
  .dropdown:hover .dropdown-content{display:block}
  .dropdown-btn{color:#cfe0ff;margin:0 10px;text-decoration:none;font-size:14px;cursor:pointer;background:none;border:none;padding:0;font-family:inherit;display:inline-block}
  .dropdown-btn:hover{color:#fff;text-decoration:underline}
"@

$oldHtml = '<a href="/pages/products/index.html">Products</a>'
$newHtml = @"
<div class="dropdown">
    <a href="/pages/products/index.html" class="dropdown-btn">Products &#9662;</a>
    <div class="dropdown-content">
    <a href="/pages/products/pet-acoustic-panels.html">PET Acoustic Panels</a>
    <a href="/pages/products/pvc-wall-panels.html">PVC Wall Panels</a>
    <a href="/pages/products/grille-slat-panels.html">Grille Slat Panels</a>
    <a href="/pages/products/3d-decorative-panels.html">3D Decorative Panels</a>
    <a href="/pages/products/carbon-crystal-panels.html">Carbon Crystal Panels</a>
    <a href="/pages/products/background-wall-panels.html">Background Wall Panels</a>
    </div>
    </div>
"@

Get-ChildItem -Path $root -Recurse -Filter "*.html" | ForEach-Object {
    $content = Get-Content $_.FullName -Raw -Encoding utf8
    if ($content.Contains($oldHtml) -and -not $content.Contains("dropdown-content")) {
        Write-Host "Updating $($_.FullName)"
        $content = $content.Replace($oldHtml, $newHtml)
        
        if (-not $content.Contains("Dropdown Styles")) {
             $content = $content -replace "</style>", "$css`n</style>"
        }
        
        $content | Set-Content $_.FullName -Encoding utf8
    }
}

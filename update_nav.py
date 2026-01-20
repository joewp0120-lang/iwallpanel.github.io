import os

root_dir = r"d:\iwallpanel\WH iwallpanel"

# CSS to insert
css_code = """
  /* Dropdown Styles */
  .dropdown{position:relative;display:inline-block}
  .dropdown-content{display:none;position:absolute;background-color:#0b1b2b;min-width:220px;box-shadow:0 8px 16px rgba(0,0,0,0.2);z-index:1000;border:1px solid rgba(255,255,255,0.1);border-radius:4px;top:100%;left:0}
  .dropdown-content a{color:#cfe0ff;padding:12px 16px;text-decoration:none;display:block;margin:0;text-align:left;border-bottom:1px solid rgba(255,255,255,0.05)}
  .dropdown-content a:last-child{border-bottom:none}
  .dropdown-content a:hover{background-color:rgba(255,255,255,0.1);color:#fff;text-decoration:none}
  .dropdown:hover .dropdown-content{display:block}
  .dropdown-btn{color:#cfe0ff;margin:0 10px;text-decoration:none;font-size:14px;cursor:pointer;background:none;border:none;padding:0;font-family:inherit;display:inline-block}
  .dropdown-btn:hover{color:#fff;text-decoration:underline}
"""

# HTML to replace
old_html = '<a href="/pages/products/index.html">Products</a>'
new_html = """<div class="dropdown">
    <a href="/pages/products/index.html" class="dropdown-btn">Products &#9662;</a>
    <div class="dropdown-content">
    <a href="/pages/products/pet-acoustic-panels.html">PET Acoustic Panels</a>
    <a href="/pages/products/pvc-wall-panels.html">PVC Wall Panels</a>
    <a href="/pages/products/grille-slat-panels.html">Grille Slat Panels</a>
    <a href="/pages/products/3d-decorative-panels.html">3D Decorative Panels</a>
    <a href="/pages/products/carbon-crystal-panels.html">Carbon Crystal Panels</a>
    <a href="/pages/products/background-wall-panels.html">Background Wall Panels</a>
    </div>
    </div>"""

count = 0

for dirpath, dirnames, filenames in os.walk(root_dir):
    for filename in filenames:
        if filename.endswith(".html"):
            file_path = os.path.join(dirpath, filename)
            
            # Skip if it is the index.html we just edited (check by reading)
            # Actually, the script logic should be robust enough to handle re-runs or already patched files.
            
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            if old_html in content and "dropdown-content" not in content:
                print(f"Updating {file_path}")
                
                # Update HTML
                new_content = content.replace(old_html, new_html)
                
                # Update CSS
                if "/* Dropdown Styles */" not in new_content:
                    # Find last occurrence of </style>
                    style_end = new_content.rfind("</style>")
                    if style_end != -1:
                        new_content = new_content[:style_end] + css_code + new_content[style_end:]
                    else:
                        print(f"Warning: No </style> tag found in {file_path}")
                
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                count += 1

print(f"Updated {count} files.")

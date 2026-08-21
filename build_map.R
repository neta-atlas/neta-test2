library(leaflet)
library(leaflet.providers)
library(sf)
library(htmltools)
library(viridisLite)
library(htmlwidgets)

sf = st_read('data/sample_simp.gpkg') |>
  st_transform(crs = 4326)

pal = colorNumeric(
  palette = rocket(256, direction = -1),
  domain = sf$vulnerability_normalised
)

map = leaflet(sf) |>
  addProviderTiles(providers$CartoDB.Positron) |>
  addPolygons(
    fillColor = ~pal(sf$vulnerability_normalised),
    fillOpacity = 0.7,
    color = '#333333',
    weight = 1,
    label = ~paste0('Region: ', sf$SA2_NAME21, " | Vulnerability: ", sf$vulnerability_normalised),
    highlightOptions = highlightOptions(
      weight = 3,
      color = '#000000',
      fillOpacity = 0.8,
      bringToFront = T
    )
  ) |>
  addLegend(
    pal = pal,
    values = ~sf$vulnerability_normalised[!is.na(sf$vulnerability_normalised)],
    title='Vulnerability index',
    position = 'bottomright'
  )

saveWidget(map, file = 'docs/vulnerability/map.html', selfcontained = T)

writeLines('<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: Arial, sans-serif; background-color: #ffffff; }
  .header { display: flex; border-bottom: 1px solid #444; }
  .header-left {
    background-color: #1a1a1a; color: white;
    width: 220px; min-width: 220px;
    padding: 20px 30px; font-weight: bold; font-size: 1.3em;
    letter-spacing: 1px; border-right: 1px solid #444;
  }
  .header-right {
    background-color: #1a1a1a; color: white;
    flex: 1; padding: 20px 30px;
    display: flex; justify-content: flex-end; align-items: center;
    font-size: 0.95em;
  }
  .main-container { display: flex; min-height: calc(100vh - 65px); }
  .sidebar {
    width: 220px; min-width: 220px;
    border-right: 1px solid #ddd;
    padding: 60px 0;
    display: flex; flex-direction: column; gap: 130px;
  }
  .sidebar-line { height: 3px; background-color: #7fb5b0; width: 55%; }
  .content { flex: 1; padding: 40px 60px; }
  .entry-title { font-size: 1.2em; font-weight: normal; margin-bottom: 14px; color: #1a1a1a; }
  .metadata { font-style: italic; color: #333; margin-bottom: 8px; font-size: 0.9em; }
  .category-tag { color: #cc5500; }
  .description { margin-top: 24px; margin-bottom: 28px; font-size: 0.85em; line-height: 1.6; color: #333; max-width: 480px; }
  .map-title { font-weight: bold; font-size: 1em; margin-bottom: 14px; color: #1a1a1a; }
  .map-container { border: 1px solid #ccc; width: 80%; }
  .map-container iframe { width: 100%; height: 500px; display: block; border: none; }
  .back-link { margin-top: 24px; display: block; font-size: 0.85em; color: #333; }
  .footer-tag {
    position: fixed; bottom: 0; right: 0;
    background-color: #1a1a1a; color: white;
    padding: 12px 20px; font-size: 0.8em;
  }
</style>
</head>
<body>
<div class="header">
<div class="header-left">NETA</div>
<div class="header-right">About</div>
</div>
<div class="main-container">
<div class="sidebar">
<div class="sidebar-line"></div>
<div class="sidebar-line"></div>
<div class="sidebar-line"></div>
<div class="sidebar-line"></div>
</div>
<div class="content">
<h2 class="entry-title">NETA test page</h2>
<p class="metadata">Location: NSW / Hay &nbsp;&nbsp; Date: 2026/08/01</p>
<p class="metadata">Category: <span class="category-tag">Category One</span> &nbsp;&nbsp; Themes: Theme1, Theme2</p>
<p class="description">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc egestas lectus risus, id faucibus est interdum at. Donec id ultrices velit, et vehicula risus. Nullam ut laoreet magna. Morbi sapien lacus, laoreet in maximus ullamcorper, hendrerit ac erat. Sed eu luctus metus. Phasellus dapibus, ligula eu egestas posuere, diam augue convallis purus, quis consequat augue mauris quis purus. Praesent id ex ac dui suscipit suscipit sit amet quis ex. Etiam orci ex, tempor non diam sit amet, suscipit ultricies tortor. Aenean at odio eleifend, efficitur ligula non, finibus libero. Maecenas risus purus, egestas vel libero vel, dignissim posuere purus. Nunc laoreet vehicula dui vel interdum. Cras efficitur tincidunt maximus. Cras nec turpis nisl. Duis eget sem enim. Morbi non fringilla mi, ac volutpat lectus.</p>
<h3 class="map-title">Map Title</h3>
<div class="map-container">
<iframe src="map.html" title="Test map"></iframe>
</div>
<p class="description">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc egestas lectus risus, id faucibus est interdum at. Donec id ultrices velit, et vehicula risus. Nullam ut laoreet magna. Morbi sapien lacus, laoreet in maximus ullamcorper, hendrerit ac erat. Sed eu luctus metus. Phasellus dapibus, ligula eu egestas posuere, diam augue convallis purus, quis consequat augue mauris quis purus. Praesent id ex ac dui suscipit suscipit sit amet quis ex. Etiam orci ex, tempor non diam sit amet, suscipit ultricies tortor. Aenean at odio eleifend, efficitur ligula non, finibus libero. Maecenas risus purus, egestas vel libero vel, dignissim posuere purus. Nunc laoreet vehicula dui vel interdum. Cras efficitur tincidunt maximus. Cras nec turpis nisl. Duis eget sem enim. Morbi non fringilla mi, ac volutpat lectus.</p>
<a class="back-link" href="../">Back to landing page</a>
</div>
</div>
<div class="footer-tag">Dark view / Light View</div>
</body>
</html>', 
'docs/vulnerability/index.html'
)

writeLines('<!DOCTYPE html>
<html>
<head>
<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #CC5500;
  }
</style>
</head>
<body>
<h1>National Energy Transition Atlas</h1>
<ul>
  <li><a href="vulnerability/">Regional Vulnerability</a></li>
</ul>
</body>
</html>', "docs/index.html")




# OLD
# writeLines('
# <!DOCTYPE html>
# <html>
# <head>
# <style>
#   body {
#   font-family: Arial, sans-serif;
#   }
# </style>
# </head>
# <body>
# <h1>NETA test page</h1>
# <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc egestas lectus risus, id faucibus est interdum at. Donec id ultrices velit, et vehicula risus. Nullam ut laoreet magna. Morbi sapien lacus, laoreet in maximus ullamcorper, hendrerit ac erat. Sed eu luctus metus. Phasellus dapibus, ligula eu egestas posuere, diam augue convallis purus, quis consequat augue mauris quis purus. Praesent id ex ac dui suscipit suscipit sit amet quis ex. Etiam orci ex, tempor non diam sit amet, suscipit ultricies tortor. Aenean at odio eleifend, efficitur ligula non, finibus libero. Maecenas risus purus, egestas vel libero vel, dignissim posuere purus. Nunc laoreet vehicula dui vel interdum. Cras efficitur tincidunt maximus. Cras nec turpis nisl. Duis eget sem enim. Morbi non fringilla mi, ac volutpat lectus.</p>
# <div style="text-align: center;">
# <iframe src="map.html" title="Test map" width="50%" height="600"></iframe>
# </div>
# <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc egestas lectus risus, id faucibus est interdum at. Donec id ultrices velit, et vehicula risus. Nullam ut laoreet magna. Morbi sapien lacus, laoreet in maximus ullamcorper, hendrerit ac erat. Sed eu luctus metus. Phasellus dapibus, ligula eu egestas posuere, diam augue convallis purus, quis consequat augue mauris quis purus. Praesent id ex ac dui suscipit suscipit sit amet quis ex. Etiam orci ex, tempor non diam sit amet, suscipit ultricies tortor. Aenean at odio eleifend, efficitur ligula non, finibus libero. Maecenas risus purus, egestas vel libero vel, dignissim posuere purus. Nunc laoreet vehicula dui vel interdum. Cras efficitur tincidunt maximus. Cras nec turpis nisl. Duis eget sem enim. Morbi non fringilla mi, ac volutpat lectus.</p>
# <a href="../">Back to landing page</a>
# </body>
# </html>', 
#            'docs/vulnerability/index.html'
# )




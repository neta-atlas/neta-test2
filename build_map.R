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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Jost:wght@300;400&family=Archivo+Black&display=swap" rel="stylesheet">
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { font-family: Montserrat, Arial, sans-serif; background-color: #ffffff; height: 100vh; overflow: hidden; }
  .header { display: flex; border-bottom: 1px solid #ddd; height: 65px; background-color: #ffffff; }
  .header-left {
    font-family: "Archivo Black", Arial, sans-serif;
    color: #1a1a1a;
    width: 220px; min-width: 220px;
    padding: 20px 20px; font-weight: 400; font-size: 2.0em;
    letter-spacing: 2px; border-right: 1px solid #ddd;
  }
  .header-right {
    color: #1a1a1a;
    flex: 1; padding: 20px 30px;
    display: flex; justify-content: flex-end; align-items: center;
    font-size: 0.95em;
  }
  .header-right a { font-family: Montserrat, Arial, sans-serif; color: #1a1a1a; text-decoration: none; }
  .header-right a:hover { text-decoration: underline; }
  .main-container { display: flex; height: calc(100vh - 65px); overflow: hidden; }
  .sidebar {
    width: 220px; min-width: 220px;
    border-right: 1px solid #ddd;
    padding: 20px;
    display: flex; flex-direction: column;
    height: 100%; overflow-y: auto;
  }
  .sidebar-links { display: flex; flex-direction: column; gap: 10px; }
  .sidebar-links a { font-family: Montserrat, Arial, sans-serif; font-size: 0.85em; color: #333; text-decoration: none; }
  .sidebar-links a:hover { text-decoration: underline; }
  .back-link { margin-top: 2em; font-family: Montserrat, Arial, sans-serif; font-size: 0.85em; color: #333; text-decoration: none; }
  .back-link:hover { text-decoration: underline; }
  .content { flex: 1; padding: 20px 60px; overflow-y: auto; height: 100%; }
  .entry-title { font-family: Montserrat, Arial, sans-serif; font-size: 1.2em; font-weight: 600; margin-top: 0; margin-bottom: 14px; color: #1a1a1a; }
  .metadata { font-family: Montserrat, Arial, sans-serif; font-style: italic; color: #333; margin-bottom: 8px; font-size: 0.9em; }
  .description { font-family: "Jost", Arial, sans-serif; margin-top: 24px; margin-bottom: 28px; font-size: 0.95em; line-height: 1.6; color: #333; width: 80%; }
  .map-title { font-family: Montserrat, Arial, sans-serif; font-weight: 600; font-size: 1em; margin-bottom: 14px; color: #1a1a1a; }
  .map-container { border: 1px solid #ccc; width: 80%; }
  .map-container iframe { width: 100%; height: 500px; display: block; border: none; }
</style>
</head>
<body>
<div class="header">
  <div class="header-left">NETA</div>
  <div class="header-right"><a href="../">About</a></div>
</div>
<div class="main-container">
  <div class="sidebar">
    <div class="sidebar-links">
      <a href="../">Placeholder link</a>
      <a href="../">Placeholder link</a>
      <a href="../">Placeholder link</a>
      <a href="../">Placeholder link</a>
      <a href="../">Placeholder link</a>
    </div>
    <a class="back-link" href="../">Back to landing page</a>
  </div>
  <div class="content">
    <h2 class="entry-title">Assessing regional vulnerability to the low-carbon energy transition in Australia</h2>
    <p class="metadata">Category: Category One &nbsp;&nbsp; Themes: Theme1, Theme2</p>
    <p class="description">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc egestas lectus risus, id faucibus est interdum at. Donec id ultrices velit, et vehicula risus. Nullam ut laoreet magna. Morbi sapien lacus, laoreet in maximus ullamcorper, hendrerit ac erat. Sed eu luctus metus. Phasellus dapibus, ligula eu egestas posuere, diam augue convallis purus, quis consequat augue mauris quis purus. Praesent id ex ac dui suscipit suscipit sit amet quis ex. Etiam orci ex, tempor non diam sit amet, suscipit ultricies tortor. Aenean at odio eleifend, efficitur ligula non, finibus libero. Maecenas risus purus, egestas vel libero vel, dignissim posuere purus. Nunc laoreet vehicula dui vel interdum. Cras efficitur tincidunt maximus. Cras nec turpis nisl. Duis eget sem enim. Morbi non fringilla mi, ac volutpat lectus.</p>
    <h3 class="map-title">Regional Vulnerability Index</h3>
    <div class="map-container">
      <iframe src="map.html" title="Test map"></iframe>
    </div>
    <p class="description">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc egestas lectus risus, id faucibus est interdum at. Donec id ultrices velit, et vehicula risus. Nullam ut laoreet magna. Morbi sapien lacus, laoreet in maximus ullamcorper, hendrerit ac erat. Sed eu luctus metus. Phasellus dapibus, ligula eu egestas posuere, diam augue convallis purus, quis consequat augue mauris quis purus. Praesent id ex ac dui suscipit suscipit sit amet quis ex. Etiam orci ex, tempor non diam sit amet, suscipit ultricies tortor. Aenean at odio eleifend, efficitur ligula non, finibus libero. Maecenas risus purus, egestas vel libero vel, dignissim posuere purus. Nunc laoreet vehicula dui vel interdum. Cras efficitur tincidunt maximus. Cras nec turpis nisl. Duis eget sem enim. Morbi non fringilla mi, ac volutpat lectus.</p>
    <p class="description">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc egestas lectus risus, id faucibus est interdum at. Donec id ultrices velit, et vehicula risus. Nullam ut laoreet magna. Morbi sapien lacus, laoreet in maximus ullamcorper, hendrerit ac erat. Sed eu luctus metus. Phasellus dapibus, ligula eu egestas posuere, diam augue convallis purus, quis consequat augue mauris quis purus. Praesent id ex ac dui suscipit suscipit sit amet quis ex. Etiam orci ex, tempor non diam sit amet, suscipit ultricies tortor. Aenean at odio eleifend, efficitur ligula non, finibus libero. Maecenas risus purus, egestas vel libero vel, dignissim posuere purus. Nunc laoreet vehicula dui vel interdum. Cras efficitur tincidunt maximus. Cras nec turpis nisl. Duis eget sem enim. Morbi non fringilla mi, ac volutpat lectus.</p>
  </div>
</div>
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




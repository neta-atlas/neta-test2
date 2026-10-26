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
  addProviderTiles(providers$Jawg.Sunny) |>
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



# Descriptions
# The <style> block:
# CSS rules have this shape: selecter { property: value; property: value; }
# e.g selecters:
# * = every element
# body, h2 = every element of that tag type
# .sidebar = every element with class = 'sidebar
# .sidebar-links a - every <a> inside an element with class = 'sidebar-links'
# .back-link:hover - the :hover is pseudo class

# <html>
# Root element, closed at bottom

# <head>
# Set up section

# <meta charset="UTF-8">
# Character encoding

#   <link rel="preconnect" href="https://fonts.googleapis.com">
#   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
#   <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Jost:wght@300;400&family=Archivo+Black&display=swap" rel="stylesheet">
# Opens connections to Google's font servers, and loads font


# <style>
# Opens CSS block

# * { margin: 0; padding: 0; box-sizing: border-box; }
# * matches every element, margin:0; padding:0 strips browser built in spaceing 
# box-sizing: border-box makes the declared width the element's total rendered width with padding fitted inside

# body { font-family: Montserrat, Arial, sans-serif; background-color: #ffffff; height: 100vh; overflow: hidden; }
# Sets Montserrat as the inherited default with Arial as fallback, white background, height locked to exactly one screen (100vh), and overflow: hidden to stop the page itself scrolling so the panels can scroll separately.

# .header { display: flex; border-bottom: 1px solid #ddd; height: 65px; background-color: #ffffff; }
# display: flex lays its two children out in a row rather than stacked, border-bottom: 1px solid #ddd draws a 1px light-grey line underneath, height: 65px fixes the bar height (the value subtracted in .main-container), and background-color: #ffffff makes it white.

# .header-left {
#         font-family: "Archivo Black", Arial, sans-serif;
#         color: #1a1a1a;
#           width: 220px; min-width: 220px;
#         padding: 20px 20px; font-weight: 400; font-size: 2.0em;
#         letter-spacing: 2px; border-right: 1px solid #ddd;
# }
# font-family sets Archivo Black (quoted because the name contains a space) with Arial and generic sans-serif as fallbacks, color: #1a1a1a makes the text near-black, width: 220px sets the block width and min-width: 220px stops flex shrinking it below that, padding: 20px 20px gives 20px top/bottom and 20px left/right, font-weight: 400 is normal weight, font-size: 2.0em is twice the inherited size, letter-spacing: 2px adds 2px between characters, and border-right: 1px solid #ddd draws the vertical divider on its right edge.

# .header-right {
#         color: #1a1a1a;
#           flex: 1; padding: 20px 30px;
#         display: flex; justify-content: flex-end; align-items: center;
#         font-size: 0.95em;
# }
# color: #1a1a1a sets near-black text, flex: 1 makes it absorb all width remaining after the 220px block, padding: 20px 30px gives 20px top/bottom and 30px left/right, display: flex makes it a flex container in its own right, justify-content: flex-end pushes its child to the right edge, align-items: center centres that child vertically within the 65px, and font-size: 0.95em sets it slightly below inherited size.

# .header-right a { font-family: Montserrat, Arial, sans-serif; color: #1a1a1a; text-decoration: none; }
# Targets any <a> inside .header-right, setting Montserrat with fallbacks, overriding the browser's default blue link colour to near-black, and text-decoration: none removing the default underline.
# <a> is a hyperlink

# .header-right a:hover { text-decoration: underline; }
# :hover applies only while the cursor is over the link, and text-decoration: underline restores the underline so it remains identifiable as clickable.

# .main-container { display: flex; height: calc(100vh - 65px); overflow: hidden; }
# display: flex lays the sidebar and content out in a row, height: calc(100vh - 65px) uses CSS arithmetic to size it to full viewport height minus the header's 65px, and overflow: hidden clips anything beyond that so scrolling happens inside the child panels instead.

# .sidebar {
#     width: 220px; min-width: 220px;
#     border-right: 1px solid #ddd;
#     padding: 20px;
#     display: flex; flex-direction: column;
#     height: 100%; overflow-y: auto;
# }
# width: 220px and min-width: 220px match .header-left so the divider runs continuously down the page, border-right: 1px solid #ddd draws that divider, padding: 20px applies 20px on all four sides, display: flex with flex-direction: column stacks its children vertically, height: 100% fills the parent's height, and overflow-y: auto adds a vertical scrollbar only when the links exceed that height.

# .sidebar-links { display: flex; flex-direction: column; gap: 10px; }
# display: flex with flex-direction: column stacks the five links vertically, and gap: 10px puts 10px between each without adding space at the outer edges or affecting the back link outside this group.

# .sidebar-links a { font-family: Montserrat, Arial, sans-serif; font-size: 0.85em; color: #333; text-decoration: none; }
# Targets the <a> elements inside .sidebar-links, setting Montserrat with fallbacks, font-size: 0.85em at 85% of inherited size, color: #333 dark grey, and text-decoration: none removing the default underline.

# .sidebar-links a:hover { text-decoration: underline; }
# Restores the underline while the cursor is over one of those links.

# .back-link { margin-top: 2em; font-family: Montserrat, Arial, sans-serif; font-size: 0.85em; color: #333; text-decoration: none; }
# margin-top: 2em pushes it down by twice its own font size to create the two-line gap below the last placeholder link, then Montserrat with fallbacks, font-size: 0.85em matching the links above, color: #333 dark grey, and text-decoration: none removing the underline.

# .back-link:hover { text-decoration: underline; }
# Restores the underline while the cursor is over it.

# .content { flex: 1; padding: 20px 60px; overflow-y: auto; height: 100%; }
# flex: 1 absorbs all width remaining after the 220px sidebar, padding: 20px 60px gives 20px top/bottom (matching the sidebar's top padding so the title aligns with the first link) and 60px left/right, overflow-y: auto adds its own vertical scrollbar when needed, and height: 100% fills the parent's height.

# .entry-title { font-family: Montserrat, Arial, sans-serif; font-size: 1.2em; font-weight: 600; margin-top: 0; margin-bottom: 14px; color: #1a1a1a; }
# Montserrat with fallbacks, font-size: 1.2em at 1.2× inherited size, font-weight: 600 semibold (one of the three weights loaded from Google), margin-top: 0 keeping it flush with the top of the panel, margin-bottom: 14px spacing it from the metadata line, and color: #1a1a1a near-black.

# .metadata { font-family: Montserrat, Arial, sans-serif; font-style: italic; color: #333; margin-bottom: 8px; font-size: 0.9em; }
# Montserrat with fallbacks, font-style: italic slanting the text, color: #333 dark grey, margin-bottom: 8px spacing below it, and font-size: 0.9em at 90% of inherited size.

# .description { font-family: "Jost", Arial, sans-serif; margin-top: 24px; margin-bottom: 28px; font-size: 0.95em; line-height: 1.6; color: #333; width: 80%; }
# The only rule using Jost (with Arial and generic sans-serif as fallbacks), margin-top: 24px and margin-bottom: 28px spacing each paragraph above and below, font-size: 0.95em at 95% of inherited size, line-height: 1.6 setting each line's height to 1.6× the font size, color: #333 dark grey, and width: 80% matching the map so their edges align.

# .map-title { font-family: Montserrat, Arial, sans-serif; font-weight: 600; font-size: 1em; margin-bottom: 14px; color: #1a1a1a; }
# Montserrat with fallbacks, font-weight: 600 semibold, font-size: 1em equal to inherited size so weight alone distinguishes it, margin-bottom: 14px spacing it from the map below, and color: #1a1a1a near-black.

# .map-container { border: 1px solid #ccc; width: 80%; }
# border: 1px solid #ccc draws a 1px grey border on all four sides, and width: 80% sets it to 80% of the content panel's available width, matching .description.

# .map-container iframe { width: 100%; height: 500px; display: block; border: none; }
# Targets the <iframe> inside .map-container, width: 100% filling that container exactly, height: 500px fixing its height, display: block removing the few pixels of stray space browsers leave beneath inline elements, and border: none removing the iframe's own default border so only the container's shows.


# </style>
# Closes CSS block

# </head>
# Closes head

# <body>
# Opens body section (everything visible on screen)

# <div class="header">
# Opens a generic container whose class="header" connects it to the .header flex rule above.

# <div class="header-left">NETA</div>
# The NETA text inside the fixed 220px block that aligns with the sidebar below it.

# <div class="header-right"><a href="../">About</a></div>
# The right-hand block containing the About link, where href="../" means up one directory from docs/vulnerability/ to docs/, whose index.html is the landing page.

# </div>
# Closes the header

# <div class="main-container">
# Opens the flex row holding the sidebar and content panels.

# <div class="sidebar">
# Opens the fixed 220px left column with its own scrollbar.

# <div class="sidebar-links">
# Opens the flex column that groups the five links so gap: 10px applies to them alone.

# <a href="../">Placeholder link</a>
# <a href="../">Placeholder link</a>
# <a href="../">Placeholder link</a>
# <a href="../">Placeholder link</a>
# <a href="../">Placeholder link</a>
# One of five identical links, each pointing up one directory to the landing page.

# </div>
# Closes the link group

# <a class="back-link" href="../">Back to landing page</a>
# Sits outside the group as a direct child of the sidebar, so its own margin-top: 2em applies rather than the group's gap.

# </div>
# Closes the sidebar

# <div class="content">
# Opens the main panel that absorbs the remaining width and scrolls independently.

# <h2 class="entry-title">Assessing regional vulnerability to the low-carbon energy transition in Australia</h2>
# An <h2> heading, where the number sets document hierarchy for screen readers rather than visual size, which comes from .entry-title.

# <p class="metadata">Category: Category One &nbsp;&nbsp; Themes: Theme1, Theme2</p>
# A paragraph where &nbsp; is a non-breaking space, used twice because HTML collapses consecutive normal spaces into a single space.

# <p class="description">Lorem ipsum...</p>
# The first body paragraph, above the map.

# <h3 class="map-title">Regional Vulnerability Index</h3>
# An <h3>, one hierarchy level below the <h2>, marking the map as a subsection.

# <div class="map-container">
# Opens the bordered box constraining the map to 80% width.

# <iframe src="map.html" title="Test map"></iframe>
# Embeds a complete separate HTML document — map.html, the file saveWidget() wrote to the same folder — with title supplying the description screen readers announce.

# </div>
# Closes the map box

# <p class="description">Lorem ipsum...</p>
# <p class="description">Lorem ipsum...</p>
# The second and third body paragraphs, below the map.

# </div>
# Closes the content panel

# </div>
# Closes the main container

# </body>
# </html>'
# Closes the body and the document














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




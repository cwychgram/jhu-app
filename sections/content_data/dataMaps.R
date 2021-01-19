output$lyme_count_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 1, 10, 25, 100, 678)
  pal <- colorBin("YlOrBr", domain = counties$CASES, bins = bins)
  
  counties %>%
    filter(YEAR == 2018) %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         round(RATE, digits = 2), " cases per 100,000 people",
                         "<br/>", 
                         CASES, " cases total") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(CASES),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = .9,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = FALSE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~CASES,
              opacity = .9,
              title = "Number of Cases",
              position = "bottomright")
  
})

output$lyme_rate_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 1, 10, 25, 100, 1600)
  pal <- colorBin("YlOrBr", domain = counties$RATE, bins = bins)
  #pal <- colorBin(c("#feeacc", "#fdc38d", "#f67a51", "#ce2317", "#7f0000"), domain = counties$RATE, bins = bins)
  counties %>%
    filter(YEAR == 2018) %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         round(RATE, digits = 2), " cases per 100,000 people",
                         "<br/>", 
                         CASES, " cases total") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(RATE),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = FALSE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~RATE,
              opacity = .9,
              title = "Cases per 100,000 people",
              position = "bottomright")
  
})

output$forest_map_county <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 10.94, 27.37, 45.50, 64.92, 92.85)
  pal <- colorBin("Greens", domain = counties_nlcd$NLCD_PCT, bins = bins)
  
  counties_nlcd %>%
    filter(NLCD_CLASS == "Forest") %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Forest Cover: ", round(NLCD_PCT, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(NLCD_PCT),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~NLCD_PCT,
              opacity = 1,
              title = "Forest Cover (%)",
              position = "bottomright")
  
})

output$forest_ed_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 14.26, 32.86, 49.82, 64.82, 97.60)
  pal <- colorBin("Greens", domain = counties_edge$ED, bins = bins)
  
  counties_edge %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Forest Edge Density (m/Ha): ", round(ED, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(ED),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~ED,
              opacity = 1,
              title = "Forest Edge Density (m/Ha)",
              position = "bottomright")
  
})

output$forest_pd_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 1.56, 3.32, 5.08, 7.46, 22.46)
  pal <- colorBin("Greens", domain = counties_edge$PATCHES_100HA, bins = bins)
  
  counties_edge %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Forest Patch Density (Patches/100 Ha): ", round(PATCHES_100HA, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(PATCHES_100HA),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~PATCHES_100HA,
              opacity = 1,
              title = "Forest Patch Density (Patches/100 Ha)",
              position = "bottomright")
  
})

output$forest_size_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 5.98, 13.74, 24.70, 44.42, 91.67)
  pal <- colorBin("Greens", domain = counties_edge$MEAN_PATCH_SIZE, bins = bins)
  
  counties_edge %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Mean Forest Patch Size (Ha): ", round(MEAN_PATCH_SIZE, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(MEAN_PATCH_SIZE),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~MEAN_PATCH_SIZE,
              opacity = 1,
              title = "Mean Forest Patch Size (Ha)",
              position = "bottomright")
  
})

output$dev_map_county <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 7.07, 16.00, 31.96, 56.63, 91.73)
  pal <- colorBin("Reds", domain = counties_nlcd$NLCD_PCT, bins = bins)
  
  
  counties_nlcd %>%
    filter(NLCD_CLASS == "Developed") %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Developed Cover: ", round(NLCD_PCT, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
      fillColor = ~pal(NLCD_PCT),
      color = "#444444",
      weight = 1,
      smoothFactor = 0.5,
      opacity = 1.0,
      fillOpacity = 1,
      highlightOptions = highlightOptions(color = "white",
                                          weight = 2,
                                          bringToFront = TRUE),
      labelOptions = labelOptions(
        style = list("font-weight" = "normal", padding = "3px 8px"),
        textsize = "15px",
        direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~NLCD_PCT,
              opacity = 1,
              title = "Developed Cover (%)",
              position = "bottomright")
  
})

output$water_map_county <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 1.00, 2.00, 10.00, 20.00, 57.96)
  pal <- colorBin("Blues", domain = counties_nlcd$NLCD_PCT, bins = bins)
  
  
  counties_nlcd %>%
    filter(NLCD_CLASS == "Water") %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Water Cover: ", round(NLCD_PCT, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(NLCD_PCT),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~NLCD_PCT,
              opacity = 1,
              title = "Water Cover (%)",
              position = "bottomright")
  
})

output$herb_map_county <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 0.52, 1.32, 3.42, 11.61, 97.66)
  pal <- colorBin("YlOrBr", domain = counties_nlcd$NLCD_PCT, bins = bins)
  
  
  counties_nlcd %>%
    filter(NLCD_CLASS == "Herbaceous") %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Herbaceous Cover: ", round(NLCD_PCT, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(NLCD_PCT),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~NLCD_PCT,
              opacity = 1,
              title = "Herbaceous Cover (%)",
              position = "bottomright")
  
})


output$fhe_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 2.18, 4.63, 8.16, 16.10, 98.04)
  pal <- colorBin("YlOrBr", domain = counties_edge$FHED, bins = bins)
  
  counties_edge %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Forest-Herbaceous Edge (%): ", round(FHED, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(FHED),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~FHED,
              opacity = 1,
              title = "Forest-Herbaceous Edge (%)",
              position = "bottomright")
  
})

output$fde_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 10.24, 22.82, 38.92, 61.77, 100.00)
  pal <- colorBin("Reds", domain = counties_edge$FDED, bins = bins)
  
  counties_edge %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Forest-Developed Edge (%): ", round(FDED, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(FDED),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~FDED,
              opacity = 1,
              title = "Forest-Developed Edge (%)",
              position = "bottomright")
  
})

output$elevation_map <- leaflet::renderLeaflet({
  
  bins <- c(-1.67, 764.63, 1943.22, 3886.98, 6521.30, 11384.62)
  pal <- colorBin("viridis", domain = counties_elev$MEAN_ft, bins = bins)
  
  
  counties_elev %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Mean Elevation (ft): ", round(MEAN_ft, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(MEAN_ft),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~MEAN_ft,
              opacity = 1,
              title = "Mean Elevation (ft)",
              position = "bottomright")
  
})

output$slope_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 2.11, 5.18, 9.50, 15.07, 23.95)
  pal <- colorBin("viridis", domain = counties_slope$MEAN, bins = bins)
  
  
  counties_slope %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Mean Slope of Elevation (degrees): ", round(MEAN, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(MEAN),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~MEAN,
              opacity = 1,
              title = "Mean Slope of Elevation (degrees)",
              position = "bottomright")
  
})

output$ndvi_map <- leaflet::renderLeaflet({
  
  bins <- c(-0.10, 0.17, 0.33, 0.46, 0.59, 0.76)
  pal <- colorBin("Greens", domain = counties_ndvi$MEAN_scale, bins = bins)
  
  
  counties_ndvi %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Mean NDVI: ", round(MEAN_scale, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(MEAN_scale),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~MEAN_scale,
              opacity = 1,
              title = "Mean NDVI",
              position = "bottomright")
  
})

output$soil_map <- leaflet::renderLeaflet({
  
  # leaflet() %>%
  #   addTiles() %>%
  #   setView(-97.50, 38.50, zoom = 5) %>%
  #   addRasterImage(soil_raster, 
  #                  colors = c("#b7d55a", "#ed028c", "#fddcb8", "#6dbcc4", "#2fa4be", "#ae4e42", "#cc7560", "#00a54f", "#c31d22", "#d5bdc1", "#faae18", "#fff101", "#000000"), 
  #                  opacity = 1) %>%
  #   addLegend(colors = c("#68AA63", "#1C6330", "#B5C98E"),
  #             labels = c("Alfisols", "Andisols", "Aridisols", "Entisols", "Gelisols", "Histosols", "Inceptisols", "Mollisols", "Oxisols", "Spodosols", "Ultisols", "Vertisols", "Miscellaneous (Non-Soil)"),
  #             opacity = 1,
  #             title = "Soil Taxonomy Order",
  #             position = "bottomright")
  
  pal <- colorFactor(palette = c("#b7d55a", "#ed028c", "#fddcb8", "#75cdd5", "#2fa4be", "#ae4e42", "#cc7560", "#00a54f", "#d5bdc1", "#faae18", "#fff101", "#000000"),
                     levels = levels(counties_soil$MAJ_TAX_ORDER))

  counties_soil %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Dominant Soil Taxonomy Order: ", MAJ_TAX_ORDER) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(MAJ_TAX_ORDER),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = FALSE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(values = ~MAJ_TAX_ORDER,
              labels = c("Alfisols", "Andisols", "Aridisols", "Entisols", "Gelisols", "Histosols", "Inceptisols", "Mollisols", "Spodosols", "Ultisols", "Vertisols", "Miscellaneous (Non-Soil)"),
              colors = c("#b7d55a", "#ed028c", "#fddcb8", "#75cdd5", "#2fa4be", "#ae4e42", "#cc7560", "#00a54f", "#d5bdc1", "#faae18", "#fff101", "#000000"),
              opacity = 1,
              title = "Dominant Soil Taxonomy Order",
              position = "bottomright")
  
})

output$scap_map <- leaflet::renderLeaflet({
  
  pal <- colorFactor(palette = c("#cccccc", "#bd0026","#cccccc", "#fecc5c"), 
                     levels = levels(counties_tick$Scap_Status))
  
  counties_tick %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Status: ", Scap_Status) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
      fillColor = ~pal(Scap_Status),
      color = "#444444",
      weight = 1,
      smoothFactor = 0.5,
      opacity = .9,
      fillOpacity = 1,
      highlightOptions = highlightOptions(color = "white",
                                          weight = 2,
                                          bringToFront = FALSE),
      labelOptions = labelOptions(
        style = list("font-weight" = "normal", padding = "3px 8px"),
        textsize = "15px",
        direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(values = ~Scap_Status,
              labels = c("Established", "Reported", "No Records"),
              colors = c("#bd0026", "#fecc5c", "#cccccc"), 
              opacity = 1,
              title = "I. scapularis status",
              position = "bottomright")
  
})

output$pac_map <- leaflet::renderLeaflet({

  pal <- colorFactor(palette = c("#cccccc", "#bd0026","#cccccc", "#fecc5c"), 
                          levels = levels(counties_tick$Scap_Status))
  counties_tick %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Status: ", Pac_Status) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
      fillColor = ~pal(Pac_Status),
      color = "#444444",
      weight = 1,
      smoothFactor = 0.5,
      opacity = .9,
      fillOpacity = 1,
      highlightOptions = highlightOptions(color = "white",
                                          weight = 2,
                                          bringToFront = FALSE),
      labelOptions = labelOptions(
        style = list("font-weight" = "normal", padding = "3px 8px"),
        textsize = "15px",
        direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(values = ~Pac_Status,
              labels = c("Established", "Reported", "No Records"),
              colors = c("#bd0026", "#fecc5c", "#cccccc"), 
              opacity = 1,
              title = "I. pacificus status",
              position = "bottomright")
  
})

output$pop_density_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 10, 100, 500, 1000, 5000, 72000)
  pal <- colorBin("YlOrRd", domain = counties$POPDENSITY, bins = bins)
  
  counties %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Population Density: ", round(POPDENSITY, digits = 2), " people per sq mi") %>%
             map(htmltools::HTML)) %>%
    filter(YEAR == 2018) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(POPDENSITY),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = .9,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = FALSE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~POPDENSITY,
              opacity = .9,
              title = "People per sq mi",
              position = "bottomright")
  
})

output$housing_map <- leaflet::renderLeaflet({
  
  bins <- c(-3.0, 0.0, 0.5, 1.0, 5.5)
  pal <- colorBin(c("#fcae91", "#e5f5e0", "#a1d99b", "#31a354"), domain = counties_housing$Delta, bins = bins)
  
  counties_housing %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Change: ", round(Delta, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    filter(Year == 2018) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(Delta),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = .9,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = FALSE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(colors = c("#fcae91", "#e5f5e0", "#a1d99b", "#31a354"),
              labels = c("Less than 0.0", "0.0 to 0.5", "0.5 to 1.0", "More than 1.0"),
              opacity = .9,
              title = "% Change",
              position = "bottomright")
  
})

output$nchs_map <- leaflet::renderLeaflet({
  
  pal <- colorFactor(palette = c("#d73027", "#fdae61", "#ffffbf", "#d9ef8b", "#a6d96a", "#1a9850"), 
                          levels = levels(counties_nchs$CODE_2013))
  
  counties_nchs %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(CODE_2013),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = .9,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = FALSE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(colors = c("#d73027", "#fdae61", "#ffffbf", "#d9ef8b", "#a6d96a", "#1a9850"),
              labels = c("Large central metro", "Large fringe metro", "Medium metro", "Small metro", "Micropolitan", "Non-core"),
              opacity = .9,
              title = "Urban/Rural Classification",
              position = "bottomright")
  
})

output$gt_ld_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 20, 40, 60, 80, 100)
  pal <- colorBin("Oranges", domain = dma$INTEREST_ld, bins = bins)
  
  dma %>%
    mutate(popup = str_c("<strong>", NAME, "</strong>",
                         "<br/>",
                         "Interest: ", INTEREST_ld) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(INTEREST_ld),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = .9,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = FALSE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addLegend(pal = pal,
              values = ~INTEREST_ld,
              opacity = 1,
              title = "'Lyme Disease' Search Interest (2019)",
              position = "bottomright")
  
})

output$gt_tick_bite_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 20, 40, 60, 80, 100)
  pal <- colorBin("Oranges", domain = dma$INTEREST_tick_bite, bins = bins)
  
  dma %>%
    mutate(popup = str_c("<strong>", NAME, "</strong>",
                         "<br/>",
                         "Interest: ", INTEREST_tick_bite) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(INTEREST_tick_bite),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = .9,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = FALSE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addLegend(pal = pal,
              values = ~INTEREST_tick_bite,
              opacity = 1,
              title = "'Tick Bite' Search Interest (2019)",
              position = "bottomright")
  
})

output$temp_map <- leaflet::renderLeaflet({
  
  bins <- c(30, 40, 50, 60, 70, 80)
  pal <- colorBin(c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c"), domain = counties_temp$Value, bins = bins)
  
  counties_temp %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Average Temperature: ", Value, "F") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
      fillColor = ~pal(Value),
      color = "#444444",
      weight = 1,
      smoothFactor = 0.5,
      opacity = 1.0,
      fillOpacity = 1,
      highlightOptions = highlightOptions(color = "white",
                                          weight = 2,
                                          bringToFront = TRUE),
      labelOptions = labelOptions(
        style = list("font-weight" = "normal", padding = "3px 8px"),
        textsize = "15px",
        direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~Value,
              opacity = 1,
              title = "Average Temperature (F)",
              position = "bottomright")
  
})

output$precip_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 25.84, 41.67, 54.76, 66.83, 110.83)
  pal <- colorBin("BrBG", domain = counties_precip$Value, bins = bins)
  
  counties_precip %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Precipitation: ", Value, '"') %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(Value),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~Value,
              opacity = 1,
              title = "Precipitation (in)",
              position = "bottomright")
  
})

output$hh_inc_map <- leaflet::renderLeaflet({
  
  bins <- c(20188, 42773, 53624, 67128, 87321, 136268)
  pal <- colorBin(c("YlGn"), domain = counties_hh_inc$S1903_C03_001E, bins = bins)
  
  counties_hh_inc %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Median HH Income: ", "$", comma(S1903_C03_001E)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(S1903_C03_001E),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~S1903_C03_001E,
              opacity = 1,
              title = "Median HH Income ($)",
              position = "bottomright")
  
})

output$edu_map <- leaflet::renderLeaflet({

  bins <- c(0.00, 9.73, 14.55, 19.94, 27.28, 64.02)
  pal <- colorBin(c("YlGn"), domain = counties_edu$percent_less_high, bins = bins)
  
  
  counties_edu %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% 18+ Population with less than high school diploma: ", round(percent_less_high, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(percent_less_high),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~percent_less_high,
              opacity = 1,
              title = "% 18+ Population with less than high school diploma",
              position = "bottomright")
  
})

output$age_05_14_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 10.06, 12.06, 13.76, 16.33, 22.47)
  pal <- colorBin(c("YlGn"), domain = counties_age$pct_05_14, bins = bins)
  
  
  counties_age %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Population Age 5-14: ", round(pct_05_14, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(pct_05_14),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~pct_05_14,
              opacity = 1,
              title = "% Population Age 5-14",
              position = "bottomright")
  
})

output$age_45_59_map <- leaflet::renderLeaflet({
  
  bins <- c(7.38, 17.02, 19.38, 21.13, 23.44, 42.67)
  pal <- colorBin(c("YlGn"), domain = counties_age$pct_45_59, bins = bins)
  
  
  counties_age %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Population Age 45-59: ", round(pct_45_59, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(pct_45_59),
                color = "#444444",
                weight = 1,
                smoothFactor = 0.5,
                opacity = 1.0,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = TRUE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~pct_45_59,
              opacity = 1,
              title = "% Population Age 45-59",
              position = "bottomright")
  
})

# output$deer_map <- leaflet::renderLeaflet({
#   
#   pal <- colorFactor(palette = c("YlGn"), 
#                           levels = levels(deer$Density))
#   deer %>%
#     leaflet() %>%
#     addTiles() %>%
#     setView(-97.50, 38.50, zoom = 5) %>%
#     addPolygons(
#       fillColor = ~pal(Density),
#       color = "#444444",
#       weight = 1,
#       smoothFactor = 0.5,
#       opacity = 1.0,
#       fillOpacity = 1,
#       highlightOptions = highlightOptions(color = "white",
#                                           weight = 2,
#                                           bringToFront = TRUE),
#       labelOptions = labelOptions(
#         style = list("font-weight" = "normal", padding = "3px 8px"),
#         textsize = "15px",
#         direction = "auto")) %>%
#     addLegend(values = ~Density,
#               labels = c("Rare, absent, or unknown", "<15", "15-30", "30-40", ">40"),
#               colors = c("#ffffcc", "#c2e699", "#78c679", "#31a354", "#006837"), 
#               opacity = 1,
#               title = "Deer per sq mi",
#               position = "bottomright")
#   
# })

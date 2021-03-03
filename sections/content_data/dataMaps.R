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
    addProviderTiles("CartoDB.Positron") %>%
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
    addProviderTiles("CartoDB.Positron") %>%
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

output$bab_count_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 22, 123, 281, 471, 696)
  pal <- colorBin("YlOrBr", domain = states_bab$CASES, bins = bins)
  
  states_bab %>%
    filter(YEAR == 2018) %>%
    mutate(popup = str_c("<strong>", NAME, "</strong>",
                         "<br/>",
                         round(RATE, digits = 2), " cases per 100,000 people",
                         "<br/>", 
                         CASES, " cases total") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
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
    addLegend(pal = pal,
              values = ~CASES,
              opacity = .9,
              title = "Number of Cases",
              position = "bottomright")
  
})

output$bab_rate_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 0.48, 2.19, 5.31, 9.14, 18.00)
  pal <- colorBin("YlOrBr", domain = states_bab$RATE, bins = bins)
  
  states_bab %>%
    filter(YEAR == 2018) %>%
    mutate(popup = str_c("<strong>", NAME, "</strong>",
                         "<br/>",
                         round(RATE, digits = 2), " cases per 100,000 people",
                         "<br/>", 
                         CASES, " cases total") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(RATE),
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
              values = ~RATE,
              opacity = .9,
              title = "Cases per 100,000 people",
              position = "bottomright")
  
})

output$a_count_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 58, 201, 372, 585, 915)
  pal <- colorBin("YlOrBr", domain = states_ea$CASES_A, bins = bins)
  
  states_ea %>%
    filter(YEAR == 2018) %>%
    mutate(popup = str_c("<strong>", NAME, "</strong>",
                         "<br/>",
                         round(RATE_A, digits = 2), " cases per 1,000,000 people",
                         "<br/>", 
                         CASES_A, " cases total") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(CASES_A),
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
              values = ~CASES_A,
              opacity = .9,
              title = "Number of Cases",
              position = "bottomright")
  
})

output$a_rate_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 20.87, 70.78, 158.11, 390.80, 639.08)
  pal <- colorBin("YlOrBr", domain = states_ea$RATE_A, bins = bins)
  
  states_ea %>%
    filter(YEAR == 2018) %>%
    mutate(popup = str_c("<strong>", NAME, "</strong>",
                         "<br/>",
                         round(RATE_A, digits = 2), " cases per 1,000,000 people",
                         "<br/>", 
                         CASES_A, " cases total") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(RATE_A),
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
              values = ~RATE_A,
              opacity = .9,
              title = "Cases per 1,000,000 people",
              position = "bottomright")
  
})

output$e_count_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 26, 70, 130, 236, 354)
  pal <- colorBin("YlOrBr", domain = states_ea$CASES_E_C, bins = bins)
  
  states_ea %>%
    filter(YEAR == 2018) %>%
    mutate(popup = str_c("<strong>", NAME, "</strong>",
                         "<br/>",
                         round(RATE_E_C, digits = 2), " cases per 1,000,000 people",
                         "<br/>", 
                         CASES_E_C, " cases total") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(CASES_E_C),
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
              values = ~CASES_E_C,
              opacity = .9,
              title = "Number of Cases",
              position = "bottomright")
  
})

output$e_rate_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 4.14, 11.65, 22.84, 41.66, 79.54)
  pal <- colorBin("YlOrBr", domain = states_ea$RATE_E_C, bins = bins)
  
  states_ea %>%
    filter(YEAR == 2018) %>%
    mutate(popup = str_c("<strong>", NAME, "</strong>",
                         "<br/>",
                         round(RATE_E_C, digits = 2), " cases per 1,000,000 people",
                         "<br/>", 
                         CASES_E_C, " cases total") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(RATE_E_C),
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
              values = ~RATE_E_C,
              opacity = .9,
              title = "Cases per 1,000,000 people",
              position = "bottomright")
  
})

output$sfr_count_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 57, 190, 409, 696, 1214)
  pal <- colorBin("YlOrBr", domain = states_sfr$CASES, bins = bins)
  
  states_sfr %>%
    filter(YEAR == 2018) %>%
    mutate(popup = str_c("<strong>", NAME, "</strong>",
                         "<br/>",
                         round(RATE, digits = 2), " cases per 1,000,000 people",
                         "<br/>", 
                         CASES, " cases total") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
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
    addLegend(pal = pal,
              values = ~CASES,
              opacity = .9,
              title = "Number of Cases",
              position = "bottomright")
  
})

output$sfr_rate_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 8.75, 31.81, 74.95, 189.75, 404.49)
  pal <- colorBin("YlOrBr", domain = states_sfr$RATE, bins = bins)
  
  states_sfr %>%
    filter(YEAR == 2018) %>%
    mutate(popup = str_c("<strong>", NAME, "</strong>",
                         "<br/>",
                         round(RATE, digits = 2), " cases per 1,000,000 people",
                         "<br/>", 
                         CASES, " cases total") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(RATE),
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
              values = ~RATE,
              opacity = .9,
              title = "Cases per 1,000,000 people",
              position = "bottomright")
  
})

output$tul_count_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 3, 11, 23, 37, 55)
  pal <- colorBin("YlOrBr", domain = states_tul$CASES, bins = bins)
  
  states_tul %>%
    filter(YEAR == 2018) %>%
    mutate(popup = str_c("<strong>", NAME, "</strong>",
                         "<br/>",
                         # round(RATE, digits = 2), " cases per 1,000,000 people",
                         # "<br/>", 
                         CASES, " cases total") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
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
    addLegend(pal = pal,
              values = ~CASES,
              opacity = .9,
              title = "Number of Cases",
              position = "bottomright")
  
})


output$pow_count_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 1, 2, 4, 7, 11)
  pal <- colorBin("YlOrBr", domain = states_pow$CASES, bins = bins)
  
  states_pow %>%
    filter(YEAR == 2018) %>%
    mutate(popup = str_c("<strong>", NAME, "</strong>",
                         "<br/>",
                         # round(RATE, digits = 2), " cases per 1,000,000 people",
                         # "<br/>", 
                         CASES, " cases total") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
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
    addLegend(pal = pal,
              values = ~CASES,
              opacity = .9,
              title = "Number of Cases",
              position = "bottomright")
  
})


output$nlcd_map <- leaflet::renderLeaflet({
  
  water <- counties_nlcd %>% filter(CLASS == "Water")
  developed <- counties_nlcd %>% filter(CLASS == "Developed")
  barren <- counties_nlcd %>% filter(CLASS == "Barren")
  forest <- counties_nlcd %>% filter(CLASS == "Forest")
  shrubland <- counties_nlcd %>% filter(CLASS == "Shrubland")
  herbaceous <- counties_nlcd %>% filter(CLASS == "Herbaceous")
  cultivated <- counties_nlcd %>% filter(CLASS == "Cultivated")
  wetlands <- counties_nlcd %>% filter(CLASS == "Wetlands")
  
  bins_water <- c(0, 5, 20, 40, 60, 100)
  pal_water <- colorBin("Blues", domain = water$PCT, bins = bins_water)
  bins_dev <- c(0, 5, 20, 40, 60, 100)
  pal_dev <- colorBin("Reds", domain = developed$PCT, bins = bins_dev)
  bins_barren <- c(0, 1, 5, 10, 25, 40)
  pal_barren <- colorBin("Greys", domain = barren$PCT, bins = bins_barren)
  bins_forest <- c(0, 10, 25, 45, 65, 100)
  pal_forest <- colorBin("Greens", domain = forest$PCT, bins = bins_forest)
  bins_shrub <- c(0, 5, 20, 40, 60, 100)
  pal_shrub <- colorBin("YlOrBr", domain = shrubland$PCT, bins = bins_shrub)
  bins_herb <- c(0, 5, 20, 40, 60, 100)
  pal_herb <- colorBin("YlOrBr", domain = herbaceous$PCT, bins = bins_herb)
  bins_cult <- c(0, 10, 25, 45, 70, 100)
  pal_cult <- colorBin("Oranges", domain = cultivated$PCT, bins = bins_cult)
  bins_wet <- c(0, 5, 10, 25, 40, 80)
  pal_wet <- colorBin("GnBu", domain = wetlands$PCT, bins = bins_wet)
  
  water <- water %>% 
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Water Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  developed <- developed %>% 
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Developed Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  barren <- barren %>% 
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Barren Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  forest <- forest %>% 
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Forest Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  shrubland <- shrubland %>% 
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Shrubland Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  herbaceous <- herbaceous %>% 
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Herbaceous Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  cultivated <- cultivated %>% 
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Cultivated Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  wetlands <- wetlands %>% 
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Wetlands Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  
  leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
      data = water,  
      group = "Water",
      fillColor = ~pal_water(PCT),
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
    addPolygons(label = ~popup,
      data = developed,  
      group = "Developed",
      fillColor = ~pal_dev(PCT),
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
    addPolygons(label = ~popup,
      data = barren,  
      group = "Barren",
      fillColor = ~pal_barren(PCT),
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
    addPolygons(label = ~popup,
      data = forest,  
      group = "Forest",
      fillColor = ~pal_forest(PCT),
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
    addPolygons(label = ~popup,
      data = shrubland,  
      group = "Shrubland",
      fillColor = ~pal_shrub(PCT),
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
    addPolygons(label = ~popup,
      data = herbaceous,  
      group = "Herbaceous",
      fillColor = ~pal_herb(PCT),
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
    addPolygons(label = ~popup,
      data = cultivated,  
      group = "Cultivated",
      fillColor = ~pal_cult(PCT),
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
    addPolygons(label = ~popup,
      data = wetlands,  
      group = "Wetlands",
      fillColor = ~pal_wet(PCT),
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
    addLegend(pal = pal_water,
              values = water$PCT,
              opacity = 1,
              title = "Water Cover (%)",
              position = "bottomright",
              group = "Water") %>%
    addLegend(pal = pal_dev,
              values = developed$PCT,
              opacity = 1,
              title = "Developed Cover (%)",
              position = "bottomright",
              group = "Developed") %>%
    addLegend(pal = pal_barren,
              values = barren$PCT,
              opacity = 1,
              title = "Barren Cover (%)",
              position = "bottomright",
              group = "Barren") %>%
    addLegend(pal = pal_forest,
              values = forest$PCT,
              opacity = 1,
              title = "Forest Cover (%)",
              position = "bottomright",
              group = "Forest") %>%
    addLegend(pal = pal_shrub,
              values = shrubland$PCT,
              opacity = 1,
              title = "Shrubland Cover (%)",
              position = "bottomright",
              group = "Shrubland") %>%
    addLegend(pal = pal_herb,
              values = herbaceous$PCT,
              opacity = 1,
              title = "Herbaceous Cover (%)",
              position = "bottomright",
              group = "Herbaceous") %>%
    addLegend(pal = pal_cult,
              values = cultivated$PCT,
              opacity = 1,
              title = "Cultivated Cover (%)",
              position = "bottomright",
              group = "Cultivated") %>%
    addLegend(pal = pal_wet,
              values = wetlands$PCT,
              opacity = 1,
              title = "Wetlands Cover (%)",
              position = "bottomright",
              group = "Wetlands") %>%
    addLayersControl(
      overlayGroups = c("Water", "Developed", "Barren", "Forest", "Shrubland", "Herbaceous", "Cultivated", "Wetlands"),
      options = layersControlOptions(collapsed = FALSE)) %>%
    hideGroup("Developed") %>%
    hideGroup("Barren") %>%
    hideGroup("Forest") %>%
    hideGroup("Shrubland") %>%
    hideGroup("Herbaceous") %>%
    hideGroup("Cultivated") %>%
    hideGroup("Wetlands")
  
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
    addProviderTiles("CartoDB.Positron") %>%
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

# output$forest_pd_map <- leaflet::renderLeaflet({
#   
#   bins <- c(0.00, 1.56, 3.32, 5.08, 7.46, 22.46)
#   pal <- colorBin("Greens", domain = counties_edge$PATCHES_100HA, bins = bins)
#   
#   counties_edge %>%
#     mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
#                          "<br/>",
#                          "Forest Patch Density (Patches/100 Ha): ", round(PATCHES_100HA, digits = 2)) %>%
#              map(htmltools::HTML)) %>%
#     leaflet() %>%
#     addProviderTiles("CartoDB.Positron") %>%
#     setView(-97.50, 38.50, zoom = 5) %>%
#     addPolygons(label = ~popup,
#                 fillColor = ~pal(PATCHES_100HA),
#                 color = "#444444",
#                 weight = 1,
#                 smoothFactor = 0.5,
#                 opacity = 1.0,
#                 fillOpacity = 1,
#                 highlightOptions = highlightOptions(color = "white",
#                                                     weight = 2,
#                                                     bringToFront = TRUE),
#                 labelOptions = labelOptions(
#                   style = list("font-weight" = "normal", padding = "3px 8px"),
#                   textsize = "15px",
#                   direction = "auto")) %>%
#     addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
#     addLegend(pal = pal,
#               values = ~PATCHES_100HA,
#               opacity = 1,
#               title = "Forest Patch Density (Patches/100 Ha)",
#               position = "bottomright")
#   
# })

output$fde_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 10.24, 22.82, 38.92, 61.77, 100.00)
  pal <- colorBin("Reds", domain = counties_edge$FDED, bins = bins)
  
  counties_edge %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Forest-Developed Edge (%): ", round(FDED, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
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
  
  bins <- c(-0.42,235.12, 595.36, 1184.74, 1984.19, 3471.14)
  pal <- colorBin("viridis", domain = counties_elev$MEAN, bins = bins)
  
  
  counties_elev %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Mean Elevation (m): ", round(MEAN, digits = 2),
                         "<br/>",
                         "Standard Deviation (m): ", round(STD, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
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
              title = "Mean Elevation (m)",
              position = "bottomright")
  
})

output$slope_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 2.19, 5.16, 9.54, 15.15, 24.12)
  pal <- colorBin("viridis", domain = counties_slope$MEAN, bins = bins)
  
  
  counties_slope %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Mean Slope of Elevation (degrees): ", round(MEAN, digits = 2),
                         "<br/>",
                         "Standard Deviation (degrees): ", round(STD, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
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
  
  bins <- c(1, 10, 20, 30, 40, 50, 60, 70, 80, 90)
  pal <- colorBin("Greens", domain = counties_tin$MEAN, bins = bins)
  
  
  counties_tin %>%
    filter(YEAR == 2018) %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Mean Time-Integrated NDVI: ", round(MEAN, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
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
              title = "Mean Time-Integrated NDVI",
              position = "bottomright")
  
})

output$soil_map <- leaflet::renderLeaflet({
  
  pal <- colorFactor(palette = c("#b7d55a", "#ed028c", "#fddcb8", "#75cdd5", "#2fa4be", "#ae4e42", "#cc7560", "#00a54f", "#ee1d24", "#d5bdc1", "#faae18", "#fff101", "#000000"),
                     levels = levels(counties_soil$MAJORITY))

  counties_soil %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Dominant Soil Taxonomy Order: ", MAJORITY) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(MAJORITY),
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
    addLegend(values = ~MAJORITY,
              labels = c("Alfisols", "Andisols", "Aridisols", "Entisols", "Gelisols", "Histosols", "Inceptisols", "Mollisols", "Oxisols", "Spodosols", "Ultisols", "Vertisols", "Misc. (Non-Soil)"),
              colors = c("#b7d55a", "#ed028c", "#fddcb8", "#75cdd5", "#2fa4be", "#ae4e42", "#cc7560", "#00a54f", "#ee1d24", "#d5bdc1", "#faae18", "#fff101", "#000000"),
              opacity = 1,
              title = "Dominant Soil Taxonomy Order",
              position = "bottomright")
  
})

output$scap_map <- leaflet::renderLeaflet({
  
  pal <- colorFactor(palette = c("#bd0026","#cccccc", "#fecc5c"), 
                     levels = levels(counties_tick$SCAP))
  
  counties_tick %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Status: ", SCAP) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
      fillColor = ~pal(SCAP),
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
    addLegend(values = ~SCAP,
              labels = c("Established", "Reported", "No Records"),
              colors = c("#bd0026", "#fecc5c", "#cccccc"), 
              opacity = 1,
              title = "I. scapularis status",
              position = "bottomright")
  
})

output$pac_map <- leaflet::renderLeaflet({

  pal <- colorFactor(palette = c("#bd0026","#cccccc", "#fecc5c"), 
                          levels = levels(counties_tick$PAC))
  counties_tick %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Status: ", PAC) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
      fillColor = ~pal(PAC),
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
    addLegend(values = ~PAC,
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
    addProviderTiles("CartoDB.Positron") %>%
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
  
  bins <- c(-3.0, 0.0, 1.0, 5.0, 122.72)
  pal <- colorBin(c("#fcae91", "#e5f5e0", "#a1d99b", "#31a354"), domain = counties_housing$PCT_CHNG, bins = bins)
  
  counties_housing %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% Change: ", round(PCT_CHNG, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(PCT_CHNG),
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
              labels = c("Less than 0.0", "0.0 to 1.0", "1.0 to 1.0", "More than 5.0"),
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
    addProviderTiles("CartoDB.Positron") %>%
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

rval_gt_ld <- reactive({
  dma_ld %>%
    filter(
      YEAR == input$year_gt_ld,
    )
})

output$gt_ld_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 14, 26, 43, 69, 100)
  pal <- colorBin("Oranges", domain = dma_ld$INTEREST, bins = bins)
  
  rval_gt_ld() %>%
    mutate(popup = str_c("<strong>", NAME, "</strong>",
                         "<br/>",
                         "Interest: ", INTEREST) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(INTEREST),
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
              values = ~INTEREST,
              opacity = 1,
              title = "'Lyme Disease' Search Interest",
              position = "bottomright")
  
})

rval_gt_tb <- reactive({
  dma_tb %>%
    filter(
      YEAR == input$year_gt_tb,
    )
})

output$gt_tick_bite_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 8, 22, 38, 63, 100)
  pal <- colorBin("Oranges", domain = dma_tb$INTEREST, bins = bins)
  
  rval_gt_tb() %>%
    mutate(popup = str_c("<strong>", NAME, "</strong>",
                         "<br/>",
                         "Interest: ", INTEREST) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(INTEREST),
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
              values = ~INTEREST,
              opacity = 1,
              title = "'Tick Bite' Search Interest",
              position = "bottomright")
  
})

output$temp_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 40, 50, 60, 70, 80)
  pal <- colorBin(c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c"), domain = counties_temp$SPRING, bins = bins)
  
  counties_temp %>%
    filter(YEAR == 2018) %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Average Temperature: ", SPRING, "F") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
      fillColor = ~pal(SPRING),
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
              values = ~SPRING,
              opacity = 1,
              title = "Average Temperature (F)",
              position = "bottomright")
  
})

output$precip_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 5, 10, 15, 20, 65)
  pal <- colorBin("Blues", domain = counties_pcpn$SPRING, bins = bins)
  
  counties_pcpn %>%
    filter(YEAR == 2018) %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Precipitation: ", SPRING, '"') %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(SPRING),
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
              values = ~SPRING,
              opacity = 1,
              title = "Precipitation (in)",
              position = "bottomright")
  
})

output$hh_inc_map <- leaflet::renderLeaflet({
  
  bins <- c(20188, 42773, 53624, 67128, 87321, 136268)
  pal <- colorBin(c("YlGn"), domain = counties_hh_inc$MED_H_INC, bins = bins)
  
  counties_hh_inc %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "Median HH Income: ", "$", comma(MED_H_INC)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(MED_H_INC),
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
              values = ~MED_H_INC,
              opacity = 1,
              title = "Median HH Income ($)",
              position = "bottomright")
  
})

output$edu_map <- leaflet::renderLeaflet({

  bins <- c(33.7, 73.9, 81.6, 86.9, 91.3, 98.8)
  pal <- colorBin(c("YlGn"), domain = counties_edu$PCT_HS_PLUS, bins = bins)
  
  
  counties_edu %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         "% 25+ population high school graduate or higher: ", PCT_HS_PLUS) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(PCT_HS_PLUS),
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
              values = ~PCT_HS_PLUS,
              opacity = 1,
              title = "% 25+ population high school graduate or higher",
              position = "bottomright")
  
})

# output$age_05_14_map <- leaflet::renderLeaflet({
#   
#   bins <- c(0.00, 10.06, 12.06, 13.76, 16.33, 22.47)
#   pal <- colorBin(c("YlGn"), domain = counties_age$pct_05_14, bins = bins)
#   
#   
#   counties_age %>%
#     mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
#                          "<br/>",
#                          "% Population Age 5-14: ", round(pct_05_14, digits = 2)) %>%
#              map(htmltools::HTML)) %>%
#     leaflet() %>%
#     addProviderTiles("CartoDB.Positron") %>%
#     setView(-97.50, 38.50, zoom = 5) %>%
#     addPolygons(label = ~popup,
#                 fillColor = ~pal(pct_05_14),
#                 color = "#444444",
#                 weight = 1,
#                 smoothFactor = 0.5,
#                 opacity = 1.0,
#                 fillOpacity = 1,
#                 highlightOptions = highlightOptions(color = "white",
#                                                     weight = 2,
#                                                     bringToFront = TRUE),
#                 labelOptions = labelOptions(
#                   style = list("font-weight" = "normal", padding = "3px 8px"),
#                   textsize = "15px",
#                   direction = "auto")) %>%
#     addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
#     addLegend(pal = pal,
#               values = ~pct_05_14,
#               opacity = 1,
#               title = "% Population Age 5-14",
#               position = "bottomright")
#   
# })

# output$age_45_59_map <- leaflet::renderLeaflet({
#   
#   bins <- c(7.38, 17.02, 19.38, 21.13, 23.44, 42.67)
#   pal <- colorBin(c("YlGn"), domain = counties_age$pct_45_59, bins = bins)
#   
#   
#   counties_age %>%
#     mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
#                          "<br/>",
#                          "% Population Age 45-59: ", round(pct_45_59, digits = 2)) %>%
#              map(htmltools::HTML)) %>%
#     leaflet() %>%
#     addProviderTiles("CartoDB.Positron") %>%
#     setView(-97.50, 38.50, zoom = 5) %>%
#     addPolygons(label = ~popup,
#                 fillColor = ~pal(pct_45_59),
#                 color = "#444444",
#                 weight = 1,
#                 smoothFactor = 0.5,
#                 opacity = 1.0,
#                 fillOpacity = 1,
#                 highlightOptions = highlightOptions(color = "white",
#                                                     weight = 2,
#                                                     bringToFront = TRUE),
#                 labelOptions = labelOptions(
#                   style = list("font-weight" = "normal", padding = "3px 8px"),
#                   textsize = "15px",
#                   direction = "auto")) %>%
#     addPolylines(data = states_dissolve, color = "black", opacity = 1, weight = 1) %>%
#     addLegend(pal = pal,
#               values = ~pct_45_59,
#               opacity = 1,
#               title = "% Population Age 45-59",
#               position = "bottomright")
#   
# })

output$ca_rate_map <- leaflet::renderLeaflet({
  
  bins <- c(0, 1, 10, 25, 100, 250)
  pal <- colorBin("YlOrBr", domain = ca_hr$RATE, bins = bins)
  
  ca_hr %>%
    filter(YEAR == 2017) %>%
    mutate(popup = str_c("<strong>", REGION, ", ", PRABBR, "</strong>",
                         "<br/>",
                         round(RATE, digits = 2), " cases per 100,000 people",
                         "<br/>",
                         CASES, " cases total") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    # setView(-96.48, 48.35, zoom = 5) %>%
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
    addPolylines(data = ca_pr_lines, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
            values = ~RATE,
            opacity = .9,
            title = "Cases per 100,000 people",
            position = "bottomright")
  
})

output$pop_ecu_ca_map <- leaflet::renderLeaflet({
  
  pal <- colorFactor(palette = c("grey", "red"), 
                     levels = levels(canada_ecu$ECUMENE))
  canada_ecu %>%
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    # setView(-97.50, 38.50, zoom = 5) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(ECUMENE),
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
    addPolylines(data = ca_pr_lines, color = "black", opacity = 1, weight = 1) %>%
    addLegend(values = ~ECUMENE,
              labels = c("Outside the ecumene", "Inside the ecumene"),
              colors = c("grey", "red"), 
              opacity = 1,
              title = "Population Ecumene",
              position = "bottomright")
  
})

output$hh_inc_ca_map <- leaflet::renderLeaflet({
  
  bins <- c(34944, 59526, 72662, 87916, 112768, 192979)
  pal <- colorBin(c("YlGn"), domain = canada_hhinc$MED_H_INC, bins = bins)
  
  canada_hhinc %>%
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "Median HH Income: ", "CA$ ", comma(MED_H_INC)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
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
    addPolylines(data = ca_pr_lines, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~MED_H_INC,
              opacity = 1,
              title = "Median HH Income (CA$)",
              position = "bottomright")
  
})

output$pop_density_ca_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 6.11, 23.66, 94.08, 2213.32, 11226.24)
  pal <- colorBin(c("YlOrRd"), domain = canada_pd$PD_SQMI, bins = bins)
  
  canada_pd %>%
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "Population Density: ", round(PD_SQMI, digits = 2), " people per sq mi") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(PD_SQMI),
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
    addPolylines(data = ca_pr_lines, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~PD_SQMI,
              opacity = 1,
              title = "People per sq mi",
              position = "bottomright")
  
})

output$edu_ca_map <- leaflet::renderLeaflet({
  
  bins <- c(52.3, 59.5, 74.9, 81.5, 86.9, 94.8)
  pal <- colorBin(c("YlOrRd"), domain = canada_edu$PCT_HS_PLUS, bins = bins)
  
  canada_edu %>%
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "% 25+ population with high school diploma or higher: ", PCT_HS_PLUS) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
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
    addPolylines(data = ca_pr_lines, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~PCT_HS_PLUS,
              opacity = 1,
              title = "% 25+ population with high school diploma or higher",
              position = "bottomright")
  
})

output$housing_ca_map <- leaflet::renderLeaflet({
  
  bins <- c(-7.5, 0.0, 5.0, 10.0, 24.6)
  pal <- colorBin(c("#fcae91", "#e5f5e0", "#a1d99b", "#31a354"), domain = canada_housing$PCT_CHNG, bins = bins)
  
  canada_housing %>%
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "% Change: ", PCT_CHNG) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(PCT_CHNG),
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
    addPolylines(data = ca_pr_lines, color = "black", opacity = 1, weight = 1) %>%
    addLegend(colors = c("#fcae91", "#e5f5e0", "#a1d99b", "#31a354"),
              labels = c("Less than 0.0", "0.0 to 5.0", "5.0 to 10.0", "More than 10.0"),
              opacity = 1,
              title = "% Change",
              position = "bottomright")
  
})

output$soil_ca_map <- leaflet::renderLeaflet({
  
  pal <- colorFactor(palette = c("#0097fe", "#a8a802", "#7054e5", "#014ca9", "#ffff87", "#ff99ec", "#75c104", "#8500a9", "#a96f03", "#b2b2b2"),
                     levels = levels(canada_soil$MAJORITY))
  
  canada_soil %>%
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "Dominant Soil Taxonomy Order: ", MAJORITY) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    # setView(-97.50, 38.50, zoom = 5) %>%
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
    addPolylines(data = ca_pr_lines, color = "black", opacity = 1, weight = 1) %>%
    addLegend(values = ~MAJORITY,
              labels = c("Brunisolic", "Chernozemic", "Cryosolic", "Gleysolic", "Luvisolic", "Organic", "Podzolic", "Regosolic", "Vertisolic", "Unclassified"),
              colors = c("#0097fe", "#a8a802", "#7054e5", "#014ca9", "#ffff87", "#ff99ec", "#75c104", "#8500a9", "#a96f03", "#b2b2b2"),
              opacity = 1,
              title = "Dominant Soil Taxonomy Order",
              position = "bottomright")
  
})

output$lc_ca_map <- leaflet::renderLeaflet({
  
  water <- canada_land %>% filter(CLASS == "Water")
  developed <- canada_land %>% filter(CLASS == "Developed")
  barren <- canada_land %>% filter(CLASS == "Barren")
  forest <- canada_land %>% filter(CLASS == "Forest")
  shrubland <- canada_land %>% filter(CLASS == "Shrubland")
  herbaceous <- canada_land %>% filter(CLASS == "Herbaceous")
  cultivated <- canada_land %>% filter(CLASS == "Cultivated")
  wetlands <- canada_land %>% filter(CLASS == "Wetlands")
  
  bins_water <- c(0, 3, 5, 10, 20, 35)
  pal_water <- colorBin("Blues", domain = water$PCT, bins = bins_water)
  bins_dev <- c(0, 5, 10, 30, 50, 80)
  pal_dev <- colorBin("Reds", domain = developed$PCT, bins = bins_dev)
  bins_barren <- c(0, 1, 5, 10, 15, 30)
  pal_barren <- colorBin("Greys", domain = barren$PCT, bins = bins_barren)
  bins_forest <- c(0, 10, 30, 50, 70, 95)
  pal_forest <- colorBin("Greens", domain = forest$PCT, bins = bins_forest)
  bins_shrub <- c(0, 3, 8, 14, 20, 45)
  pal_shrub <- colorBin("YlOrBr", domain = shrubland$PCT, bins = bins_shrub)
  bins_herb <- c(0, 3, 8, 18, 30, 60)
  pal_herb <- colorBin("YlOrBr", domain = herbaceous$PCT, bins = bins_herb)
  bins_cult <- c(0, 10, 25, 45, 70, 95)
  pal_cult <- colorBin("Oranges", domain = cultivated$PCT, bins = bins_cult)
  bins_wet <- c(0, 1, 4, 9, 18, 25)
  pal_wet <- colorBin("GnBu", domain = wetlands$PCT, bins = bins_wet)
  
  water <- water %>% 
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "% Water Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  developed <- developed %>% 
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "% Developed Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  barren <- barren %>% 
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "% Barren Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  forest <- forest %>% 
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "% Forest Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  shrubland <- shrubland %>% 
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "% Shrubland Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  herbaceous <- herbaceous %>% 
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "% Herbaceous Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  cultivated <- cultivated %>% 
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "% Cultivated Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  wetlands <- wetlands %>% 
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "% Wetlands Cover: ", round(PCT, digits = 2)) %>%
             map(htmltools::HTML))
  
  leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    # setView(-97.50, 38.50, zoom = 5) %>%
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
    addPolylines(data = ca_pr_lines, color = "black", opacity = 1, weight = 1) %>%
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

output$elevation_ca_map <- leaflet::renderLeaflet({
  
  bins <- c(15.70, 187.85, 407.02, 703.25, 1136.83, 1962.60)
  pal <- colorBin("viridis", domain = canada_elev$MEAN, bins = bins)
  
  
  canada_elev %>%
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "Mean Elevation (m): ", round(MEAN, digits = 2),
                         "<br/>",
                         "Standard Deviation (m): ", round(STD, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    # setView(-97.50, 38.50, zoom = 5) %>%
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
    addPolylines(data = ca_pr_lines, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~MEAN,
              opacity = 1,
              title = "Mean Elevation (m)",
              position = "bottomright")
  
})

output$slope_ca_map <- leaflet::renderLeaflet({
  
  bins <- c(0.15, 3.54, 8.16, 14.86, 23.98, 35.19)
  pal <- colorBin("viridis", domain = canada_slope$MEAN, bins = bins)
  
  
  canada_slope %>%
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "Mean Slope of Elevation (degrees): ", round(MEAN, digits = 2),
                         "<br/>",
                         "Standard Deviation (degrees): ", round(STD, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    # setView(-97.50, 38.50, zoom = 5) %>%
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
    addPolylines(data = ca_pr_lines, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~MEAN,
              opacity = 1,
              title = "Mean Slope of Elevation (degrees)",
              position = "bottomright")
  
})

output$forest_ed_ca_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 15.56, 30.66, 41.68, 55.64, 80.52)
  pal <- colorBin("Greens", domain = canada_edge$ED, bins = bins)
  
  canada_edge %>%
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "Forest Edge Density (m/Ha): ", round(ED, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    # setView(-97.50, 38.50, zoom = 5) %>%
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
    addPolylines(data = ca_pr_lines, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~ED,
              opacity = 1,
              title = "Forest Edge Density (m/Ha)",
              position = "bottomright")
  
})

output$fde_ca_map <- leaflet::renderLeaflet({
  
  bins <- c(0.00, 8.42, 16.58, 25.38, 37.79, 69.52)
  pal <- colorBin("Reds", domain = canada_edge$FDED, bins = bins)
  
  canada_edge %>%
    mutate(popup = str_c("<strong>", NAME, ", ", PRABBR, "</strong>",
                         "<br/>",
                         "Forest-Developed Edge (%): ", round(FDED, digits = 2)) %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    # setView(-97.50, 38.50, zoom = 5) %>%
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
    addPolylines(data = ca_pr_lines, color = "black", opacity = 1, weight = 1) %>%
    addLegend(pal = pal,
              values = ~FDED,
              opacity = 1,
              title = "Forest-Developed Edge (%)",
              position = "bottomright")
  
})
rval_ca <- reactive({
  ca_hr %>%
    filter(
      YEAR == input$year_ca,
    )
})

output$map_cases_ca <- leaflet::renderLeaflet({
  
  bins <- c(0, 1, 10, 25, 100, 250)
  pal <- colorBin("YlOrBr", domain = ca_hr$RATE, bins = bins)
  
  rval_ca() %>%
    mutate(popup = str_c("<strong>", REGION, ", ", PRABBR, "</strong>",
                         "<br/>",
                         round(RATE, digits = 2), " cases per 100,000 people",
                         "<br/>",
                         CASES, " cases total") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    addResetMapButton() %>% 
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
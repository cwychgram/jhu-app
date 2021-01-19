rval <- reactive({
  counties %>%
    filter(
      YEAR == input$year,
    )
})

output$map_cases <- leaflet::renderLeaflet({

  bins <- c(0, 1, 10, 25, 100, 1600)
  pal <- colorBin("YlOrBr", domain = counties$RATE, bins = bins)

  rval() %>%
    mutate(popup = str_c("<strong>", CTYNAME, ", ", STABBR, "</strong>",
                         "<br/>",
                         round(RATE, digits = 2), " cases per 100,000 people",
                         "<br/>",
                         CASES, " cases total") %>%
             map(htmltools::HTML)) %>%
    leaflet() %>%
    addTiles() %>%
    setView(-97.50, 38.50, zoom = 4) %>%
    addResetMapButton() %>% 
    addEasyButton(easyButton(
      icon = "fas fa-trash", title = "Clear Selection",
      onClick = JS("function(btn, map){ Shiny.onInputChange('clear_selection_btn',  Math.random()); }"))) %>%
    addPolygons(label = ~popup,
                fillColor = ~pal(RATE),
                color = "#444444",
                weight = .5,
                smoothFactor = 0.5,
                opacity = .8,
                fillOpacity = 1,
                highlightOptions = highlightOptions(color = "white",
                                                    weight = 2,
                                                    bringToFront = FALSE),
                labelOptions = labelOptions(
                  style = list("font-weight" = "normal", padding = "3px 8px"),
                  textsize = "15px",
                  direction = "auto")) %>%
    addPolylines(data = states_dissolve, color = "black", opacity = .5, weight = .75) %>%
    addLegend(pal = pal,
              values = ~RATE,
              opacity = 1,
              title = "Cases per 100,000 people",
              position = "bottomright")

})
observe({
  updateSelectInput(session, "county_101", "Select County (or Equivalent):", 
                    choices = sort(counties[counties$STNAME == input$state_101,]$CTYNAME))
})

rval_lookup <- reactive({
  counties %>%
    filter(YEAR == 2018, STNAME == input$state_101)
})

observeEvent(input$county_101, {
  if (nchar(input$county_101) >1) {
    txt <- paste0(input$state_101)
  } else {
    txt <- paste0("No State Selected")
  }
  output$map_title_101 <- renderText({ 
    paste0("Map of 2018 Lyme Disease Incidence*: ", txt)
  })
})

output$map_101 <- leaflet::renderLeaflet({
  leaflet(options = leafletOptions(zoomControl = FALSE)) %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 4)
})

observeEvent(input$county_101,{
  
  state_lines <- rval_lookup() %>%
    filter(STNAME == input$state_101)
  
  counties_lines <- rval_lookup() %>%
    filter(CTYNAME == input$county_101)
  
  bbox <- st_bbox(state_lines) %>% 
    as.vector()
  
  bins <- c(0, 1, 25, 50, 100, 500)
  pal <- colorBin("YlOrBr", domain = rval_lookup()$RATE, bins = bins)
  
  leafletProxy("map_101", data = rval_lookup()) %>%
    clearShapes() %>%
    clearControls() %>%
    clearGroup(group = "County_lines") %>%
    clearGroup(group = "State_lines") %>%
    fitBounds(bbox[1], bbox[2], bbox[3], bbox[4]) %>%
    addPolygons(label = paste0(rval_lookup()$CTYNAME, ", ", rval_lookup()$STABBR),
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
                  direction = "auto",
                  group = "county")) %>%
    addPolylines(data = state_lines, color = "#000000", opacity = 1, weight = 1, group = "State_lines") %>%
    addPolylines(data = counties_lines, color = "#00FFFF", opacity = 1, weight = 2, group = "County_lines") %>%
    addLegend(pal = pal,
              values = ~RATE,
              opacity = .9,
              title = "Cases per 100,000 people",
              position = "bottomright")
})

df_cty <- as.data.frame(counties)
df_st <- cases_by_state
cases_us <- cases_by_state %>%
  group_by(YEAR) %>%
  summarise(CASES = sum(CASES))
pop_us <- cases_by_state %>%
  group_by(YEAR) %>%
  summarise(POP = sum(POP))
df_us <- cases_us %>%
  left_join(pop_us, c("YEAR" = "YEAR"))
df_us$RATE <- (df_us$CASES / df_us$POP) * 100000

rval_df_cty <- reactive({
  df_cty %>%
    filter(STNAME == input$state_101) %>%
    filter(CTYNAME == input$county_101)
})

rval_df_st <- reactive({
  df_st %>%
    filter(STNAME == input$state_101)
})

# df_balt <- df_cty %>%
#   filter(STNAME == "Maryland") %>%
#   filter(CTYNAME == "Baltimore County")
# 
# df_md <- df_st %>%
#   filter(STNAME == "Maryland")

output$comp_plot <- renderPlot({
  ggplot(data = rval_df_cty(), aes(x = YEAR, y = RATE)) + geom_line(aes(color = "County"), lwd = 1.5) + 
  geom_line(data = rval_df_st(), aes(x = YEAR, y = RATE, color = "State"), lwd = 1.5) + 
  geom_line(data = df_us, aes(x = YEAR, y = RATE, color = "US"), lwd = 1.5) +
    xlab("Year") +
    ylab("Incidence") + 
    labs(color = "Incidence") + 
    theme(axis.text = element_text(size = 15)) +
    theme(axis.title = element_text(size = 18)) +
    theme(legend.text = element_text(size = 15)) +
    theme(legend.title = element_text(size = 18))
})

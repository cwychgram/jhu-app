observe({
   updateSelectInput(session, "county", "Select County (or Equivalent):", 
                    choices = sort(counties[counties$STNAME == input$state,]$CTYNAME))
})

rval_geo <- reactive({
  counties %>%
    filter(STNAME == input$state) %>%
    filter(CTYNAME == input$county)
})

observeEvent(input$county, {
  if (nchar(input$county) >1) {
    txt <- paste0(input$county, ", ",input$state)
  } else {
    txt <- paste0("County, State")
  }
  output$map_title <- renderText(txt)
})

output$profile_map <- leaflet::renderLeaflet({
  leaflet() %>%
    addProviderTiles("CartoDB.Positron") %>%
    setView(-97.50, 38.50, zoom = 3)
})

output$county_plot <- renderPlotly({
  ggplot(data = rval_geo(), aes(x = YEAR, y = CASES)) +
    geom_bar(stat = "identity") +
    labs(x = "Year", y = "Cases")
  
  # plotly works but I like the blank plot ggplot shows before state/county selected
  # plotlyOutput works with ggplot code and makes it interactive (?)
  
  # df <- rval_geo() %>% as.data.frame()
  # 
  # x <- list(
  #   title = "<b>Year</b>"
  # )
  # y <- list(
  #   title = "<b>Cases</b>",
  #   tickformat = "digits"
  # )
  # p <- plot_ly(df, x = ~YEAR, y = ~CASES, type = 'bar')
  # p <- p %>% layout(xaxis = x, yaxis = y, autosize = F, width = 550, height = 300)
  # p
  
})

observeEvent(input$county,{

  # if (input$state == "Alaska") {
  #   states <- states %>% st_crop(states[states$NAME == "Alaska", ], xmin = -179.1473, ymin = 51.21986, xmax = -129.9742, ymax = 71.35256)
  # } 
  
  state_lines <- states %>%
    filter(STNAME == input$state)
  
  counties_lines <- counties %>%
    filter(STNAME == input$state)
  
  bbox <- st_bbox(state_lines) %>% 
    as.vector()
  
  leafletProxy("profile_map", data = state_lines) %>%
    clearShapes() %>%
    fitBounds(bbox[1], bbox[2], bbox[3], bbox[4]) %>%
    addPolygons(data = counties_lines,
                fillColor = "#E5E2E0",
                color = "#444444",
                label = paste0(counties_lines$CTYNAME, ", ", counties_lines$STABBR),
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
                  group = "state")) %>%
    addPolygons(data = rval_geo(),
                fillColor = "#E03C31",
                color = "#444444",
                label = paste0(rval_geo()$CTYNAME, ", ", rval_geo()$STABBR),
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
                  group = "county"))
})

rval_nlcd <- reactive ({
  counties_nlcd <- as.data.frame(counties_nlcd)
  counties_nlcd %>%
    filter(STNAME == input$state) %>%
    filter(CTYNAME == input$county) %>%
    rename(Class = CLASS, Percent = PCT)
})

output$plot_nlcd <- renderPlotly({
  
  pal <- c("#4569a2", "#ee0000", "#b3afa9", "#18652c", "#e3e3c3", "#dbcf38", "#aa7228", "#badbeb")
  
  # same plotly issue as above
  
  # x <- list(
  #   title = "<b>Land Cover Class</b>"
  # )
  # y <- list(
  #   title = "<b>Percent Cover</b>"
  # )
  # p <- plot_ly(rval_nlcd(), x = ~NLCD_CLASS, y = ~NLCD_PCT, type = 'bar', marker = list(color = pal))
  # p <- p %>% layout(xaxis = x, yaxis = y)
  # p
  
  ggplot(data = rval_nlcd(), aes(x = Class, y = Percent)) +
    geom_bar(stat = "identity", fill = pal) +
    labs(x = "Land Cover Class", y = "Percent Cover")
})

rval_forest <- reactive ({
  counties_edge <- as.data.frame(counties_edge)
  counties_edge %>%
    filter(STNAME == input$state) %>%
    filter(CTYNAME == input$county)
})

output$forest_edge <- renderText({
  round(rval_forest()$ED, digits = 2)
  
})

# output$forest_patch <- renderText({
#   round(rval_forest()$PATCHES_100HA, digits = 2)
#   
# })

output$fde <- renderText({
  round(rval_forest()$FDED, digits = 2)
  
})

rval_elev <- reactive ({
  counties_elev <- as.data.frame(counties_elev)
  counties_elev %>%
    filter(STNAME == input$state) %>%
    filter(CTYNAME == input$county)
})

output$elevation <- renderText({
  round(rval_elev()$MEAN, digits = 2)

})

rval_land <- reactive ({
  counties_lines <- as.data.frame(counties_lines)
  counties_lines %>%
    filter(STNAME == input$state) %>%
    filter(CTYNAME == input$county)
})

output$area <- renderText({
  format(round(((rval_land()$ALAND + rval_land()$AWATER) * 0.000001), digits = 2), big.mark = ",")
  
})

rval_soil <- reactive ({
  counties_soil <- as.data.frame(counties_soil)
  counties_soil %>%
    filter(STNAME == input$state) %>%
    filter(CTYNAME == input$county)
})

output$soil_order <- renderText({
  rval_soil()$MAJ_TXT
  
})

rval_tick <- reactive ({
  counties_tick <- as.data.frame(counties_tick)
  counties_tick %>%
    filter(STNAME == input$state) %>%
    filter(CTYNAME == input$county)
})

output$tick_status <- renderText({
  rval_tick()$EITHER
  
})

# rval_temp <- reactive ({
#   counties_temp <- as.data.frame(counties_temp)
#   counties_temp %>%
#     filter(STNAME == input$state) %>%
#     filter(CTYNAME == input$county)
# })
# 
# output$temperature <- renderText({
#   rval_temp()$Value
#   
# })
# 
# rval_precip <- reactive ({
#   counties_precip <- as.data.frame(counties_precip)
#   counties_precip %>%
#     filter(STNAME == input$state) %>%
#     filter(CTYNAME == input$county)
# })
# 
# output$precipitation <- renderText({
#   rval_precip()$Value
#   
# })

rval_pop <- reactive ({
  counties <- counties %>% filter(YEAR == 2018) %>% as.data.frame()
  counties %>%
    filter(STNAME == input$state) %>%
    filter(CTYNAME == input$county)
})

output$pop <- renderText({
  format(rval_pop()$POP, big.mark = ",")
  
})

output$pop_density <- renderText({
  format(round(rval_pop()$POPDENSITY, digits = 2), big.mark = ",")
  
})

rval_nchs <- reactive ({
  counties_nchs <- as.data.frame(counties_nchs)
  counties_nchs %>%
    filter(STNAME == input$state) %>%
    filter(CTYNAME == input$county)
})

output$urban_rural <- renderText({
  rval_nchs()$CODE_TXT
  
})
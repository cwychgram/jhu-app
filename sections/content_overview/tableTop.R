# this was for setting zoom based on centroid, but bbox seems better for shapes of varying sizes
# however there's an issue with Alaska's bbox. The Aleutians West Census Area wraps around to another map 
# this is a problem when selecting Alaska on the County Profile
# counties$centroid <- st_centroid(counties)
# counties$centroid <- st_coordinates(counties$centroid)
# counties$lat <- counties$centroid[, 2]
# counties$long <- counties$centroid[, 1]

# convert to df for tables

counties_df <- as.data.frame(counties)
counties_df <- counties_df %>% rename(Cases = CASES, Rate = RATE, County = CTYNAME, State = STNAME, Year = YEAR)
counties_df$Rate <- round(counties_df$Rate, digits = 2)

cases_by_state$RATE <- round(cases_by_state$RATE, digits = 2)

# same as above
# states$centroid <- st_centroid(states)
# states$centroid <- st_coordinates(states$centroid)
# states$lat <- states$centroid[, 2]
# states$long <- states$centroid[, 1]

states <- states%>%
  left_join(cases_by_state, c("STATEFP" = "STATEFP"))

states_df <- as.data.frame(states)

top_counties_cases <- function(){
  counties_df %>%
    filter(Year == input$year) %>% 
    top_n(100, Cases) %>%
    arrange(desc(Cases))
}

output$table_top_counties_cases <- DT::renderDT({
  top_counties_cases() %>% 
    select(County, State, Year, Cases, Rate) %>%
    arrange(desc(Cases))
}, selection = list(mode = "single"), options = list(lengthChange = FALSE))

top_counties_rate <- function(){
  counties_df %>% 
    filter(Year == input$year) %>% 
    top_n(100, Rate) %>%
    arrange(desc(Rate))
}

output$table_top_counties_rate <- DT::renderDT({
  top_counties_rate() %>% 
    select(County, State, Year, Cases, Rate) %>%
    arrange(desc(Rate))
}, selection = list(mode = "single"), options = list(lengthChange = FALSE))

top_states_cases <- function(){
  states_df %>%
    filter(YEAR == input$year) %>% 
    top_n(50, CASES) %>%
    arrange(desc(CASES))
}

output$table_top_states_cases <- DT::renderDT({
  df <- states_df %>% filter(YEAR == input$year)
  top_states_cases() %>% 
    mutate(Percent_Of_Total = round((CASES/sum(df$CASES) * 100), digits = 2)) %>%
    rename(Cases = CASES, Rate = RATE, State = STNAME, Year = YEAR) %>%
    select(State, Year, Cases, Percent_Of_Total) %>%
    arrange(desc(Cases))
}, selection = list(mode = "single"), options = list(lengthChange = FALSE))

top_states_rate <- function(){
  states_df %>%
    filter(YEAR == input$year) %>% 
    top_n(10, RATE) %>%
    arrange(desc(RATE))
}

output$table_top_states_rate <- DT::renderDT({
  top_states_rate() %>% 
    rename(Cases = CASES, Rate = RATE, State = STNAME, Year = YEAR) %>%
    select(State, Year, Cases, Rate) %>%
    arrange(desc(Rate))
}, selection = list(mode = "single"), options = list(lengthChange = FALSE))

observeEvent(input$table_top_counties_cases_rows_selected, {
  
  selectedRow <- input$table_top_counties_cases_rows_selected
  
  selectedCounty <- top_counties_cases()[selectedRow, "GEOID"]
  
  location <- counties %>%
    filter(GEOID == selectedCounty)
  
  bbox <- st_bbox(location) %>% 
    as.vector()
  
  selectedCounty_lines <- counties %>% filter(GEOID == selectedCounty)
  
  leafletProxy("map_cases") %>%
    clearGroup(group = "selectedCounty") %>%
    clearGroup(group = "selectedState") %>%
    fitBounds(bbox[1], bbox[2], bbox[3], bbox[4]) %>%
    addPolylines(data = selectedCounty_lines, color = "#00FFFF", opacity = 1, weight = 2, group = "selectedCounty")
  
})

observeEvent(input$table_top_counties_rate_rows_selected, {

  selectedRow <- input$table_top_counties_rate_rows_selected

  selectedCounty <- top_counties_rate()[selectedRow, "GEOID"]

  location <- counties %>%
    filter(GEOID == selectedCounty)
  
  bbox <- st_bbox(location) %>% 
    as.vector()

  selectedCounty_lines <- counties %>% filter(GEOID == selectedCounty)

  leafletProxy("map_cases") %>%
    clearGroup(group = "selectedCounty") %>%
    clearGroup(group = "selectedState") %>%
    fitBounds(bbox[1], bbox[2], bbox[3], bbox[4]) %>%
    addPolylines(data = selectedCounty_lines, color = "#00FFFF", opacity = 1, weight = 2, group = "selectedCounty")
})

observeEvent(input$table_top_states_cases_rows_selected, {

  selectedRow <- input$table_top_states_cases_rows_selected

  selectedState <- top_states_cases()[selectedRow, "STATEFP"]
  
  location <- states %>%
    filter(STATEFP == selectedState)
  
  bbox <- st_bbox(location) %>% 
    as.vector()

  selectedState_lines <- states_dissolve %>% filter(STATEFP == selectedState)

  leafletProxy("map_cases") %>%
    clearGroup(group = "selectedState") %>%
    clearGroup(group = "selectedCounty") %>%
    fitBounds(bbox[1], bbox[2], bbox[3], bbox[4]) %>% 
    addPolylines(data = selectedState_lines, color = "#00FFFF", opacity = 1, weight = 3, group = "selectedState")
})

observeEvent(input$table_top_states_rate_rows_selected, {
  
  selectedRow <- input$table_top_states_rate_rows_selected
  
  selectedState <- top_states_rate()[selectedRow, "STATEFP"]
  
  location <- states %>%
    filter(STATEFP == selectedState)
  
  bbox <- st_bbox(location) %>% 
    as.vector()
  
  selectedState_lines <- states_dissolve %>% filter(STATEFP == selectedState)
  
  leafletProxy("map_cases") %>%
    clearGroup(group = "selectedState") %>%
    clearGroup(group = "selectedCounty") %>%
    fitBounds(bbox[1], bbox[2], bbox[3], bbox[4]) %>% 
    addPolylines(data = selectedState_lines, color = "#00FFFF", opacity = 1, weight = 3, group = "selectedState")
})

# observer for easyButton on the overview map

observeEvent(input$clear_selection_btn, {
  leafletProxy("map_cases") %>%
    clearGroup(group = "selectedCounty") %>%
    clearGroup(group = "selectedState")
})
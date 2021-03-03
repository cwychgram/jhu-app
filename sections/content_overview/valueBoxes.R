output$total_cases <- renderText({ 
  df <- cases_by_state %>% filter(YEAR == input$year)
  comma(sum(df$CASES))
})

output$subtitle <- renderText({ 
  paste0(h4("Reported Cases in ", input$year))
})
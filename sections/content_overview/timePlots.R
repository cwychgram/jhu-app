output$plot_historical_cases <- renderPlotly({
  df <- cases_by_state %>%
    group_by(YEAR) %>%
    summarise(annual_total = sum(CASES))
  df$YEAR <- as.numeric(df$YEAR)
  x <- list(
    title = "<b>Year</b>"
  )
  y <- list(
    title = "<b>Cases</b>",
    tickformat = "digits",
    range = c(-5000, 45000)
  )
  p <- plot_ly(df, x = ~YEAR, y = ~annual_total, mode = 'lines', line = list(color = "#3d9970"), type = 'scatter')
  p <- p %>% layout(xaxis = x, yaxis = y)
  p
})

output$plot_seasonal_cases <- renderPlotly({
  x <- list(
    title = "<b>Month</b>"
  )
  y <- list(
    title = "<b>Cases</b>",
    tickformat = "digits"
  )
  p <- plot_ly(month_onset, x = ~Month, y = ~Cases, type = 'bar', marker = list(color = 'rgb(61, 153, 112)'))
  p <- p %>% layout(xaxis = x, yaxis = y)
  p
})

output$plot_age_sex_cases <- renderPlotly({
  x <- list(
    title = "<b>Age Group</b>"
  )
  y <- list(
    title = "<b>Cases</b>",
    tickformat = "digits"
  )
  
  p <- plot_ly(age_sex, x = ~AgeGroup, y = ~Male, name = 'Male', type = 'bar', marker = list(color = 'rgb(61, 153, 112)'))
  p <- p %>% add_trace(y = ~Female, name = 'Female', type = 'bar', marker = list(color = 'rgb(253, 153, 41)'))
  p <- p %>% layout(xaxis = x, yaxis = y)
  p
})

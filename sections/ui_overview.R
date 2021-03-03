tab_overview <- fluidPage(
  useShinydashboard(),
    fluidRow(
      tags$style(HTML(
      ".box.box-solid.box-success > .box-header {
      color: #fff;
      background-color: #3d9970;
      }")),
      tags$style('.nav-tabs-custom .nav-tabs li.active {border-top-color: #3d9970;}"'),
      tags$style(type = "text/css", 
                 ".irs-grid-pol.small {height: 0px;}",
                 ".irs-grid-text:nth-child(-2n+18) {color: white}",
                 ".irs-grid-text:nth-child(2n+20) {color: white}",
                 ".irs-grid-pol:nth-of-type(-n+18) {background:white}",
                 ".irs-grid-pol:nth-of-type(n+18) {background:white}",
                 ".irs-min, .irs-max {display: none;}",
                 "h4, .h4 {
                   font-size: 20px;
                   font-family: Arial;
                 }",
                 "label {
                   display: inline-block;
                   max-width: 100%;
                   margin-bottom: 0px;
                   font-weight: normal;
                   font-family: Arial;
                   font-size: 18px;
                 }",
                 "body {
                   font-family: Arial;
                   font-size: 15px;
                   line-height: 1.19;
                   color: #333333;
                 }",
                 ".box-header .box-title {
                   display: inline-block;
                   font-size: 18px;
                   font-family: Arial;
                   margin: 0;
                   line-height: 1;
                 }",
                 ".irs-from, .irs-to, .irs-single {
                   color: #000000;
                   font-size: 13px;
                   line-height: 1.333;
                   text-shadow: none;
                   padding: 1px 3px;
                   border-radius: 3px;
                   -moz-border-radius: 3px;
                 }",
                 ".irs-from, .irs-to, .irs-single {
                   color: #000000;
                   font-size: 13px;
                   font-weight: bold;
                   line-height: 1.333;
                   text-shadow: none;
                   padding: 1px 3px;
                   background: #fed98e;
                   border-radius: 3px;
                   -moz-border-radius: 3px;
                 }",
                 ".irs-bar {
                   height: 8px;
                   top: 25px;
                   border-top: 1px solid #FFFFFF;
                   border-bottom: 1px solid #FFFFFF;
                   background: #FFFFFF;
                 }",
                 ".irs-bar-edge {
                   height: 8px;
                   top: 25px;
                   width: 14px;
                   border: 1px solid #ffffff;
                   border-right: 0;
                   background: #FFFFFF;
                   border-radius: 16px 0 0 16px;
                   -moz-border-radius: 16px 0 0 16px;
               }",
                 ".irs-slider {
                 top: 20px;
                 width: 20px;
                 height: 20px;
                 #border: 1px solid #AAA;
                 background: #fed98e;
                 border-radius: 27px;
                 -moz-border-radius: 27px;
                 box-shadow: 0 0 black;
                 cursor: pointer;
               }",
                 "irs-active-slider, .irs-slider:hover {
                 background: #fed98e;
               }",
                 ".irs-grid-text {
                 position: absolute;
                 left: 0;
                 white-space: nowrap;
                 text-align: center;
                 font-size: 13px;
                 line-height: 13px;
                 padding: 0px;
                 color: #000;
               }",
                 ".dataTables_wrapper .dataTables_paginate .paginate_button {
                   box-sizing: border-box;
                   display: inline-block;
                   min-width: 1.2em;
                   padding: .5em .5em;
                   margin-left: 2px;
                   text-align: center;
                   text-decoration: none !important;
                   cursor: pointer;
                   *cursor: hand;
                   color: #333 !important;
                     border: 1px solid transparent;
                   border-radius: 2px;
                 }",
                 ".small-box {height: 90px}",
                 ".nav-tabs-custom {
                  margin-bottom: 20px;
                  background: #fff;
                  box-shadow: 0 1px 1px rgba(0,0,0,.1);
                  border-radius: 3px;
                  border: solid 1px #3d9970;
                  }"
                 ),
      column(8, 
             fluidRow(
               column(6, 
                      box(
                        width = 12,
                        height = 90,
                        background = "olive",
                        sliderInput("year",
                                    label = "Select Year", 
                                    value = 2018, 
                                    min = 2000, 
                                    max = 2018, 
                                    sep = ""
                        )
                      )
               ),
               column(6, 
                      valueBox(
                        width = 12,
                        uiOutput("total_cases"), uiOutput("subtitle"), icon = icon("users"), color = "olive"
                      )
               )
             ),
             fluidRow(
               column(12, 
                      box(
                        title = "Map of Reported Lyme Disease Cases per 100,000 People",
                        solidHeader = TRUE,
                        status = "success",
                        width = 12,
                        height = 480,
                        leaflet::leafletOutput("map_cases", height = 420)
                      )
               )
             )
      ), 
      column(4, 
             tabBox(
               width = 12,
               height = 590,
               tabPanel(
                 "Top 100 Counties by Cases",
                 DT::DTOutput("table_top_counties_cases")
               ),
               tabPanel(
                 "Top 100 Counties by Rate",
                 DT::DTOutput("table_top_counties_rate")
               ),
               tabPanel(
                 "Top 10 States by Cases",
                 DT::DTOutput("table_top_states_cases")
               ),
               tabPanel(
                 "Top 10 States by Rate",
                 DT::DTOutput("table_top_states_rate")
               )
             )
      )
    ),
  fluidRow(
    column(12,
           fluidRow(
             column(4,
                    box(
                      solidHeader = TRUE,
                      status = "success",
                      width = 12,
                      height = 275,
                      title = "Confirmed Lyme Disease Cases by Month of Onset, 2008-2018",
                      plotlyOutput("plot_seasonal_cases", height = "200px")
                    )
             ),
             column(4,
                    box(
                      solidHeader = TRUE,
                      status = "success",
                      width = 12,
                      height = 275,
                      title = "Confirmed Lyme Disease Cases by Age and Sex, 2001-2018",
                      plotlyOutput("plot_age_sex_cases", height = "200px")
                    )
             ),
             column(4,
                    box(
                      solidHeader = TRUE,
                      status = "success",
                      width = 12,
                      height = 275,
                      title = "Reported Lyme Disease Cases, 2000-2018",
                      plotlyOutput("plot_historical_cases", height = "200px")
                    )
             )
           )
    )
  )
)

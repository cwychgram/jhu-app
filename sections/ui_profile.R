tab_profile <- fluidPage(
  sidebarLayout(
    
    sidebarPanel(
      width = 2,
      selectInput("state", 
                "Select State:", 
                choices = c(" ", sort(unique(counties$STNAME)))
                ),
    
      selectInput("county", 
                "Select County:", 
                choices = NULL
                )
    ),
  
    mainPanel(
      useShinydashboard(),
      width = 10,
      fluidRow(
        column(6,
               fluidRow(
                 column(12,
                        box(
                          solidHeader = TRUE,
                          status = "success",
                          width = 12,
                          height = 375,
                          title = uiOutput("map_title"),
                          leafletOutput("profile_map", height = "315px", width = "100%")
                        )
                 )
               )
        ),
        column(6,
               fluidRow(
                 column(12,
                        box(
                          solidHeader = TRUE,
                          status = "success",
                          width = 12,
                          height = 375,
                          title = "Reported Cases of Lyme Disease, 2000-2018",
                          plotlyOutput("county_plot", height = "315px", width = "100%")
                        )
                 )
               )
        )
      ),
      fluidRow(
        column(12,
               # align = "center",
               span(tags$b("Eastern/Western Blacklegged Tick Status"), style = "color:#000000; font-size: 30px; font-family: Arial"), 
               br(),
               br()
               # tags$hr(style = "border-color: #000000;", width = "450px")
        )
        
      ),
      fluidRow(
               valueBox(
                 width = 3,
                 uiOutput("tick_status"), " ", icon = icon(""), color = "yellow"
               )
      ),
      fluidRow(
        column(12,
               # align = "center",
               span(tags$b("Geography and Land Use"), style = "color:#000000; font-size: 30px; font-family: Arial"), 
               # tags$hr(style = "border-color: #000000;", width = "450px")
               br(),
               br()
        )
        
      ),
      fluidRow(
        column(6,
               fluidRow(
                 valueBox(
                   width = 6,
                   uiOutput("area"), h5("Total Area (sq km)"), icon = icon(""), color = "olive"
                 ),
                 valueBox(
                   width = 6,
                   uiOutput("forest_edge"), h5("Forest Edge Density (m/Ha)"), icon = icon(""), color = "olive"
                 )
               ),
               fluidRow(
                 valueBox(
                   width = 6,
                   uiOutput("elevation"), h5("Average Elevation (m)"), icon = icon(""), color = "olive"
                 ),
                 valueBox(
                   width = 6,
                   uiOutput("forest_patch"), h5("Forest Patch Density (Patches/100 Ha)"), icon = icon(""), color = "olive"
                 )
               ),
               fluidRow(
                 valueBox(
                   width = 6,
                   uiOutput("soil_order"), h5("Dominant Soil Taxonomy Order"), icon = icon(""), color = "olive"
                 ),
                 valueBox(
                   width = 6,
                   uiOutput("forest_size"), h5("Average Forest Patch Size (Ha)"), icon = icon(""), color = "olive"
                 )
               )

        ),
        column(6,
               box(
                 solidHeader = TRUE,
                 status = "success",
                 height = 310,
                 width = 12,
                 title = "Percent Land Cover by Class",
                 plotlyOutput("plot_nlcd", height = "250px", width = "100%")
               )
        )
      ),
      fluidRow(
        column(12,
               # align = "center",
               span(tags$b("Climate"), style = "color:#000000; font-size: 30px; font-family: Arial"), 
               # tags$hr(style = "border-color: #000000;", width = "450px")
               br(),
               br()
        )
        
      ),
      fluidRow(
        valueBox(
          width = 3,
          uiOutput("temperature"), h5("Mean Temperature (F) - 2018"), icon = icon(""), color = "blue"
          ),
        valueBox(
          width = 3,
          uiOutput("precipitation"), h5("Total Precipitation (in) - 2018"), icon = icon(""), color = "blue"
          )
      ),
      fluidRow(
        column(12,
               # align = "center",
               span(tags$b("Population and Sociodemographics"), style = "color:#000000; font-size: 30px; font-family: Arial"), 
               # tags$hr(style = "border-color: #000000;", width = "450px")
               br(),
               br()
        )
        
      ),
      fluidRow(
        valueBox(
          width = 3,
          uiOutput("pop"), h5("Population"), icon = icon(""), color = "red"
        ),
        valueBox(
          width = 3,
          uiOutput("pop_density"), h5("Population Density (people/sq mi)"), icon = icon(""), color = "red"
        ),
        valueBox(
          width = 3,
          uiOutput("urban_rural"), h5("Urban/Rural Classification"), icon = icon(""), color = "red"
        )
      )
    )
  )
)

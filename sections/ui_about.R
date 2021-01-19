
tab_about <- fluidPage(
  useShinydashboardPlus(),
  # fluidRow(
  #   box(
  #     height = 140,
  #     width = 3,
  #     background = "olive",
  #     span(style = "color:#fecc5c; font-size:20px; font-family: Arial", "Under Construction:"),
  #     br(),
  #     span(style = "color:#FFFFFF; font-size:20px; font-family: Arial", "The 'About Us' section will include information about our project, team, and project funders. It will include an email address/contact form where visitors can send questions/feedback.")
  #   )
  # ),
  br(),
  fluidRow(
    column(3
           ),
    column(6,
           fluidRow(
             column(4,
                    align = "center",
                    # span(img(src = "Spatial_Science_for_Public_Health Center_Lockup.vertical.black.png", width = "275", height = "300"))
                    span(tags$b("[Spatial Science logo]"), style = "color:#000000; font-size:15px; font-family: Arial")
             ),
             column(4,
                    align = "center",
                    span(tags$b("[Lyme Center logo]"), style = "color:#000000; font-size:15px; font-family: Arial")
             ),
             column(4,
                    align = "center",
                    span(tags$b("[Institute logo]"), style = "color:#000000; font-size:15px; font-family: Arial")
             )
           )
           ),
    column(3
           )
  ),
  br(),
  br(),
  br(),
  fluidRow(
    column(12,
           align = "center",
           span(tags$b("About Us"), style = "color:#000000; font-size:40px; font-family: Arial"), 
           tags$hr(style = "border-color: #000000;", width = "600px")
           )
  ),
  br(),
  fluidRow(
    column(2
           ),
    column(8,
           widgetUserBox(
             width = 4,
             title = "Person",
             subtitle = "Title",
             type = NULL,
             src = 'about-person.png',
             color = "olive",
             closable = FALSE,
             collapsible = FALSE,
             footer = "Description"
           ),
           widgetUserBox(
             width = 4,
             title = "Person",
             subtitle = "Title",
             type = NULL,
             src = 'about-person.png',
             color = "olive",
             closable = FALSE,
             collapsible = FALSE,
             footer = "Description"
           ),
           widgetUserBox(
             width = 4,
             title = "Person",
             subtitle = "Title",
             type = NULL,
             src = 'about-person.png',
             color = "olive",
             closable = FALSE,
             collapsible = FALSE,
             footer = "Description"
           )
    ),
    column(2
           )
  ),
  br(),
  fluidRow(
    column(2
    ),
    column(8,
           widgetUserBox(
             width = 4,
             title = "Person",
             subtitle = "Title",
             type = NULL,
             src = 'about-person.png',
             color = "olive",
             closable = FALSE,
             collapsible = FALSE,
             footer = "Description"
           ),
           widgetUserBox(
             width = 4,
             title = "Person",
             subtitle = "Title",
             type = NULL,
             src = 'about-person.png',
             color = "olive",
             closable = FALSE,
             collapsible = FALSE,
             footer = "Description"
           ),
           widgetUserBox(
             width = 4,
             title = "Person",
             subtitle = "Title",
             type = NULL,
             src = 'about-person.png',
             color = "olive",
             closable = FALSE,
             collapsible = FALSE,
             footer = "Description"
           )
    ),
    column(2
    )
  ),
  br(),
  br(),
  br(),
  fluidRow(
    column(12,
           align = "center",
           span(tags$b("Contact Us"), style = "color:#000000; font-size:40px; font-family: Arial"), 
           tags$hr(style = "border-color: #000000;", width = "600px"),
           br(),
           span(tags$b("[email address/form]"), style = "color:#000000; font-size:15px; font-family: Arial"),
           br(),
           br()
           )
  )
)
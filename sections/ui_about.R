tab_about <- fluidPage(
  useShinydashboardPlus(),
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
    column(3
    ),
    column(6,
           style = "background-color: rgb(61,153,112, .25)",
           align = "justify",
           span(style = "color:#000000; font-size:20px; font-family: Arial; line-height: 1.5;", "The Johns Hopkins Lyme and Tick-borne Disease Dashboard Initiative is led by the Spatial Science for Public Health Center, in close collaboration with the Lyme Disease Research Center and the Lyme and Tick-borne Illness Research and Education Institute. [TBD -- Move mission statement here or keep separate]")
    ),
    column(3
    )
  ),
  br(),
  br(),
  fluidRow(
    column(2
    ),
    column(8,
           widgetUserBox(
             width = 4,
             title = "Frank C. Curriero, PhD",
             subtitle = "Director, Johns Hopkins Spatial Science for Public Health Center",
             type = NULL,
             boxToolSize = "lg",
             src = 'curriero.jpg',
             color = "olive",
             closable = FALSE,
             collapsible = FALSE,
             footer = "Dr. Curriero is a Professor in the Department of Epidemiology with a joint appointment in the Departments of Biostatistics at the Johns Hopkins Bloomberg School of Public Health.  Dr. Curriero's research focus is on the development and application of spatial and spatial-temporal statistical methods in the public health sciences.  Much of his current work involves translating methods of spatial science involving spatial data, GIS and spatial statistics for building research capacity in wide ranging health research applications."
           ),
           widgetUserBox(
             width = 4,
             title = "John Aucott, MD",
             subtitle = "Director, Johns Hopkins Lyme Disease Research Center",
             type = NULL,
             boxToolSize = "lg",
             src = 'aucott.jpg',
             color = "olive",
             closable = FALSE,
             collapsible = FALSE,
             footer = "Dr. Aucott is Associate Professor of Medicine, Johns Hopkins University School of Medicine, Board certified in Infectious Diseases, and a clinical researcher who sees patients for Lyme disease and complications of Lyme disease."
           ),
           widgetUserBox(
             width = 4,
             title = "Arturo Casadevall, MD, PhD / TBD",
             subtitle = "Acting Director, Johns Hopkins Lyme and Tick-borne Illness Research and Education Institute",
             type = NULL,
             boxToolSize = "lg",
             src = 'casadevall.jpg',
             color = "olive",
             closable = FALSE,
             collapsible = FALSE,
             footer = "Dr. Arturo Casadevall is a professor of medicine at the Johns Hopkins School of Medicine. He holds a joint appointment in molecular microbiology and immunology at the Johns Hopkins Bloomberg School of Public Health. His research focuses on how microbes cause disease and how the immune system defends itself. Dr. Casadevall serves as chair of the W. Harry Feinstone Department of Molecular Microbiology and Immunology at the Johns Hopkins Bloomberg School of Public Health."
           )
    ),
    column(2
    )
  ),
  br(),
  br(),
  fluidRow(
    column(12,
           align = "center",
           span(tags$b("Other Team Members"), style = "color:#000000; font-size:35px; font-family: Arial"), 
           tags$hr(style = "border-color: #000000;", width = "600px")
    )
  ),
  br(),
  fluidRow(
    column(3
           ),
    column(6,
           tags$div(tags$ul(
             tags$li("Anne E. Corrigan, MS, Senior Research Data Analyst, Johns Hopkins Spatial Science for Public Health Center"),
             tags$li("Anton Kvit, ScM, Senior Research Data Analyst, Johns Hopkins Spatial Science for Public Health Center"),
             tags$li("Alison Rebman, MPH, Co-Director for Clinical and Epidemiological Research, Johns Hopkins Lyme Disease Research Center"),
             tags$li("Timothy M. Shields, MA, Associate Director, Johns Hopkins Spatial Science for Public Health Center"),
             tags$li("Cara Wychgram, MPP, Research Data Analyst, Johns Hopkins Spatial Science for Public Health Center"), style = "color:#000000; font-size:25px; font-family: Arial; line-height: 1.5;")
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
           span(tags$b("Partners"), style = "color:#000000; font-size:35px; font-family: Arial"), 
           tags$hr(style = "border-color: #000000;", width = "600px")
    )
  ),
  br(),
  fluidRow(
    column(3
    ),
    column(6,
           tags$div(tags$ul(
             tags$li("..."),
             tags$li("..."),
             tags$li("..."), style = "color:#000000; font-size:25px; font-family: Arial; line-height: 1.5;")
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
           span(tags$b("Funders"), style = "color:#000000; font-size:35px; font-family: Arial"), 
           tags$hr(style = "border-color: #000000;", width = "600px")
    )
  ),
  br(),
  fluidRow(
    column(3
    ),
    column(6,
           tags$div(tags$ul(
             tags$li("..."),
             tags$li("..."),
             tags$li("..."), style = "color:#000000; font-size:25px; font-family: Arial; line-height: 1.5;")
           )
    ),
    column(3
    )
  )
)
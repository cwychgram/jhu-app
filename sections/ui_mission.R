tab_mission <- fluidPage(
  fluidRow(
    column(2
    ),
    column(8,
           align = "center",
           span(tags$b("Mission Statement"), style = "color:#000000; font-size:40px; font-family: Arial"), 
           tags$hr(style = "border-color: #000000;", width = "600px"),
           br(),
    ),
    column(2
           )
  ),
  br(),
  br(),
  fluidRow(
    column(2
    ),
    column(8,
           br(),
           style = "background-color: rgb(61,153,112, .25)",
           align = "justify",
           span(style = "color:#000000; font-size:25px; font-family: Arial; line-height: 1.5;", "The increasing incidence and geographic spread of Lyme and other tick-borne diseases are global public health problems. Many aspects of these diseases, including their true burden, are not fully understood and remain active areas of research. The Johns Hopkins Lyme and Tick-Borne Disease Dashboard Initiative is a data-driven public health tool and resource that tracks and contextualizes tick-borne diseases through a geographic lens. Based on a One Health approach, it features a comprehensive set of mapped data layers and provides general information on tick-borne diseases, while also highlighting data limitations and gaps in knowledge. The dashboard initiative is further enhanced to be interactive with the ability to download data, visualize the spread of diseases over space and time, and perform comparative assessments between different geographies. With this resource we aim to advance the understanding of the geography of Lyme and other tick-borne diseases, improve awareness, and motivate and support future research and research communication."),
           br(),
           br()
    ),
    column(2
    )
  )
)
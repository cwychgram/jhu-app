tab_other <- fluidPage(
  fluidRow(
    column(3
    ),
    column(6,
           fluidRow(
             column(12,
                    align = "center",
                    span(tags$b("Other Resources"), style = "color:#000000; font-size:40px; font-family: Arial"),
                    br(),
                    br(),
             )
           ),
           fluidRow(
             column(12,
                    box(
                      width = 12,
                      status = "success",
                      tags$div(tags$ul(
                        tags$li(a(href = "https://www.cdc.gov/ticks/index.html", "Centers for Disease Control and Prevention - Ticks")),
                        tags$li(a(href = "https://www.clydrn.ca/about-the-network/", "Canadian Lyme Disease Research Network")),
                        tags$li(a(href = "https://www.canada.ca/en/public-health/services/diseases/lyme-disease.html", "Government of Canada - Lyme Disease")),
                        tags$li(a(href = "https://tickencounter.org/", "University of Rhode Island TickEncounter Resource Center")),
                        tags$li(a(href = "https://thangamani-lab.com/ny-tick-results", "New York Tick Surveillance Dashboard")), 
                        tags$li(a(href = "https://www.caryinstitute.org/our-expertise/disease-ecology/lyme-tick-borne-disease", "Cary Institute of Ecosystem Studies - Lyme & Tick-Borne Disease")), 
                        tags$li(a(href = "https://ecoepidemiologylab.e3b.columbia.edu/", "Columbia University Eco-Epidemiology Lab")), style = "color:#000000; font-size:30px; font-family: Arial; line-height: 1.5;")
                      )
                    )
             )
           )
    ),
    column(3
    )
  )
)
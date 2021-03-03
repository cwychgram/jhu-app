tab_research <- fluidPage(
  fluidRow(
    column(3
    ),
    column(6,
           fluidRow(
             column(12,
                    align = "center",
                    span(tags$b("Research"), style = "color:#000000; font-size:40px; font-family: Arial"),
                    br(),
                    br(),
             )
           ),
           fluidRow(
             column(12,
                    box(
                      width = 12,
                      status = "success",
                      attachmentBlock(
                        a(href = "https://geospatialhealth.net/index.php/gh/article/view/195", span(tags$b("The utility of 'Google Trends' for epidemiological research: Lyme disease as an example"), style = "color:#000000; font-size:20px; font-family: Arial")),
                        src = "https://geospatialhealth.net/public/site/images/mikimos/minicover_gh.jpg",
                        br(),
                        "Geospatial Health",
                        br(),
                        "Internet search engines have become an increasingly popular resource for accessing health-related information. The key words used as well as the number and geographic location of searches can provide trend data, as have recently been made available by Google Trends. We report briefly on exploring this resource using Lyme disease as an example because it has well-described seasonal and geographic patterns..."
                      )
                    )
             )
           )
    ),
    column(3
    )
  )
)
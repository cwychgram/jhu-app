tab_news <- fluidPage(
  tags$style(type = "text/css", 
             ".attachment-block {
             border: 1px solid #ffffff;
             padding: 5px;
             margin-bottom: 10px;
             background: #ffffff;
             }",
             ".attachment-block .attachment-text {
               color: #000000;
             }",
             "a {
              color: #000000;
              text-decoration: none;
             }", 
             "a:link {
              color: #000000;
              text-decoration: none;
             }", 
             "a:visited {
              color: #000000;
              text-decoration: none;
             }",
             "a:hover {
              color: #000000;
              text-decoration: underline;
             }",
             "a:active {
              color: #000000;
              text-decoration: underline;
             }"
             ),
  fluidRow(
    column(2
           ),
    column(8,
           fluidRow(
             column(12,
                    align = "center",
                    span(tags$b("In the News"), style = "color:#000000; font-size:40px; font-family: Arial"),
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
                        a(href = "https://www.rollingstone.com/culture/culture-features/climate-change-risks-infectious-diseases-covid-19-ebola-dengue-1098923/", span(tags$b("How Climate Change Is Ushering in a New Pandemic Era"), style = "color:#000000; font-size:20px; font-family: Arial")),
                        src = "https://www.rollingstone.com/wp-content/uploads/2020/12/R1347_FEA_COVID_Gcrop.jpg",
                        br(),
                        "Rolling Stone",
                        br(),
                        "A warming world is expanding the range of deadly diseases and risking an explosion of new zoonotic pathogens from the likes of bats, mosquitoes, and ticks."
                      )
                    )
             )
           )
    ),
    column(2
           )
  )
)
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
    column(3
           ),
    column(6,
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
                        a(href = "https://www.sciencenews.org/article/ticks-animals-skinks-lyme-disease-united-states-south", span(tags$b("The Animals That Ticks Bite in the U.S. South Can Impact Lyme Disease Spread"), style = "color:#000000; font-size:20px; font-family: Arial")),
                        src = "https://cdn.pixabay.com/photo/2012/07/10/21/55/skink-52274_1280.jpg",
                        br(),
                        "Science News",
                        br(),
                        "In the South, ticks attach more often to skinks, which don't pass on Lyme bacteria as well as mice."
                      ),
                      attachmentBlock(
                        a(href = "https://www.caryinstitute.org/news-insights/press-release/new-study-identifies-bird-species-could-spread-ticks-and-lyme-disease#:~:text=Birds%20play%20an%20underrecognized%20role,shifting%20due%20to%20climate%20change.", span(tags$b("New Study Identifies Bird Species That Could Spread Lyme Disease"), style = "color:#000000; font-size:20px; font-family: Arial")),
                        src = "https://www.caryinstitute.org/sites/default/files/public/styles/wysiwyg_max_width/public/2021-01/fyn_kynd_robin_fotor.jpg",
                        br(),
                        "Cary Institute of Ecosystem Studies",
                        br(),
                        "Birds play an underrecognized role in spreading tick-borne disease due to their capacity for long-distance travel and tendency to split their time in different parts of the world - patterns that are shifting due to climate change. Knowing which bird species are able to infect ticks with pathogens can help scientists predict where tick-borne diseases might emerge and pose a health risk to people."
                      ),
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
    column(3
           )
  )
)
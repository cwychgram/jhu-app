tab_home <- fluidPage(
  useShinydashboard(),
  tags$head(tags$style(HTML(
    ".navbar-default .navbar-nav>.active>a, .navbar-default
    .navbar-nav>.active>a:hover, .navbar-default .navbar-nav>.active>a:focus {
    color: #ffffff;
    background-color: #3d9970;
    }",
    ".navbar-brand {
    float: left;
    padding: 14.5px 15px;
    font-size: 20px;
    line-height: 21px;
    height: 50px;
    font-family: Arial;
    }",
    ".navbar-default .navbar-nav>li>a {
    color: #ffffff;
    font-family: Arial;
    font-size: 15px;
    }"))),
  tags$head(tags$script(HTML('
    var fakeClick = function(tabName) {
      var dropdownList = document.getElementsByTagName("a");
    for (var i = 0; i < dropdownList.length; i++) {
      var link = dropdownList[i];
      if(link.getAttribute("data-value") == tabName) {
        link.click();
      };
    }
  };
  '))),
  fluidRow(
    column(8,
           fluidRow(
             column(6,
                    style = "background-color:#3d9970; height:300px;background-image:url('ixodes-blade.jpg');background-repeat:no-repeat;background-size:cover;", 
                    align = "center",
                    span(style = "color:#000000; font-size:20px; font-weight: bold; font-family: Arial; position: relative; top: 250px; display: block;background-color: rgba(255, 255, 255, 0.88); padding: 5px; cursor:pointer", "OVERVIEW", onclick = "fakeClick('tab-overview')")
                  
             ),
             column(6,
                    style = "background-color:#3d9970; height:300px;background-image:url('map.png');background-repeat:no-repeat;background-size:cover;", 
                    align = "center",
                    span(style = "color:#000000; font-size:20px; font-weight: bold; font-family: Arial; position: relative; top: 250px; display: block;background-color: rgba(255, 255, 255, 0.88); padding: 5px; cursor:pointer", "DATA DASHBOARD", onclick = "fakeClick('tab-data')")
                    )
             ),
           fluidRow(
             column(6,
                    style = "background-color:#3d9970; height:300px;background-image:url('borrelia.jpeg');background-repeat:no-repeat;background-size:cover;", 
                    align = "center",
                    span(style = "color:#000000; font-size:20px; font-weight: bold; font-family: Arial; position: relative; top: 250px; display: block;background-color: rgba(255, 255, 255, 0.88); padding: 5px; cursor:pointer", "LYME DISEASE 101", onclick = "fakeClick('tab-101')")
             ),
             column(6,
                    style = "background-color:#3d9970; height:300px;background-image:url('dog.jpg');background-repeat:no-repeat;background-size:cover;", 
                    align = "center",
                    span(style = "color:#000000; font-size:20px; font-weight: bold; font-family: Arial; position: relative; top: 250px; display: block;background-color: rgba(255, 255, 255, 0.88); padding: 5px; cursor:pointer", "ABOUT US", onclick = "fakeClick('tab-about')")
             )
           )
    ),
    column(4, 
           style = "background-color:#3d9970; height:600px;", 
           align = "center",
           br(),
           br(),
           br(),
           br(),
           span(tags$b("Welcome to the Johns Hopkins Lyme and Tick-borne Disease Dashboard"), style = "color:#FFFFFF; font-size:35px; font-family: Arial"), 
           tags$hr(style = "border-color: white;"), 
           span(style = "color:#FFFFFF; font-size:30px; font-family: Arial", "A project of the Johns Hopkins Spatial Science for Public Health Center, the Johns Hopkins Lyme Disease Research Center, and the Johns Hopkins Lyme and Tick-borne Illness Research and Education Institute."),
           br(),
           br(),
           span(tags$i("Harnessing the Power of Geography"), style = "color:#FFFFFF; font-size:30px; font-family: Arial"),
           br(),
           span(tags$i("in Tick-borne Diseases"), style = "color:#FFFFFF; font-size:30px; font-family: Arial")
    )
  )
)
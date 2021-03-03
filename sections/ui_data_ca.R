header_data_ca <- dashboardHeader(
  disable = TRUE)

sidebar_data_ca <- dashboardSidebar(
  width = 400,
  
  sidebarMenu(
    
    menuItem(
      " Case Data",
      tabName = "case-ca",
      icon = htmltools::browsable(tags$i(class = "fas fa-file-medical")),

      menuSubItem(
        "Canada Lyme Disease Rates (2017)",
        tabName = "ca-rate")

    ),
    
    menuItem(
      " Environmental Data",
      icon = htmltools::browsable(tags$i(class = "fab fa-envira")),
      tabName = "environment-ca",
      
      menuSubItem(
        "Land Cover (2015)",
        tabName = "lc-ca"),
      
      menuSubItem(
        "Forest Edge Density (2015)",
        tabName = "forest-ed-ca"),
      
      menuSubItem(
        "% Forest-Developed Edge (2015)",
        tabName = "fde-ca"),
      
      menuSubItem(
        "Mean Elevation",
        tabName = "elevation-ca"),
      
      menuSubItem(
        "Mean Slope of Elevation",
        tabName = "slope-ca"),
      
      menuSubItem(
        "Dominant Soil Taxonomy Order",
        tabName = "soil-ca")
      
    ),
    
    menuItem(
      " Socio-Demographic Data",
      icon = htmltools::browsable(tags$i(class = "fas fa-users")),
      tabName = "socio-demographic-ca",
      
      menuSubItem(
        "Population Density (2016)",
        tabName = "pop-density-ca"),
      
      menuSubItem(
        "Population Ecumene (2016)",
        tabName = "pop-ecu-ca"),
      
      menuSubItem(
        "% Change in Housing Units (2011-2016)",
        tabName = "housing-ca"),
      
      menuSubItem(
        "Median HH Income (CAD, 2016)",
        tabName = "hh-inc-ca"),
      
      menuSubItem(
        "% High School Graduate + (2016)",
        tabName = "edu-ca")
      
    )
  )
)

body_data_ca <- dashboardBody(
  tags$head(tags$style(HTML('
        .skin-blue .main-sidebar {
         background-color: #222222;
        }
        .sidebar-menu li a {
         font-size: 20px;
         font-family: Arial;
        }
         .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
          background-color: #090909;
        }
        .skin-blue .sidebar-menu>li>.treeview-menu {
         margin: 0 1px;
         background: #090909;
        }
        .sidebar-menu .treeview-menu>li>a {
         padding: 5px 5px 5px 15px;
         display: block;
         font-size: 18px;
         font-family: Arial;
        }
        .skin-blue .main-sidebar .sidebar .sidebar-menu a{
         background-color: #222222;
         color: #FFFFFF;
        }
         .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
          background-color: #3d9970;
        }
         .skin-blue .main-header .navbar .sidebar-toggle:hover{
          background-color: #3d9970;
        }
         .skin-blue .sidebar-menu > li.active > a,
         .skin-blue .sidebar-menu > li:hover > a {
          border-left-color: #3d9970;
        }'))
  ),

  tabItems(
    
    tabItem(
      tabName = "ca-rate",
      fluidRow(
        leafletOutput("ca_rate_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "lc-ca",
      fluidRow(
        leafletOutput("lc_ca_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "forest-ed-ca",
      fluidRow(
        leafletOutput("forest_ed_ca_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "elevation-ca",
      fluidRow(
        leafletOutput("elevation_ca_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "slope-ca",
      fluidRow(
        leafletOutput("slope_ca_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "soil-ca",
      fluidRow(
        leafletOutput("soil_ca_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "fde-ca",
      fluidRow(
        leafletOutput("fde_ca_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "pop-density-ca",
      
      fluidRow(
        leafletOutput("pop_density_ca_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "pop-ecu-ca",

      fluidRow(
        leafletOutput("pop_ecu_ca_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "housing-ca",
      
      fluidRow(
        leafletOutput("housing_ca_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "hh-inc-ca",
      
      fluidRow(
        leafletOutput("hh_inc_ca_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "edu-ca",
      
      fluidRow(
        leafletOutput("edu_ca_map", height = 890)
      )
    )
  )
)

tab_data_ca <- dashboardPage(
  title = "Canada Data",
  header = header_data_ca,
  sidebar = sidebar_data_ca,
  body = body_data_ca
)
sidebar_data <- dashboardSidebar(
  width = 375,
  
  sidebarMenu(
    
    menuItem(
      " Case Data",
      tabName = "case",
      icon = icon("file-medical"),
      
      menuSubItem(
        "U.S. Lyme Disease Counts (2018)",
        tabName = "lyme-count"),
      
      menuSubItem(
        "U.S. Lyme Disease Rates (2018)",
        tabName = "lyme-rate")
      
    ),
    
    menuItem(
      " Environmental Data",
      icon = icon("envira"),
      tabName = "environment",
      
      menuSubItem(
        "% Forest Cover",
        tabName = "forest-county"),
      
      menuSubItem(
        "Forest Edge Density",
        tabName = "forest-ed"),
      
      menuSubItem(
        "Forest Patch Density",
        tabName = "forest-pd"),
      
      menuSubItem(
        "Mean Forest Patch Size",
        tabName = "forest-size"),
      
      menuSubItem(
        "% Herbaceous Cover",
        tabName = "herb-county"),
      
      menuSubItem(
        "% Forest-Herbaceous Edge",
        tabName = "fhe"),
      
      menuSubItem(
        "% Forest-Developed Edge",
        tabName = "fde"),
      
      menuSubItem(
        "% Developed Cover",
        tabName = "dev-county"),
      
      menuSubItem(
        "% Water Cover",
        tabName = "water-county"),
      
      menuSubItem(
        "Mean Elevation",
        tabName = "elevation"),
      
      menuSubItem(
        "Mean Slope of Elevation",
        tabName = "slope"),
      
      menuSubItem(
        "Average Temperature",
        tabName = "temp"),
      
      menuSubItem(
        "Total Precipitation",
        tabName = "precip"),
      
      menuSubItem(
        "Mean NDVI",
        tabName = "ndvi"),
      
      menuSubItem(
        "Dominant Soil Taxonomy Order",
        tabName = "soil")
      
    ),
    
    menuItem(
      " Socio-Demographic Data",
      icon = icon("user-alt"),
      tabName = "socio-demographic",
      
      menuSubItem(
        "Population Density (2018)",
        tabName = "pop-density"),
      
      menuSubItem(
        "Urban/Rural Classification (2013)",
        tabName = "urban-rural"),
      
      menuSubItem(
        "% Change in Housing Units (2017-2018)",
        tabName = "housing"),

      menuSubItem(
        "Median HH Income (2014-2018)",
        tabName = "hh-inc"),
      
      menuSubItem(
        "Less than High School (2014-2018)",
        tabName = "edu"),
      
      menuSubItem(
        "% Population Age 5-14 (2014-2018)",
        tabName = "age_05_14"),
      
      menuSubItem(
        "% Population Age 45-59 (2014-2018)",
        tabName = "age_45_59") 
      
    ),
    
    menuItem(
      " Tick-Host Data",
      icon = icon("bug"),
      tabName = "ticks",
      
      menuSubItem(
        "Ixodes scapularis status (2019)",
        tabName = "scapularis"),
      
      menuSubItem(
        "Ixodes pacificus status (2019)",
        tabName = "pacificus")
      
      # menuSubItem(
      #   "White-tailed Deer Estimates (2008)",
      #   tabName = "deer")
      
    ),
    
    menuItem(
      " Google Trends Data",
      icon = icon("search"),
      tabName = "google",
      
      menuSubItem(
        "'Lyme Disease' Search Interest (2019)",
        tabName = "gt-ld"),
      
      menuSubItem(
        "'Tick Bite' Search Interest (2019)",
        tabName = "gt-tick-bite")
    ),
    
    menuItem(
      " *Veterinary Data",
      icon = icon("disease"),
      tabName = "vet",
      
      menuSubItem(
        "*Tick-borne Disease Cases in Dogs",
        tabName = "dog")
    ),
    
    menuItem(
      " *Cost Burden Data",
      icon = icon("dollar-sign"),
      tabName = "cost",
      
      menuSubItem(
        "*In Progress",
        tabName = "tbd")
    ),
    br(),
    menuItem(
      " *Analytic Functionality",
      icon = icon("chart-line"),
      tabName = "analytics",
      
      menuSubItem(
        "*In Progress",
        tabName = "tbd")
    )
  )
)

body_data <- dashboardBody(
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
      tabName = "lyme-count",
      fluidRow(
        tabBox(
          width = 12,
          height = 890,
          tabPanel(
            "Map",
            leafletOutput("lyme_count_map", height = 820)
          ),
          tabPanel(
            "About the Data"
          ),
          tabPanel(
            "Download Data"
          )
        )
      )
    ),
    
    tabItem(
      tabName = "lyme-rate",
      fluidRow(
            leafletOutput("lyme_rate_map", height = 820)
      )
    ),
    
    tabItem(
      tabName = "forest-county",
      fluidRow(
        leafletOutput("forest_map_county", height = 890)
      )
    ),
    
    tabItem(
      tabName = "forest-ed",
      fluidRow(
        leafletOutput("forest_ed_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "forest-pd",
      fluidRow(
        leafletOutput("forest_pd_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "forest-size",
      fluidRow(
        leafletOutput("forest_size_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "dev-county",
      fluidRow(
        leafletOutput("dev_map_county", height = 890)
      )
    ),
    
    tabItem(
      tabName = "water-county",
      fluidRow(
        leafletOutput("water_map_county", height = 890)
      )
    ),
    
    tabItem(
      tabName = "elevation",
      fluidRow(
        leafletOutput("elevation_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "slope",
      fluidRow(
        leafletOutput("slope_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "ndvi",
      fluidRow(
        leafletOutput("ndvi_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "soil",
      fluidRow(
        leafletOutput("soil_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "herb-county",
      fluidRow(
        leafletOutput("herb_map_county", height = 890)
      )
    ),
    
    tabItem(
      tabName = "fhe",
      fluidRow(
        leafletOutput("fhe_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "fde",
      fluidRow(
        leafletOutput("fde_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "temp",
      fluidRow(
        leafletOutput("temp_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "precip",
      fluidRow(
        leafletOutput("precip_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "pop-density",
      
      fluidRow(
        leafletOutput("pop_density_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "urban-rural",
      
      fluidRow(
        leafletOutput("nchs_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "housing",
      
      fluidRow(
        leafletOutput("housing_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "hh-inc",
      
      fluidRow(
        leafletOutput("hh_inc_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "edu",
      
      fluidRow(
        leafletOutput("edu_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "age_05_14",
      
      fluidRow(
        leafletOutput("age_05_14_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "age_45_59",
      
      fluidRow(
        leafletOutput("age_45_59_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "scapularis",
      
      fluidRow(
        leafletOutput("scap_map", height = 890)
        )
    ),
    
    tabItem(
      tabName = "pacificus",
      
      fluidRow(
        leafletOutput("pac_map", height = 890)
      )
    ),
    
    # tabItem(
    #   tabName = "deer",
    #   
    #   fluidRow(
    #     leafletOutput("deer_map", height = 890)
    #   )
    # ),
    
    tabItem(
      tabName = "gt-ld",
      
      fluidRow(
        leafletOutput("gt_ld_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "gt-tick-bite",
      
      fluidRow(
        leafletOutput("gt_tick_bite_map", height = 890)
      )
    )
  )
)

tab_data <- dashboardPage(
  title = "Data",
  header = dashboardHeader(disable = TRUE),
  sidebar = sidebar_data,
  body = body_data
)
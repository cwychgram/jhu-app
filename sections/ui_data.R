header_data <- dashboardHeader(
  disable = TRUE)

sidebar_data <- dashboardSidebar(
  width = 400,
  
  sidebarMenu(
    
    menuItem(
      " Case Data",
      tabName = "case",
      icon = htmltools::browsable(tags$i(class = "fas fa-file-medical")),
      
      menuSubItem(
        "Lyme Disease Counts (2018)",
        tabName = "lyme-count"),
      
      menuSubItem(
        "Lyme Disease Rates (2018)",
        tabName = "lyme-rate"),
      
      menuSubItem(
        "Babesiosis Counts (2018)",
        tabName = "bab-count"),
      
      menuSubItem(
        "Babesiosis Rates (2018)",
        tabName = "bab-rate"),
      
      menuSubItem(
        "Anaplasmosis Counts (2018)",
        tabName = "a-count"),
      
      menuSubItem(
        "Anaplasmosis Rates (2018)",
        tabName = "a-rate"),
      
      menuSubItem(
        "Ehrlichiosis (E. chaffeensis) Counts (2018)",
        tabName = "e-count"),
      
      menuSubItem(
        "Ehrlichiosis (E. chaffeensis) Rates (2018)",
        tabName = "e-rate"),
      
      menuSubItem(
        "Spotted Fever Rickettsiosis Counts (2018)",
        tabName = "sfr-count"),
      
      menuSubItem(
        "Spotted Fever Rickettsiosis Rates (2018)",
        tabName = "sfr-rate"),
      
      menuSubItem(
        "Tularemia Counts (2018)",
        tabName = "tul-count"),
      
      menuSubItem(
        "Powassan Virus Counts (2018)",
        tabName = "pow-count")
      
    ),
    
    menuItem(
      " Environmental Data",
      icon = htmltools::browsable(tags$i(class = "fab fa-envira")),
      tabName = "environment",
      
      menuSubItem(
        "Land Cover (2016)",
        tabName = "nlcd"),
      
      menuSubItem(
        "Forest Edge Density (2016)",
        tabName = "forest-ed"),
      
      # menuSubItem(
      #   "Forest Patch Density",
      #   tabName = "forest-pd"),
      
      menuSubItem(
        "% Forest-Developed Edge (2016)",
        tabName = "fde"),
      
      # menuSubItem(
      #   "% Developed Cover",
      #   tabName = "dev-county"),
      # 
      # menuSubItem(
      #   "% Water Cover",
      #   tabName = "water-county"),
      
      menuSubItem(
        "Mean Elevation",
        tabName = "elevation"),
      
      menuSubItem(
        "Mean Slope of Elevation",
        tabName = "slope"),
      
      menuSubItem(
        "Average Temperature (Spr 2018)",
        tabName = "temp"),
      
      menuSubItem(
        "Total Precipitation (Spr 2018)",
        tabName = "precip"),
      
      menuSubItem(
        "Time-Integrated NDVI (2018)",
        tabName = "ndvi"),
      
      menuSubItem(
        "Dominant Soil Taxonomy Order",
        tabName = "soil")
      
    ),
    
    menuItem(
      " Socio-Demographic Data",
      icon = htmltools::browsable(tags$i(class = "fas fa-users")),
      tabName = "socio-demographic",
      
      menuSubItem(
        "Population Density (2018)",
        tabName = "pop-density"),
      
      menuSubItem(
        "Urban/Rural Classification (2013)",
        tabName = "urban-rural"),
      
      menuSubItem(
        "% Change in Housing Units (2010-2018)",
        tabName = "housing"),

      menuSubItem(
        "Median HH Income (2014-2018)",
        tabName = "hh-inc"),
      
      menuSubItem(
        "% High School Graduate + (2014-2018)",
        tabName = "edu")
      
      # menuSubItem(
      #   "% Population Age 5-14 (2014-2018)",
      #   tabName = "age_05_14"),
      # 
      # menuSubItem(
      #   "% Population Age 45-59 (2014-2018)",
      #   tabName = "age_45_59") 
      
    ),
    
    menuItem(
      " Tick Data",
      icon = htmltools::browsable(tags$i(class = "fas fa-spider")),
      tabName = "ticks",
      
      menuSubItem(
        "Ixodes scapularis status (2019)",
        tabName = "scapularis"),
      
      menuSubItem(
        "Ixodes pacificus status (2019)",
        tabName = "pacificus")
      
    ),
    
    menuItem(
      " Google Trends Data",
      icon = htmltools::browsable(tags$i(class = "fas fa-search")),
      tabName = "google",
      
      menuSubItem(
        "'Lyme Disease' Search Interest",
        tabName = "gt-ld"),
      
      menuSubItem(
        "'Tick Bite' Search Interest",
        tabName = "gt-tick-bite")
    )
    
    # menuItem(
    #   " *Veterinary Data",
    #   icon = htmltools::browsable(tags$i(class = "fas fa-dog")),
    #   tabName = "vet",
    #   
    #   menuSubItem(
    #     "*Tick-borne Disease Cases in Dogs",
    #     tabName = "dog")
    # ),
    # 
    # menuItem(
    #   " *Economic Burden Data",
    #   icon = htmltools::browsable(tags$i(class = "fas fa-dollar-sign")),
    #   tabName = "econ",
    #   
    #   menuSubItem(
    #     "*In Progress",
    #     tabName = "tbd")
    # )
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
      tabName = "bab-count",
      fluidRow(
        leafletOutput("bab_count_map", height = 820)
      )
    ),
    
    tabItem(
      tabName = "bab-rate",
      fluidRow(
        leafletOutput("bab_rate_map", height = 820)
      )
    ),
    
    tabItem(
      tabName = "a-count",
      fluidRow(
        leafletOutput("a_count_map", height = 820)
      )
    ),
    
    tabItem(
      tabName = "a-rate",
      fluidRow(
        leafletOutput("a_rate_map", height = 820)
      )
    ),
    
    tabItem(
      tabName = "e-count",
      fluidRow(
        leafletOutput("e_count_map", height = 820)
      )
    ),
    
    tabItem(
      tabName = "e-rate",
      fluidRow(
        leafletOutput("e_rate_map", height = 820)
      )
    ),
    
    tabItem(
      tabName = "sfr-count",
      fluidRow(
        leafletOutput("sfr_count_map", height = 820)
      )
    ),
    
    tabItem(
      tabName = "sfr-rate",
      fluidRow(
        leafletOutput("sfr_rate_map", height = 820)
      )
    ),
    
    tabItem(
      tabName = "tul-count",
      fluidRow(
        leafletOutput("tul_count_map", height = 820)
      )
    ),
    
    tabItem(
      tabName = "pow-count",
      fluidRow(
        leafletOutput("pow_count_map", height = 820)
      )
    ),
    
    tabItem(
      tabName = "nlcd",
      fluidRow(
        leafletOutput("nlcd_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "forest-ed",
      fluidRow(
        leafletOutput("forest_ed_map", height = 890)
      )
    ),
    
    # tabItem(
    #   tabName = "forest-pd",
    #   fluidRow(
    #     leafletOutput("forest_pd_map", height = 890)
    #   )
    # ),
    
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
    
    # tabItem(
    #   tabName = "age_05_14",
    #   
    #   fluidRow(
    #     leafletOutput("age_05_14_map", height = 890)
    #   )
    # ),
    
    # tabItem(
    #   tabName = "age_45_59",
    #   
    #   fluidRow(
    #     leafletOutput("age_45_59_map", height = 890)
    #   )
    # ),
    
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
    
    tabItem(
      tabName = "gt-ld",
      
      fluidRow(
        box(
          width = 3,
          height = 90,
          background = "olive",
          sliderInput("year_gt_ld",
                      label = "Select Year", 
                      value = 2020, 
                      min = 2010, 
                      max = 2020, 
                      sep = ""
          )
        )
      ),
      fluidRow(
        leafletOutput("gt_ld_map", height = 890)
      )
    ),
    
    tabItem(
      tabName = "gt-tick-bite",
      
      fluidRow(
        box(
          width = 3,
          height = 90,
          background = "olive",
          sliderInput("year_gt_tb",
                      label = "Select Year", 
                      value = 2020, 
                      min = 2010, 
                      max = 2020, 
                      sep = ""
          )
        )
      ),
      fluidRow(
        leafletOutput("gt_tick_bite_map", height = 890)
      )
    )
  )
)

tab_data <- dashboardPage(
  title = "US Data",
  header = header_data,
  sidebar = sidebar_data,
  body = body_data
)
source("sections/ui_home.R", local = TRUE)
source("sections/ui_mission.R", local = TRUE)
source("sections/ui_overview.R", local = TRUE)
source("sections/ui_data.R", local = TRUE)
source("sections/ui_profile.R", local = TRUE)
source("sections/ui_101.R", local = TRUE)
source("sections/ui_news.R", local = TRUE)
source("sections/ui_research.R", local = TRUE)
source("sections/ui_about.R", local = TRUE)

ui <- navbarPage(
  theme = shinytheme("cosmo"),
  title = span(img(src = "bloomberg.shield.small.white.png", width = "25", height = "25"), "Johns Hopkins Lyme and Tick-borne Disease Dashboard Initiative"),
  collapsible = TRUE,
  fluid = TRUE,
  tabPanel("Home", tab_home, value = "tab-home"),
  tabPanel("Mission Statement", tab_mission, value = "tab-mission"),
  tabPanel("Overview", tab_overview, value = "tab-overview"),
  tabPanel("Data Dashboard", tab_data, value = "tab-data"),
  tabPanel("County Profiles", tab_profile, value = "tab-profile"),
  tabPanel("Lyme Disease 101", tab_101, value = "tab-101"),
  tabPanel("In the News", tab_news, value = "tab-news"),
  tabPanel("Research", tab_research, value = "tab-research"),
  tabPanel("About Us", tab_about, value = "tab-about")
)

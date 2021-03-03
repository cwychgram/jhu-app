source("sections/ui_home.R", local = TRUE)
source("sections/ui_mission.R", local = TRUE)
source("sections/ui_101.R", local = TRUE)
source("sections/ui_overview.R", local = TRUE)
source("sections/ui_overview_ca.R", local = TRUE)
source("sections/ui_data.R", local = TRUE)
source("sections/ui_data_ca.R", local = TRUE)
# source("sections/ui_profile.R", local = TRUE)
source("sections/ui_news.R", local = TRUE)
source("sections/ui_research.R", local = TRUE)
source("sections/ui_other.R", local = TRUE)
source("sections/ui_about.R", local = TRUE)

ui <- navbarPage(
  theme = shinytheme("cosmo"),
  title = span(img(src = "bloomberg.shield.small.white.png", width = "25", height = "25"), "Johns Hopkins Lyme and Tick-borne Disease Dashboard Initiative"),
  collapsible = TRUE,
  fluid = TRUE,
  tabPanel("Home", tab_home, value = "tab-home"),
  navbarMenu("About",
             tabPanel("Mission", tab_mission, value = "tab-mission"),
             tabPanel("Team", tab_about, value = "tab-about"),
             tabPanel("Contact")),
  tabPanel("Geography Ticks & You", tab_101, value = "tab-101"),
  navbarMenu("US Dashboard",
             tabPanel("Overview", tab_overview, value = "tab-overview"),
             tabPanel("Data", tab_data, value = "tab-data")),
             # tabPanel("County Profiles", tab_profile, value = "tab-profile")),
  navbarMenu("Canada Dashboard",
             tabPanel("Overview", tab_overview_ca, value = "tab-overview-ca"),
             tabPanel("Data", tab_data_ca, value = "tab-data-ca")),
  navbarMenu("News & Resources",
             tabPanel("In the News", tab_news, value = "tab-news"),
             tabPanel("Research", tab_research, value = "tab-research"),
             tabPanel("Other Resources", tab_other, value = "tab-other"))
)

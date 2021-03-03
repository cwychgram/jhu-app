server <- function(input, output, session) {
  
  source("sections/content_overview/valueBoxes.R", local = TRUE)
  source("sections/content_overview/casesMap.R", local = TRUE)
  source("sections/content_overview/casesMap_ca.R", local = TRUE)
  source("sections/content_overview/tableTop.R", local = TRUE)
  source("sections/content_overview/timePlots.R", local = TRUE)
  source("sections/content_overview/timePlots_ca.R", local = TRUE)
  source("sections/content_data/dataMaps.R", local = TRUE)
  source("sections/content_data/dataMaps_ca.R", local = TRUE)
  # source("sections/content_profile/countyProfile.R", local = TRUE)
  source("sections/content_101/lookupTool.R", local = TRUE)
  
}
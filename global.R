# library(BAMMtools) # for calculating natural breaks
library(leaflet)
library(leaflet.extras)
library(plotly)
library(scales)
library(sf)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinythemes)
library(shinyWidgets)
library(sp)
library(stringr)
library(tidyverse)

######################
## STATE BOUNDARIES ##
######################

states <- st_read("data/states.shp", stringsAsFactors = FALSE)
states <- st_transform(states, "+proj=longlat +datum=WGS84")

#########################
## COUNTY LYME DISEASE ##
#########################

counties <- st_read("data/counties_ld.shp", stringsAsFactors = FALSE)
counties <- st_transform(counties, "+proj=longlat +datum=WGS84")

colnames(counties)[colnames(counties) == "COUNTYF"] <- "CTYFP"
colnames(counties)[colnames(counties) == "ALAND_S"] <- "ALAND_SQMI"
colnames(counties)[colnames(counties) == "AWATER_"] <- "AWATER_SQMI"
colnames(counties)[colnames(counties) == "AREA_SQ"] <- "AREA_SQMI"
colnames(counties)[colnames(counties) == "POPDENS"] <- "POPDENSITY"
colnames(counties)[colnames(counties) == "DELTA_C"] <- "DELTA_CASES"
colnames(counties)[colnames(counties) == "DELTA_R"] <- "DELTA_RATE"

######################
## STATE BOUNDARIES ##
######################

states_dissolve <- st_read("data/states_lines.shp", stringsAsFactors = FALSE)
states_dissolve <- st_transform(states_dissolve, "+proj=longlat +datum=WGS84")

###############################
## STATE-LEVEL CASES & RATES ##
###############################

cases_by_state <- read.csv("data/ld_by_state.csv")

###################
## RURAL / URBAN ##
###################

counties_nchs <- st_read("data/counties_urban_rural.shp", stringsAsFactors = FALSE)
counties_nchs <- st_transform(counties_nchs, "+proj=longlat +datum=WGS84")

counties_nchs$CODE_2013 <- as.factor(counties_nchs$CODE_2013)
counties_nchs$CODE_2006 <- as.factor(counties_nchs$CODE_2006)
counties_nchs$CODE_1990 <- as.factor(counties_nchs$CODE_1990)

########################
## IXODES STATUS DATA ##
########################

counties_tick <- st_read("data/counties_tick.shp", stringsAsFactors = FALSE)
counties_tick <- st_transform(counties_tick, "+proj=longlat +datum=WGS84")

counties_tick$SCAP <- as.factor(counties_tick$SCAP)
counties_tick$PAC <- as.factor(counties_tick$PAC)

##################
## AVERAGE TEMP ##
##################

counties_temp <- st_read("data/counties_temp.shp", stringsAsFactors = FALSE)
counties_temp <- st_transform(counties_temp, "+proj=longlat + datum=WGS84")

#############
##  PRECIP ##
#############

counties_pcpn <- st_read("data/counties_pcpn.shp", stringsAsFactors = FALSE)
counties_pcpn <- st_transform(counties_pcpn, "+proj=longlat + datum=WGS84")

############
## HH INC ##
############

counties_hh_inc<- st_read("data/counties_hh_inc.shp", stringsAsFactors = FALSE)
counties_hh_inc <- st_transform(counties_hh_inc, "+proj=longlat +datum=WGS84")

###############
## EDUCATION ##
###############

counties_edu <- st_read("data/counties_edu.shp", stringsAsFactors = FALSE)
counties_edu <- st_transform(counties_edu, "+proj=longlat +datum=WGS84")

colnames(counties_edu)[colnames(counties_edu) == "PCT_HS_"] <- "PCT_HS_PLUS"
colnames(counties_edu)[colnames(counties_edu) == "PCT_LT_"] <- "PCT_LT_HS"

####################
## HOUSING CHANGE ##
####################

counties_housing <- st_read("data/counties_housing.shp", stringsAsFactors = FALSE)
counties_housing <- st_transform(counties_housing, "+proj=longlat +datum=WGS84")

##################################
## GOOGLE TRENDS ~ LYME DISEASE ##
##################################

dma_ld <- st_read("data/dma_ld.shp", stringsAsFactors = FALSE)
dma_ld <- st_transform(dma_ld, "+proj=longlat +datum=WGS84")

###############################
## GOOGLE TRENDS ~ TICK BITE ##
###############################

dma_tb <- st_read("data/dma_tb.shp", stringsAsFactors = FALSE)
dma_tb <- st_transform(dma_tb, "+proj=longlat +datum=WGS84")

################
## LAND COVER ##
################

counties_nlcd <- st_read("data/counties_nlcd.shp", stringsAsFactors = FALSE)
counties_nlcd <- st_transform(counties_nlcd, "+proj=longlat +datum=WGS84")

###############
## ELEVATION ##
###############

counties_elev <- st_read("data/counties_elev.shp", stringsAsFactors = FALSE)
counties_elev <- st_transform(counties_elev, "+proj=longlat +datum=WGS84")

###########
## SLOPE ##
###########

counties_slope <- st_read("data/counties_slope.shp", stringsAsFactors = FALSE)
counties_slope <- st_transform(counties_slope, "+proj=longlat +datum=WGS84")

##########
## NDVI ##
##########

counties_tin <- st_read("data/counties_tin.shp", stringsAsFactors = FALSE)
counties_tin <- st_transform(counties_tin, "+proj=longlat +datum=WGS84")

##########
## SOIL ##
##########

counties_soil <- st_read("data/counties_soil.shp", stringsAsFactors = FALSE)
counties_soil <- st_transform(counties_soil, "+proj=longlat +datum=WGS84")

counties_soil$MAJORITY <- factor(counties_soil$MAJORITY, levels = c("Alfisols", "Andisols", "Aridisols", "Entisols", "Gelisols", "Histosols", "Inceptisols", "Mollisols", "Oxisols", "Spodosols", "Ultisols", "Vertisols", "Misc. (Non-Soil)"))

########################
## LANDSCAPE ANALYSIS ##
########################

counties_edge <- st_read("data/counties_edge.shp", stringsAsFactors = FALSE)
counties_edge <- st_transform(counties_edge, "+proj=longlat +datum=WGS84")

#################
## SEASONALITY ##
#################

# for plot on Overview tab

month_onset <- read.csv("data/month_2008_2018.csv")
colnames(month_onset)[colnames(month_onset) == "ï..Month.of.disease.onset"] <- "Month"
month_onset$Month <- factor(month_onset$Month, levels = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"))

##########################
## AGE/SEX DISTRIBUTION ##
##########################

# for plot on Overview tab

age_sex <- read.csv("data/age_sex_2001_2018.csv")
colnames(age_sex)[colnames(age_sex) == "ï..Age.Group"] <- "AgeGroup"
age_sex$Cases <- age_sex$Male + age_sex$Female
age_sex$AgeGroup <- factor(age_sex$AgeGroup, levels = c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80-84", "85-89", "90+"))

#########################
## BABESIOSIS BY STATE ##
#########################

states_bab <- st_read("data/states_babesiosis.shp", stringsAsFactors = FALSE)
states_bab <- st_transform(states_bab, "+proj=longlat +datum=WGS84")

##########################################
## EHRLICHIOSIS & ANAPLASMOSIS BY STATE ##
##########################################

states_ea <- st_read("data/states_ehr_ana.shp", stringsAsFactors = FALSE)
states_ea <- st_transform(states_ea, "+proj=longlat +datum=WGS84")

colnames(states_ea)[colnames(states_ea) == "CASES_U"] <- "CASES_UND"
colnames(states_ea)[colnames(states_ea) == "CASES_T"] <- "CASES_TOT"
colnames(states_ea)[colnames(states_ea) == "RATE_E_"] <- "RATE_E_C"

states_ea <- states_ea[-c(16)]

##########################################
## Spotted Fever Rickettsiosis BY STATE ##
##########################################

states_sfr <- st_read("data/states_sfr.shp", stringsAsFactors = FALSE)
states_sfr <- st_transform(states_sfr, "+proj=longlat +datum=WGS84")

########################
## TULAREMIA BY STATE ##
########################

states_tul <- st_read("data/states_tul.shp", stringsAsFactors = FALSE)
states_tul <- st_transform(states_tul, "+proj=longlat +datum=WGS84")

#######################
## POWASSAN BY STATE ##
#######################

states_pow <- st_read("data/states_pow.shp", stringsAsFactors = FALSE)
states_pow <- st_transform(states_pow, "+proj=longlat +datum=WGS84")

#########################
## CANADA MERGED CASES ##
#########################

ca_hr <- st_read("data/canada_ld.shp", stringsAsFactors = FALSE)
ca_hr <- st_transform(ca_hr, "+proj=longlat +datum=WGS84")

ca_hr <- ca_hr[-c(7)]

# removing territories for now

ca_hr <- subset(ca_hr, PRNAME != "Yukon" & PRNAME != "Northwest Territories" & PRNAME != "Nunavut")

# ArcGIS converted NAs to 0, so switching back

ca_hr$CASES[ca_hr$PRNAME == "Newfoundland and Labrador" | ca_hr$PRNAME == "Saskatchewan" | ca_hr$PRNAME == "Yukon" | ca_hr$PRNAME == "Northwest Territories" | ca_hr$PRNAME == "Nunavut"] <- NA
ca_hr$POP[ca_hr$PRNAME == "Newfoundland and Labrador" | ca_hr$PRNAME == "Saskatchewan" | ca_hr$PRNAME == "Yukon" | ca_hr$PRNAME == "Northwest Territories" | ca_hr$PRNAME == "Nunavut"] <- NA
ca_hr$RATE[ca_hr$PRNAME == "Newfoundland and Labrador" | ca_hr$PRNAME == "Saskatchewan" | ca_hr$PRNAME == "Yukon" | ca_hr$PRNAME == "Northwest Territories" | ca_hr$PRNAME == "Nunavut"] <- NA

ca_hr$CASES[ca_hr$PRNAME == "Alberta" & ca_hr$YEAR < 2011] <- NA
ca_hr$POP[ca_hr$PRNAME == "Alberta" & ca_hr$YEAR < 2011] <- NA
ca_hr$RATE[ca_hr$PRNAME == "Alberta" & ca_hr$YEAR < 2011] <- NA

ca_hr$CASES[ca_hr$PRNAME == "Prince Edward Island" & ca_hr$CASES == 0] <- NA
ca_hr$POP[ca_hr$PRNAME == "Prince Edward Island" & ca_hr$POP == 0] <- NA
ca_hr$RATE[ca_hr$PRNAME == "Prince Edward Island" & ca_hr$RATE == 0] <- NA

ca_hr$CASES[ca_hr$PRNAME == "Manitoba" & ca_hr$YEAR < 2015] <- NA
ca_hr$POP[ca_hr$PRNAME == "Manitoba" & ca_hr$YEAR < 2015] <- NA
ca_hr$RATE[ca_hr$PRNAME == "Manitoba" & ca_hr$YEAR < 2015] <- NA

ca_hr$CASES[ca_hr$PRNAME == "Nova Scotia" & ca_hr$YEAR < 2014] <- NA
ca_hr$CASES[ca_hr$PRNAME == "Nova Scotia" & ca_hr$YEAR == 2018] <- NA
ca_hr$POP[ca_hr$PRNAME == "Nova Scotia" & ca_hr$YEAR < 2014] <- NA
ca_hr$POP[ca_hr$PRNAME == "Nova Scotia" & ca_hr$YEAR == 2018] <- NA
ca_hr$RATE[ca_hr$PRNAME == "Nova Scotia" & ca_hr$YEAR < 2014] <- NA
ca_hr$RATE[ca_hr$PRNAME == "Nova Scotia" & ca_hr$YEAR == 2018] <- NA

ca_hr$CASES[ca_hr$PRNAME == "Quebec" & ca_hr$YEAR < 2013] <- NA
ca_hr$POP[ca_hr$PRNAME == "Quebec" & ca_hr$YEAR < 2013] <- NA
ca_hr$RATE[ca_hr$PRNAME == "Quebec" & ca_hr$YEAR < 2013] <- NA

ca_hr$CASES[ca_hr$PRNAME == "New Brunswick" & ca_hr$YEAR < 2012] <- NA
ca_hr$POP[ca_hr$PRNAME == "New Brunswick" & ca_hr$YEAR < 2012] <- NA
ca_hr$RATE[ca_hr$PRNAME == "New Brunswick" & ca_hr$YEAR < 2012] <- NA

##########################################
## CANADA COUNTRY-LEVEL CASES 2009-2018 ##
##########################################

# for plotting total cases over time, since there is missing health region-level data
# these are from https://www.canada.ca/en/public-health/services/diseases/lyme-disease/surveillance-lyme-disease.html

ca_2009_2018 <- read.csv("data/Canada_Total_Cases_2009_2018.csv")

colnames(ca_2009_2018)[colnames(ca_2009_2018) == "ï..YEAR"] <- "YEAR"

######################
## CANADA PROVINCES ##
######################

ca_pr_lines <- st_read("data/ca_provinces_simplify.shp", stringsAsFactors = FALSE)

ca_pr_lines <- st_transform(ca_pr_lines, "+proj=longlat +datum=WGS84")

ca_pr_lines <- subset(ca_pr_lines, PRNAME != "Yukon" & PRNAME != "Northwest Territories / Territoires du Nord-Ouest" & PRNAME != "Nunavut")

ca_pr_lines <- ca_pr_lines[-c(2:3)]

#######################
## CANADA LAND COVER ##
#######################

canada_land <- st_read("data/canada_land.shp", stringsAsFactors = FALSE)
canada_land <- st_transform(canada_land, "+proj=longlat +datum=WGS84")

########################
## CANADA FOREST EDGE ##
########################

canada_edge <- st_read("data/canada_edge.shp", stringsAsFactors = FALSE)
canada_edge <- st_transform(canada_edge, "+proj=longlat +datum=WGS84")

######################
## CANADA ELEVATION ##
######################

canada_elev <- st_read("data/canada_elev.shp", stringsAsFactors = FALSE)
canada_elev <- st_transform(canada_elev, "+proj=longlat +datum=WGS84")

##################
## CANADA SLOPE ##
##################

canada_slope <- st_read("data/canada_slope.shp", stringsAsFactors = FALSE)
canada_slope <- st_transform(canada_slope, "+proj=longlat +datum=WGS84")

#################
## CANADA SOIL ##
#################

canada_soil <- st_read("data/canada_soil.shp", stringsAsFactors = FALSE)
canada_soil <- st_transform(canada_soil, "+proj=longlat +datum=WGS84")

canada_soil$MAJORITY <- factor(canada_soil$MAJORITY, levels = c("Brunisolic", "Chernozemic", "Cryosolic", "Gleysolic", "Luvisolic", "Organic", "Podzolic", "Regosolic", "Vertisolic", "Unclassified"))

######################
## CANADA EDUCATION ##
######################

canada_edu <- st_read("data/canada_edu.shp", stringsAsFactors = FALSE)
canada_edu <- st_transform(canada_edu, "+proj=longlat +datum=WGS84")

colnames(canada_edu)[colnames(canada_edu) == "PCT_LT_"] <- "PCT_LT_HS"
colnames(canada_edu)[colnames(canada_edu) == "PCT_HS_"] <- "PCT_HS_PLUS"

###########################
## CANADA HOUSING CHANGE ##
###########################

canada_housing <- st_read("data/canada_housing.shp", stringsAsFactors = FALSE)
canada_housing <- st_transform(canada_housing, "+proj=longlat +datum=WGS84")

####################
## CANADA ECUMENE ##
####################

# ECUMEME = 1 means inside the ecumene

canada_ecu <- st_read("data/canada_ecu_simplify.shp", stringsAsFactors = FALSE)

canada_ecu <- st_transform(canada_ecu, "+proj=longlat +datum=WGS84")

colnames(canada_ecu)[colnames(canada_ecu) == "ECUMENE_EN"] <- "ECUMENE"
colnames(canada_ecu)[colnames(canada_ecu) == "PROV_TERR_"] <- "PRNAME"
colnames(canada_ecu)[colnames(canada_ecu) == "NAME_EN"] <- "NAME"
colnames(canada_ecu)[colnames(canada_ecu) == "CDUID_EN"] <- "CDUID"

canada_ecu <- mutate(canada_ecu, PRABBR = case_when(
  PRNAME == "Alberta" ~ "AB",
  PRNAME == "Quebec" ~ "QC",
  PRNAME == "Ontario" ~ "ON", 
  PRNAME == "Nova Scotia" ~ "NS",           
  PRNAME == "New Brunswick" ~ "NB",
  PRNAME == "Manitoba" ~ "MB",
  PRNAME == "British Columbia" ~ "BC",
  PRNAME == "Prince Edward Island" ~ "PE",
  PRNAME == "Newfoundland and Labrador" ~ "NL",
  PRNAME == "Saskatchewan" ~ "SK",
  PRNAME == "Yukon" ~ "YT", 
  PRNAME == "Northwest Territories" ~ "NT",
  PRNAME == "Nunavut" ~ "NU"
))

canada_ecu$ECUMENE <- as.factor(canada_ecu$ECUMENE)

canada_ecu <- subset(canada_ecu, PRNAME != "Yukon" & PRNAME != "Northwest Territories" & PRNAME != "Nunavut")

canada_ecu <- canada_ecu[-c(1, 4:6, 8, 10:19)]

########################
## CANADA POP DENSITY ##
########################

canada_pd <- st_read("data/canada_pd.shp", stringsAsFactors = FALSE)
canada_pd <- st_transform(canada_pd, "+proj=longlat +datum=WGS84")

##################
## CANADA HHINC ##
##################

canada_hhinc <- st_read("data/canada_hhinc.shp", stringsAsFactors = FALSE)
canada_hhinc <- st_transform(canada_hhinc, "+proj=longlat +datum=WGS84")
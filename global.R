# library(BAMMtools) # for calculating natural breaks
# library(FedData)
# library(leafem)
library(leaflet)
library(leaflet.extras)
library(plotly)
# library(rgdal)
# library(rmapshaper)
# library(rsconnect)
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
library(tigris) # for fips codes
# library(tmap)
# library(widgetframe)

# read in state boundaries

states <- st_read("data/cb_2018_us_state_5m.shp", stringsAsFactors = FALSE)

# remove terriroties

states <- subset(states, STATEFP != "60" & STATEFP != "66" & STATEFP != "69" & STATEFP != "72" & STATEFP != "78")

# convert ALAND and AWATER from sq m to sq mi

states$ALAND <- states$ALAND * 3.86102e-7
states$AWATER <- states$AWATER * 3.86102e-7

# set coordinate system

states <- st_set_crs(states, "+proj=longlat +datum=WGS84")

# read in county boundaries

counties <- st_read("data/cb_2018_us_county_5m.shp", stringsAsFactors = FALSE)

# remove territories

counties <- subset(counties, STATEFP != "60" & STATEFP != "66" & STATEFP != "69" & STATEFP != "72" & STATEFP != "78")

# convert ALAND and AWATER from sq m to sq mi

counties$ALAND <- counties$ALAND * 3.86102e-7
counties$AWATER <- counties$AWATER * 3.86102e-7

# create state/state abbr fields

data(fips_codes)

fips_codes$GEOID <- paste(fips_codes$state_code, fips_codes$county_code, sep = "")

counties <- counties%>%
  left_join(fips_codes, c("GEOID" = "GEOID"))

colnames(counties)[colnames(counties) == "state"] <- "STABBR"
colnames(counties)[colnames(counties) == "state_name"] <- "STNAME"
colnames(counties)[colnames(counties) == "county"] <- "CTYNAME"

counties <- counties[ -c(11, 13) ]

# save as new shapefile

# st_write(counties, "data/counties.shp", delete_layer = T)

# set coordinate system

counties <- st_set_crs(counties, "+proj=longlat +datum=WGS84")

# save separate file for just mapping lines

counties_lines <- st_read("data/cb_2018_us_county_5m.shp", stringsAsFactors = FALSE)

# set coordinate system

counties_lines <- st_set_crs(counties_lines, "+proj=longlat +datum=WGS84")

# dissolve into states

states_dissolve <- aggregate(counties_lines[, "STATEFP"], by = list(ID = counties_lines$STATEFP),
                             FUN = unique, dissolve = T)

# read in cases

cases <- read.csv("data/CDC-LD-Case-Counts-by-County-00-18.csv")

# remove state rows from county-level cases

cases <- subset(cases, CTYCODE != 999)

# create a GEOID field in cases data. GEOID == 2-digit state code + 3-digit county code

cases$STCODE_pad <- str_pad(cases$STCODE, width = 2, side = "left", pad = "0")
cases$CTYCODE_pad <- str_pad(cases$CTYCODE, width = 3, side = "left", pad = "0")
cases$GEOID <- paste(cases$STCODE_pad, cases$CTYCODE_pad, sep = "")

# change annual cases from wide to long format

cases <- cases %>% 
  gather(YEAR, CASES, Cases2000:Cases2018) %>% 
  separate(YEAR, c("tobedeleted", "YEAR"), sep = 5)

cases <- cases[ -c(3:6, 8) ]

# join cases to counties based on GEOID

counties <- counties%>%
  left_join(cases, c("GEOID" = "GEOID"))

# change year field to numeric

counties$YEAR <- as.numeric(counties$YEAR)

# read in population data. This comes in two files, 2000-10 and 2010-19

pop_00_10 <- read.csv("data/co-est00int-tot.csv")

pop_10_19 <- read.csv("data/co-est2019-alldata.csv")

# create GEOID field for both

pop_00_10$STATE_pad <- str_pad(pop_00_10$STATE, width = 2, side = "left", pad = "0")
pop_00_10$COUNTY_pad <- str_pad(pop_00_10$COUNTY, width =3 , side = "left", pad = "0")
pop_00_10$GEOID <- paste(pop_00_10$STATE_pad, pop_00_10$COUNTY_pad, sep = "")

pop_10_19$STATE_pad <- str_pad(pop_10_19$STATE, width = 2, side = "left", pad = "0")
pop_10_19$COUNTY_pad <- str_pad(pop_10_19$COUNTY, width = 3, side = "left", pad = "0")
pop_10_19$GEOID <- paste(pop_10_19$STATE_pad, pop_10_19$COUNTY_pad, sep = "")

# update GEOIDs of Shannon County, South Dakota (now Oglala Lakota County)
# and Wade Hampton Census Area, Alaska (now Kusilvak Census Area)
# otherwise there will be NAs in the pre-2010 data

pop_00_10$GEOID[pop_00_10$GEOID == "46113"] <- "46102"
pop_00_10$GEOID[pop_00_10$GEOID == "02270"] <- "02158"

# for 2000-10, change annual population from wide to long format, first removing 
# 2000 estimate base and 2010 estimates because 2010 is included in second file

pop_00_10 <- pop_00_10[ -c(8, 19:22) ]

pop_00_10 <- pop_00_10 %>% 
  gather(YEAR, POP, POPESTIMATE2000:POPESTIMATE2009) %>%
  separate(YEAR, c("tobedeleted", "YEAR"), sep = 11)

pop_00_10 <- pop_00_10[ -c(1, 9) ]

# repeat for 2010-19, first removing 2010 census pop/estimate base as well as 
# all the extra birth/death/migration fields

pop_10_19 <- pop_10_19[ -c(8:9, 20:166) ]

pop_10_19 <- pop_10_19  %>% 
  gather(YEAR, POP, POPESTIMATE2010:POPESTIMATE2019) %>%
  separate(YEAR, c("tobedeleted", "YEAR"), sep = 11)

pop_10_19 <- pop_10_19[ -c(1, 9) ]

# combine population data

pop <- rbind(pop_00_10, pop_10_19)

pop$YEAR <- as.numeric(pop$YEAR)

# pull out state-level pops

pop_by_state <- subset(pop, COUNTY == 0)

pop_by_state <- pop_by_state[ -c(1:2, 4, 6:7) ]

pop_by_state$STATE <- str_pad(pop_by_state$STATE, width = 2, side = "left", pad = "0")

# remove states from county-level data

pop <- subset(pop, COUNTY != 0)

# join county-level data to counties

counties <- counties %>% 
  left_join(pop, c("GEOID" = "GEOID", "YEAR" = "YEAR"))

counties <- counties[ -c(13:14, 19:22) ]

colnames(counties)[colnames(counties) == "STNAME.x"] <- "STNAME"
colnames(counties)[colnames(counties) == "CTYNAME.x"] <- "CTYNAME"

counties$AREA <- counties$ALAND + counties$AWATER

counties$POPDENSITY <- counties$POP / counties$ALAND

# make sure all county names are capitalized

counties$CTYNAME <- str_to_title(counties$CTYNAME)

# create new field RATE as cases per 100,000 people

counties$RATE <- (counties$CASES / counties$POP) * 100000

#########################
## COUNTY AFFECTED Y/N ##
#########################

cases$AFFECTED <- ifelse(cases$CASES > 0, 1, 0)

#####################################
## PERCENT CHANGE IN CASES & RATES ##
#####################################

counties$DELTA_CASES <- ((counties$CASES - lag(counties$CASES))/lag(counties$CASES)) * 100
counties$DELTA_CASES <- round(counties$DELTA_CASES, digits = 2)

counties$DELTA_RATE <- ((counties$RATE - lag(counties$RATE))/lag(counties$RATE)) * 100
counties$DELTA_RATE <- round(counties$DELTA_RATE, digits = 2)

###########################
## CTY / STATE SEPARATED ##
###########################

df_st_cty <- counties %>% filter(YEAR == 2018) %>% as.data.frame()
df_st_cty <- df_st_cty[, -c(1:4, 6:9, 13:21)]

counties_lines <- counties_lines %>%
  left_join(df_st_cty, c("GEOID" = "GEOID"))

###############################
## STATE-LEVEL CASES & RATES ##
###############################

# In the CDC case data, when county of residence is unknown, the case goes under the state instead. 
# So to get accurate national totals for each year, we need to add county and state data together.  

# read in cases again

cases2 <- read.csv("data/CDC-LD-Case-Counts-by-County-00-18.csv")

# create a new data frame with annual cases by state

cases_by_state <- cases2 %>% 
  group_by(STCODE) %>%
  summarize(total_2000 = sum(Cases2000, na.rm = TRUE),
            total_2001 = sum(Cases2001, na.rm = TRUE),
            total_2002 = sum(Cases2002, na.rm = TRUE),
            total_2003 = sum(Cases2003, na.rm = TRUE),
            total_2004 = sum(Cases2004, na.rm = TRUE),
            total_2005 = sum(Cases2005, na.rm = TRUE),
            total_2006 = sum(Cases2006, na.rm = TRUE),
            total_2007 = sum(Cases2007, na.rm = TRUE),
            total_2008 = sum(Cases2008, na.rm = TRUE),
            total_2009 = sum(Cases2009, na.rm = TRUE),
            total_2010 = sum(Cases2010, na.rm = TRUE),
            total_2011 = sum(Cases2011, na.rm = TRUE),
            total_2012 = sum(Cases2012, na.rm = TRUE),
            total_2013 = sum(Cases2013, na.rm = TRUE),
            total_2014 = sum(Cases2014, na.rm = TRUE),
            total_2015 = sum(Cases2015, na.rm = TRUE),
            total_2016 = sum(Cases2016, na.rm = TRUE),
            total_2017 = sum(Cases2017, na.rm = TRUE),
            total_2018 = sum(Cases2018, na.rm = TRUE))

cases_by_state <- cases_by_state %>% 
  gather(YEAR, CASES, total_2000:total_2018) %>% 
  separate(YEAR, c("tobedeleted", "YEAR"), sep = 6)

cases_by_state$STATEFP <- str_pad(cases_by_state$STCODE, width = 2, side = "left", pad = "0")

cases_by_state <- cases_by_state[ -c(1:2) ]

# remove 2019 pop data (don't have cases) and join to cases

pop_by_state <- subset(pop_by_state, YEAR != 2019)

cases_by_state$YEAR <- as.numeric(cases_by_state$YEAR)

cases_by_state <- cases_by_state %>% 
  left_join(pop_by_state, c("STATEFP" = "STATE", "YEAR" = "YEAR"))

cases_by_state$RATE <- (cases_by_state$CASES / cases_by_state$POP) * 100000

###################
## RURAL / URBAN ##
###################

# read in rural/urban classification data

nchs <- read.csv("data/NCHSURCodes2013.csv")

colnames(nchs)[colnames(nchs) == "ï..FIPS.code"] <- "GEOID"
colnames(nchs)[colnames(nchs) == "State.Abr."] <- "ST_ABBR"
colnames(nchs)[colnames(nchs) == "County.name"] <- "CTYNAME"
colnames(nchs)[colnames(nchs) == "X2013.code"] <- "CODE_2013"
colnames(nchs)[colnames(nchs) == "X2006.code"] <- "CODE_2006"
colnames(nchs)[colnames(nchs) == "X1990.based.code"] <- "CODE_1990"

nchs$GEOID <- str_pad(nchs$GEOID, width = 5, side = "left", pad = "0")

nchs$GEOID <- as.character(nchs$GEOID)

nchs$CODE_2013 <- as.factor(nchs$CODE_2013)
nchs$CODE_2006 <- as.factor(nchs$CODE_2006)
nchs$CODE_1990 <- as.factor(nchs$CODE_1990)

nchs <- nchs[ -c(2:6, 10) ]

# read in counties shapefile

counties_nchs <- st_read("data/counties.shp", stringsAsFactors = FALSE)

# set coordinate system

counties_nchs <- st_set_crs(counties_nchs, "+proj=longlat +datum=WGS84")

# join

counties_nchs <- counties_nchs %>% 
  left_join(nchs, c("GEOID" = "GEOID"))

counties_nchs <- mutate(counties_nchs, Class_txt = case_when(
  CODE_2013 == 1 ~ "Large central metro",
  CODE_2013 == 2 ~ "Large fringe metro",
  CODE_2013 == 3 ~ "Medium metro",
  CODE_2013 == 4 ~ "Small metro",
  CODE_2013 == 5 ~ "Micropolitan",
  CODE_2013 == 6 ~ "Non-core")
)

########################
## IXODES STATUS DATA ##
########################

# read in I. scapularis data

i_scap <- read.csv("data/I_scapularis_status_county_2019.csv")

colnames(i_scap)[colnames(i_scap) == "ï..FIPSCode"] <- "GEOID"

colnames(i_scap)[colnames(i_scap) == "County_Status"] <- "Scap_Status"

i_scap$GEOID <- str_pad(i_scap$GEOID, width = 5, side = "left", pad = "0")

i_scap$GEOID <- as.character(i_scap$GEOID)

i_scap <- i_scap[ -c(2:3, 5) ]

# I. pacificus data

i_pac <- read.csv("data/I_pacificus_status_county_2019.csv")

colnames(i_pac)[colnames(i_pac) == "ï..FIPSCode"] <- "GEOID"

colnames(i_pac)[colnames(i_pac) == "County_Status"] <- "Pac_Status"

i_pac$GEOID <- str_pad(i_pac$GEOID, width = 5, side = "left", pad = "0")

i_pac$GEOID <- as.character(i_pac$GEOID)

i_pac<- i_pac[ -c(2:3, 5) ]

# join them together

tick_status <- i_scap %>% 
  left_join(i_pac, c("GEOID" = "GEOID"))

# update GEOIDs of Shannon County, South Dakota (now Oglala Lakota County)

tick_status$GEOID[tick_status$GEOID == "46113"] <- "46102"

# read in counties shapefile

counties_tick <- st_read("data/counties.shp", stringsAsFactors = FALSE)

# set coordinate system

counties_tick <- st_set_crs(counties_tick, "+proj=longlat +datum=WGS84")

# only have data for conterminous US so remove territories + Hawaii and Alaska

counties_tick <- subset(counties_tick, STATEFP != "02" & STATEFP != "15")

# join tick data

counties_tick <- counties_tick %>% 
  left_join(tick_status, c("GEOID" = "GEOID"))

# create field for either or

counties_tick <- mutate(counties_tick, Either_Status = case_when(
  Scap_Status == "Reported" | Pac_Status == "Reported" ~ "Reported",
  Scap_Status == "Established" | Pac_Status == "Established" ~ "Established",
  TRUE ~ "No Records")
)

# convert status from character to factor

counties_tick$Scap_Status <- as.factor(counties_tick$Scap_Status)
counties_tick$Pac_Status <- as.factor(counties_tick$Pac_Status)

#######################
## WHITE-TAILED DEER ##
#######################

# removing deer layer for now -- needs work

# deer <- st_read("data/deer_density_project.shp", stringsAsFactors = FALSE)
# 
# deer <- st_set_crs(deer, "+proj=longlat +datum=WGS84")
# 
# deer$Density <- as.factor(deer$Density)

##################
## AVERAGE TEMP ##
##################

temp <- read.csv("data/avg_temp_2018.csv")

# read in counties shapefile

counties_temp <- st_read("data/counties.shp", stringsAsFactors = FALSE)

# set coordinate system

counties_temp <- st_set_crs(counties_temp, "+proj=longlat +datum=WGS84")

# create geo identifier that matches identifier in temp data (STABBR-COUNTYFP)

counties_temp$Location.ID <- paste(counties_temp$STABBR, counties_temp$COUNTYFP, sep = "-")

counties_temp <- counties_temp %>% 
  left_join(temp, c("Location.ID" = "Location.ID"))

# have AK data but not HI, so remove both for now

counties_temp <- counties_temp %>% filter(STATEFP != "02" & STATEFP != "15") 

# 1 county has missing data, so remove for now

counties_temp <- counties_temp[which(!is.na(counties_temp$Value)),]

#############
##  PRECIP ##
#############

precip <- read.csv("data/precip_2018.csv")

# read in counties shapefile

counties_precip <- st_read("data/counties.shp", stringsAsFactors = FALSE)

# set coordinate system

counties_precip <- st_set_crs(counties_precip, "+proj=longlat +datum=WGS84")

# create geo identifier that matches identifier in temp data (STABBR-COUNTYFP)

counties_precip$Location.ID <- paste(counties_precip$STABBR, counties_precip$COUNTYFP, sep = "-")

counties_precip <- counties_precip %>% 
  left_join(precip, c("Location.ID" = "Location.ID"))

# have AK data but not HI, so remove both for now

counties_precip <- counties_precip %>% filter(STATEFP != "02" & STATEFP != "15") 

# 1 county has missing data, so remove for now

counties_precip <- counties_precip[which(!is.na(counties_precip$Value)),]

############
## HH INC ##
############

hh_inc <- read.csv("data/income_5Y_2018.csv")

hh_inc <- hh_inc %>% separate(GEO_ID, c("tobedeleted", "GEOID"), sep = 9)

hh_inc <- hh_inc[, -c(1, 3)]

# read in counties shapefile

counties_hh_inc<- st_read("data/counties.shp", stringsAsFactors = FALSE)

# set coordinate system

counties_hh_inc <- st_set_crs(counties_hh_inc, "+proj=longlat +datum=WGS84")

counties_hh_inc <- counties_hh_inc %>% 
  left_join(hh_inc, c("GEOID" = "GEOID"))

counties_hh_inc$S1903_C03_001E <- as.numeric(counties_hh_inc$S1903_C03_001E)

# delete excess fields

counties_hh_inc <- counties_hh_inc[, -c(13:117, 119:252)]

###############
## EDUCATION ##
###############

edu <- read.csv("data/education_5Y_2018.csv")

edu <- edu %>% separate(GEO_ID, c("tobedeleted", "GEOID"), sep = 9)

edu <- edu[, -c(1, 3)]

edu$pop_18plus <- edu$S1501_C01_001E + edu$S1501_C01_006E

edu$pop_less_high <- edu$S1501_C01_002E + edu$S1501_C01_007E + edu$S1501_C01_008E

edu$percent_less_high <- (edu$pop_less_high / edu$pop_18plus) * 100

# read in counties shapefile

counties_edu <- st_read("data/counties.shp", stringsAsFactors = FALSE)

# set coordinate system

counties_edu <- st_set_crs(counties_edu, "+proj=longlat +datum=WGS84")

counties_edu <- counties_edu %>% 
  left_join(edu, c("GEOID" = "GEOID"))

#########
## AGE ##
#########

age <- read.csv("data/census_age_sex_2014_2018.csv")

age <- age %>% separate(GEO_ID, c("tobedeleted", "GEOID"), sep = 9)

age <- age[, -c(1, 3)]

age$pct_05_14 <- ((age$S0101_C01_003E + age$S0101_C01_004E) / age$S0101_C01_001E) * 100

age$pct_45_59 <- ((age$S0101_C01_011E + age$S0101_C01_012E + age$S0101_C01_013E) / age$S0101_C01_001E) * 100

# read in counties shapefile

counties_age <- st_read("data/counties.shp", stringsAsFactors = FALSE)

# set coordinate system

counties_age <- st_set_crs(counties_age, "+proj=longlat +datum=WGS84")

counties_age <- counties_age %>% 
  left_join(age, c("GEOID" = "GEOID"))

####################
## HOUSING CHANGE ##
####################

housing <- read.csv("data/CO-EST2019-ANNHU.csv")

colnames(housing)[colnames(housing) == "ï.."] <- "County"

housing <- subset(housing, County != "United States")

housing <- housing %>% separate(County, c("tobedeleted", "County"), sep = 1)

housing <- housing[, -c(1, 3:4)]

housing <- housing %>% 
  gather(Year, Units, X2010:X2019) %>% 
  separate(Year, c("tobedeleted", "Year"), sep = 1)

housing <- housing[, -c(2)]

housing$Year <- as.numeric(housing$Year)
housing$Units <- as.numeric(housing$Units)

housing <- housing %>% group_by(County) %>% mutate(Delta = ((Units - lag(Units))/lag(Units)) * 100)

counties_housing <- st_read("data/counties.shp", stringsAsFactors = FALSE)

counties_housing <- st_set_crs(counties_housing, "+proj=longlat +datum=WGS84")

counties_housing$CTY_ST <- paste(counties_housing$CTYNAME, counties_housing$STNAME, sep = ", ")

counties_housing <- counties_housing %>% 
  left_join(housing, c("CTY_ST" = "County"))

###################
## GOOGLE TRENDS ##
###################

# Smallest geography for GT data is Designated Market Area (media mkts for Nielsen and the like) 

# dma shp is very large for some reason (sourced from ESRI) and slow to load, so simplifying

# dma <- st_read("data/DMAs_Esri_prj.shp", stringsAsFactors = FALSE)

# dma <- rmapshaper::ms_simplify(dma, keep = 0.05)

# save as new shapefile

# st_write(dma, "data/dma_simplify.shp", delete_layer = T)

# read in new shapefile

dma <- st_read("data/dma_simplify.shp", stringsAsFactors = FALSE)

# set coordinate system

dma <- st_set_crs(dma, "+proj=longlat +datum=WGS84")

gt_ld <- read.csv("data/gt_LD_2019.csv")

gt_tick_bite <- read.csv("data/gt_tick_bite_2019.csv")

gt <- cbind(gt_ld, gt_tick_bite)

gt <- gt[, -c(3)]

dma <- dma %>% 
  left_join(gt, c("NAME" = "DMA"))

colnames(dma)[colnames(dma) == "Lyme.disease...2019."] <- "INTEREST_ld"
colnames(dma)[colnames(dma) == "tick.bite...2019."] <- "INTEREST_tick_bite"

dma$INTEREST_ld[is.na(dma$INTEREST_ld)] <- 0
dma$INTEREST_tick_bite[is.na(dma$INTEREST_tick_bite)] <- 0

####################
## LAND COVER SHP ##
####################  

# read in data

counties_nlcd <- st_read("data/counties_nlcd.shp", stringsAsFactors = FALSE)

counties_nlcd$NLCD_CLASS <- factor(counties_nlcd$NLCD_CLASS, levels = c("Water", "Developed", "Barren", "Forest", "Shrubland", "Herbaceous", "Cultivated", "Wetlands"))

###################
## ELEVATION SHP ##
###################

# read in data

counties_elev <- st_read("data/counties_elev_prj.shp", stringsAsFactors = FALSE)

# set coordinate system

counties_elev <- st_set_crs(counties_elev, "+proj=longlat +datum=WGS84")

counties_elev <- counties_elev %>%
  left_join(df_st_cty, c("GEOID" = "GEOID"))

###############
## SLOPE SHP ##
###############

# read in data

counties_slope <- st_read("data/counties_slope_prj.shp", stringsAsFactors = FALSE)

# set coordinate system

counties_slope <- st_set_crs(counties_slope, "+proj=longlat +datum=WGS84")

counties_slope <- counties_slope %>%
  left_join(df_st_cty, c("GEOID" = "GEOID"))


##############
## NDVI SHP ##
##############

# read in data

counties_ndvi <- st_read("data/counties_ndvi_prj.shp", stringsAsFactors = FALSE)

# set coordinate system

counties_ndvi <- st_set_crs(counties_ndvi, "+proj=longlat +datum=WGS84")

counties_ndvi <- counties_ndvi %>%
  left_join(df_st_cty, c("GEOID" = "GEOID"))

##########
## SOIL ##
##########

counties_soil <- st_read("data/counties_soil_prj.shp", stringsAsFactors = FALSE)

counties_soil <- counties_soil %>%
  left_join(df_st_cty, c("GEOID" = "GEOID"))

counties_soil <- mutate(counties_soil, MAJ_TAX_ORDER_txt = case_when(
  MAJORITY == 1 ~ "Alfisols",
  MAJORITY == 2 ~ "Entisols",
  MAJORITY == 3 ~ "Ultisols",
  MAJORITY == 4 ~ "Mollisols",
  MAJORITY == 5 ~ "Histosols",
  MAJORITY == 6 ~ "Vertisols",
  MAJORITY == 7 ~ "Inceptisols",
  MAJORITY == 8 ~ "Spodosols",
  MAJORITY == 9 ~ "Aridisols",
  MAJORITY == 10 ~ "Misc. (Non-Soil)",
  MAJORITY == 11 ~ "Andisols",
  MAJORITY == 12 ~ "Gelisols"
  
))

counties_soil$MAJ_TAX_ORDER <- factor(counties_soil$MAJ_TAX_ORDER_txt, levels = c("Alfisols", "Andisols", "Aridisols", "Entisols", "Gelisols", "Histosols", "Inceptisols", "Mollisols", "Spodosols", "Ultisols", "Vertisols", "Miscellaneous (Non-Soil)"))

########################
## LANDSCAPE ANALYSIS ##
########################

counties_edge <- st_read("data/counties_edge.shp", stringsAsFactors = FALSE)

# renaming what st_write abbreviated

colnames(counties_edge)[colnames(counties_edge) == "FOR_EDG"] <- "FOR_EDGE"
colnames(counties_edge)[colnames(counties_edge) == "FOR_PAT"] <- "FOR_PATCH"
colnames(counties_edge)[colnames(counties_edge) == "PATCHES"] <- "PATCHES_100HA"
colnames(counties_edge)[colnames(counties_edge) == "FOR_ARE"] <- "FOR_AREA"
colnames(counties_edge)[colnames(counties_edge) == "MEAN_PA"] <- "MEAN_PATCH_SIZE"

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
#age_sex$AgeGroup <- as.factor(age_sex$AgeGroup)
age_sex$AgeGroup <- factor(age_sex$AgeGroup, levels = c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80-84", "85-89", "90+"))
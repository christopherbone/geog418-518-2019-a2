#####
## For this lab you will need the following libraries: 
##spatstat, rgdal, maptools, raster, sp, plyr, lubridate

#####
##Cleaning Data
#load required libraries
#####


##Set Working Directory
dir <- "YOUR WORKING DIR"
setwd(dir)

#####
##Read in and clean data

#Read in city shapefile
VanCity <- readOGR(CITY OF VANCOUVER SHAPEFILE)

#Read in CSV
VanCrime <- read.csv(CRIME DATA)

VanCrime$Date <- as.POSIXct(as.character(VanCrime$incident_datetime), format = "%m/%d/%Y %H:%M")
VanCrime$Year <- year(VanCrime$Date)



#clean up the columns
VanCrime_Clean <- VanCrime[,c(***SELECT COLUMNS IMPORTANT FOR FURTHER ANALYSIS***)]

VanCrime_Clean <- VanCrime_Clean[which(***YEAR IS 2020***),]

Coords <- VanCrime_Clean[,c(***LONG***, ***LAT***)]
crs <- CRS("+init=epsg:4326") 

VanCrimePoints <- SpatialPointsDataFrame(coords = , data = , proj4string = )

VanCrimePoints <- spTransform(VanCrimePoints, CRS("+init=epsg:3005"))
VanCity <- spTransform(VanCity, CRS("+init=epsg:3005"))

VanCrimePoints <- raster::intersect(VanCrimePoints, VanCity)
VanCrimePoints <- VanCrimePoints[,-c(9:14)]

levels(VanCrimePoints$parent_incident_type)


kma <- VanCrimePoints[which(VanCrimePoints$parent_incident_type == ***CHOOSE CRIME***),]


kma$x <- coordinates(kma)[,1]
kma$y <- coordinates(kma)[,2]
#check for and remove duplicated points
#check for duplicated points
#finds zero distance among points
zd <- zerodist(kma)
zd
#remove duplicates
kma <- remove.duplicates(kma)

#create an "extent" object which can be used to create the observation window for spatstat
kma.ext <- as.matrix(extent(kma)) 

#observation window
window <- as.owin(list(xrange = kma.ext[1,], yrange = kma.ext[2,]))

#create ppp oject from spatstat
kma.ppp <- ppp(x = kma$x, y = kma$y, window = window)

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
VicCity <- readOGR(CITY OF VICTORIA SHAPEFILE)

#Read in CSV
VicCrime <- read.csv(CRIME DATA)

VicCrime$Date <- as.POSIXct(as.character(VicCrime$incident_datetime), format = "%m/%d/%Y %H:%M")
VicCrime$Year <- year(VicCrime$Date)



#clean up the columns
VicCrime_Clean <- VicCrime[,c(***SELECT COLUMNS IMPORTANT FOR FURTHER ANALYSIS***)]

VicCrime_Clean <- VicCrime_Clean[which(***YEAR IS 2018***),]

Coords <- VicCrime_Clean[,c(***LONG***, ***LAT***)]
crs <- CRS("+init=epsg:4326") 

VicCrimePoints <- SpatialPointsDataFrame(coords = , data = , proj4string = )

VicCrimePoints <- spTransform(VicCrimePoints, CRS("+init=epsg:3005"))
VicCity <- spTransform(VicCity, CRS("+init=epsg:3005"))

VicCrimePoints <- raster::intersect(VicCrimePoints, VicCity)
VicCrimePoints <- VicCrimePoints[,-c(9:14)]

levels(VicCrimePoints$parent_incident_type)


kma <- VicCrimePoints[which(VicCrimePoints$parent_incident_type == ***CHOOSE CRIME***),]


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

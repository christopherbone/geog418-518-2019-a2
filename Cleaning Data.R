#####
##Read in and clean data
VanCity <- readOGR(".", NAME of SHAPE FILE, verbose = FALSE)
VanCrime <- read.csv(CRIME DATA)

#clean up the columns
VanCrime_Clean <- VanCrime_Clean[which(***YEAR***),]
range(VanCrime_Clean$X)

#omit values with NA
VanCrime_Clean <- na.omit(VanCrime_Clean)
range(VanCrime_Clean$X)

VanCrime_Clean <- VanCrime_Clean[which(***X > ZERO****, ]
range(VanCrime_Clean$X)
range(VanCrime_Clean$Y)

Coords <- VanCrime_Clean[,c(***LONG***, ***LAT***)]
crs <- CRS("+init=epsg:32610") 

#create a file type called a SpatialPointsDataFrame
VanCrimePoints <- SpatialPointsDataFrame(coords = , data = , proj4string = )

#transform the projection of both datasets to ensure that they are the same
VanCrimePoints <- spTransform(VanCrimePoints, CRS("+init=epsg:3005"))
VanCity <- spTransform(VanCity, CRS("+init=epsg:3005"))

#intersect the two datasets
VanCrimePoints <- raster::intersect(VanCrimePoints, VanCity)

#convert the crimes data type to factor
VanCrimePoints@data$TYPE <- as.factor(VanCrimePoints@data$TYPE)
levels(VanCrimePoints$Type)

kma <- VanCrimePoints[which(VanCrimePoints$parent_incident_type == ***CHOOSE CRIME***),]
kma$x <- coordinates(kma)[,1]
kma$y <- coordinates(kma)[,2]

#check for and remove duplicated points
#first, finds zero distance among points to see if there are any duplicates
zd <- zerodist(kma)
zd

#if there are duplicates, remove them
kma <- remove.duplicates(kma)

#create an "extent" object which can be used to create the observation window for spatstat
kma.ext <- as.matrix(extent(kma)) 

#observation window
window <- as.owin(list(xrange = kma.ext[1,], yrange = kma.ext[2,]))

#create ppp oject from spatstat
kma.ppp <- ppp(x = kma$x, y = kma$y, window = window)

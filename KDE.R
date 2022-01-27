#####
###KERNEL DENSITY ESTIMATION
#2D (gaussian) kernel, compare how bandwidth (sigma) selection influences the point density estimates
#since data are projected, sigma is represented in metres
#eps is the width and height of the pixels (1000m X 1000m)
#coerce to a SpatialGridDataFrame for plotting
kde.100 <- density(kma.ppp, sigma = 100, at = "pixels", eps = c(1000, 1000))
kde.SG <- as(kde.100, "SpatialGridDataFrame")
kde.500 <- density(kma.ppp, sigma = 500, at = "pixels", eps = c(1000, 1000))
kde.SG <- cbind(kde.SG, as(kde.500, "SpatialGridDataFrame"))

***CHOOSE SOME OTHER SIGMA VALUES FOR SENSITIVITY ANALYSIS***
  
names(kde.SG) <- c(***NAME YOUR SENSITIVITY TEST COLUMNS***)

#plot
spplot(kde.SG)

#can see how the bandwidth selection influences the density estimates
summary(kde.SG)

#use cross-validation to get the bandwidth that minimizes MSE
bw.d <- bw.diggle(kma.ppp)
#plot the "optimal" bandwidth
plot(bw.d, ylim=c(-10, 10), main= ***CHOOSE AN APPROPRIATE TITLE***)

#density using the cross-validation bandwidth
kde.bwo <- density(kma.ppp, sigma = bw.d, at = "pixels", eps = c(1000, 1000))
plot(kde.bwo)

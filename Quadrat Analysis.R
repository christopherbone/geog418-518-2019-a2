
#####
##QUADRAT ANALYSIS
##First, determine the number of qusdrats 
quads <- ***CHOOSE NUMBER OF QUADRATS***
  
qcount <- quadratcount(kma.ppp, nx = quads, ny = quads)
  
plot(kma.ppp, pch = "+", cex = 0.5)
plot(qcount, add = T, col = "red")
  
qcount.df <- as.data.frame(qcount)
  
##Second, count the number of quadrats with a distinct number of points.
qcount.df <- plyr::count(qcount.df,'Freq')
  
##Change the column names so that x=number of points and f=frequency of quadrats with x point.
colnames(qcount.df) <- c("x","f")
  
  
sum.f.x2 <- 
    
M <- 
    
N <- 
  
sum.fx.2 <- 
    
    
VAR <- 
    
MEAN <- 
    
VMR <- 
    
    
    
##Finally, perform the test statistic to test for the existence of a random spatial pattern.
chi.square = 
p = 1 - pchisq(chi.square, (M - 1))
  
quadResults <- data.frame())

kable(quadResults, caption = "Caption for table.")  
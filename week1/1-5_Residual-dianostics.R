# page [7-9]
# set up data in WN
set.seed(1)
WN <- ts(rnorm(50)) 
# use averrage method
Wnmean<-meanf(WN) 
e<-Wnmean$residuals # store data only col residuals

#Box-Pierce x-squre = Q and p-value > a = 0.05 it white noise
Box.test(e, lag = 7, type = "Box-Pierce", fitdf=1)
#Ljunf-Box x-squre = Q* and p-value > a = 0.05 it white noise
Box.test(e,lag=7,type="Lj",fitdf=1)

# page [10-14] normality tests
#The Shapiro–Wilk test p-value > a = 0.05 makw it normality
shapiro.test(e)

# plot graph for prove this data is white noise and normal  distributed
gghistogram(e) + ggtitle("Histogram of residuals") # prove normal
ggAcf(e)+ ggtitle("ACF of residuals") # prove white noise

# plot check residual
checkresiduals(meanf(WN), lag=7 ,test="LB")
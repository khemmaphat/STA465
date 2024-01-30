library(forecast)
library(ggplot2)

# This function will return count day in every month or quarter
monthdays(AirPassengers) #month data
monthdays(UKgas) # quarter data

# try dividing number od days in each month and make graph smooth 
dframe <- cbind(Monthly = AirPassengers, 
                AirPassengersAverage = AirPassengers/monthdays(AirPassengers))

# facet() use for sparete grapgh follow col
autoplot(dframe, facet=TRUE) + xlab("Years") + ylab("Thousand") 
+ ggtitle("Monthly totals of international airline passengers")

# try plot every tranformation and see result
autoplot(AirPassengers)+ ylab("thousand") + 
xlab("Year") + ggtitle("Monthly totals of international 
airline passengers")
autoplot(sqrt(AirPassengers))+ ylab("thousand") 
+xlab("Year") + ggtitle("Square root totals of 
international airline passengers")
autoplot(AirPassengers^(1/3))+ ylab("thousand") + 
xlab("Year") + ggtitle("Cube root totals of international 
airline passengers")
lambda <- BoxCox.lambda(AirPassengers,lower=0) # this code for fid best lambda value and return that value | lower = 0  it will return positive lambda
autoplot(BoxCox(AirPassengers,lambda))
# page [4 - 8] Average method
# set time series to year
set.seed(1)
WN <- ts(rnorm(50))
write.csv(WN,file="WN.csv")

autoplot(WN) + ggtitle("White noise")

# funtion for preduction next 10 row with average method
# menaf(data, next row count want to predict)
Wnmean <- meanf(WN, 10)
Wnmean # use t-distribution for predcition in exel use z-table

# Ajarn try to Code workflow in meanf 
sd_resid <- Wnmean$model$sd
sd_h<-sd_resid * sqrt(1+1/n)
pf <- Wnmean$mean
n <- length(WN)

# 80% of normal distribution
hi80z <- pf + (sd_h* qnorm(0.9))
lo80z <- pf - (sd_h* qnorm(0.9))
# 95% of normal distribution
hi95z <- pf + (sd_h* qnorm(0.975))
lo95z <- pf - (sd_h* qnorm(0.975))

# 80% of t distribution
hi80t <- pf + (sd_h* qt(0.9,n-1))
lo80t <- pf - (sd_h* qt(0.9,n-1))
# 95% of t distribution
hi95t <- pf + (sd_h* qt(0.975,n-1))
lo95t <- pf - (sd_h* qt(0.975,n-1))

plot(Wnmean)

# page [8-13] Naive Method
WNnaive<-naive(WN, 10)
WNnaive

# Ajarn try to Code workflow in Naive
n <- length(WN)
sd_resid <- sqrt(WNnaive$model[7]$sigma2)
sd_h<-0
for (h in 1:10) sd_h[h]<-sd_resid * sqrt(h)
pf <- WNnaive$mean

#80% of normal distribution
hi80z <- pf + (sd_h* qnorm(0.9))
lo80z <- pf - (sd_h* qnorm(0.9))
#95% of normal distribution
hi95z <- pf + (sd_h* qnorm(0.975))
lo95z <- pf - (sd_h* qnorm(0.975))

plot(WNnaive)

# same naive some time it call random walk forecasts.
WNrwf<-rwf(WN, 10)
WNrwf

plot(WNrwf)

# page [13] Seasonal Naive
write.csv(AirPassengers,file="AirPassengers.csv")

# Notice this graph have Seasonal
autoplot(AirPassengers) + ggtitle("Monthly 
Airline Passenger Numbers 1949-1960")

# function for predict in seasonal naive
# snaive(data, h=(count year want to predict)*(4(quater) | 12(year)))
# defualt predict 2 year
airsnaive<-snaive(AirPassengers , h=3*12)
airsnaive

# Ajarn try to Code workflow in SNaive
n <- length(AirPassengers)
sd_resid <- sqrt(airsnaive$model[7]$sigma2)
sd_h<-0
for (h in 1:24){
k<-as.integer((h-1)/12)
sd_h[h]<-sd_resid * sqrt(k+1)
}
pf <- airsnaive$mean

#80% of normal distribution
hi80z <- pf + (sd_h* qnorm(0.9))
lo80z <- pf - (sd_h* qnorm(0.9))
#95% of normal distribution
hi95z <- pf + (sd_h* qnorm(0.975))
lo95z <- pf - (sd_h* qnorm(0.975))

plot(airsnaive)

# page [19-22] Drift Method
# same function but must use drift=TRUE
airdrift<-rwf(AirPassengers, h=24, drift=TRUE)
airdrift

# Ajarn try to Code workflow in Drift method
m <- frequency(AirPassengers)
lag<-1
fitted <- ts(c(rep(NA, lag), head(fits, -lag)), start = start(AirPassengers), frequency = m)
fit <- summary(lm(AirPassengers-fitted ~ 1, na.action=na.exclude))
b.se <- fit$coefficients[1,2]
b <- fit$coefficients[1,1]
fitted <- fitted + b
res <- y - fitted
mse <- mean(res^2, na.rm=TRUE)
sd_h<-0
for (h in 1:24) sd_h[h]<-sqrt(mse*h + (h*b.se)^2)
pf <- airdrift$mean

#80% of normal distribution
hi80z <- pf + (sd_h* qnorm(0.9))
lo80z <- pf - (sd_h* qnorm(0.9))
#95% of normal distribution
hi95z <- pf + (sd_h* qnorm(0.975))
lo95z <- pf - (sd_h* qnorm(0.975))

plot(airdrift)

# page [23] compare all method
autoplot(AirPassengers) +
autolayer(meanf(AirPassengers, h=48), series="Mean", PI=FALSE) +
autolayer(naive(AirPassengers, h=48),series="Naïve", PI=FALSE) +
autolayer(snaive(AirPassengers, h=48),series="Seasonal naïve", 
PI=FALSE) +
autolayer(rwf(AirPassengers, h=48, drift=TRUE), series="Drift", 
PI=FALSE) +
ggtitle("Forecasts for Monthly totals of international airline 
passengers") + xlab("Year") + ylab("Thousand") + 
guides(colour=guide_legend(title="Forecast"))
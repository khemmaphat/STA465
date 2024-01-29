# try add time series with ts()
# c( ) <- function for create vector for add in time series
# [page 5]
y <- ts(c(123, 39, 78, 52, 110), start=2012)

# [page 5]
# frequency = 1(Annual), 4(Quarterly), 12(Mounthly), 52(Weekly)
# start=c(start year, start at) -> start at should not more frequency
z <- c(1, 2, 3 ,4, 5, 6, 7, 8, 1, 2, 3, 100, 199 ,201, 423)
y1 <- ts(z, frequency=1, start=c(2000, 1))
y4 <- ts(z, frequency=4, start=c(2000, 3))  
y12 <- ts(z, frequency=12, start=c(2000, 11))
y52 <- ts(z, frequency=52, start=c(2003, 51))

# [page 6-8]
# Try to understand data 
help(EuStockMarkets)
head(EuStockMarkets)
plot(EuStockMarkets)

# Load data from ggplot2 and try to understanding
library(ggplot2)
try(data(package = "ggplot2"))
help(economics)
head(economics)

help(AirPassengers)
head(AirPassengers)

help(UKgas)
head(UKgas)


# page[9]
# load Libary for use autoplot or .....
library(ggfortify)
# autoplot(data[,num col to plot], ylab("name of y-axis"))
autoplot(EuStockMarkets[,1]) + ylab("the 
daily closing prices of DAX indices")
# 1:4  for create array[1, 2, 3, 4] for plot 4 col
# facets=boolean true = 1 graph 4 col | false = each col for each graph 
autoplot(EuStockMarkets[,1:4], facets=TRUE) +
ylab("the daily closing prices of major European stock 
indices")
autoplot(EuStockMarkets[,1:4], facets=FALSE) +
ylab("the daily closing prices of major European stock 
indices")


# page[10]
# this error happens because economics deals with numbers, not time series data
# use class( "dataname" ) for check type of data
# autoplot(economics$pce)

# add time series follow date col in economics then can use auto plot
x<-economics
pce <- ts(x$pce, frequency=12,start=c(1967,7))
autoplot(pce)

# can use autoplot becuase class(AirPassengers) = ts
autoplot(AirPassengers)


# page [11]
# plot Follower ajarn code
autoplot(AirPassengers) + ylab("thousand") + xlab("Year") + ggtitle("Monthly totals of international airline passengers")
# make by myself
# step : check class -> make it to time series -> autoplot
autoplot(UKgas) + ylab("million") + xlab("Quarty") + ggtitle("Quarterly UK gas consumption from 1960Q1 to 1986Q4, in millions of therms")

# page [12-14]
# Seasonal plot
library(fpp2)
library(forecast)
# ggseasonplot(data, col=color, continuous(make continuous graph)=boolean, year.labels(make year into graph)=boolean palar(make circle graph)=boolean) 
ggseasonplot(pce, col=rainbow(12), continuous=TRUE , year.labels=TRUE, polar=FALSE)

#make by myself
ggseasonplot(UKgas,  col=rainbow(4), year.labels=TRUE)

# page [15-16]
# Seasonal subseries plot
ggsubseriesplot(AirPassengers) + ylab("thousand") +
ggtitle("Seasonal subseries plot: Monthly totals of international airline 
passengers")

ggsubseriesplot(UKgas)

# page [16 - 18]
# Seasonal plot with TSstudio
library(TSstudio)
ts_seasonal(AirPassengers, type = "all") # plot all type of graph(naormal, cycle, box)
ts_seasonal(AirPassengers, type = "normal") # plot each type
ts_seasonal(AirPassengers, type = "cycle")
ts_seasonal(AirPassengers, type = "box")

# page [19] help me plsssss export and cal by yourself
write.csv(economics,file="economics.csv")

# page [21]
# qplot(x a-axus, y a-xis, data = df)
# as.data.frame make economics from dataset to dataframe
qplot(psavert, pce, data=as.data.frame(economics)) +
ylab("personal savings rate") + xlab("personal 
consumption expenditures, in billions of dollars")

# page [21-22]
library(GGally)
# plot graph for compare value each col
# make it dataframe before compare
ggpairs(as.data.frame(economics[,2:6]))
ggpairs(as.data.frame(EuStockMarkets[,1:4]))

#page [24-26] help me plsssss export and cal by yourself
write.csv(UKgas,file="UKgas.csv")


# page [27-33]  
# Function for plot and see ACF Value
# Type graph see in slide
ggAcf(UKgas,plot=FALSE)
ggAcf(UKgas)

# window() is function for slice data
gas <- window(UKgas, start=1960)
# gglagplot(data, lags=specify the amount of lag, do.lines=make line data from dot data,  )
gglagplot(gas, lags=9, do.lines=FALSE, continuous=FALSE)

AirPassengers2 <- window(AirPassengers, start=1949)
autoplot(AirPassengers2)
ggAcf(AirPassengers2,lag=48)
gglagplot(AirPassengers2, lags=24, do.lines=FALSE, continuous=FALSE)

DAX<-EuStockMarkets[,1]
autoplot(DAX)
ggAcf(DAX,lag=48)
gglagplot(DAX, lags=24, do.lines=FALSE, continuous=FALSE)

set.seed(1)
y <- ts(rnorm(50))

autoplot(y) + ggtitle("White noise")
ggAcf(y)


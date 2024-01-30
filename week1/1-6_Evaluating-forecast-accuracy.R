# page [4-6]
set.seed(1)
WNall<-ts(rnorm(63))
write.csv(WNall,file="WNall.csv")
WN<-window(WNall,start=c(1),end=c(50)) # slice data 1-50
WNtest<-window(WNall,start=c(51)) # slice data 51 - end(63)

# forecast with average method for compare in WNtets
Wnmean<-meanf(WN,h=13)
accuracy(Wnmean)
accuracy(Wnmean, WNtest) # save return value then compare exel in 1-6_exel

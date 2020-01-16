#####--Definition--#####
library(forecast)
library(zoo)
setwd("~/Desktop/Time Series")
wmt <- read.csv("C://Users//HareeshManisha//Downloads//Book8.csv" , header = TRUE)
head(wmt)


#####--Time Series for WMalmart Quarterly data--#####
wmtrev.ts <- ts(wmt$Quaterly.Sales, start = c(2005,1), freq = 4)


#####--time Series for WMT monthly--#####
summary(wmtrev.ts)
plot(wmtrev.ts, 
     xlab = "Year", ylab = "Revenue in Million $", 
     ylim = c(71000, 140000), main = "Walmart Quarterly Revenue", col = "blue")


#####--STL and Acf--#####
wmtrev.stl <- stl(wmtrev.ts, s.window = "periodic")
autoplot(wmtrev.stl, main = "Walmart Quarterly Revenue")
autocase1 <- Acf(wmtrev.ts, lag.max = 12, main = "Autocorrelation for Walmart Quarterly Revenue")

Lag <- round(autocase1$lag, 0)
ACF <- round(autocase1$acf, 3)
data.frame(Lag, ACF)




#########--Parition Data--##################
wmtrev.nValid <- 18
wmtrev.nTrain <- length(wmtrev.ts) - wmtrev.nValid
wmtrev.nTrain
wmtrev.train.ts <- window(wmtrev.ts, start = c(2005, 01), end = c(2005, wmtrev.nTrain))
wmtrev.train.ts
wmtrev.valid.ts <- window(wmtrev.ts, start = c(2005, wmtrev.nTrain + 1), 
                            end = c(2005, (wmtrev.nTrain + wmtrev.nValid)))
wmtrev.valid.ts




#####--Moving Average--#####
wmtrev_trailing_2 <- rollmean(wmtrev.train.ts, k = 2, align = "right")
wmtrev_trailing_3 <- rollmean(wmtrev.train.ts, k = 3, align = "right")
wmtrev_trailing_4 <- rollmean(wmtrev.train.ts, k = 4, align = "right")
wmtrev_trailing_12 <- rollmean(wmtrev.train.ts, k = 12, align = "right")



wmtrev_trail_2 <- c(rep(NA, length(wmtrev.train.ts) - length(wmtrev_trailing_2)), wmtrev_trailing_2)
wmtrev_trail_3 <- c(rep(NA, length(wmtrev.train.ts) - length(wmtrev_trailing_3)), wmtrev_trailing_3)
wmtrev_trail_4 <- c(rep(NA, length(wmtrev.train.ts) - length(wmtrev_trailing_4)), wmtrev_trailing_4)
wmtrev_trail_12 <- c(rep(NA, length(wmtrev.train.ts) - length(wmtrev_trailing_12)), wmtrev_trailing_12)

wmt_ma_table <- cbind(wmtrev.train.ts, wmtrev_trail_2, wmtrev_trail_3, wmtrev_trail_4, wmtrev_trail_12)
wmt_ma_table



wmtrev_trailing_2.pred <- forecast(wmtrev_trailing_2, h=wmtrev.nValid, level = 0)
wmtrev_trailing_3.pred <- forecast(wmtrev_trailing_3, h=wmtrev.nValid, level = 0)
wmtrev_trailing_4.pred <- forecast(wmtrev_trailing_2, h=wmtrev.nValid, level = 0)
wmtrev_trailing_12.pred <- forecast(wmtrev_trailing_2, h=wmtrev.nValid, level = 0)


round(accuracy(wmtrev_trailing_2.pred, wmtrev.valid.ts),3)
round(accuracy(wmtrev_trailing_3.pred, wmtrev.valid.ts),3)
round(accuracy(wmtrev_trailing_4.pred, wmtrev.valid.ts),3)
round(accuracy(wmtrev_trailing_12.pred, wmtrev.valid.ts),3)



#####--Regression--#####



## FIT REGRESSION MODEL WITH QUADRARTIC TREND AND SEASONALITY
wmtrev.train.quad.trend.season <- tslm(wmtrev.train.ts ~ trend + I(trend^2) + season)
summary(wmtrev.train.quad.trend.season)
wmtrev.train.quad.trend.season.pred <- forecast(wmtrev.train.quad.trend.season, h = wmtrev.nValid, level = 0)
wmtrev.train.quad.trend.season.pred




round(accuracy(wmtrev.train.quad.trend.season.pred, wmtrev.valid.ts),3)





#####--Predictability and differencing--#####

wmtrev.ar1<- Arima(wmtrev.ts, order = c(1,0,0))
summary(wmtrev.ar1)


# Create differenced ClosePrice data using (lag-1)
diff.wmtrev.ts <- diff(wmtrev.ts, lag = 4)
diff.wmtrev.ts
Acf(diff.wmtrev.ts, lag.max = 12, main = "Autocorrelation for Differenced WMT Reveue")





#####--AR Model--#####

wmtrev.train.quad.trend.season.pred$residuals
Acf(wmtrev.train.quad.trend.season.pred$residuals, lag.max = 12, 
    main = "Autocorrelation for WMT Revenue Training Residuals")




#####--Holt's Winter--#####
hw.ZZZ <- ets(wmtrev.train.ts, model = "ZZZ")
hw.ZZZ 
hw.ZZZ.pred <- forecast(hw.ZZZ, h = wmtrev.nValid, level = 0)
hw.ZZZ.pred

round(accuracy(hw.ZZZ.pred, wmtrev.valid.ts), 3)






#####--Auto Arima--#####

# Use auto.arima() function to fit ARIMA model.
# use summary() to show auto ARIMA model and its parameters for entire dataset.
auto.arima <- auto.arima(wmtrev.train.ts)
summary(auto.arima)

# Apply forecast() function to make predictions for ts with 
# auto ARIMA model for the future 12 periods. 
auto.arima.pred <- forecast(auto.arima, h = wmtrev.nValid, level = 0)
auto.arima.pred
round(accuracy(auto.arima.pred, wmtrev.valid.ts), 3)






#####--Models on Full Data--#####


#M.A best3#
wmtrev_trailing_3_full <- rollmean(wmtrev.ts, k = 3, align = "right")
wmtrev_trailing_3_full.pred <- forecast(wmtrev_trailing_3_full, h=8, level = 0)
wmtrev_trailing_3_full.pred



#Regression#
wmtrev.train.quad.trend.season_full <- tslm(wmtrev.ts ~ trend + I(trend^2) + season)
summary(wmtrev.train.quad.trend.season_full)
wmtrev.train.quad.trend.season.pred_full <- forecast(wmtrev.train.quad.trend.season_full, h = 8, level = 0)
wmtrev.train.quad.trend.season.pred_full


#Holt's Winter#
hw.ZZZ_full <- ets(wmtrev.ts, model = "ZZZ")
hw.ZZZ_full
hw.ZZZ.pred_full <- forecast(hw.ZZZ_full, h = 8, level = 0)
hw.ZZZ.pred_full


#Auto Arima#
auto.arima <- auto.arima(wmtrev.ts)
summary(auto.arima)

auto.arima.pred <- forecast(auto.arima, h = 8, level = 0)
auto.arima.pred


##Accuracy of the models##

round(accuracy(auto.arima.pred$fitted, wmtrev.ts), 3)
round(accuracy(hw.ZZZ.pred_full$fitted, wmtrev.ts), 3)
round(accuracy(wmtrev.train.quad.trend.season.pred_full$fitted, wmtrev.ts), 3)
round(accuracy(wmtrev_trailing_3_full.pred$fitted, wmtrev.ts), 3)
round(accuracy((naive(wmtrev.ts))$fitted, wmtrev.ts), 3)
round(accuracy((snaive(wmtrev.ts))$fitted, wmtrev.ts), 3)




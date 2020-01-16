# Walmart-Revenue-forecast-for-year-2020-2021

With historical quarterly revenue data for Walmart stores all over the USA. We selected data across all the departments of the stores, 
and the aim is to predict the quarterly revenue for Walmart. We will be  using  various  time  series  analytics  models  such  as  
Moving Average,  Holt-winter’s  model,  Auto  ARIMA  model,  Regression model  with  quadratic  trend  and  seasonality,  Naïve  Bayes  
and seasonal  Naïve  Bayes  to  address  the  problem  and  select  the  best solution.

DATA SOURCE:

Used the following site to get the data:
https://www.macrotrends.net/stocks/charts/WMT/walmart/rev enue

Macrotrends.net  is  a  premier  research  platform  which  is  a  stock
screener for long term investors. This site monitors the annual and quarterly 
revenue and stock data of various organizations so as to guide the investors and help them make an informed decision.


DATASET:

The  dataset used  is  based  on  the  Walmart  annual/quarterly revenue history and growth rate from 2006 to 2019 across all
over the USA and across all store departments. Revenue can be defined as the amount of money a company receives from its customers in 
exchange for the sales of goods or services. Revenue is the top line item on an income statement from which all costs and expenses are 
subtracted to arrive at net income. We replicated the data provided in the above mentioned site into excel so that we could do further 
analysis on the data.


PRE-PROCESS DATA:

Following pre-processing steps were taken to deal with the potential issues with the data:

●	Selected all the Walmart wholesale supermarket stores located all over the USA. Considered all the departments. We filtered the data to keep the data which we required for our objective. This made the data less noisy.
●	Selected Quarterly data starting from 2005-2019 and also tried to see the trend for yearly data.
●	Aggregated  the  quarterly  data  to  yearly  to  visualize  (using different plots) the trend and seasonality if present in the data. And accordingly selected the best models to work on our data which will tried to reveal the best from the Walmart revenue and give us insight of the data.
●	With  this  forecast  if  necessary  Walmart  can  stratergise  or  take precautions to make their revenue better in future.

Partitioned the data in training and validation as partitioning is an  important  preliminary  step  before  applying  any  forecasting 
method. Also, we did partition to avoid overfitting of the data. As overfitted model is likely to perform poorly on the new data to be forecasted.


Build multiple models :
1: First Model: Moving Average model
It is a smoothing method used to smooth out the noise to uncover the  data  patterns.  Using  this  model,  we  estimated  time  series components level, trend, seasonality directly from the data without a predetermined structure.
In this method we forecast the future points by using an average of several  past  consecutive  points  with  window  (m)  decided  by  the user.
The term "moving" represents the fact that as each new actual data point becomes available, a revised MA is computed for the next data period requiring forecasting.


Accuracy metric:
Tried  to  find  accuracy  measures  for  multiple  trailing  moving average after considering different windows.
Based  on  the  accuracy  measures  MAPE  (3.208%)  and  RMSE (4807.973)  for  the  validation  data,  the  best  model i got  it  for trailing moving average window 3.



Second   Model:   Regression   model   with   quadratic   trend   and seasonality
Assuming that the historical data has a non-linear trend (some form of a quadratic trend) and monthly seasonality, we can combine both patterns in one forecasting model.
This  is  an  additive  model  with  quadratic  trend  and  monthly seasonality
The general equation of the model is:

Yt  = b0+ b1 t +b2  t2 + b3  D2 + b4  D3 + … + b13  D12+ e

Accuracy:
Adjusted  R  squared  is  equal  to  0.9718 which indicates that the model is a good fit for the data. The model shows a statistically significant F-statistic (p value is substantially lower than 0.01). Intercept, trend and two regression coefficients of D2 and D3 are statistically significant (p-value lower than 0.01).
Overall this method is statistically significant.
Applied accuracy() function to estimate the performance of the model which we will use later to compare the performance of all the models.


Third Model: Holt-Winter’s model:

Winter’s (Holt-Winter’s) model is used for time series that contains trend and seasonality. In this case we augment the Holt’s model by also capturing the seasonal component.
Winter’s multiplicative model:
Forecast = [Level (Lt) + Trend(Tt)]×Seasonal Component (St)

Ft+k  = (Lt  + k Tt ) × St+k-M

where:   St+k-M  = seasonal index of period t+k-M (M = number of seasons)
 Level component (Lt) (exponential smoothing)
 Trend component (Tt) (linear trend, same as Holt’s model)
 Seasonal component (St) (multiplicative)


●	A  summary  of  Holt-Winter’s (HW)      model      with      the automated    selection    of    the model  options  and  automated selection    of    the    smoothing parameters    for    the    training period as shown above.
●	The HW    model    has    the (M,N,A)         options,         i.e., multiplicative  error,  no  trend and  additive  seasonality.The
optimal value for exponential smoothing constant (alpha) is 0.4109, no  smoothing  constant  for  trend  estimate  (beta),  and 
smoothing constant for seasonality estimate (gamma) is 0.0001.
The  alpha  value  of  this  model  indicates  that  the  model’s  level component tends to be  more global,  while additive seasonality 
is globally  adjusted  as  gamma  is  close  to  zero.  The  latter  is  also indicating that, according to this model, the seasonality 
is not going to change over time.



Model 4: Auto ARIMA
●	ARIMA models are rather complex with a number of parameters involved and complex relationships between the model parts
It  is  hard  (but  not  impossible)  to  clearly  identify  what  specific parameters should be used in the model
Apply ACF and PACF (partial autocorrelation function) charts
However, may not produce optimal results
auto.arima()  function  in  R  is  used  to   identify  optimal  ARIMA
model and its respective (p, d, q)(P, D, Q) parameters.



IMPLEMENTING FORECASTS:

●	After running the models and seeing the accuracy comparisons, we can say that the Auto-ARIMA model proves to be the most accurate model   for   forecasting   the   Walmart   quarterly   revenue.   After comparing   RMSE   and   MAPE   this   model   looks   statistically significant.
●	Ideally this model should be implemented on the historical data and used by Walmart for forecasting the revenue for future periods.




CONCLUSION:

●	In the matter of a few minutes and a few more lines of code, we were able to turn the data points into a concise and fairly safe estimate of the next 2 years of  revenue for Walmart stores  all over the USA across all departments.
●	By implementing the Auto ARIMA model which proved to be the most  accurate  one,  Walmart  management  can  plan  their  future targets in a fully informed manner.
●	We  could  put  this  model  into  production  and  turn  it  into  an interactive web app that business users within the organization could use  to  forecast  revenue  for  any  store  or  department  for  however many quarters they wanted.
●    By  utilizing  this  model  and  the  forecasted  value  Walmart  can
strategize and take precautions to make their maximum profit.






# AlpacaforR 🦙𝘙
Connecting to [Alpaca's](https://alpaca.markets) API and navigating it using R. General and authentication rules regarding Alpaca's Web API interaction can be found [here.](https://docs.alpaca.markets/api-documentation/web-api/) If you have never heard of Alpaca, then you should visit [here!](https://docs.alpaca.markets/about-us/)  


Also, I've created a post that uses AlpacaforR to connect and implement both live and paper trades which can be [read here.](https://jagg19.github.io/2019/04/alpaca-for-r/)

<br>
### Release notes
#### 0.2.0
- Add support for Alpaca Websockets

## Installing AlpacaforR 🦙𝘙

**AlpacaforR** 🦙𝘙 isn't yet available on CRAN, but you may install the development versions of the package from Github.

Install the [devtools](https://cran.r-project.org/web/packages/devtools/readme/README.html) package if you have yet to do so, and then load it in:

```r
install.packages("devtools")
library(devtools)
```

Now, install **AlpacaforR** 🦙𝘙 using devtools `install_github` and then load it in:

```r
install_github("jagg19/AlpacaforR")
library(AlpacaforR)
```




## User Keys & URL 


### KEY-ID and SECRET-KEY

You must set your KEY-ID 🔑 and SECRET-KEY 🗝 for both live and paper APIs as specifically named environment variables.
You can find these values on the respective dashboards. You may need to hit "Regenerate Key" if you've returned to the dashboard and the secret key is no longer visible.
They *must* be named as the following:
```r
Sys.setenv('APCA-PAPER-API-KEY-ID' = "...")
Sys.setenv('APCA-PAPER-API-SECRET-KEY' = "...")
Sys.setenv('APCA-LIVE-API-KEY-ID' = "...")
Sys.setenv('APCA-LIVE-API-SECRET-KEY' = "...")
```

You can test that these have been properly set by calling:
```r
Sys.getenv('APCA-PAPER-API-KEY-ID')
Sys.getenv('APCA-PAPER-API-SECRET-KEY')
Sys.getenv('APCA-LIVE-API-KEY-ID')
Sys.getenv('APCA-LIVE-API-SECRET-KEY')
```

The output should be the key values you've entered. Once you've set these to your environment, you will be able to use any of the **AlpacaforR** 🦙𝘙 functions for the remainder of the session. It is advised to set these parameters globally to persist across R sessions. As per [R Set environment variable permanently](https://stackoverflow.com/questions/49738564/r-set-environment-variable-permanently) If you are using RStudio, you can set these parameters in your .Renviron file found in the folder returned by `Sys.getenv('R_USER')`. The File Option: View Hidden Files must be enabled in your Control Panel (on Windows) to make the .Renviron file visible.

<br>

### Live or Paper URL?
You can learn more about [Account Plans](https://docs.alpaca.markets/account-plans/) if you're interested on the key differences. When using AlpacaforR, you do not have to specify the URL, as the functions handle that on its own. You only need to specify whether or not you are interacting with a live account by setting the `live = "TRUE/FALSE"` argument which is set to FALSE by default. E.g:

```r
#If paper account; you does not need to input anything since live = FALSE is the default.
get_account()

#If live account; you needs to set live = TRUE
get_account(live = TRUE)
```

Not all functions require this since some functions use the same URL regardless of the account type. These functions are `get_assets` 💰, `get_calendar` 🗓, `get_clock` ⏰, and `get_bars` 📊 since the same URL is used for each account type.

<br>

## Getting Your Account
This is made extremely easy through the `get_account` function, which will return account details such as account id 🆔, portfolio value 💲 , buying power 🔌, cash 💵, cash withdrawable 💸, etc. See `?get_account()` for more details or visit the [Account API](https://docs.alpaca.markets/api-documentation/web-api/account/) webpage to learn everything there is to know about the requests and responses for this API.

<br>

> 🛑 You *MUST* have your user keys set as the appropriately named environment variables shown above!

<br>

```r
#If paper account: 
get_account()

#If live account:
get_account(live = TRUE)
```

<br>

## Getting Your Current Positions
You can get all your current positions or only the positions specified by ticker when calling `get_positions()`. See `?get_positions()` for more details. Visit the [Positions API](https://docs.alpaca.markets/api-documentation/web-api/positions/) webpage to learn everything there is to know about the requests and responses for this API.

```r
#If paper account:
get_positions()

#By specific tickers:
get_positions(ticker = c("AAPL","AMZN"))

If live account:
get_positions(ticker = c("AAPL","AMZN"), live = TRUE)
```

<br>

## Managing Orders
Getting, submitting, and cancelling 🚫 orders are also made extremely easy through `get_orders()`, `submit_order()`, `cancel_order()` but require some specific arguments. Visit the [Orders API](https://docs.alpaca.markets/api-documentation/web-api/orders/) webpage to learn everything there is to know about the requests and responses for this API.

<br>

### Getting Orders
To get orders, use `get_orders()` and set the status to your desired option. Status options are "open", "closed", and "all". Default status is set to "open". See `?get_orders()` for more details.

```r
#If paper account:
get_orders(status = "all") 

#If live account:
get_orders(status = "all", live = TRUE)
```

<br>

### Submitting Orders
To submit orders, use `submit_order()` with the appropriate arguments and fire away 🚀. These arguments include ticker, qty, side, type, time_in_force, limit_price, stop price. The required arguments are ticker ("AAPL") 🍎, the share qty (50), side of trade ("buy" or "sell"), and type of order ("market" or "limit" or "stop" or "stoplimit"). 

The options for time_in_force are ("day" or "gtc" or "opg") but the default is set to "day". If you select "limit" or "stop" as your order type, then you must provide the limit_price or stop_price as inputs as well. See `?submit_order()` for more details.

```r
#If paper account:

#A market order
submit_order(ticker = "AAPL", qty = 100, side = "buy", type = "market")

#A market order with "gtc" time_in_force
submit_order(ticker = "AAPL", qty = 100, side = "buy", type = "market", time_in_force = "gtc")

#A limit order
submit_order(ticker = "AAPL", qty = 100, side = "buy", type = "limit", limit_price = 100)




#If live account:
#A market order
submit_order(ticker = "AAPL", qty = 100, side = "buy", type = "market", live = TRUE)

#A market order with "gtc" time_in_force
submit_order(ticker = "AAPL", qty = 100, side = "buy", type = "market", time_in_force = "gtc", live = TRUE)

#A limit order
submit_order(ticker = "AAPL", qty = 100, side = "buy", type = "limit", limit_price = 100, live = TRUE)
```

<br>

### Cancelling Orders
You can cancel 🚫 any open order using `cancel_order()` by providing either the ticker or the orders id. The orders id is one of the many columns returned when using `get_orders()`, or you can just enter the ticker for the order that you want cancelled. The function will search 🕵 for and cancel the most recent open order for the ticker specified. See `?cancel_order()` for more details.

```r
#If paper account:
#Cancelling by ticker, case insensitive
cancel_order(ticker_id = "AAPL")
cancel_order(ticker_id = "aapl")

#Cancelling by order_id
cancel_order(ticker_id = "1n0925a7-aq52-480d-t68f-01d5970182ae")

#OR
orders <- get_orders()
cancel_order(ticker_id = orders$id[1])



#If live account:
cancel_order(ticker_id = "AAPL", live = TRUE)

#Cancelling by order_id
cancel_order(ticker_id = orders$id[1], live = TRUE)
```

<br>

## Getting All / Specific Assets Available
To get all assets 💰 available or just a specific asset 🍎, you can use `get_assets()` and provide a stocks symbol to the ticker argument for a specific asset. You do not need to specify the account type with this function. See `?get_assets()` for more details or visit the [Assets API](https://docs.alpaca.markets/api-documentation/web-api/assets/) webpage to learn everything there is to know about the requests and responses for this API.

```r
#Return ALL assets available on Alpaca
get_assets()

#Return a specific asset
get_assets(ticker = "AAPL")
```

<br>

## Get Pricing Data
Pricing data is accessible through the `get_bars()` function to get pricing data 📈 in OHLCV bar format 📊 for one or multiple tickers. You do not need to specify the account type for this function. The only input needed is the ticker(s) value, and it will return a list 📝 containing pricing data for the last 5 trading days of each ticker. You can easily change the date range as well as the time frame of the OHLCV bars with the "from", "to", and "timeframe" arguments. 




The options for the time frame argument include "minute", "1Min", "5Min", "15Min", "day" or "1D" and has a default value of "1D". The bar limit argument can range from 1 to 1000 and has various default values according to the time frame chosen. If time frame "1D or day" then the limit is set to the # of days. If "15Min" the default is 250, if "5Min" the default is 500, and if "1Min or minute" then the default is the max, 1000. If the date range includes more than 1000 bars, then it will return the 1000 most recent bars. Dates are returned as a column if a daily time frame is set. See `?` for more details. 

See `?get_bars()` for more details or visit the [Market Data API](https://docs.alpaca.markets/api-documentation/web-api/market-data/) webpage to learn everything there is to know about the requests and responses for this API.

```r
#Getting daily pricing data for multiple tickers, and returning the default time frame (last 5 trading days).
tickers <- c("AAPL","AMZN")
get_bars(ticker = tickers)

#Getting daily pricing data since the start of 2019
get_bars(ticker = tickers, from = "2019-01-01")

#Getting 15Min bar pricing data for the last 5 trading days. Default bar limit is set to the value of 250.
get_bars(ticker = tickers, timeframe= "15Min")

#Getting 1Min pricing data for the last 5 trading days. Default bar limit is set to the max value of 1000.
get_bars(ticker = tickers, timeframe= "1Min")
```

<br>

## Getting Open Market Days and Market Clock Data
One of my favorite requests to make while interacting with Alpaca is the calendar 🗓 and clock ⏰ requests. Using the `get_calendar()` and `get_clock()` functions in this package, you can get all the dates and hours from the start of **1970** to the end of **2029** during which the stock market is open while accounting for market holidays.

Visit the [Calendar API](https://docs.alpaca.markets/api-documentation/web-api/calendar/) and [Clock API](https://docs.alpaca.markets/api-documentation/web-api/clock/) webpage to learn everything there is to know about the requests and responses for this API.

```r
#Getting all dates from 1970 to 2029
get_calendar()

#Getting specific dates using date ranges
get_calendar(from = "2000-01-01", to = "2020-01-01")


#Get market clock and see if the market is currently open as well as the times of the next open and close
get_clock()
```



## Start trading in R!
You're all set! 🥳 Now you can start using **AlpacaforR** 🦙𝘙 functions to send and receive [Alpaca](https://alpaca.markets) API requests using R!🍻

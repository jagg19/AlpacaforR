% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/alpaca4R.R
\name{get_positions}
\alias{get_positions}
\title{Get Positions function}
\usage{
get_positions(ticker = NULL, live = FALSE, version = "v2")
}
\arguments{
\item{ticker}{Specify which symbol you want to call by inserting ticker as a string.}

\item{live}{TRUE / FALSE if you are connecting to a live account. Default to FALSE, so it will use the paper url if nothing was provided.}
}
\value{
"asset_id"  Asset ID.

"symbol"  Symbol of the asset.

"exchange"  Exchange name of the asset.

"asset_class"  Asset class name.

"avg_entry_price"  Average entry price of the position.

"qty" The number of shares.

"side" long/short exposure.

"market_value"  Total dollar amount of the position.

"cost_basis"  Total cost basis in dollar.

"unrealized_pl"  Unrealized profit/loss in dollar.

"unrealized_plpc"  Unrealized profit/loss percent (by a factor of 1).

"unrealized_intraday_pl"  Unrealized profit/loss in dollar for the day.

"unrealized_intraday_plpc"  Unrealized profit/loss percent (by a factor of 1).

"current_price"  Current asset price per share.

"lastday_price"  Last day’s asset price per share.

"change_today"  Percent change from last day price (by a factor of 1).
}
\description{
The positions API provides information about an account’s current open positions. The response will include information such as cost basis, shares traded, and market value, which will be updated live as price information is updated. Character values are returned as a string while integer values are returned as numeric.
}
\examples{
get_positions(ticker = "AAPL", live = FALSE, version = "v2")
get_positions(ticker = "AAPL", live = TRUE, version = "v2")
# This gets all positions:
get_positions(version = "v2")
get_positions(live = TRUE, version = "v2")
}

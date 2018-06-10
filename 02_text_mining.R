library(tidytext)
library(tidyverse)
library(tm.plugin.webmining)

company <- c("Microsoft", "Apple", "Google", "Amazon", "Facebook",
             "Twitter", "IBM", "Yahoo", "Netflix")
symbol <- c("MSFT", "AAPL", "GOOG", "AMZN", "FB", "TWTR", "IBM", "YHOO", "NFLX")


download_articles <- function(symbol) {
  WebCorpus(YahooFinanceSource(symbol))
}

stock_articles <- data_frame(company = company, symbol = symbol) %>% mutate(corpus = map(symbol, download_articles))

stock_articles
stock_articles$corpus
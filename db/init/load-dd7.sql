CREATE DATABASE IF NOT EXISTS turning_bullish;
USE turning_bullish;

CREATE TABLE IF NOT EXISTS spy_close_prices (
    date DATE NOT NULL,
    close DECIMAL(5,2),
    PRIMARY KEY (date)
);

LOAD DATA INFILE '/datasets/turning-bullish/SPY_close_price_5Y.csv'
INTO TABLE spy_close_prices
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(date, close);

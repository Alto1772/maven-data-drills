CREATE DATABASE IF NOT EXISTS rolling_up_looking_back;
USE rolling_up_looking_back;

CREATE TABLE IF NOT EXISTS coffee_shop_sales (
    order_id INT AUTO_INCREMENT,
    date DATE,
    store VARCHAR(30),
    product VARCHAR(30),
    quantity INT,
    sales DECIMAL(8,2),
    PRIMARY KEY (order_id)
);

LOAD DATA INFILE '/datasets/rolling-up-looking-back/coffee_shop_sales.csv'
INTO TABLE coffee_shop_sales
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

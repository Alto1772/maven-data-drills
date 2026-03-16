CREATE DATABASE IF NOT EXISTS spot_the_sale;
USE spot_the_sale;

CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT,
    order_date DATE,
    order_quantity INT,
    PRIMARY KEY (order_id)
);

CREATE TABLE IF NOT EXISTS promotions (
    promo_id VARCHAR(7),
    promo_name VARCHAR(30),
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (promo_id)
);


LOAD DATA INFILE '/datasets/promotions/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/datasets/promotions/promotions.csv'
INTO TABLE promotions
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

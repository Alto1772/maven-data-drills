CREATE DATABASE IF NOT EXISTS the_price_is_right;
USE the_price_is_right;

CREATE TABLE IF NOT EXISTS products (
    pizza_id INT AUTO_INCREMENT,
    name VARCHAR(30),
    current_price DECIMAL(6,2),
    PRIMARY KEY (pizza_id)
);

CREATE TABLE IF NOT EXISTS price_history (
    id INT AUTO_INCREMENT,
    pizza_id INT,
    effective_date DATE,
    price DECIMAL(6, 2),
    PRIMARY KEY (id),
    FOREIGN KEY (pizza_id) REFERENCES products(pizza_id)
);

CREATE TABLE IF NOT EXISTS transactions (
    order_detail_id INT AUTO_INCREMENT,
    order_id INT,
    order_date DATE,
    pizza_id INT,
    quantity INT,
    PRIMARY KEY (order_detail_id),
    FOREIGN KEY (pizza_id) REFERENCES products(pizza_id),
    INDEX (order_id)
);

LOAD DATA INFILE '/datasets/the-price-is-right/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/datasets/the-price-is-right/price_history.csv'
INTO TABLE price_history
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(pizza_id, effective_date, price);

LOAD DATA INFILE '/datasets/the-price-is-right/transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

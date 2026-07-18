CREATE DATABASE IF NOT EXISTS cart_combos;
USE cart_combos;

CREATE TABLE IF NOT EXISTS grocery_transactions (
    transaction_id INT,
    transaction_datetime DATETIME,
    register INT(3),
    line_item INT(3),
    upc NUMERIC(15),
    product_name VARCHAR(20),
    quantity INT,
    unit_price DECIMAL(7,2),
    PRIMARY KEY (transaction_id, line_item, upc)
);

LOAD DATA INFILE '/datasets/cart-combos/grocery_transactions.csv'
INTO TABLE grocery_transactions
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

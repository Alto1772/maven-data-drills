CREATE DATABASE IF NOT EXISTS flatten_the_stack;
USE flatten_the_stack;

CREATE TABLE IF NOT EXISTS sales_orders (
    order_number INT AUTO_INCREMENT,
    order_date DATE,
    line_items JSON,
    fulfillment ENUM('Online', 'In store'),
    PRIMARY KEY (order_number)
);

LOAD DATA INFILE '/datasets/flatten-the-stack/sales_orders.csv'
INTO TABLE sales_orders
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

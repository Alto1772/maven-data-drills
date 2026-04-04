CREATE DATABASE IF NOT EXISTS estimate_the_estimate;
USE estimate_the_estimate;

CREATE TABLE IF NOT EXISTS property_sales (
    id INT AUTO_INCREMENT,
    neighborhood VARCHAR(50),
    address VARCHAR(50),
    zip_code INT,
    building_class VARCHAR(5),
    square_feet INT,
    sale_price INT,
    PRIMARY KEY (id)
);

LOAD DATA INFILE '/datasets/estimate-the-estimate/manhattan_property_sales.csv'
INTO TABLE property_sales
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(neighborhood, address, zip_code, building_class, square_feet, sale_price);

CREATE DATABASE IF NOT EXISTS splitting_the_field;
USE splitting_the_field;

CREATE TABLE IF NOT EXISTS baseball_positions (
    id INT AUTO_INCREMENT,
    name VARCHAR(50),
    team VARCHAR(20),
    position VARCHAR(20),
    PRIMARY KEY (id)
);

LOAD DATA INFILE '/datasets/splitting-the-field/baseball_positions.csv'
INTO TABLE baseball_positions
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(name, team, position);

CREATE DATABASE IF NOT EXISTS making_the_cut;
USE making_the_cut;

CREATE TABLE IF NOT EXISTS marathon_data (
    id INT AUTO_INCREMENT,
    age INT,
    gender VARCHAR(1),
    split TIME,
    final TIME,
    PRIMARY KEY (id)
);

LOAD DATA INFILE '/datasets/making-the-cut/marathon-data.csv'
INTO TABLE marathon_data
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(age, gender, split, final);

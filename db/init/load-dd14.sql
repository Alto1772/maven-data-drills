CREATE DATABASE IF NOT EXISTS final_form;
USE final_form;

CREATE TABLE IF NOT EXISTS employee_satisfaction_survey (
    timestamp DATETIME,
    email VARCHAR(50),
    satisfaction TINYINT,
    PRIMARY KEY (timestamp, email)
);

LOAD DATA INFILE '/datasets/final-form/employee_satisfaction_survey.csv'
INTO TABLE employee_satisfaction_survey
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE DATABASE IF NOT EXISTS org_chart_overhaul;
USE org_chart_overhaul;

CREATE TABLE IF NOT EXISTS office_space (
    employee_name VARCHAR(30) NOT NULL,
    manager_name VARCHAR(30),
    PRIMARY KEY (employee_name)
);

LOAD DATA INFILE '/datasets/org-chart-overhaul/OfficeSpace.csv'
INTO TABLE office_space
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(employee_name, @manager_name)
SET manager_name = NULLIF(TRIM(@manager_name), '');

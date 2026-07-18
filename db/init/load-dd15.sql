CREATE DATABASE IF NOT EXISTS readmission_radar;
USE readmission_radar;

CREATE TABLE IF NOT EXISTS inpatient_admissions (
    admission_id VARCHAR(10),
    patient_id VARCHAR(10),
    admission_date DATE,
    discharge_date DATE,
    PRIMARY KEY (admission_id)
);

LOAD DATA INFILE '/datasets/readmission-radar/inpatient_admissions.csv'
INTO TABLE inpatient_admissions
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

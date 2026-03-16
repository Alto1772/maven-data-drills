CREATE DATABASE IF NOT EXISTS movie_metrics;
USE movie_metrics;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT,
    created_at DATE,
    country_code VARCHAR(2),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS activity (
    id INT AUTO_INCREMENT,
    user_id INT,
    date DATE,
    movie_name VARCHAR(60),
    finished TINYINT,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);


LOAD DATA INFILE '/datasets/movie-metrics/users.csv'
INTO TABLE users
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/datasets/movie-metrics/activity.csv'
INTO TABLE activity
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

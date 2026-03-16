CREATE DATABASE IF NOT EXISTS streak_leaderboard;
USE streak_leaderboard;

CREATE TABLE IF NOT EXISTS lesson_streaks (
    id INT AUTO_INCREMENT,
    lesson_id INT,
    date DATE,
    user_id INT,
    user_name VARCHAR(30),
    PRIMARY KEY (id),
    INDEX (user_id, lesson_id)
);

LOAD DATA INFILE '/datasets/streak-leaderboard/LessonStreaks.csv'
INTO TABLE lesson_streaks
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

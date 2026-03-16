WITH first_last AS (
    SELECT DISTINCT
        user_id,
        FIRST_VALUE(date) OVER (PARTITION BY user_id ORDER BY date) AS first_date,
        FIRST_VALUE(movie_name) OVER (PARTITION BY user_id ORDER BY date) AS first_movie,
        FIRST_VALUE(date) OVER (PARTITION BY user_id ORDER BY date DESC) AS last_date,
        FIRST_VALUE(movie_name) OVER (PARTITION BY user_id ORDER BY date DESC) AS last_movie
    FROM activity
    WHERE finished = 1
), started_finished AS (
    SELECT
        user_id,
        COUNT(user_id) AS started,
        SUM(finished = 1) AS finished
    FROM activity
    GROUP BY user_id
)
SELECT
    u.id, u.created_at,
    fl.first_date, fl.first_movie, fl.last_date, fl.last_movie,
    sf.started, sf.finished
FROM users u
JOIN first_last fl ON u.id = fl.user_id
JOIN started_finished sf ON u.id = sf.user_id
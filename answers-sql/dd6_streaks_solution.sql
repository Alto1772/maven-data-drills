WITH numdays AS (
    SELECT
        user_id, user_name, date,
        DATEDIFF(date, LAG(date) OVER(PARTITION BY user_id ORDER BY date)) AS days
    FROM lesson_streaks
    GROUP BY user_id, user_name, date
), grps AS (
    SELECT *,
        SUM(CASE WHEN days IS NULL OR days <> 1 THEN 1 ELSE 0 END) OVER(
            PARTITION BY user_id ORDER BY date
        ) AS grp
    FROM numdays
), streaks AS (
    SELECT
        user_id, user_name,
        MAX(date) AS last_date,
        COUNT(*) AS streak
    FROM grps
    GROUP BY user_id, user_name, grp
)
SELECT user_id, user_name, streak
FROM streaks WHERE last_date = '2025-09-28'
ORDER BY streak DESC;

-- Another solution for grouping by subtracting dates through indexes
WITH indexes AS (
    SELECT
        user_id, user_name, date,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY date) AS idx
    FROM lesson_streaks
    GROUP BY user_id, user_name, date
), streaks AS (
    SELECT
        user_id, user_name,
        -- MIN(date) AS start_date,
        MAX(date) AS end_date,
        DATEDIFF(MAX(date), MIN(date)) + 1 AS streak,
        DATE_SUB(date, INTERVAL idx DAY) AS dategrp
    FROM indexes
    GROUP BY user_id, user_name, dategrp
)
SELECT user_id, user_name, streak
FROM streaks WHERE end_date = '2025-09-28'
ORDER BY streak DESC
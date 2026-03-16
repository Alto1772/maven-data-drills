WITH rolling_avg AS (
    SELECT *,
        CASE
            WHEN COUNT(close) OVER (ORDER BY date) >= 50
            THEN AVG(close) OVER (ORDER BY date ROWS BETWEEN 50 PRECEDING AND CURRENT ROW)
        END AS avg_50day,
        CASE
            WHEN COUNT(close) OVER (ORDER BY date) >= 200
            THEN AVG(close) OVER (ORDER BY date ROWS BETWEEN 200 PRECEDING AND CURRENT ROW)
        END AS avg_200day
    FROM spy_close_prices
)
SELECT *,
    CASE 
        WHEN LAG(avg_50day) OVER (ORDER BY date) < LAG(avg_200day) OVER (ORDER BY date) AND avg_50day >= avg_200day
        THEN 1
        ELSE 0
    END AS golden_cross
FROM rolling_avg
ORDER BY date
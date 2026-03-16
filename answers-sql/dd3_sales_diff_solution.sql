WITH total AS (
    SELECT
        MONTH(date) AS month,
        MAX(MONTHNAME(date)) AS month_name,
        store,
        SUM(sales) AS total_sales
    FROM coffee_shop_sales
    GROUP BY month, store
)
SELECT
    month_name, store, total_sales,
    total_sales - LAG(total_sales) OVER (PARTITION BY store ORDER BY month) AS sales_vs_last_month
FROM total
ORDER BY month, store
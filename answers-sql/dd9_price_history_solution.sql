WITH prices_with_range AS (
    SELECT
        pizza_id,
        effective_date AS start_date,
        LEAD(effective_date) OVER (PARTITION BY pizza_id ORDER BY effective_date) AS end_date,
        price
    FROM price_history
)
SELECT
    t.order_date,
    p.pizza_id,
    p.name,
    h.price,
    t.quantity
FROM transactions t
JOIN products p ON p.pizza_id  = t.pizza_id
JOIN prices_with_range h
    ON h.pizza_id = t.pizza_id AND (
        t.order_date >= h.start_date AND COALESCE(t.order_date < h.end_date, TRUE)
    );

-- Another method using subqueries in Select
SELECT
    t.order_date,
    t.pizza_id,
    t.quantity,
    (
        SELECT ph.price
        FROM price_history ph
        WHERE ph.pizza_id = t.pizza_id
            AND ph.effective_date <= t.order_date
        ORDER BY ph.effective_date DESC
        LIMIT 1
    ) AS price
FROM transactions t;

-- Solution for the total revenue of transactions
WITH prices_with_range AS (
    SELECT
        pizza_id,
        effective_date AS start_date,
        LEAD(effective_date) OVER (PARTITION BY pizza_id ORDER BY effective_date) AS end_date,
        price
    FROM price_history
)
SELECT
    ROUND(SUM(h.price * t.quantity)) AS total_revenue
FROM transactions t
JOIN prices_with_range h
    ON h.pizza_id = t.pizza_id AND (
        t.order_date >= h.start_date AND COALESCE(t.order_date < h.end_date, TRUE)
    );
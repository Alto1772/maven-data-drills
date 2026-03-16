SELECT
    o.*,
    p.promo_id
FROM orders o
LEFT JOIN promotions p
    ON o.order_date BETWEEN p.start_date AND p.end_date;
    
-- Solution to the placed orders without promotions
SELECT
    SUM(p.promo_id IS NULL)
FROM orders o
LEFT JOIN promotions p
    ON o.order_date BETWEEN p.start_date AND p.end_date;
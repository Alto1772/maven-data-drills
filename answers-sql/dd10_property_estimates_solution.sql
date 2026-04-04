WITH avg_market AS (
    SELECT
        zip_code,
        building_class,
        AVG(sale_price / square_feet) avg_price
    FROM property_sales
    GROUP BY zip_code, building_class
)
SELECT
    p.neighborhood,
    p.address,
    p.zip_code,
    p.building_class,
    p.square_feet,
    CASE WHEN p.sale_price = 0
         THEN ROUND(am.avg_price * p.square_feet)
         ELSE p.sale_price
    END AS market_value
FROM property_sales p
JOIN avg_market am
    ON p.zip_code = am.zip_code AND p.building_class = am.building_class;

-- Alternative subquery method
SELECT
    p.neighborhood,
    p.address,
    p.zip_code,
    p.building_class,
    p.square_feet,
    CASE WHEN p.sale_price = 0
         THEN ROUND((
            SELECT AVG(p2.sale_price / p2.square_feet)
            FROM property_sales p2
            GROUP BY zip_code, building_class
            HAVING p2.zip_code = p.zip_code AND p2.building_class = p.building_class
         ) * p.square_feet)
         ELSE p.sale_price
    END AS market_value
FROM property_sales p;
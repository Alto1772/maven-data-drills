SELECT 
    order_number, order_date,
    line_item, product_name, product_price, quantity,
    fulfillment
FROM sales_orders,
    JSON_TABLE(
        sales_orders.line_items,
        '$[*]'
        COLUMNS(
            line_item FOR ORDINALITY,
            product_name VARCHAR(100) PATH '$.product.product_name',
            product_price DECIMAL(6,2) PATH '$.product.product_price',
            quantity INT PATH '$.quantity'
        )
    ) AS items;

-- Solution for total online sales
SELECT
    ROUND(SUM(product_price * quantity)) AS total_online_sales
FROM
    sales_orders,
    JSON_TABLE(
        sales_orders.line_items,
        '$[*]'
        COLUMNS(
            product_price DECIMAL(6,2) PATH '$.product.product_price',
            quantity INT PATH '$.quantity'
        )
    ) AS items
WHERE fulfillment = 'Online';
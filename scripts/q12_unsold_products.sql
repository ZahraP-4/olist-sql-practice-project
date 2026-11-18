-- Q12: Unsold Products | Which product categories had the highest number of products that received no orders
-- during 2017? Show the top 10 categories.

SELECT
    p.product_category_name,
    COUNT(p.product_id) AS products_with_no_orders
FROM public.products AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM public.items AS i
    INNER JOIN public.orders AS o
        ON i.order_id = o.order_id
    WHERE i.product_id = p.product_id
      AND o.order_purchase_timestamp::TIMESTAMP >= '2017-01-01'
      AND o.order_purchase_timestamp::TIMESTAMP < '2018-01-01'
)
GROUP BY p.product_category_name
ORDER BY products_with_no_orders DESC
LIMIT 10;
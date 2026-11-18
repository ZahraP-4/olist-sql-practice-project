-- Q8: Highest-Value Orders | Which 20 delivered orders placed in 2017 had the highest total value,
-- including product prices and shipping charges? Show the number of items and the cost breakdown for each order.

SELECT
	o.order_id,
	COUNT(i.product_id) AS total_products,
	ROUND(SUM(i.price):: NUMERIC , 2) AS total_price_value,
	ROUND(SUM( i.freight_value):: NUMERIC, 2) AS total_freight_value,
	ROUND(SUM(i.price + i.freight_value):: NUMERIC, 2) AS total_value
	
FROM public.orders AS o
LEFT JOIN public.items AS i
	ON o.order_id = i.order_id
WHERE 
	o.order_status = 'delivered'
	AND o.order_purchase_timestamp :: TIMESTAMP >= '2017-01-01'
	AND o.order_purchase_timestamp :: TIMESTAMP < '2018-01-01'
GROUP BY o.order_id
ORDER BY total_value DESC
LIMIT 20;
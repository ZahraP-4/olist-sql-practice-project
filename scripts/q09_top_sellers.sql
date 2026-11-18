-- Q9: Top Sellers | Who were the 15 highest-performing sellers by product sales value in 2017?
-- Include their location, number of delivered orders, and items sold. Consider sellers with at least 30 delivered orders.

SELECT
	s.seller_id,
	s.seller_city,
	s.seller_state,
	ROUND(SUM(i.price):: NUMERIC, 2) AS total_value,
	COUNT(DISTINCT i.order_id) AS num_of_delivered_orders,
	COUNT(*) AS item_sold
FROM public.sellers AS s
LEFT JOIN public.items AS i
	ON s.seller_id = i.seller_id
LEFT JOIN public.orders AS o
	ON i.order_id = o.order_id 
WHERE 
	o.order_purchase_timestamp :: TIMESTAMP >= '2017-01-01'
	AND o.order_purchase_timestamp :: TIMESTAMP < '2018-01-01'
	AND o.order_status = 'delivered'
GROUP BY s.seller_id, s.seller_city, s.seller_state
HAVING COUNT(DISTINCT i.order_id) >= 30
ORDER BY total_value DESC
LIMIT 15;
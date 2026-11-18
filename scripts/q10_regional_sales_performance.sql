-- Q10: Regional Sales Performance | Which Brazilian states generated the highest product sales value in 2017?
-- Compare delivered orders, unique customers, total sales value, and average order value for states with at least 300 delivered orders.

SELECT
	c.customer_state,
	COUNT(DISTINCT c.customer_unique_id) AS unique_customers,
	COUNT(DISTINCT o.order_id) AS delivered_orders,
	ROUND(SUM(i.price):: NUMERIC, 2) AS sales_value,
	ROUND((SUM(i.price)/ COUNT(DISTINCT o.order_id)):: NUMERIC , 2) AS average_order_value
FROM public.customers AS c
LEFT JOIN public.orders AS o
	ON c.customer_id = o.customer_id
LEFT JOIN public.items AS i
	ON  o.order_id = i.order_id
WHERE 
	o.order_purchase_timestamp :: TIMESTAMP >= '2017-01-01'
	AND o.order_purchase_timestamp :: TIMESTAMP < '2018-01-01'
	AND o.order_status = 'delivered'
GROUP BY c.customer_state
HAVING COUNT(DISTINCT o.order_id) >= 300
ORDER BY sales_value DESC;
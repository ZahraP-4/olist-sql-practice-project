-- Q4: Monthly Orders | How many orders were placed each month in 2017, regardless of their status?

SELECT 
	TO_CHAR(order_purchase_timestamp :: TIMESTAMP, 'FMMonth') AS month,
	COUNT(order_id) AS total_orders
FROM public.orders
WHERE  
	order_purchase_timestamp >= '2017-01-01'
	AND order_purchase_timestamp < '2018-01-01'
GROUP BY 
	EXTRACT(MONTH FROM order_purchase_timestamp::TIMESTAMP),
	TO_CHAR(order_purchase_timestamp :: TIMESTAMP, 'FMMonth')
ORDER BY 
	EXTRACT(MONTH FROM order_purchase_timestamp::TIMESTAMP) ASC;
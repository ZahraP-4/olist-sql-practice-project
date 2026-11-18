-- Q1: Order Status Distribution | How many orders are there for each order status?
-- Show the results from highest to lowest.

SELECT 
	order_status,
	COUNT(order_id) AS order_count
FROM public.orders
GROUP BY order_status
ORDER BY order_count DESC;
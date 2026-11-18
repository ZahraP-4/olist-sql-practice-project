-- Q11: Missing Payments | How many orders have no payment records, and how are these orders distributed
-- across different order statuses?

SELECT
	o.order_status,
	COUNT(o.order_id) FILTER (WHERE p.order_id IS NULL) AS num_orders_no_payments
FROM public.orders AS o
LEFT JOIN public.payments AS p
	ON o.order_id = p.order_id
GROUP BY o.order_status
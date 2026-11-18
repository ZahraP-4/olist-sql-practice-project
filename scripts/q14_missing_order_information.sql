-- Q14: Missing Order Information | How does missing approval and delivery information vary across order statuses?
-- Compare the number and percentage of affected orders.

SELECT
    order_status,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE order_approved_at IS NULL) AS missing_approval,
	ROUND(100.0 * COUNT(*) FILTER (WHERE order_approved_at IS NULL) / COUNT(*), 2) AS missing_approval_pct,
    COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL) AS missing_delivery,
    ROUND(100.0 * COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL) / COUNT(*), 2) AS missing_delivery_pct
FROM public.orders
GROUP BY order_status
ORDER BY total_orders DESC;

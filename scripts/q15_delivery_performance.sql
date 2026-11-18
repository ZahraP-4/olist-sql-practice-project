-- Q15: Delivery Performance | Which customer states have the longest delivery times and highest late-delivery percentages?
-- Compare average delivery time, median delivery time, and late-delivery rate for states with at least 100 delivered orders.

SELECT
    c.customer_state,
    COUNT(o.order_id) AS total_delivered_orders,
    ROUND(AVG(o.order_delivered_customer_date::DATE - o.order_purchase_timestamp::DATE), 2) AS avg_delivery_days,
    PERCENTILE_CONT(0.5) WITHIN GROUP (
        ORDER BY (o.order_delivered_customer_date::DATE - o.order_purchase_timestamp::DATE)) AS median_delivery_days,
    ROUND(100.0 * COUNT(*) FILTER (WHERE o.order_delivered_customer_date::DATE > o.order_estimated_delivery_date::DATE
        ) / COUNT(*), 2) AS late_delivery_pct
FROM public.orders AS o
INNER JOIN public.customers AS c
    ON o.customer_id = c.customer_id
WHERE
    o.order_status = 'delivered'
    AND o.order_purchase_timestamp IS NOT NULL
    AND o.order_delivered_customer_date IS NOT NULL
    AND o.order_estimated_delivery_date IS NOT NULL
    AND o.order_delivered_customer_date::TIMESTAMP
        >= o.order_purchase_timestamp::TIMESTAMP
GROUP BY c.customer_state
HAVING COUNT(o.order_id) >= 100
ORDER BY
    avg_delivery_days DESC,
    late_delivery_pct DESC;
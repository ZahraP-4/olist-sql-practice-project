-- Q16: Delivery and Satisfaction | How do customer review scores differ between on-time and late deliveries?
-- Compare average review scores and the percentage of low ratings (1 or 2), considering each order's latest review.

WITH delivery_time AS (
    SELECT
        order_id,
        CASE
            WHEN order_delivered_customer_date::DATE <= order_estimated_delivery_date::DATE THEN 'on-time'
            WHEN order_delivered_customer_date::DATE > order_estimated_delivery_date::DATE THEN 'late'
            ELSE 'Unknown'
        END AS delivery_status
    FROM public.orders
    WHERE order_status = 'delivered'
        AND order_delivered_customer_date IS NOT NULL
        AND order_estimated_delivery_date IS NOT NULL
),

latest_reviews AS (
    SELECT
        order_id,
        review_score,
        ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY review_answer_timestamp::TIMESTAMP DESC NULLS LAST,
		review_creation_date::TIMESTAMP DESC NULLS LAST, review_id DESC) AS rn
    FROM public.reviews
)

SELECT
    d.delivery_status,
    COUNT(*) AS total_reviewed_orders,
    ROUND(AVG(r.review_score), 2) AS average_review_score,
    COUNT(*) FILTER (WHERE r.review_score IN (1, 2)) AS low_scores,
    ROUND(100.0 * COUNT(*) FILTER (WHERE r.review_score IN (1, 2)) / COUNT(*), 2) AS low_scores_pct
FROM delivery_time AS d
INNER JOIN latest_reviews AS r ON d.order_id = r.order_id
WHERE r.rn = 1 AND r.review_score IS NOT NULL
GROUP BY d.delivery_status
ORDER BY average_review_score DESC;
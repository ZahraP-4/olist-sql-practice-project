-- Q6: Market Coverage | Which Brazilian states have customers, sellers, or both?
-- Classify each state based on its market presence.

WITH sellers_count AS (
	SELECT 
		seller_state AS states,
		COUNT(seller_id) AS seller_count
	FROM public.sellers
	GROUP BY seller_state
),
customer_count AS (
	SELECT 
		customer_state AS states,
		COUNT(customer_id) AS customer_count
	FROM public.customers
	GROUP BY customer_state
)

SELECT 
	COALESCE(s.states, c.states) AS states,
	CASE
		WHEN s.states IS NULL THEN 'Customers Only'
		WHEN c.states IS NULL THEN  'Sellers Only'
		WHEN s.states IS NOT NULL AND c.states IS NOT NULL THEN 'Both'
	END AS states_status
FROM sellers_count AS s
FULL OUTER JOIN customer_count AS c
	ON s.states = c.states
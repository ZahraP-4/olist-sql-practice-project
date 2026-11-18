-- Q2: Customer Locations | Which 10 cities in São Paulo state (SP) have the highest number of unique customers?

SELECT 
	customer_city,
	COUNT(DISTINCT customer_unique_id) AS unique_customers_count
FROM public.customers
WHERE customer_state = 'SP'
GROUP BY customer_city
ORDER BY unique_customers_count DESC
LIMIT 10;
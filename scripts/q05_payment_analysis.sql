-- Q5: Payment Analysis | How do payment methods compare in payment record count, unique orders, total payment value,
-- average installments, and percentage of all payment records?
SELECT 
	payment_type,
	COUNT(order_id) AS total_payment_record,
	COUNT(DISTINCT order_id) AS unique_orders,
	ROUND(SUM(payment_value):: NUMERIC, 2) AS total_payment_value,
	ROUND(AVG(payment_installments):: NUMERIC, 2) AS average_installments,
	ROUND(
		100 * (COUNT(*) / SUM(COUNT(*)) OVER())
		, 2) AS total_payment_records_pct 
FROM public.payments
GROUP BY payment_type

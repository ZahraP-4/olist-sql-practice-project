-- Q17: Shipping Charges | Which product categories have the highest shipping charges relative to product sales value?
-- Compare total sales, shipping charges, average shipping charge per item, and shipping-to-sales percentage for
-- categories with at least 200 sold items.

SELECT 
	p.product_category_name,
	COUNT(p.product_id) AS total_sold,
	ROUND(SUM(freight_value):: NUMERIC, 2) AS shipping_value,
	ROUND(SUM(price):: NUMERIC, 2) AS product_sale_value,
	ROUND(SUM(freight_value):: NUMERIC/ COUNT(p.product_id):: NUMERIC, 2) AS avg_shipping_charge_per_item,
	ROUND(100 * (SUM(freight_value):: NUMERIC/ NULLIF(SUM(price), 0):: NUMERIC), 2) AS shipping_to_sales_pct
FROM products AS p
INNER JOIN items AS i
	ON p.product_id = i.product_id
GROUP BY p.product_category_name
HAVING COUNT(p.product_id) >= 200
ORDER BY shipping_to_sales_pct DESC
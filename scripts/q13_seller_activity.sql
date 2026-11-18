-- Q13: Seller Activity | Which sellers had delivered orders between January and August 2017 but no delivered orders
-- during the same period in 2018? Include their locations.

WITH group_a AS(
	SELECT i.seller_id
	FROM public.orders AS o
	INNER JOIN public.items AS i
		ON o.order_id = i.order_id
	WHERE 
		order_purchase_timestamp :: TIMESTAMP >= '2017-01-01'
		AND order_purchase_timestamp :: TIMESTAMP < '2017-09-01'
		AND order_status = 'delivered'
),
group_b AS(
	SELECT i.seller_id
	FROM public.orders AS o
	INNER JOIN public.items AS i
		ON o.order_id = i.order_id
	WHERE 
		order_purchase_timestamp :: TIMESTAMP >= '2018-01-01'
		AND order_purchase_timestamp :: TIMESTAMP < '2018-09-01'
		AND order_status = 'delivered'
)

SELECT
	s.seller_id,
	s.seller_city,
	s.seller_state
FROM group_a AS a
LEFT JOIN public.sellers AS s
	ON a.seller_id = s.seller_id

EXCEPT 

SELECT
	s.seller_id,
	s.seller_city,
	s.seller_state
FROM group_b AS b
LEFT JOIN public.sellers AS s
	ON b.seller_id = s.seller_id

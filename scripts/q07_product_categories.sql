-- Q7: Product Categories | Which 10 product categories contain the highest number of products?
-- Show their English category names.

SELECT
    c.product_category_name_english,
    COUNT(p.product_id) AS total_products
FROM public.products AS p
LEFT JOIN public.categories AS c
    ON p.product_category_name = c.product_category_name
GROUP BY c.product_category_name_english
ORDER BY total_products DESC
LIMIT 10;

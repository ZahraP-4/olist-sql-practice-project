-- Q3: Product Data Quality | How many products have missing category, weight, or dimension information?
-- What percentage of products is affected by each issue?

SELECT
    COUNT(*) AS total_products,
	
    COUNT(*) FILTER (WHERE product_category_name IS NULL)
        AS missing_category,
    ROUND(100.0 * COUNT(*) FILTER (WHERE product_category_name IS NULL) / COUNT(*), 2)
        AS missing_category_pct,

    COUNT(*) FILTER (WHERE product_weight_g IS NULL)
        AS missing_weight,
    ROUND(100.0 * COUNT(*) FILTER (WHERE product_weight_g IS NULL) / COUNT(*), 2)
        AS missing_weight_pct,

    COUNT(*) FILTER (WHERE product_length_cm IS NULL)
        AS missing_length,
    ROUND(100.0 * COUNT(*) FILTER (WHERE product_length_cm IS NULL) / COUNT(*), 2)
        AS missing_length_pct,

    COUNT(*) FILTER (WHERE product_height_cm IS NULL)
        AS missing_height,
    ROUND(100.0 * COUNT(*) FILTER (WHERE product_height_cm IS NULL) / COUNT(*), 2)
        AS missing_height_pct,

    COUNT(*) FILTER (WHERE product_width_cm IS NULL)
        AS missing_width,
    ROUND(100.0 * COUNT(*) FILTER (WHERE product_width_cm IS NULL) / COUNT(*), 2)
        AS missing_width_pct,

    COUNT(*) FILTER (
        WHERE product_category_name IS NULL
           OR product_weight_g IS NULL
           OR product_length_cm IS NULL
           OR product_height_cm IS NULL
           OR product_width_cm IS NULL
    ) AS products_with_missing_data

FROM public.products;

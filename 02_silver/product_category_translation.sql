-- Silver: category translation (Portuguese -> English)
-- Run this BEFORE products.sql, which joins to it.

CREATE OR REPLACE TABLE workspace.silver.product_category_translation AS
SELECT DISTINCT
  TRIM(product_category_name)          AS category_name_pt,
  TRIM(product_category_name_english)  AS category_name_en
FROM workspace.bronze.product_category_translation;

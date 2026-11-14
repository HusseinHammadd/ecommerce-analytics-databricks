-- Silver: cleaned products with English category names
-- Fixes: misspelled source columns ("lenght") renamed, missing categories
-- labeled 'unknown', Portuguese category joined to its English translation.

CREATE OR REPLACE TABLE workspace.silver.products AS
SELECT
  TRIM(p.product_id)                                          AS product_id,
  COALESCE(TRIM(p.product_category_name), 'unknown')          AS category_name_pt,
  COALESCE(t.category_name_en,
           TRIM(p.product_category_name), 'unknown')          AS category_name_en,
  CAST(p.product_name_lenght        AS INT)                   AS product_name_length,
  CAST(p.product_description_lenght AS INT)                   AS product_description_length,
  CAST(p.product_photos_qty         AS INT)                   AS product_photos_qty,
  CAST(p.product_weight_g           AS INT)                   AS product_weight_g,
  CAST(p.product_length_cm          AS INT)                   AS product_length_cm,
  CAST(p.product_height_cm          AS INT)                   AS product_height_cm,
  CAST(p.product_width_cm           AS INT)                   AS product_width_cm
FROM workspace.bronze.products p
LEFT JOIN workspace.silver.product_category_translation t
  ON TRIM(p.product_category_name) = t.category_name_pt;

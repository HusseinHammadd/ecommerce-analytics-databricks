CREATE OR REPLACE TABLE workspace.gold.dim_product AS
SELECT
  product_id,
  category_name_en                                            AS category,
  category_name_pt                                            AS category_pt,
  product_weight_g                                            AS weight_g,
  product_length_cm * product_height_cm * product_width_cm    AS volume_cm3,
  product_photos_qty                                          AS photos_qty,
  product_name_length                                         AS name_length,
  product_description_length                                  AS description_length
FROM workspace.silver.products;
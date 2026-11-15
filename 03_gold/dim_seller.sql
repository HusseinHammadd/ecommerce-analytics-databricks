CREATE OR REPLACE TABLE workspace.gold.dim_seller AS
SELECT
  s.seller_id,
  s.seller_zip_code_prefix  AS zip_code_prefix,
  s.seller_city             AS city,
  s.seller_state            AS state,
  g.latitude,
  g.longitude
FROM workspace.silver.sellers s
LEFT JOIN workspace.silver.geolocation g
  ON s.seller_zip_code_prefix = g.zip_code_prefix;
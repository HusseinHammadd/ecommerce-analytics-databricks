-- Gold: customer dimension
-- Grain: one row per customer_id
-- Adds map coordinates by joining to the deduplicated geolocation table.

CREATE OR REPLACE TABLE workspace.gold.dim_customer AS
SELECT
  c.customer_id,
  c.customer_unique_id,
  c.customer_zip_code_prefix  AS zip_code_prefix,
  c.customer_city             AS city,
  c.customer_state            AS state,
  g.latitude,
  g.longitude
FROM workspace.silver.customers c
LEFT JOIN workspace.silver.geolocation g
  ON c.customer_zip_code_prefix = g.zip_code_prefix;
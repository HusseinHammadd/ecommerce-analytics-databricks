-- Silver: cleaned sellers
-- Fixes: zip codes restored to 5 digits, text trimmed and standardized.

CREATE OR REPLACE TABLE workspace.silver.sellers AS
SELECT
  TRIM(seller_id)                                         AS seller_id,
  LPAD(CAST(seller_zip_code_prefix AS STRING), 5, '0')    AS seller_zip_code_prefix,
  LOWER(TRIM(seller_city))                                AS seller_city,
  UPPER(TRIM(seller_state))                               AS seller_state
FROM workspace.bronze.sellers;

-- Silver: cleaned customers
-- Grain: one row per customer_id (one per order; customer_unique_id identifies the person)
-- Fixes: zip codes restored to 5 digits (leading zeros lost when read as numbers),
--        text trimmed and standardized.

CREATE OR REPLACE TABLE workspace.silver.customers AS
SELECT
  TRIM(customer_id)                                         AS customer_id,
  TRIM(customer_unique_id)                                  AS customer_unique_id,
  LPAD(CAST(customer_zip_code_prefix AS STRING), 5, '0')    AS customer_zip_code_prefix,
  LOWER(TRIM(customer_city))                                AS customer_city,
  UPPER(TRIM(customer_state))                               AS customer_state
FROM workspace.bronze.customers;

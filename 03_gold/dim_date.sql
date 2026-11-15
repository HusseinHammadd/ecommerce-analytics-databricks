CREATE OR REPLACE TABLE workspace.gold.dim_date AS
WITH bounds AS (
  SELECT MIN(CAST(order_purchase_ts AS DATE)) AS start_date,
         MAX(CAST(order_purchase_ts AS DATE)) AS end_date
  FROM workspace.silver.orders
),
days AS (
  SELECT EXPLODE(SEQUENCE(start_date, end_date, INTERVAL 1 DAY)) AS date_key
  FROM bounds
)
SELECT
  date_key,
  YEAR(date_key)                      AS year,
  QUARTER(date_key)                   AS quarter,
  MONTH(date_key)                     AS month,
  DATE_FORMAT(date_key, 'MMMM')       AS month_name,
  DATE_FORMAT(date_key, 'yyyy-MM')    AS year_month,
  DAY(date_key)                       AS day,
  DATE_FORMAT(date_key, 'EEEE')       AS day_name,
  DAYOFWEEK(date_key) IN (1, 7)       AS is_weekend
FROM days;
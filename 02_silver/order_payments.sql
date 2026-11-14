-- Silver: cleaned order payments
-- Grain: one row per (order_id, payment_sequential); an order can be paid in several parts.

CREATE OR REPLACE TABLE workspace.silver.order_payments AS
SELECT
  TRIM(order_id)                                AS order_id,
  CAST(payment_sequential   AS INT)             AS payment_sequential,
  LOWER(TRIM(payment_type))                     AS payment_type,
  CAST(payment_installments AS INT)             AS payment_installments,
  CAST(payment_value        AS DECIMAL(10, 2))  AS payment_value
FROM workspace.bronze.order_payments;

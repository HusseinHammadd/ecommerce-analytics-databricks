CREATE OR REPLACE TABLE workspace.gold.dim_order AS
WITH reviews AS (
  SELECT order_id,
         MAX_BY(review_score, review_created_ts) AS review_score
  FROM workspace.silver.order_reviews
  GROUP BY order_id
),
payments AS (
  SELECT order_id,
         SUM(payment_value)                    AS total_paid,
         MAX_BY(payment_type, payment_value)   AS main_payment_type,
         MAX(payment_installments)             AS installments
  FROM workspace.silver.order_payments
  GROUP BY order_id
)
SELECT
  o.order_id,
  o.order_status,
  o.order_purchase_ts,
  o.is_delivered,
  o.is_late,
  o.delivery_days,
  o.delivery_delay_days,
  r.review_score,
  p.total_paid,
  p.main_payment_type,
  p.installments
FROM workspace.silver.orders o
LEFT JOIN reviews  r ON o.order_id = r.order_id
LEFT JOIN payments p ON o.order_id = p.order_id;
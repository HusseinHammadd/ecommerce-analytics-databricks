CREATE OR REPLACE TABLE workspace.gold.fact_order_items AS
SELECT
  i.order_id,
  i.order_item_id,
  o.customer_id,
  i.product_id,
  i.seller_id,
  CAST(o.order_purchase_ts AS DATE)  AS date_key,
  i.price,
  i.freight_value,
  i.price + i.freight_value          AS total_value
FROM workspace.silver.order_items i
INNER JOIN workspace.silver.orders o
  ON i.order_id = o.order_id;
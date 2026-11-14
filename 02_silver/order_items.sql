-- Silver: cleaned order items
-- Grain: one row per (order_id, order_item_id), i.e. one row per item in an order.

CREATE OR REPLACE TABLE workspace.silver.order_items AS
SELECT
  TRIM(order_id)                                AS order_id,
  CAST(order_item_id AS INT)                    AS order_item_id,
  TRIM(product_id)                              AS product_id,
  TRIM(seller_id)                               AS seller_id,
  CAST(shipping_limit_date AS TIMESTAMP)        AS shipping_limit_ts,
  CAST(price         AS DECIMAL(10, 2))         AS price,
  CAST(freight_value AS DECIMAL(10, 2))         AS freight_value
FROM workspace.bronze.order_items;

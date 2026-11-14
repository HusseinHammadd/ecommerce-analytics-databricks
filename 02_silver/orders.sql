-- Silver: cleaned orders with delivery metrics
-- Missing delivery/approval dates are kept: they reflect orders that were
-- canceled, unavailable or still in transit, not data errors.

CREATE OR REPLACE TABLE workspace.silver.orders AS
WITH typed AS (
  SELECT
    TRIM(order_id)                                       AS order_id,
    TRIM(customer_id)                                    AS customer_id,
    LOWER(TRIM(order_status))                            AS order_status,
    CAST(order_purchase_timestamp      AS TIMESTAMP)     AS order_purchase_ts,
    CAST(order_approved_at             AS TIMESTAMP)     AS order_approved_ts,
    CAST(order_delivered_carrier_date  AS TIMESTAMP)     AS delivered_to_carrier_ts,
    CAST(order_delivered_customer_date AS TIMESTAMP)     AS delivered_to_customer_ts,
    CAST(order_estimated_delivery_date AS TIMESTAMP)     AS estimated_delivery_ts
  FROM workspace.bronze.orders
)
SELECT
  *,
  delivered_to_customer_ts IS NOT NULL                              AS is_delivered,
  DATEDIFF(delivered_to_customer_ts, order_purchase_ts)             AS delivery_days,
  DATEDIFF(delivered_to_customer_ts, estimated_delivery_ts)         AS delivery_delay_days,
  delivered_to_customer_ts > estimated_delivery_ts                  AS is_late
FROM typed;

-- Silver: cleaned order reviews
-- Grain: one row per (review_id, order_id).
-- In the source, the same review_id can be attached to several orders, and
-- exact duplicate rows exist. We keep the latest answered version of each
-- (review_id, order_id) pair and cast text dates/scores to proper types.

CREATE OR REPLACE TABLE workspace.silver.order_reviews AS
WITH typed AS (
  SELECT
    TRIM(review_id)                                 AS review_id,
    TRIM(order_id)                                  AS order_id,
    TRY_CAST(review_score AS INT)                   AS review_score,
    NULLIF(TRIM(review_comment_title), '')          AS review_comment_title,
    NULLIF(TRIM(review_comment_message), '')        AS review_comment_message,
    TRY_CAST(review_creation_date AS TIMESTAMP)     AS review_created_ts,
    TRY_CAST(review_answer_timestamp AS TIMESTAMP)  AS review_answered_ts
  FROM workspace.bronze.order_reviews
),
ranked AS (
  SELECT *,
         ROW_NUMBER() OVER (
           PARTITION BY review_id, order_id
           ORDER BY review_answered_ts DESC NULLS LAST
         ) AS rn
  FROM typed
)
SELECT * EXCEPT (rn)
FROM ranked
WHERE rn = 1
  AND review_score BETWEEN 1 AND 5;

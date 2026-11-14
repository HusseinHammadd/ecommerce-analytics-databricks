-- Silver: geolocation deduplicated to ONE row per zip code prefix
-- Bronze has ~1M rows for ~19k prefixes (many sampled points per prefix),
-- which would multiply rows on any join. We keep:
--   * the average latitude/longitude of points inside Brazil's bounding box
--   * the most frequent city and state spelling for that prefix

CREATE OR REPLACE TABLE workspace.silver.geolocation AS
SELECT
  LPAD(CAST(geolocation_zip_code_prefix AS STRING), 5, '0')  AS zip_code_prefix,
  ROUND(AVG(CAST(geolocation_lat AS DOUBLE)), 6)             AS latitude,
  ROUND(AVG(CAST(geolocation_lng AS DOUBLE)), 6)             AS longitude,
  MODE(LOWER(TRIM(geolocation_city)))                        AS city,
  MODE(UPPER(TRIM(geolocation_state)))                       AS state,
  COUNT(*)                                                   AS source_points
FROM workspace.bronze.geolocation
WHERE CAST(geolocation_lat AS DOUBLE) BETWEEN -34 AND 6
  AND CAST(geolocation_lng AS DOUBLE) BETWEEN -74 AND -34
GROUP BY LPAD(CAST(geolocation_zip_code_prefix AS STRING), 5, '0');

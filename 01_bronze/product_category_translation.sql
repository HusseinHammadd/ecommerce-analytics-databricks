-- Bronze: raw ingestion of product_category_name_translation.csv
-- Source: /Volumes/workspace/bronze/raw_files/product_category_name_translation.csv

CREATE OR REPLACE TABLE workspace.bronze.product_category_translation AS
SELECT *,
       _metadata.file_name AS source_file,
       current_timestamp()  AS ingested_at
FROM read_files(
  '/Volumes/workspace/bronze/raw_files/product_category_name_translation.csv',
  format => 'csv',
  header => true);

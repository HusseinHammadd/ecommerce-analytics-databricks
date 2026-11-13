-- Bronze: raw ingestion of olist_products_dataset.csv
-- Source: /Volumes/workspace/bronze/raw_files/olist_products_dataset.csv

CREATE OR REPLACE TABLE workspace.bronze.products AS
SELECT *,
       _metadata.file_name AS source_file,
       current_timestamp()  AS ingested_at
FROM read_files(
  '/Volumes/workspace/bronze/raw_files/olist_products_dataset.csv',
  format => 'csv',
  header => true);

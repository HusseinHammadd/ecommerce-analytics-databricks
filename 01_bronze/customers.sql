-- Bronze: raw ingestion of olist_customers_dataset.csv
-- Source: /Volumes/workspace/bronze/raw_files/olist_customers_dataset.csv

CREATE OR REPLACE TABLE workspace.bronze.customers AS
SELECT *,
       _metadata.file_name AS source_file,
       current_timestamp()  AS ingested_at
FROM read_files(
  '/Volumes/workspace/bronze/raw_files/olist_customers_dataset.csv',
  format => 'csv',
  header => true);

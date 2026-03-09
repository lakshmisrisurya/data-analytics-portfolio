# Data Ingestion & Incremental Load Framework

This project demonstrates how source-system data can be ingested and incrementally loaded into analytics tables using watermark logic, change tracking, and merge/upsert patterns.

## Business Use Case
Enterprise reporting environments require efficient loading of source data without reprocessing full history every time. This project shows how ingestion pipelines can support scalable and reliable warehouse refreshes.

## Concepts Included
- full load vs incremental load
- watermark-based ingestion
- changed record detection
- merge/upsert logic
- audit columns
- pipeline monitoring fields

## Files
- `stg_source_orders.sql`
- `incremental_orders_load.sql`
- `merge_customer_snapshot.sql`
- `load_audit_check.sql`

## What This Demonstrates
- ingestion architecture thinking
- scalable ETL design
- incremental processing logic
- operational data engineering skills

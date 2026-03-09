SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    total_amount,
    source_updated_at,
    CURRENT_TIMESTAMP AS ingestion_timestamp
FROM raw_orders_source

WITH last_watermark AS (
    SELECT
        COALESCE(MAX(source_updated_at), TIMESTAMP '1900-01-01 00:00:00') AS max_loaded_timestamp
    FROM analytics_orders
),
changed_records AS (
    SELECT
        s.order_id,
        s.customer_id,
        s.order_date,
        s.order_status,
        s.total_amount,
        s.source_updated_at,
        CURRENT_TIMESTAMP AS loaded_at
    FROM stg_source_orders s
    CROSS JOIN last_watermark w
    WHERE s.source_updated_at > w.max_loaded_timestamp
)
SELECT *
FROM changed_records

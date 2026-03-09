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
),
deduplicated_records AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_status,
        total_amount,
        source_updated_at,
        loaded_at,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY source_updated_at DESC, loaded_at DESC
        ) AS rn
    FROM changed_records
)
SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    total_amount,
    source_updated_at,
    loaded_at
FROM deduplicated_records
WHERE rn = 1

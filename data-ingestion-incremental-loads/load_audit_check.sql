SELECT
    CURRENT_DATE AS audit_date,
    COUNT(*) AS loaded_record_count,
    MIN(source_updated_at) AS min_source_updated_at,
    MAX(source_updated_at) AS max_source_updated_at,
    MIN(loaded_at) AS min_loaded_at,
    MAX(loaded_at) AS max_loaded_at
FROM analytics_orders
WHERE DATE(loaded_at) = CURRENT_DATE

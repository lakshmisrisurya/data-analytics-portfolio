WITH source_counts AS (
    SELECT
        DATE(source_updated_at) AS report_date,
        COUNT(*) AS source_record_count
    FROM raw_orders_source
    GROUP BY 1
),
target_counts AS (
    SELECT
        DATE(loaded_at) AS report_date,
        COUNT(*) AS target_record_count
    FROM analytics_orders
    GROUP BY 1
)
SELECT
    COALESCE(s.report_date, t.report_date) AS report_date,
    COALESCE(s.source_record_count, 0) AS source_record_count,
    COALESCE(t.target_record_count, 0) AS target_record_count,
    COALESCE(s.source_record_count, 0) - COALESCE(t.target_record_count, 0) AS count_difference
FROM source_counts s
FULL OUTER JOIN target_counts t
    ON s.report_date = t.report_date
ORDER BY 1

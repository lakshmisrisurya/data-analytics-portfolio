MERGE INTO customer_snapshot tgt
USING (
    SELECT
        customer_id,
        customer_name,
        segment,
        region,
        source_updated_at,
        CURRENT_TIMESTAMP AS loaded_at
    FROM stg_customers
) src
ON tgt.customer_id = src.customer_id
WHEN MATCHED AND (
       COALESCE(tgt.customer_name, '') <> COALESCE(src.customer_name, '')
    OR COALESCE(tgt.segment, '') <> COALESCE(src.segment, '')
    OR COALESCE(tgt.region, '') <> COALESCE(src.region, '')
    OR COALESCE(tgt.source_updated_at, TIMESTAMP '1900-01-01 00:00:00') <> COALESCE(src.source_updated_at, TIMESTAMP '1900-01-01 00:00:00')
)
THEN UPDATE SET
    customer_name = src.customer_name,
    segment = src.segment,
    region = src.region,
    source_updated_at = src.source_updated_at,
    loaded_at = src.loaded_at
WHEN NOT MATCHED THEN INSERT (
    customer_id,
    customer_name,
    segment,
    region,
    source_updated_at,
    loaded_at
)
VALUES (
    src.customer_id,
    src.customer_name,
    src.segment,
    src.region,
    src.source_updated_at,
    src.loaded_at
);

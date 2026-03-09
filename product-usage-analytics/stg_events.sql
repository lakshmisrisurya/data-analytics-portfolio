SELECT
    event_id,
    account_id,
    user_id,
    event_name,
    feature_name,
    CAST(event_timestamp AS TIMESTAMP) AS event_timestamp,
    DATE(CAST(event_timestamp AS TIMESTAMP)) AS event_date
FROM product_events
WHERE event_name IS NOT NULL

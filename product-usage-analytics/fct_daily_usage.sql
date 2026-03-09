SELECT
    event_date,
    account_id,
    COUNT(DISTINCT user_id) AS daily_active_users,
    COUNT(*) AS total_events,
    COUNT(DISTINCT feature_name) AS distinct_features_used
FROM stg_events
GROUP BY 1, 2

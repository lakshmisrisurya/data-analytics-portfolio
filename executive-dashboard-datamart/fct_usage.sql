SELECT
    usage_month,
    customer_id,
    COUNT(DISTINCT active_user_id) AS active_users,
    COUNT(*) AS usage_events
FROM customer_usage
GROUP BY 1, 2

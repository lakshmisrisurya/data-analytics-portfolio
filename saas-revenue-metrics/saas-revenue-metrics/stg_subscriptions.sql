SELECT
    subscription_id,
    customer_id,
    product_name,
    CAST(start_date AS DATE) AS start_date,
    CAST(end_date AS DATE) AS end_date,
    monthly_recurring_revenue AS mrr,
    CASE
        WHEN status = 'Active' THEN 'Active'
        WHEN status = 'Cancelled' THEN 'Cancelled'
        ELSE 'Unknown'
    END AS subscription_status
FROM raw_subscriptions

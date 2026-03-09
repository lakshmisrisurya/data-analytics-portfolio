SELECT
    subscription_id,
    customer_id,
    product_name,
    CAST(start_date AS DATE) AS start_date,
    CAST(end_date AS DATE) AS end_date,
    monthly_recurring_revenue AS mrr,
    CASE
        WHEN UPPER(TRIM(status)) = 'Active' THEN 'Active'
        WHEN UPPER(TRIM(status))  IN ('Cancelled', 'Canceled')  THEN 'Cancelled'
        ELSE 'Unknown'
    END AS subscription_status
FROM raw_subscriptions

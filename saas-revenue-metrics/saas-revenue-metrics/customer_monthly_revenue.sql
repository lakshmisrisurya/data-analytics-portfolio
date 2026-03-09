SELECT
    DATE_TRUNC('month', start_date) AS month_start,
    customer_id,
    SUM(mrr) AS customer_mrr
FROM subscriptions
GROUP BY 1,2

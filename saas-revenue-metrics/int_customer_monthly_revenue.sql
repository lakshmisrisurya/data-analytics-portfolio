WITH calendar AS (
    SELECT DATE '2025-01-01' AS month_start
    UNION ALL
    SELECT DATE '2025-02-01'
    UNION ALL
    SELECT DATE '2025-03-01'
    UNION ALL
    SELECT DATE '2025-04-01'
),
subscription_months AS (
    SELECT
        c.month_start,
        s.customer_id,
        s.subscription_id,
        s.product_name,
        s.mrr
    FROM calendar c
    JOIN stg_subscriptions s
        ON c.month_start BETWEEN DATE_TRUNC('month', s.start_date)
                             AND COALESCE(DATE_TRUNC('month', s.end_date), DATE '2099-12-01')
)
SELECT
    month_start,
    customer_id,
    SUM(mrr) AS customer_mrr
FROM subscription_months
GROUP BY 1, 2

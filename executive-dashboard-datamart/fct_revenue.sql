SELECT
    revenue_month,
    customer_id,
    SUM(recognized_revenue) AS recognized_revenue,
    SUM(recurring_revenue) AS recurring_revenue
FROM finance_revenue
GROUP BY 1, 2

SELECT
    customer_id,
    revenue_month,
    COUNT(*) AS record_count
FROM finance_revenue
GROUP BY 1, 2
HAVING COUNT(*) > 1
ORDER BY record_count DESC

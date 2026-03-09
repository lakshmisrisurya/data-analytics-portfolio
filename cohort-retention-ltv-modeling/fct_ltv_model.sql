WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(recurring_revenue) AS lifetime_revenue,
        COUNT(DISTINCT revenue_month) AS active_months
    FROM recurring_revenue_fact
    GROUP BY 1
),
customer_cost AS (
    SELECT
        customer_id,
        SUM(service_cost) AS lifetime_service_cost,
        SUM(acquisition_cost) AS acquisition_cost
    FROM customer_cost_fact
    GROUP BY 1
)
SELECT
    r.customer_id,
    r.lifetime_revenue,
    r.active_months,
    COALESCE(c.lifetime_service_cost, 0) AS lifetime_service_cost,
    COALESCE(c.acquisition_cost, 0) AS acquisition_cost,
    r.lifetime_revenue - COALESCE(c.lifetime_service_cost, 0) - COALESCE(c.acquisition_cost, 0) AS estimated_ltv
FROM customer_revenue r
LEFT JOIN customer_cost c
    ON r.customer_id = c.customer_id

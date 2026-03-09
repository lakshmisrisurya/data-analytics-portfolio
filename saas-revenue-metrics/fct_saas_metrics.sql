WITH revenue AS (
    SELECT
        month_start,
        customer_id,
        customer_mrr,
        LAG(customer_mrr) OVER (
            PARTITION BY customer_id
            ORDER BY month_start
        ) AS prior_month_mrr
    FROM customer_monthly_revenue
)
SELECT
    month_start,
    customer_id,
    COALESCE(prior_month_mrr, 0) AS beginning_mrr,
    customer_mrr AS ending_mrr,
    CASE
        WHEN COALESCE(prior_month_mrr, 0) = 0 AND customer_mrr > 0 THEN customer_mrr
        ELSE 0
    END AS new_mrr,
    CASE
        WHEN prior_month_mrr > 0 AND customer_mrr = 0 THEN prior_month_mrr
        ELSE 0
    END AS churn_mrr,
    CASE
        WHEN customer_mrr > prior_month_mrr AND prior_month_mrr > 0 THEN customer_mrr - prior_month_mrr
        ELSE 0
    END AS expansion_mrr,
    CASE
        WHEN customer_mrr < prior_month_mrr AND customer_mrr > 0 THEN prior_month_mrr - customer_mrr
        ELSE 0
    END AS contraction_mrr
FROM revenue

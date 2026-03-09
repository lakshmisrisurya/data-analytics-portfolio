WITH customer_cohort AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', first_subscription_date) AS cohort_month
    FROM stg_customer_cohorts
),
monthly_activity AS (
    SELECT
        r.customer_id,
        c.cohort_month,
        DATE_TRUNC('month', r.revenue_month) AS activity_month
    FROM recurring_revenue_fact r
    JOIN customer_cohort c
        ON r.customer_id = c.customer_id
    WHERE r.recurring_revenue > 0
),
cohort_size AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT customer_id) AS cohort_customers
    FROM customer_cohort
    GROUP BY 1
),
retained_customers AS (
    SELECT
        cohort_month,
        activity_month,
        COUNT(DISTINCT customer_id) AS retained_customers
    FROM monthly_activity
    GROUP BY 1, 2
)
SELECT
    r.cohort_month,
    r.activity_month,
    c.cohort_customers,
    r.retained_customers,
    CASE
        WHEN c.cohort_customers > 0
        THEN r.retained_customers * 1.0 / c.cohort_customers
        ELSE 0
    END AS logo_retention_rate
FROM retained_customers r
JOIN cohort_size c
    ON r.cohort_month = c.cohort_month

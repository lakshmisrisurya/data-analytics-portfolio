WITH crm AS (
    SELECT
        DATE_TRUNC('month', close_date) AS report_month,
        SUM(amount) AS crm_total
    FROM crm_opportunities
    WHERE stage_name = 'Closed Won'
    GROUP BY 1
),
billing AS (
    SELECT
        DATE_TRUNC('month', invoice_date) AS report_month,
        SUM(invoice_amount) AS billed_total
    FROM billing_invoices
    GROUP BY 1
)
SELECT
    COALESCE(c.report_month, b.report_month) AS report_month,
    COALESCE(c.crm_total, 0) AS crm_total,
    COALESCE(b.billed_total, 0) AS billed_total,
    COALESCE(c.crm_total, 0) - COALESCE(b.billed_total, 0) AS variance
FROM crm c
FULL OUTER JOIN billing b
    ON c.report_month = b.report_month
ORDER BY 1

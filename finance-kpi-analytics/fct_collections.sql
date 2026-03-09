WITH payments AS (
    SELECT
        invoice_id,
        SUM(payment_amount) AS total_paid,
        MAX(payment_date) AS last_payment_date
    FROM stg_payments
    GROUP BY 1
)
SELECT
    i.invoice_id,
    i.customer_id,
    i.invoice_date,
    i.due_date,
    i.invoice_amount,
    COALESCE(p.total_paid, 0) AS total_paid,
    i.invoice_amount - COALESCE(p.total_paid, 0) AS outstanding_balance,
    CASE
        WHEN i.invoice_amount - COALESCE(p.total_paid, 0) <= 0 THEN 'Paid'
        WHEN CURRENT_DATE > i.due_date THEN 'Overdue'
        ELSE 'Open'
    END AS collection_status,
    CASE
        WHEN p.last_payment_date IS NOT NULL THEN DATEDIFF(day, i.invoice_date, p.last_payment_date)
        ELSE NULL
    END AS days_to_collect
FROM stg_invoices i
LEFT JOIN payments p
    ON i.invoice_id = p.invoice_id

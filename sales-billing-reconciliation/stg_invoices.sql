SELECT
    invoice_id,
    account_id,
    invoice_date,
    invoice_amount,
    invoice_status
FROM billing_invoices
WHERE invoice_status IN ('Posted', 'Paid')

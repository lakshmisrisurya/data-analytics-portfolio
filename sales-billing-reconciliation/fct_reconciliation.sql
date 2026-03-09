WITH opps AS (
    SELECT
        account_id,
        SUM(closed_won_amount) AS total_closed_won
    FROM stg_opportunities
    GROUP BY 1
),
contracts AS (
    SELECT
        account_id,
        SUM(contract_value) AS total_contract_value
    FROM stg_contracts
    GROUP BY 1
),
invoices AS (
    SELECT
        account_id,
        SUM(invoice_amount) AS total_invoiced
    FROM stg_invoices
    GROUP BY 1
)
SELECT
    COALESCE(o.account_id, c.account_id, i.account_id) AS account_id,
    COALESCE(o.total_closed_won, 0) AS total_closed_won,
    COALESCE(c.total_contract_value, 0) AS total_contract_value,
    COALESCE(i.total_invoiced, 0) AS total_invoiced,
    COALESCE(o.total_closed_won, 0) - COALESCE(c.total_contract_value, 0) AS opp_vs_contract_gap,
    COALESCE(c.total_contract_value, 0) - COALESCE(i.total_invoiced, 0) AS contract_vs_invoice_gap,
    CASE
        WHEN COALESCE(o.total_closed_won, 0) <> COALESCE(c.total_contract_value, 0)
          OR COALESCE(c.total_contract_value, 0) <> COALESCE(i.total_invoiced, 0)
        THEN 'Mismatch'
        ELSE 'Matched'
    END AS reconciliation_status
FROM opps o
FULL OUTER JOIN contracts c
    ON o.account_id = c.account_id
FULL OUTER JOIN invoices i
    ON COALESCE(o.account_id, c.account_id) = i.account_id

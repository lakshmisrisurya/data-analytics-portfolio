SELECT
    COUNT(*) AS null_critical_field_count
FROM crm_opportunities
WHERE opportunity_id IS NULL
   OR account_id IS NULL
   OR close_date IS NULL
   OR amount IS NULL

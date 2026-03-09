SELECT
    opportunity_id,
    account_id,
    opportunity_name,
    close_date,
    amount AS closed_won_amount,
    stage_name
FROM crm_opportunities
WHERE stage_name = 'Closed Won'

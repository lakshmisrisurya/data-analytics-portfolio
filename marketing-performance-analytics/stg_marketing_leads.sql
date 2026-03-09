SELECT
    lead_id,
    contact_id,
    account_id,
    lead_source,
    campaign_id,
    created_date,
    mql_date,
    sql_date,
    opportunity_id,
    opportunity_created_date,
    closed_won_date,
    pipeline_amount,
    closed_won_amount,
    CASE WHEN mql_date IS NOT NULL THEN 1 ELSE 0 END AS is_mql,
    CASE WHEN sql_date IS NOT NULL THEN 1 ELSE 0 END AS is_sql,
    CASE WHEN opportunity_id IS NOT NULL THEN 1 ELSE 0 END AS is_opportunity,
    CASE WHEN closed_won_date IS NOT NULL THEN 1 ELSE 0 END AS is_closed_won
FROM crm_marketing_leads

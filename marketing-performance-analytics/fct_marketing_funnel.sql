WITH lead_funnel AS (
    SELECT
        DATE_TRUNC('month', created_date) AS lead_month,
        lead_source,
        campaign_id,
        COUNT(DISTINCT lead_id) AS leads,
        SUM(is_mql) AS mqls,
        SUM(is_sql) AS sqls,
        SUM(is_opportunity) AS opportunities,
        SUM(is_closed_won) AS closed_won_count,
        SUM(COALESCE(pipeline_amount, 0)) AS pipeline_generated,
        SUM(COALESCE(closed_won_amount, 0)) AS closed_won_revenue
    FROM stg_marketing_leads
    GROUP BY 1, 2, 3
)
SELECT
    lead_month,
    lead_source,
    campaign_id,
    leads,
    mqls,
    sqls,
    opportunities,
    closed_won_count,
    pipeline_generated,
    closed_won_revenue,
    CASE WHEN leads > 0 THEN mqls * 1.0 / leads ELSE 0 END AS lead_to_mql_rate,
    CASE WHEN mqls > 0 THEN sqls * 1.0 / mqls ELSE 0 END AS mql_to_sql_rate,
    CASE WHEN sqls > 0 THEN opportunities * 1.0 / sqls ELSE 0 END AS sql_to_opp_rate,
    CASE WHEN opportunities > 0 THEN closed_won_count * 1.0 / opportunities ELSE 0 END AS opp_to_win_rate
FROM lead_funnel

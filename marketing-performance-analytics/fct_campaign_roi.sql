WITH funnel AS (
    SELECT
        campaign_id,
        DATE_TRUNC('month', lead_month) AS report_month,
        SUM(leads) AS leads,
        SUM(mqls) AS mqls,
        SUM(opportunities) AS opportunities,
        SUM(pipeline_generated) AS pipeline_generated,
        SUM(closed_won_revenue) AS closed_won_revenue
    FROM fct_marketing_funnel
    GROUP BY 1, 2
),
spend AS (
    SELECT
        campaign_id,
        DATE_TRUNC('month', spend_month) AS report_month,
        SUM(spend_amount) AS total_spend,
        SUM(impressions) AS impressions,
        SUM(clicks) AS clicks
    FROM stg_campaign_spend
    GROUP BY 1, 2
)
SELECT
    COALESCE(f.campaign_id, s.campaign_id) AS campaign_id,
    COALESCE(f.report_month, s.report_month) AS report_month,
    COALESCE(f.leads, 0) AS leads,
    COALESCE(f.mqls, 0) AS mqls,
    COALESCE(f.opportunities, 0) AS opportunities,
    COALESCE(f.pipeline_generated, 0) AS pipeline_generated,
    COALESCE(f.closed_won_revenue, 0) AS closed_won_revenue,
    COALESCE(s.total_spend, 0) AS total_spend,
    COALESCE(s.impressions, 0) AS impressions,
    COALESCE(s.clicks, 0) AS clicks,
    CASE WHEN COALESCE(s.total_spend, 0) > 0 THEN COALESCE(f.leads, 0) * 1.0 / s.total_spend ELSE 0 END AS leads_per_dollar,
    CASE WHEN COALESCE(f.leads, 0) > 0 THEN COALESCE(s.total_spend, 0) * 1.0 / f.leads ELSE 0 END AS cost_per_lead,
    CASE WHEN COALESCE(f.mqls, 0) > 0 THEN COALESCE(s.total_spend, 0) * 1.0 / f.mqls ELSE 0 END AS cost_per_mql,
    CASE WHEN COALESCE(f.opportunities, 0) > 0 THEN COALESCE(s.total_spend, 0) * 1.0 / f.opportunities ELSE 0 END AS cost_per_opportunity,
    CASE WHEN COALESCE(s.total_spend, 0) > 0 THEN COALESCE(f.closed_won_revenue, 0) * 1.0 / s.total_spend ELSE 0 END AS roas
FROM funnel f
FULL OUTER JOIN spend s
    ON f.campaign_id = s.campaign_id
   AND f.report_month = s.report_month

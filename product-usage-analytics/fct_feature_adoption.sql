WITH first_feature_use AS (
    SELECT
        account_id,
        feature_name,
        MIN(event_date) AS first_used_date
    FROM stg_events
    GROUP BY 1, 2
)
SELECT
    feature_name,
    COUNT(DISTINCT account_id) AS adopted_accounts,
    MIN(first_used_date) AS earliest_adoption_date,
    MAX(first_used_date) AS latest_adoption_date
FROM first_feature_use
GROUP BY 1
ORDER BY adopted_accounts DESC

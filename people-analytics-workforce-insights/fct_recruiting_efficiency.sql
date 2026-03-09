SELECT
    department,
    recruiter_name,
    COUNT(DISTINCT requisition_id) AS requisitions,
    COUNT(DISTINCT CASE WHEN status = 'Closed' THEN requisition_id END) AS closed_requisitions,
    SUM(COALESCE(offers_extended, 0)) AS offers_extended,
    SUM(COALESCE(offers_accepted, 0)) AS offers_accepted,
    AVG(
        CASE
            WHEN closed_date IS NOT NULL AND opened_date IS NOT NULL
            THEN DATEDIFF(day, opened_date, closed_date)
            ELSE NULL
        END
    ) AS avg_time_to_fill_days,
    AVG(
        CASE
            WHEN candidate_hired_date IS NOT NULL AND accepted_offer_date IS NOT NULL
            THEN DATEDIFF(day, accepted_offer_date, candidate_hired_date)
            ELSE NULL
        END
    ) AS avg_time_to_hire_days,
    CASE
        WHEN SUM(COALESCE(offers_extended, 0)) > 0
        THEN SUM(COALESCE(offers_accepted, 0)) * 1.0 / SUM(COALESCE(offers_extended, 0))
        ELSE 0
    END AS offer_acceptance_rate
FROM stg_requisitions
GROUP BY 1, 2

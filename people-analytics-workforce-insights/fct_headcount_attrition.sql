WITH employee_base AS (
    SELECT
        employee_id,
        department,
        location,
        manager_id,
        hire_date,
        termination_date,
        termination_type
    FROM stg_employees
),
monthly_headcount AS (
    SELECT
        DATE_TRUNC('month', hire_date) AS report_month,
        department,
        COUNT(DISTINCT employee_id) AS new_hires
    FROM employee_base
    GROUP BY 1, 2
),
monthly_terms AS (
    SELECT
        DATE_TRUNC('month', termination_date) AS report_month,
        department,
        COUNT(DISTINCT employee_id) AS terminations,
        COUNT(DISTINCT CASE WHEN termination_type = 'Voluntary' THEN employee_id END) AS voluntary_terminations,
        COUNT(DISTINCT CASE WHEN termination_type = 'Involuntary' THEN employee_id END) AS involuntary_terminations
    FROM employee_base
    WHERE termination_date IS NOT NULL
    GROUP BY 1, 2
),
active_snapshot AS (
    SELECT
        department,
        COUNT(DISTINCT employee_id) AS active_headcount
    FROM employee_base
    WHERE termination_date IS NULL
    GROUP BY 1
)
SELECT
    COALESCE(h.report_month, t.report_month) AS report_month,
    COALESCE(h.department, t.department, a.department) AS department,
    COALESCE(h.new_hires, 0) AS new_hires,
    COALESCE(t.terminations, 0) AS terminations,
    COALESCE(t.voluntary_terminations, 0) AS voluntary_terminations,
    COALESCE(t.involuntary_terminations, 0) AS involuntary_terminations,
    COALESCE(a.active_headcount, 0) AS active_headcount,
    CASE
        WHEN COALESCE(a.active_headcount, 0) > 0
        THEN COALESCE(t.terminations, 0) * 1.0 / a.active_headcount
        ELSE 0
    END AS attrition_rate
FROM monthly_headcount h
FULL OUTER JOIN monthly_terms t
    ON h.report_month = t.report_month
   AND h.department = t.department
LEFT JOIN active_snapshot a
    ON COALESCE(h.department, t.department) = a.department

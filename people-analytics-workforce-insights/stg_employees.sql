SELECT
    employee_id,
    department,
    job_level,
    manager_id,
    location,
    gender,
    ethnicity_group,
    hire_date,
    termination_date,
    termination_type,
    CASE
        WHEN termination_date IS NULL THEN 'Active'
        ELSE 'Inactive'
    END AS employee_status
FROM hr_employees

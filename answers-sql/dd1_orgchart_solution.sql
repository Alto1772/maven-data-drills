WITH RECURSIVE hierarchy AS (
    SELECT
        employee_name,
        manager_name,
        CAST(employee_name AS char(160)) AS reporting_hierarchy
    FROM office_space
    WHERE manager_name IS NULL
    UNION ALL
    SELECT
        os.employee_name,
        os.manager_name,
        CONCAT(rc.reporting_hierarchy, " > ", os.employee_name)
    FROM office_space os
    JOIN hierarchy rc ON rc.employee_name = os.manager_name
), manager_map AS (
    SELECT
        employee_name AS manager_name,
        employee_name AS sub_emp
    FROM office_space
    UNION ALL
    SELECT
        mm.manager_name,
        os.employee_name
    FROM office_space os
    JOIN manager_map mm ON os.manager_name = mm.sub_emp
), totals AS (
    SELECT
        manager_name, COUNT(sub_emp) - 1 AS total_reports
    FROM manager_map
    GROUP BY manager_name
), direct_reports AS (
    SELECT manager_name, COUNT(manager_name) AS direct_reports
    FROM office_space
    GROUP BY manager_name
)
SELECT
    h.*,
    COALESCE(d.direct_reports, 0) AS direct_reports,
    t.total_reports
FROM hierarchy h
JOIN totals t ON h.employee_name = t.manager_name
LEFT JOIN direct_reports d ON h.employee_name = d.manager_name
ORDER BY total_reports DESC, direct_reports DESC;

-- Solution to the sum of total reports
WITH RECURSIVE manager_map AS (
    SELECT
        employee_name AS manager_name,
        employee_name AS sub_emp
    FROM office_space
    UNION ALL
    SELECT
        mm.manager_name,
        os.employee_name
    FROM office_space os
    JOIN manager_map mm ON os.manager_name = mm.sub_emp
), totals AS (
    SELECT
        manager_name, COUNT(sub_emp) - 1 AS total_reports
    FROM manager_map
    GROUP BY manager_name
)
SELECT SUM(total_reports) FROM totals
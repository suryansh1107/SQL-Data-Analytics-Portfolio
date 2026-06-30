-- ============================================================
-- PROJECT 5: HR ANALYTICS DASHBOARD
-- Author: Aman Yadav
-- Tool: PostgreSQL 18 + pgAdmin
-- Description: Employee attrition, salary, and tenure analysis
--              for workforce planning decisions
-- ============================================================


-- ============================================================
-- SECTION 1: DATABASE SETUP
-- ============================================================

CREATE TABLE hr_employees (
    employee_id    INT PRIMARY KEY,
    name           VARCHAR(100),
    department     VARCHAR(50),
    salary         INT,
    join_date      DATE,
    exit_date      DATE,
    status         VARCHAR(20)
);


-- ============================================================
-- SECTION 2: ATTRITION ANALYSIS
-- ============================================================

-- Q1: Overall Attrition Rate
-- Purpose: Headline metric for workforce health
SELECT
    status                                              AS "Status",
    COUNT(*)                                            AS "Count",
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1)  AS "Percentage"
FROM hr_employees
GROUP BY status
ORDER BY "Count" DESC;


-- Q2: Department-wise Attrition Rate
-- Purpose: Identify departments with retention problems
SELECT
    department                                                       AS "Department",
    COUNT(*)                                                         AS "Total Employees",
    COUNT(CASE WHEN status = 'Left' THEN 1 END)                     AS "Left",
    ROUND(
        COUNT(CASE WHEN status = 'Left' THEN 1 END) * 100.0
        / COUNT(*), 1
    )                                                                 AS "Attrition Rate %"
FROM hr_employees
GROUP BY department
ORDER BY "Attrition Rate %" DESC;


-- ============================================================
-- SECTION 3: SALARY ANALYSIS
-- ============================================================

-- Q3: Average Salary by Department (Active employees only)
-- Purpose: Benchmark compensation across departments
SELECT
    department                          AS "Department",
    COUNT(*)                            AS "Employees",
    ROUND(AVG(salary))                  AS "Avg Salary",
    MIN(salary)                         AS "Min Salary",
    MAX(salary)                         AS "Max Salary"
FROM hr_employees
WHERE status = 'Active'
GROUP BY department
ORDER BY "Avg Salary" DESC;


-- Q4: Salary Quartiles (NTILE Window Function)
-- Purpose: Segment employees into pay bands for compensation review
SELECT
    name                                  AS "Employee",
    department                            AS "Department",
    salary                                AS "Salary",
    NTILE(4) OVER (ORDER BY salary DESC)  AS "Salary Quartile"
FROM hr_employees
WHERE status = 'Active'
ORDER BY salary DESC;


-- ============================================================
-- SECTION 4: TENURE ANALYSIS
-- ============================================================

-- Q5: Employee Tenure Buckets
-- Purpose: Understand workforce experience distribution
SELECT
    CASE
        WHEN status = 'Active' THEN
            CASE
                WHEN CURRENT_DATE - join_date < 365 * 1 THEN '< 1 year'
                WHEN CURRENT_DATE - join_date < 365 * 3 THEN '1-3 years'
                WHEN CURRENT_DATE - join_date < 365 * 5 THEN '3-5 years'
                ELSE '5+ years'
            END
        ELSE
            CASE
                WHEN exit_date - join_date < 365 * 1 THEN '< 1 year'
                WHEN exit_date - join_date < 365 * 3 THEN '1-3 years'
                WHEN exit_date - join_date < 365 * 5 THEN '3-5 years'
                ELSE '5+ years'
            END
    END                                   AS "Tenure Bucket",
    COUNT(*)                              AS "Employees"
FROM hr_employees
GROUP BY 1
ORDER BY "Employees" DESC;


-- Q6: Average Tenure Comparison (Active vs Left)
-- Purpose: Test whether shorter tenure correlates with attrition
-- NOTE: COALESCE(exit_date, CURRENT_DATE) handles NULL exit_date for
--       active employees by treating "today" as their current tenure endpoint
SELECT
    status                                AS "Status",
    ROUND(AVG(
        COALESCE(exit_date, CURRENT_DATE) - join_date
    ) / 365.0, 1)                         AS "Avg Tenure (years)"
FROM hr_employees
GROUP BY status;


-- ============================================================
-- END OF QUERIES
-- ============================================================

WITH salary_data AS (
    SELECT job_title_short,
        salary_hour_avg,
        CASE
            WHEN salary_hour_avg IS NULL THEN 'No Salary'
            WHEN salary_hour_avg < 25 THEN 'Low'
            WHEN salary_hour_avg < 50 THEN 'Medium'
            WHEN salary_hour_avg < 75 THEN 'High'
            ELSE 'Very High'
        END AS salary_category
    FROM job_postings_fact
    WHERE salary_hour_avg IS NOT NULL
    LIMIT 20
)
SELECT job_title_short,
    salary_hour_avg,
    salary_category,
    AVG(salary_hour_avg) OVER (PARTITION BY salary_category) AS avg_salary_by_category
FROM salary_data
ORDER BY CASE
        WHEN salary_category = 'No Salary' THEN 1
        WHEN salary_category = 'Low' THEN 2
        WHEN salary_category = 'Medium' THEN 3
        WHEN salary_category = 'High' THEN 4
        WHEN salary_category = 'Very High' THEN 5
    END,
    salary_hour_avg;
WITH job_type AS(
    SELECT job_title_short,
        salary_hour_avg,
        CASE
            WHEN job_title_short LIKE '%Data%'
            AND job_title_short LIKE '%Analyst%' THEN 'Data Analyst'
            WHEN job_title_short LIKE '%Data%'
            AND job_title_short LIKE '%Engineer%' THEN 'Data Engineer'
            WHEN job_title_short LIKE '%Data%'
            AND job_title_short LIKE '%Scientist%' THEN 'Data Scientist'
            ELSE 'Other'
        END AS job_category
    FROM job_postings_fact
    WHERE salary_hour_avg IS NOT NULL
    ORDER BY random()
    LIMIT 100
)
SELECT *
FROM job_type
ORDER BY CASE
        WHEN job_category = 'Data Analyst' THEN 1
        WHEN job_category = 'Data Engineer' THEN 2
        WHEN job_category = 'Data Scientist' THEN 3
        ELSE 4
    END,
    job_type.salary_hour_avg DESC;
SELECT job_title_short,
    COUNT(*) AS posting_job,
    PERCENTILE_CONT(0.5) WITHIN GROUP (
        ORDER BY salary_year_avg
    ) FILTER (
        WHERE salary_year_avg < 100000
    ) AS median_low_salary,
    PERCENTILE_CONT(0.5) WITHIN GROUP (
        ORDER BY salary_year_avg
    ) FILTER (
        WHERE salary_year_avg >= 100000
            AND salary_year_avg < 150000
    ) AS median_mid_salary,
    PERCENTILE_CONT(0.5) WITHIN GROUP (
        ORDER BY salary_year_avg
    ) FILTER (
        WHERE salary_year_avg >= 150000
    ) AS median_high_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
ORDER BY posting_job DESC;
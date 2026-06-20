SELECT EXTRACT(
        MONTH
        FROM job_posted_date
    ) AS post_month,
    COUNT(job_id) AS posting_job_count
FROM job_postings_fact
WHERE job_title_short = 'Machine Learning Engineer'
GROUP BY post_month
ORDER BY post_month;
SELECT job_title_short,
    avg(salary_year_avg),
    avg(salary_hour_avg),
    avg(
        coalesce(salary_year_avg, salary_hour_avg * 2080)
    ) AS avg_salary_annual
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
    OR salary_hour_avg IS NOT NULL
GROUP BY job_title_short;
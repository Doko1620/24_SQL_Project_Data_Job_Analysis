SELECT job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date,
    EXTRACT(
        MONTH
        FROM job_posted_date
    ) AS date_month,
    EXTRACT(
        YEAR
        FROM job_posted_date
    ) AS date_year
FROM job_postings_fact
LIMIT 5;
SELECT COUNT(job_id),
    EXTRACT(
        MONTH
        FROM job_posted_date
    ) AS job_month
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY job_month
ORDER BY COUNT(job_id) DESC;
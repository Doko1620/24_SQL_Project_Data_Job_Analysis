SELECT skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Machine Learning Engineer'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = true
GROUP BY skills
ORDER BY avg_salary DESC
Limit 25;
/*
 - MLOps and Infrastructure skills drive the highest salaries — Tools like Docker, Kubernetes, Terraform, Ansible, and Chef appear frequently among top-paying roles, showing that companies pay more for engineers who can deploy, automate, and scale ML systems in production.
 - Cloud and Data Engineering are becoming core ML Engineer skills — AWS, GCP, BigQuery, Spark, Hadoop, Airflow, and MongoDB indicate that modern ML Engineers are expected to manage data pipelines and cloud infrastructure, not just build models.
 - Machine Learning knowledge is expected; system-building skills create differentiation — Python and SQL remain foundational, but the biggest salary premiums come from rarer skills such as Golang, Scala, distributed systems, and MLOps architecture, which are harder to learn and provide stronger career capital.
 
 [
 {
 "skills": "chef",
 "avg_salary": "325000"
 },
 {
 "skills": "ansible",
 "avg_salary": "325000"
 },
 {
 "skills": "golang",
 "avg_salary": "300000"
 },
 {
 "skills": "excel",
 "avg_salary": "283333"
 },
 {
 "skills": "scala",
 "avg_salary": "252500"
 },
 {
 "skills": "mongodb",
 "avg_salary": "235500"
 },
 {
 "skills": "docker",
 "avg_salary": "194331"
 },
 {
 "skills": "c#",
 "avg_salary": "180000"
 },
 {
 "skills": "kubernetes",
 "avg_salary": "174102"
 },
 {
 "skills": "airflow",
 "avg_salary": "174064"
 },
 {
 "skills": "java",
 "avg_salary": "171429"
 },
 {
 "skills": "matplotlib",
 "avg_salary": "170000"
 },
 {
 "skills": "github",
 "avg_salary": "170000"
 },
 {
 "skills": "aws",
 "avg_salary": "168402"
 },
 {
 "skills": "spark",
 "avg_salary": "168386"
 },
 {
 "skills": "hadoop",
 "avg_salary": "167659"
 },
 {
 "skills": "c",
 "avg_salary": "165318"
 },
 {
 "skills": "gitlab",
 "avg_salary": "165318"
 },
 {
 "skills": "flask",
 "avg_salary": "165318"
 },
 {
 "skills": "bigquery",
 "avg_salary": "165000"
 },
 {
 "skills": "gcp",
 "avg_salary": "163974"
 },
 {
 "skills": "terraform",
 "avg_salary": "161875"
 },
 {
 "skills": "typescript",
 "avg_salary": "160000"
 },
 {
 "skills": "sql",
 "avg_salary": "152983"
 },
 {
 "skills": "python",
 "avg_salary": "150570"
 }
 ]
 */
-- What are the top paying data analyst jobs?
 
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM 
    job_postings_fact jobs
LEFT JOIN company_dim company ON jobs.company_id = company.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'California'AND 
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;


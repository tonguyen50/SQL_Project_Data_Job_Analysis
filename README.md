# How to Navigate the Data Analyst Job Search in California 2025

## Project Overview

I'm currently in the job search for a data analyst role, so I set out to understand what are the skills desired from the top-paying roles in the data analyst job market. Right now, I am located in California so I wanted to focus in on jobs in the area to find insights on how I can improve my skills as a data analyst.

Here is a link to my queries! 

### Questions to Analyze

To understand the sales trends of our company, I asked the following:

1. **What are the top-paying data analyst jobs in California?**
2. **What skills are required for these top-paying jobs?**
3. **What skills are most in demand for data analysts?**
4. **Which skills are associated with higher salaries for data analysts jobs as a whole?**
5. **What are the most optimal skills to learn for a data analyst looking to maximize job market value?**

### Tools I Used 
- 📊 - **SQL** (Structured Query Language): Enabled me to interact with the database, extract insights, and answer my key questions through queries.
- 📁 - **PostgreSQL**: As the database management system, PostgreSQL allowed me to store, query, and manipulate the job posting data.
- 💻 **Visual Studio Code:** This open-source administration and development platform helped me manage the database and execute SQL queries.
- 💻 **Python Pandas:** I used the the python pandas library to make a visualization from the insights I gathered from my SQL queries.

## 1️⃣ What are the top-paying data analyst jobs in California?


### 📊 Analysis

```
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
```


**💡Insights**
- The highest paying data analyst job in California is "Procurement Data Analyst" a full-time role offered by the company ByteDance at $232,223!
- Dreamhaven is offering many Data Analyst roles to contractors at high salaries

## 2️⃣ What skills are required for these top-paying jobs?


### 📊 Analysis
```
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM 
        job_postings_fact jobs
    LEFT JOIN company_dim company ON jobs.company_id = company.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'California'AND 
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```

I then exported the data to CSV and used this Python code is analyze and visualize the data further


**💡Insights**
- SQL, Tableau. and PowerBi are the top skills fors the most paying jobs in CA
- It is important to be able to manipulate data and use it visualization tools. The other tools noted indicate a desire for employees to be able to analyze large sets of data.

![Top 10 Products by Revenue](https://github.com/user-attachments/assets/a79aa1da-194a-4bff-9961-cc04a1146e96)


## 3️⃣ What skills are most in demand for data analysts? 


### 📊 Analysis
```
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND job_location = 'California'
GROUP BY
    skills
ORDER BY demand_count DESC
LIMIT 5
```
**💡Insights**
- The top 5 skills are Excel, Sql, Python, Tableau, and PowerBi in that order

![Total Revenue By Country](https://github.com/user-attachments/assets/9120d7bd-0a35-4480-88e2-97ae47d91d88)


## 4️⃣ Which skills are associated with higher salaries for data analysts jobs as a whole?

### 📊 Analysis
```
SELECT 
    skills,
    ROUND(AVG(salary_year_avg),2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOt NULL
GROUP BY
    skills
ORDER BY   
    avg_salary DESC
LIMIT 25
```
**💡Insights**
- As salaries increase, the specificness of the skillset grows narrower based on the industry the job is in. For example, fastapi is more associated with building APIs with python and SVN is version control moreso used by large enterprises or government agencies. 

## 5️⃣ What are the most optimal skills to learn for a data analyst looking to maximize job market value?

### 📊 Analysis
```
WITH skills_demand AS  
    (SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOt NULL AND
        job_work_from_home = TRUE
    GROUP BY
        skills_dim.skills,
        skills_dim.skill_id
    
    ),

average_salary AS
    (SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg),2) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOt NULL AND
        job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id
 
    )
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM 
    skills_demand INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    demand_count DESC   ,
    avg_salary DESC

```
**💡Insights**
- The top 5 skills are Sql, Tableau, Python, Excel, and PowerBi in that order

## Conclusion
Through this project, I gained a clear picture of the California data analyst job market in 2025. High-paying roles are often tied to specialized skills and industry-specific tools, while the most consistently in-demand skills are SQL, Python, Excel, Tableau, and Power BI.

The key takeaway is that a competitive data analyst today needs a balance of strong foundational skills, practical visualization and business intelligence tools. Further along in the data analyst journey, it is a smart move to specialize in tools that can boost salary potential depending on the industry. This analysis highlights current demand and provides a general roadmap for prioritizing skill development for career growth in data analytics.

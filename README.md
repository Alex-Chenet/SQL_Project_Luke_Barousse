# Introduction
This is my SQL Portfolio Project, I delve into the data job market with a focus on data analyst roles, but can be easliy changed to diffrent data roles. into identifying the top-paying jobs, in-demand skills, and the intersection of high demand with high salary in the field of data analytics.

Check out my SQL queries here: [Project Folder](/Project/)

# Background
The motivation behind this project stemmed from my desire to understand the data analyst job market better. I aimed to discover which skills are paid the most and in demand, making my job search more targeted and effective. 

The data for this analysis is from [Luke Barousse’s SQL Course](https://www.lukebarousse.com/sql). This data includes details on job titles, salaries, locations, and required skills. 

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn for a data analyst looking to maximize job market value?

# Tools Used
In this project, I utilized a variety of tools to conduct my analysis:

- **SQL**: The powerhouse of my analysis. SQL enabled me to interact with the database, extract insights, and answer my key questions through queries.
- **PostgreSQL**: As the database management system, PostgreSQL allowed me to store, query, and manipulate the job posting data.
- **Visual Studio Code:** This open-source administration and development platform helped me manage the database and execute SQL queries.
- **Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis.

# Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
--Top 10 highest paying data analyst roles that are either remote or local
SELECT
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
	name AS company_name
FROM
	job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
	job_title_short = 'Data Analyst'
	AND salary_year_avg IS NOT NULL
	AND job_location = 'Anywhere'
ORDER BY
	salary_year_avg DESC 
LIMIT 10    
```
The breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** The top 10 paying roles span from $650,000 to $184,000, showing significant salary potentail in the field.
- **Diverse Employers:** Companies like Meta, AT&T, and Pinterest. This show intrest across diffrent industries for analyst jobs.
- **Job Title Variety:** There is a high diversity of job titles from Data Analyst to Director of Analytics, reflecting roles and specializations in this field.

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
-- Gets the top 10 paying Data Analyst jobs 
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'
				AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
-- Skills required for data analyst jobs
SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC   
```
Here's a breakdown of the most demanded skills for the top 10 paying Data Analyst jobs:
- **SQL** is the most common skill, appearing in 8.
- **Python** is the second most common skill, appearing in 7.
- **Tableau** is the third most common skill, appearing in 6.
- Other skills include Excel, R, Snowflake, and Pandas show lesser varying degrees of demand.

![Top Paying Skills](assets\2_top_paying_roles_skills.png)

### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
-- Identify the top 5 in-demand skills for a Data Analyst
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5
```

*Here's a breakdown of the top 5 most in-demanded skills for all Data Analyst jobs:*
| Skills | Demand |
|--------|--------|
| SQL    | 92,628 |
|Excel   | 67,031 |
|Python  | 57,326 |
|Tableau |46,554  |
|Power BI| 39,468 |

- **SQL & Excel** Remain the building blocks to every analysts tool kit. Emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Python & Tableau** show the need and want for Programming and Visualization tools that show a trend of increased importance of technical skills in data storytelling.

### 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = True
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25
```

*Here's a breakdown of the top 10 skills based on salary for Data Analyst jobs:*
| Skills       | Average Salary ($) |
|--------------|--------------------|
| pyspark      | 208,172            |
| bitbucket    | 189,155            |
| couchbase    | 160,515            |
| watson       | 160,515            |
| datarobot    | 155,486            |
| gitlab       | 154,500            |
| swift        | 153,750            |
| jupyter      | 152,777            |
| pandas       | 151,821            |
| elasticsearch| 145,000            |

 - **High Demand for Big Data & ML Skills:** The top salaried skills include big data technologies, machine learning tools, and Python libraries.
 - **Software Development & Deployment Proficency:** Knowledge in develpopment and deployment tools like GitLab and Terraform is highly valued.
 - **Cloud Computing Expertise:** Fimiliarity with cloud platforms is also a key factor in salary determination.

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
```sql
SELECT
  skills_dim.skill_id,
  skills_dim.skills, 
  COUNT(skills_job_dim.job_id) as demand_count,
  ROUND(AVG(job_postings_fact.salary_year_avg),2) AS avg_salary
FROM
  job_postings_fact
  INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  job_postings_fact.job_title_short = 'Data Analyst'
	AND job_postings_fact.salary_year_avg IS NOT NULL
  AND job_postings_fact.job_work_from_home = True
GROUP BY
  skills_dim.skill_id
HAVING
	COUNT(skills_job_dim.job_id) > 15
ORDER BY
	avg_salary DESC,
	demand_count DESC
LIMIT 25;
```
- **High-Demand Programming Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database Technologies:** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

# What was Learned
Throughout this project, I honed several key SQL techniques and skills:

- **Complex Query Construction**: Learning to build advanced SQL queries that combine multiple tables and employ functions like **`WITH`** clauses for temporary tables.
- **Data Aggregation**: Utilizing **`GROUP BY`** and aggregate functions like **`COUNT()`** and **`AVG()`** to summarize data effectively.
- **Analytical Thinking**: Developing the ability to translate real-world questions into actionable SQL queries that got insightful answers.

# Conclusions
### Insight
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Final Thoughts
This project significantly strengthened my SQL skills and offered meaningful insights into the data analyst job market. The analysis results serve as a practical roadmap for prioritizing skill development and targeting job search strategies. By focusing on high-demand, high-paying skills, aspiring data analysts can enhance their competitiveness in an evolving industry. Ultimately, this project underscores the importance of continuous learning and staying current with emerging trends in the data analytics field.

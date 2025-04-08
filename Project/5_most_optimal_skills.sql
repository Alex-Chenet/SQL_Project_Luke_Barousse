/*
**Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill) for a data analyst?** 
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
-Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), offering strategic insights for career development in data analysis.
*/

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

/*
[
  {
    "skill_id": 8,
    "skills": "go",
    "demand_count": "27",
    "avg_salary": "115319.89"
  },
  {
    "skill_id": 97,
    "skills": "hadoop",
    "demand_count": "22",
    "avg_salary": "113192.57"
  },
  {
    "skill_id": 80,
    "skills": "snowflake",
    "demand_count": "37",
    "avg_salary": "112947.97"
  },
  {
    "skill_id": 74,
    "skills": "azure",
    "demand_count": "34",
    "avg_salary": "111225.10"
  },
  {
    "skill_id": 76,
    "skills": "aws",
    "demand_count": "32",
    "avg_salary": "108317.30"
  },
  {
    "skill_id": 4,
    "skills": "java",
    "demand_count": "17",
    "avg_salary": "106906.44"
  },
  {
    "skill_id": 233,
    "skills": "jira",
    "demand_count": "20",
    "avg_salary": "104917.90"
  },
  {
    "skill_id": 79,
    "skills": "oracle",
    "demand_count": "37",
    "avg_salary": "104533.70"
  },
  {
    "skill_id": 185,
    "skills": "looker",
    "demand_count": "49",
    "avg_salary": "103795.30"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "demand_count": "236",
    "avg_salary": "101397.22"
  },
  {
    "skill_id": 5,
    "skills": "r",
    "demand_count": "148",
    "avg_salary": "100498.77"
  },
  {
    "skill_id": 78,
    "skills": "redshift",
    "demand_count": "16",
    "avg_salary": "99936.44"
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "demand_count": "230",
    "avg_salary": "99287.65"
  },
  {
    "skill_id": 186,
    "skills": "sas",
    "demand_count": "63",
    "avg_salary": "98902.37"
  },
  {
    "skill_id": 7,
    "skills": "sas",
    "demand_count": "63",
    "avg_salary": "98902.37"
  },
  {
    "skill_id": 61,
    "skills": "sql server",
    "demand_count": "35",
    "avg_salary": "97785.73"
  },
  {
    "skill_id": 9,
    "skills": "javascript",
    "demand_count": "20",
    "avg_salary": "97587.00"
  },
  {
    "skill_id": 183,
    "skills": "power bi",
    "demand_count": "110",
    "avg_salary": "97431.30"
  },
  {
    "skill_id": 0,
    "skills": "sql",
    "demand_count": "398",
    "avg_salary": "97237.16"
  },
  {
    "skill_id": 215,
    "skills": "flow",
    "demand_count": "28",
    "avg_salary": "97200.00"
  },
  {
    "skill_id": 201,
    "skills": "alteryx",
    "demand_count": "17",
    "avg_salary": "94144.53"
  },
  {
    "skill_id": 199,
    "skills": "spss",
    "demand_count": "24",
    "avg_salary": "92169.68"
  },
  {
    "skill_id": 22,
    "skills": "vba",
    "demand_count": "24",
    "avg_salary": "88783.29"
  },
  {
    "skill_id": 196,
    "skills": "powerpoint",
    "demand_count": "58",
    "avg_salary": "88701.09"
  },
  {
    "skill_id": 181,
    "skills": "excel",
    "demand_count": "256",
    "avg_salary": "87288.21"
  }
]
*/
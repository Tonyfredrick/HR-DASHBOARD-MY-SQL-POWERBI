SELECT * FROM hr_dashboard.`human resources`;


ALTER TABLE hr_dashboard.`human resources`
CHANGE COLUMN ï»¿id emp_id varchar(20)NULL;

DESC hr_dashboard.`human resources`;

select birthdate from hr_dashboard.`human resources`;

SET sql_safe_updates=0; 

UPDATE hr_dashboard.`human resources`
SET birthdate = CASE
   WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
   WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
   ELSE NULL
END;   

select birthdate from  hr_dashboard.`human resources`;

Alter Table hr_dashboard.`human resources`
Modify Column birthdate Date;

desc hr_dashboard.`human resources`;


UPDATE hr_dashboard.`human resources`
SET hire_date = CASE
   WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
   WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
   ELSE NULL
END; 

Alter table  hr_dashboard.`human resources`
Modify column hire_date DATE;




UPDATE hr_dashboard.`human resources`
SET birthdate = CASE
   WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
   WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
   ELSE NULL
END; 

select hire_date from  hr_dashboard.`human resources`;

select termdate from  hr_dashboard.`human resources`;

UPDATE  hr_dashboard.`human resources` 
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate !='';

select termdate from  hr_dashboard.`human resources`;

ALTER TABLE  hr_dashboard.`human resources`
Modify column termdate DATE;

DESC  hr_dashboard.`human resources`;

ALTER TABLE   hr_dashboard.`human resources`
ADD COLUMN age int;


select *from hr_dashboard.`human resources`;

UPDATE hr_dashboard.`human resources`
SET age = timestampdiff(YEAR,birthdate, CURDATE());

SELECT birthdate,age from hr_dashboard.`human resources`;

select
     min(age) AS youngest,
     max(age) AS oldest,
hr_dashboard.`human resources`; 


SELECT count(*) from hr_dashboard.`human resources`
where age < 18;
select * from hr_dashboard.`human resources`;

# what is the gender breakdown of the employees in the company?
select gender, count(*) AS count
from hr_dashboard.`human resources`
where age >= 18
GROUP BY gender;

#what is the race/ethnicity breakdown of employees in the company?
select race,count(*) AS COUNT
FROM hr_dashboard.`human resources`
WHERE age >= 18
group by race
ORDER BY COUNT(*) DESC;

#what is the age distribution of employees in the company?
select
   min(age) as youngest,
   max(age) as oldest
from hr_dashboard.`human resources`
Where age >= 18;

select
   case 
     when age >= 18 and age <= 24 then '18-24'
     when age >= 25 and age <= 34 then '25-34'
     when age >= 35 and age <= 44 then '35-44'
     when age >= 45 and age <= 54 then '45-54'
     when age >= 55 and age <= 64 then '55-64'
     ELSE '65+'
END AS age_group,
count(*) AS count
from  hr_dashboard.`human resources`
where age >= 18
group by age_group 
order by age_group; 

select
   case 
     when age >= 18 and age <= 24 then '18-24'
     when age >= 25 and age <= 34 then '25-34'
     when age >= 35 and age <= 44 then '35-44'
     when age >= 45 and age <= 54 then '45-54'
     when age >= 55 and age <= 64 then '55-64'
     ELSE '65+'
END AS age_group,gender,
count(*) AS count
from  hr_dashboard.`human resources`
where age >= 18
group by age_group,gender 
order by age_group,gender;

#How many employees work at headquarters versus remote locations 
select location, count(*) AS count
from hr_dashboard.`human resources`
where age >= 18 
group by location;

# 5 what is the average length of employees who have been terminated?

#how does the gender distribution vary across department and job titles
select department,gender, count(*) as count
from hr_dashboard.`human resources`
where age >=18 
group by department,gender
order by department;

# what is the distribution of job titles across the company
select jobtitle, count(*) as count
from hr_dashboard.`human resources`
where age >= 18
group by jobtitle
order by jobtitle DESC;

#what department has the highest turnover rate
select department 
  total_count,
  terminated_count,
  terminated_count/total_count as termination_rate
from(
   select department,
   count(*) AS total_count,
   sum(case when termdate <= curdate() then 1 else 0 end) AS terminated_count
   from hr_dashboard.`human resources`
   where age >= 18
   group by department
   ) subquery
   order by termination_rate DESC;
   
# what is the distribution of employees across locations by city and state?
select location_state, count(*) as count
from hr_dashboard.`human resources`
where age >= 18 
group by location_state
order by count desc;
#what is the tenure distribution in each department
select department, round(avg(datediff(termdate, hire_date)/365),0) as avg_tenure
from hr_dashboard.`human resources`
where termdate <= curdate() and age >= 18
group by department;
 

   

  

     

     




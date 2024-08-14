Project Name: 
ScienceQtech Employee Performance Mapping 

Problem scenario: 
ScienceQtech is a startup that works in the Data Science field. ScienceQtech has worked on fraud detection, market basket, self-driving cars, supply chain, algorithmic early detection of lung cancer, customer sentiment, and the drug discovery field. With the annual appraisal cycle around the corner, the HR department has asked you (Junior Database Administrator) to generate reports on employee details, their performance, and on the project that the employees have undertaken, to analyze the employee database and extract specific data based on different requirements.

Objective: 
To facilitate a better understanding, managers have provided ratings for each employee which will help the HR department to finalize the employee performance mapping. As a DBA, you should find the maximum salary of the employees and ensure that all jobs are meeting the organization's profile standard. You also need to calculate bonuses to find extra cost for expenses. This will raise the overall performance of the organization by ensuring that all required employees receive training.

Dataset description:

emp_record_table: It contains the information of all the employees.
●	EMP_ID – ID of the employee
●	FIRST_NAME – First name of the employee
●	LAST_NAME – Last name of the employee
●	GENDER – Gender of the employee
●	ROLE – Post of the employee
●	DEPT – Field of the employee
●	EXP – Years of experience the employee has
●	COUNTRY – Country in which the employee is presently living
●	CONTINENT – Continent in which the country is
●	SALARY – Salary of the employee
●	EMP_RATING – Performance rating of the employee
●	MANAGER_ID – The manager under which the employee is assigned 
●	PROJ_ID – The project on which the employee is working or has worked on


Proj_table: It contains information about the projects.
●	PROJECT_ID – ID for the project
●	PROJ_Name – Name of the project
●	DOMAIN – Field of the project
●	START_DATE – Day the project began
●	CLOSURE_DATE – Day the project was or will be completed
●	DEV_QTR – Quarter in which the project was scheduled
●	STATUS – Status of the project currently

Data_science_team: It contains information about all the employees in the Data Science team.
●	EMP_ID – ID of the employee
●	FIRST_NAME – First name of the employee
●	LAST_NAME – Last name of the employee
●	GENDER – Gender of the employee
●	ROLE – Post of the employee
●	DEPT – Field of the employee
●	EXP – Years of experience the employee has
●	COUNTRY – Country in which the employee is presently living
●	CONTINENT – Continent in which the country is

1.	Create a database named employee, then import data_science_team.csv proj_table.csv and emp_record_table.csv into the employee database from the given resources.

CREATE SCHEMA EMPLOYEES;

2.	Create an ER diagram for the given employee database.

![1](https://github.com/Siddhishastri/SQL_Projects/assets/172502412/664f9bc0-7879-4e5d-8535-5195ee7675a4)
3.  Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department.

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT from emp_record_table;

![2](https://github.com/Siddhishastri/SQL_Projects/assets/172502412/81d87f65-d210-4e33-ba74-6c94f643cf12)

4.	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
●	less than two
●	greater than four 
●	between two and four

# Combining All Queries with UNION

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT,EMP_RATING
from emp_record_table
where EMP_RATING < 2

UNION

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
from emp_record_table
where EMP_RATING > 4

UNION

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
from emp_record_table
where EMP_RATING between 2 and 4;

![3](https://github.com/Siddhishastri/SQL_Projects/assets/172502412/7395e16a-3288-4c1f-93fd-f761953bba4f)

5.	Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.

select concat(FIRST_NAME,' ',LAST_NAME)as name from emp_record_table
where DEPT = 'Finance';

![5](https://github.com/Siddhishastri/SQL_Projects/assets/172502412/27562ba9-1c7e-4d88-92bf-9b558b83e0c9)

6.	Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).

select count(MANAGER_ID) from emp_record_table;

![6](https://github.com/Siddhishastri/SQL_Projects/assets/172502412/30a9da76-4ce6-4479-8a9d-8a8c8973e0a3)

7.	Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table.

select * from emp_record_table;
select EMP_ID,FIRST_NAME,LAST_NAME, DEPT from emp_record_table
where DEPT = 'HEALTHCARE'

UNION

select EMP_ID,FIRST_NAME,LAST_NAME, DEPT from emp_record_table
where DEPT = 'FINANCE';

![8](https://github.com/Siddhishastri/SQL_Projects/assets/172502412/2edea833-1b63-403e-aa7a-c37848f9f4a4)

8.	Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department.

select EMP_ID,FIRST_NAME,LAST_NAME,ROLE,DEPT,EMP_RATING,
max(EMP_RATING) over (partition by DEPT) as max_emp_rating
from emp_record_table
order by DEPT;

![9](https://github.com/Siddhishastri/SQL_Projects/assets/172502412/454448b9-5a66-42f7-a8f6-4be195edf14b)

9.	Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.

select DEPT, SALARY from emp_record_table;

![9](https://github.com/Siddhishastri/SQL_Projects/assets/172502412/3e436cc2-47d5-4c83-8206-1ea79c829ef0)

select ROLE, min(SALARY) as min_salary, max(SALARY) as max_salary from emp_record_table
group by ROLE;

10.	Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.

select EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EXP, 
rank() over (order by EXP desc) as Experience_Rank
from emp_record_table;

![10](https://github.com/Siddhishastri/SQL_Projects/assets/172502412/4dc92c18-7857-4012-abcb-2684bdd884bb)

11.	Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table.

create view high_earners as
select EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, COUNTRY, SALARY from emp_record_table
where SALARY > 6000;

![11](https://github.com/Siddhishastri/SQL_Projects/assets/172502412/966e6d73-8b9f-4538-b26c-94f3d181eb1e)

12.	Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.

select EMP_ID,FIRST_NAME,LAST_NAME,ROLE,DEPT,EXP from emp_record_table
where EXP > (select 10);

![12](https://github.com/Siddhishastri/SQL_Projects/assets/172502412/ae64a43b-8564-45d5-be5f-438b7948d39c)

13. Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.

DELIMITER //
create procedure GetEmployeesWithExperience()
BEGIN
select
EMP_ID,FIRST_NAME,LAST_NAME,ROLE,DEPT,EXP from emp_record_table
where EXP > 3;
END //
DELIMITER ;

![12](https://github.com/Siddhishastri/SQL_Projects/assets/172502412/c5b54885-beca-467c-9453-dd14b1dbee0b)



# import all 3 .csv files via 'table import wizard' 

CREATE SCHEMA EMPLOYEES;

/* 
3.Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT 
from the employee record table, and make a list of employees and details of their 
department.
*/

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT from emp_record_table;

/* 
4.Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and 
EMP_RATING if the EMP_RATING is: 
●	less than two
●	greater than four 
●	between two and four
*/
#less than two

select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT,EMP_RATING
from emp_record_table
where EMP_RATING < 2;

#greater than four
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
from emp_record_table
where EMP_RATING > 4;

#between two and four
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
from emp_record_table
where EMP_RATING between 2 and 4;

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

/*
5.Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the 
Finance department from the employee table and then give the resultant column alias 
as NAME.
*/

select concat(FIRST_NAME,' ',LAST_NAME)as name from emp_record_table
where DEPT = 'Finance';

/*
6.Write a query to list only those employees who have someone reporting to them. 
Also, show the number of reporters (including the President).
*/

select count(MANAGER_ID) from emp_record_table;

/*
7.Write a query to list down all the employees from the healthcare and finance 
departments using union. Take data from the employee record table.
*/

select * from emp_record_table;
select EMP_ID,FIRST_NAME,LAST_NAME, DEPT from emp_record_table
where DEPT = 'HEALTHCARE'

UNION

select EMP_ID,FIRST_NAME,LAST_NAME, DEPT from emp_record_table
where DEPT = 'FINANCE';

/*
8.Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, 
ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee 
rating along with the max emp rating for the department.
*/

select EMP_ID,FIRST_NAME,LAST_NAME,ROLE,DEPT,EMP_RATING,
max(EMP_RATING) over (partition by DEPT) as max_emp_rating
from emp_record_table
order by DEPT;

/*9.Write a query to calculate the minimum and the maximum salary of the employees 
in each role. Take data from the employee record table.
*/

select DEPT, SALARY from emp_record_table;

select ROLE, min(SALARY) as min_salary, max(SALARY) as max_salary from emp_record_table
group by ROLE;

/*
10.Write a query to assign ranks to each employee based on their experience. 
Take data from the employee record table.
*/

select EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EXP, 
rank() over (order by EXP desc) as Experience_Rank
from emp_record_table;

/* 
11.Write a query to create a view that displays employees in various countries 
whose salary is more than six thousand. Take data from the employee record table.
*/

create view high_earners as
select EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, COUNTRY, SALARY from emp_record_table
where SALARY > 6000;

/*12.
Write a nested query to find employees with experience of more than ten years. 
Take data from the employee record table.
*/

select EMP_ID,FIRST_NAME,LAST_NAME,ROLE,DEPT,EXP from emp_record_table
where EXP > (select 10);

/*13.
Write a query to create a stored procedure to retrieve the details of the 
employees whose experience is more than three years. 
Take data from the employee record table.
*/

DELIMITER //
create procedure GetEmployeesWithExperience()
BEGIN
select
EMP_ID,FIRST_NAME,LAST_NAME,ROLE,DEPT,EXP from emp_record_table
where EXP > 3;
END //
DELIMITER ;

















CREATE TABLE dept (
  dep_no int NOT NULL,
  dname varchar(200) NOT NULL,
  loc varchar(200) NOT NULL
)
INSERT INTO dept (dep_no, dname, loc) VALUES
(10, 'accounts', 'bangalore'),
(20, 'it', 'delhi'),
(30, 'production', 'chennai'),
(40, 'sales', 'hybd'),
(50, 'admin', 'london');

CREATE TABLE emp (
  Empno int NOT NULL,
  Empname varchar(500) NOT NULL,
  sal bigint NOT NULL,
  hiredate date NOT NULL,
  commision int DEFAULT NULL,
  deptno int DEFAULT NULL,
  mgr int DEFAULT NULL
)
INSERT INTO emp (Empno, Empname, sal, hiredate, commision, deptno, mgr) VALUES
(1001, 'sachin', 18810, '1980-01-01', 2100, 20, 1003),
(1002, 'kapil', 14850, '1970-01-01', 2300, 10, 1003),
(1003, 'stefan', 11880, '1990-01-01', 500, 20, 1007),
(1004, 'williams', 8910, '2001-01-01', NULL, 30, 1007),
(1005, 'john', 4950, '2005-01-01', NULL, 30, 1006),
(1006, 'devid', 18810, '1985-01-01', 2400, 10, 1007),
(1007, 'martin', 20790, '2000-01-01', 1040, NULL, NULL);

--1. Select employee details  of dept number 10 or 30
SELECT * FROM emp_table where deptno = 10 or deptno=30;


--2. Write a query to fetch all the dept details with more than 1 Employee. 
SELECT * FROM dept WHERE dep_no IN ( SELECT deptno FROM emp_table GROUP BY deptno HAVING COUNT(*) >1 );

or 

select * from  (
select deptno, count(*) from emp_table group by deptno having count(*) > 1) as department 
join dept on dep_no = department.deptno

--Write a query to fetch employee details whose name starts with the letter “S”
    SELECT * FROM emp_table WHERE Empname like 'S%';

--Select Emp Details Whose experience is more than 2 years

4.SELECT * FROM emp_table WHERE TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) > 2;
or
select * from emp where date_part('year',age(hiredate)) > 2
--Write a SELECT statement to replace the char “a” with “#” in Employee Name ( Ex:  Sachin as S#chin)
5.SELECT REPLACE( Empname, 'a', '#' ) as new_Empname FROM emp_table;
 
--Write a query to fetch employee name and his/her manager name. 
6. SELECT e.Empno 'Emp_Id', e.Empname 'Employee', m.Empno 'Mgr_Id', m.Empname 'Manager' 
FROM emp_table e 
join emp_table m ON (e.mgr = m.Empno);

or 

select e.Empname, m.Empname as manager from emp_table e left join emp_table m on e.mgr = m.Empno;
--Fetch Dept Name , Total Salry of the Dept
7. SELECT deptno, SUM(sal) FROM emp_table GROUP BY deptno;

select deptno,d.dname,sum(sal) from emp_table e
join dept d on d.dep_no = deptno
group by deptno,d.dname

--Write a query to fetch ALL the  employee details along with department name, department location, irrespective of employee existance in the department.
8.SELECT* from emp_table left join dept on deptno = dep_no;

--Write an update statement to increase the employee salary by 10 %
9. UPDATE emp_table SET sal=  (sal * 10 / 100);

--Write a statement to delete employees belong to Chennai location.
10.delete from emp_table where deptno = (SELECT dep_no FROM `dept` WHERE loc = 'chennai');

--Get Employee Name and gross salary (sal + comission) .
11.SELECT Empname, (sal + COALESCE(commision,0)) as gross_salary FROM emp_table;

--Increase the data length of the column Ename of Emp table from  100 to 250 using ALTER statement
12. alter table emp_table MODIFY COLUMN Empname varchar(250);

--Write query to get current datetime
13. SELECT now();
SELECT CURRENT_TIMESTAMP;
SELECT CURRENT_date;
SELECT CURRENT_time;
select CURDATE()
select CURTIME()

--Write a statement to create STUDENT table, with related 5 columns
14. CREATE TABLE STUDENTS (  
ID INT   NOT NULL PRIMARY KEY,  
NAME VARCHAR (20) NOT NULL,  
date_of_birth date                         NOT NULL,  
ADDRESS varchar (25),  
email varchar(150) unique

);  

 --Write a query to fetch number of employees in who is getting salary more than 10000

15. select count(*) from emp_table where sal > 10000;

--Write a query to fetch minimum salary, maximum salary and average salary from emp table.

16.SELECT max(sal) as max_sal, min(sal) as min_sal , round(avg(sal),2) as avg_sal from emp_table;

--Write a query to fetch number of employees in each location
17.SELECT count(Empno) as emp_count, loc FROM `dept` LEFT JOIN emp_table ON dept.dep_no = emp_table.deptno group by loc;

--Write a query to display emplyee names in descending order
18.select * from emp_table ORDER by Empname desc;
   
--Write a statement to create a new table(EMP_BKP) from the existing EMP table 
19.CREATE TABLE emp AS SELECT * FROM emp_table;

 --Write a query to fetch first 3 characters from employee name appended with salary.
 20.select concat(substring(Empname, 1,3),sal) from emp_table;
 
 -- Get the details of the employees whose name starts with S
      21.select * from emp_table where Empname like 's%';


       -- Get the details of the employees who works in Bangalore location
       22. select * from emp_table where deptno = (SELECT dep_no FROM dept where loc = 'bangalore');


      -- Write the query to get the employee details whose name started within  any letter between  A and K
23.SELECT Empname FROM emp WHERE Empname between 'a' and 'l';


 --Write a query in SQL to display the employees whose manager name is Stefen 
24.select * from emp_table where mgr = (SELECT Empno from emp_table where Empname='stefan');

 --Write a query in SQL to list the name of the managers who is having maximum number of employees working under him
25.select * from 
(SELECT mgr,count(*) FROM `emp_table` group by mgr having count(*) = 
( select max(max_count) from 
(SELECT mgr,count(*) as max_count FROM `emp_table` group by mgr) as max_emp ) ) as max_manager 
join emp_table on Empno = max_manager.mgr;

 --Write a query to display the employee details, department details and the manager details of the employee who has second highest salary
26. select e.Empno,e.Empname,e.sal,e.hiredate,
e.commision,e.mgr,m.Empname as manager,e.deptno,d.dname,d.loc from emp_table e,emp_table m, 
dept d where e.mgr = m.Empno and 
e.deptno = d.dep_no and e.sal = (select sal from emp_table e1 order by e1.sal desc limit 1 offset 1);

 --Write a query to list all details of all the managers
27.select * from emp_table where Empno in ( select distinct(mgr) from emp_table);

 --Write a query to list the details and total experience of all the managers
28.select *, DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), hiredate)), '%Y') + 0 AS experience 
from emp_table where Empno in ( select distinct(mgr) from emp_table);
or
select *,date_part('year',age(hiredate)) from emp where Empno in (select distinct(mgr) from emp)

 --Write a query to list the employees who is manager and  takes commission less than 1000 and works in Delhi

29.select * from emp_table,dept where commision <1000 and dept.dep_no = deptno and dept.loc = 'delhi' and Empno in (SELECT  distinct(mgr) FROM `emp_table`);

 30--Write a query to display the details of employees who are senior to Martin 
SELECT * FROM emp_table where hiredate > (select hiredate from emp_table where Empname='martin');









SELECT *, DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), hiredate)), '%Y') + 0 AS age
FROM emp_table;

26.select * from emp_table where Empno in ( select distinct(mgr) from emp_table);

27.select *, DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), hiredate)), '%Y') + 0 AS experience from emp_table where Empno in ( select distinct(mgr) from emp_table);

29.select * from emp_table,dept where commision <1000 and dept.dep_no = deptno and dept.loc = 'delhi' and Empno in (SELECT  distinct(mgr) FROM `emp_table`);

30.SELECT * FROM emp_table where hiredate > (select hiredate from emp_table where Empname='martin');


25. select e.Empno,e.Empname,e.sal,e.hiredate,e.commision,e.mgr,m.Empname as manager,e.deptno,d.dname,d.loc from emp_table e,emp_table m, dept d where e.mgr = m.Empno and e.deptno = d.dep_no and e.sal = (select sal from emp_table e1 order by e1.sal desc limit 1,1);

24.select * from emp_table where mgr = (SELECT Empno from emp_table where Empname='stefan');

23. SELECT Name FROM Employees WHERE Name LIKE '[A-K]%'

22. select * from emp_table where deptno = (SELECT dep_no FROM dept where loc = 'bangalore');
21.select * from emp_table where Empname like 's%';

20.select concat(substring(Empname, 1,3),sal) from emp_table;
19.CREATE TABLE emp AS SELECT * FROM emp_table;
18.select * from emp_table ORDER by Empname desc;
17.SELECT count(Empno) as emp_count, loc FROM `dept` LEFT JOIN emp_table ON dept.dep_no = emp_table.deptno group by loc;

16.SELECT max(sal) as max_sal, min(sal) as min_sal , round(avg(sal),2) as avg_sal from emp_table;

15. select count(*) from emp_table where sal > 10000;

14. CREATE TABLE STUDENTS (  
ID INT                           NOT NULL PRIMARY KEY,  
NAME VARCHAR (20) NOT NULL,  
date-of_birth date                         NOT NULL,  
ADDRESS varchar (25),  
email varchar(150) unique

);  


13. SELECT now();
SELECT CURRENT_TIMESTAMP;
SELECT CURRENT_date;
SELECT CURRENT_time;
select CURDATE()
select CURTIME()


12. alter table emp_table MODIFY COLUMN Empname varchar(250);

11.SELECT Empname, (sal + COALESCE(commision,0)) as gross_salary FROM emp_table;

10.delete from emp_table where deptno = (SELECT dep_no FROM `dept` WHERE loc = 'chennai');
9. UPDATE emp_table SET sal= sal - (sal * 10 / 100);
8.SELECT* from emp_table left join dept on deptno = dep_no;

7. SELECT deptno, SUM(sal) FROM emp_table GROUP BY deptno;

1.SELECT * FROM emp_table where deptno = 10 or deptno=30;

2. SELECT * FROM dept WHERE dep_no IN ( SELECT deptno FROM emp_table GROUP BY deptno HAVING COUNT(*) >1 );

3.SELECT * FROM emp_table WHERE Empname like 'S%';

4.SELECT * FROM emp_table WHERE TIMESTAMPDIFF(YEAR, hiredate, CURDATE()) > 2;

5.SELECT REPLACE( Empname, 'a', '#' ) as new_Empname FROM emp_table;

6. SELECT e.Empno 'Emp_Id', e.Empname 'Employee', m.Empno 'Mgr_Id', m.Empname 'Manager' FROM emp_table e join emp_table m ON (e.mgr = m.Empno);

or 

select e.Empname, m.Empname as manager from emp_table e left join emp_table m on e.mgr = m.Empno;


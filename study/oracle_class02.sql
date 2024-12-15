-- Set the format for the output of the SELECT statement.
set pages 1000 line 200

-- Perform various arithmetic operations on the 'sal' and 'comm' columns of the 'emp' table.
select ename, empno, sal from emp;

select ename, empno, sal*12 from emp;

select ename, empno, sal+5000 from emp;

select ename, empno, sal*0.05, comm + 1000 from emp;

select ename, empno, sal-100 from emp;

select ename, empno, (sal + 5000)/12 from emp;

/*
An execution plan in Oracle:
In Oracle, an execution plan refers to the sequence of steps that the database engine takes to execute a SQL statement.
The execution plan is determined by the Oracle optimizer, which analyzes the SQL statement
and determines the most efficient way to retrieve the requested data.
*/

-- Use the 'sysdate' function to retrieve the current date and time.
select ename, sal, comm, hiredate, sysdate from emp
  where empno = '7566';
  
select ename, sal, hiredate, sysdate "TODAY"
  from emp
  where empno = '7566';

/*
Use the 'dual' table to perform various operations.
FROM DUAL in a query means that selecting a single row from the DUAL table.
*/
select sysdate "TODAY", sysdate - 10 from dual;

select to_char(sysdate, 'YYYY/MM/DD HH:MI:SS') from dual;

/*
Use the 'decode' function to perform conditional operations.
Decode function is similar to an if statement in Python
*/
select grade,
  decode(grade,
  1, '15%',
  2, '10%',
  3, '8%',
  '5%') bonus
  from salgrade;

select ename, deptno,
  decode(deptno,
  10, 'New York',
  20, 'Dallas',
  30, 'Chicago',
  'Boston') dept_name
  from emp
  order by deptno;
  
-- GROUP FUNCTION
-- without GROUP function

-- Retrieves the department number and salary for all employees in department number 20.
select deptno, sal from emp
  where deptno = 20;

-- Retrieves the sum of salaries for all employees in department number 20.
select sum(sal) from emp
  where deptno = 20;

-- Retrieves the average salary for all employees in department number 20.
select avg(sal) from emp
  where deptno = 20;

/*
While SQL keywords and identifiers are typically not case-sensitive,
the names of database objects like tables and columns are often case-sensitive.
*/

/*
These statements retrieve salary-related data from the "emp" table,
with filters based on department number and job title.
The first query selects employee name, job title, department number, and salary for all employees in department number 20 who have the job title of 'CLERK'.
The next two queries calculate the average salary for the same set of employees.
*/

select ename, job, deptno, sal from emp
  where deptno = 20 and job = 'CLERK';

select avg(sal) from emp
  where deptno = 20 and job = 'CLERK';

select * from emp;

-- Retrives the count of rows in the emp table.
select count(*) from emp;

select count(*) from emp
  where deptno = 20;

select count(*) from emp
  where deptno in ('10', '20', '50');

-- with GROUP BY function
select sum(sal) from emp;

-- Retrieves the department number and sum of salaries for all employees grouped by department number.
select deptno, sum(sal) from emp
  group by deptno;
 
select deptno, sum(sal) from emp
  group by deptno
  order by sum(sal);

-- Retrieves the department number and average salary for all employees grouped by department number, ordered by the average salary.
select deptno, avg(sal) from emp
  group by deptno
  order by avg(sal);
 
select deptno, round(avg(sal)) from emp
  group by deptno
  order by round(avg(sal));

select 'Dept Number 20' DN, job, sum(sal) from emp
  where deptno = 20
  group by job
  order by sum(sal);

select deptno, count(*) from emp
  group by deptno
  order by deptno;

select deptno, count(*) from emp
  where job = 'CLERK'
  group by deptno;

select job, count(*) from emp
  group by job;

-- DML

-- INSERT
insert into old_dept(deptno, dname, loc)
  values(60, 'HR', 'SEOUL');

insert into old_dept(deptno, dname, loc)
  values(70, 'SALES', 'DAEJEON');

COMMIT;

select * from old_dept;

select * from dept;

insert into dept
  (select * from old_dept);

select * from dept order by deptno;

rollback;

insert into dept(deptno, dname)
  (select deptno, initcap(dname) from old_dept);

-- Check that the data from the old_dept table has been merged into the dept table.
select * from dept order by deptno;

commit;

-- UPDATE statement is used to modify the existing data in a table.
select * from hrinfo order by ename;

update hrinfo
  set job = 'SALESMAN',
      SAL = SAL*1.5,
      COMM = 1500,
      DEPTNO = 40
   WHERE ENAME IN ('SCOTT', 'FORD');
   
 select * from hrinfo order by ename;
 
 update hrinfo
  set sal = sal*1.5,
      comm = 1500
  where sal < 5000;
  
  commit;
  
  select * from hrinfo order by ename;

/*
DELETE and TRUNCATE
The DELETE statements can be rolled back if needed.
Unlike the DELETE statement, TRUNCATE statements can't be rolled back.
*/
delete hrinfo
  where ename = 'FORD';
  
select * from hrinfo order by ename;

rollback;

select * from hrinfo order by ename;

truncate table hrinfo;

select * from hrinfo order by ename;

-- JOIN

-- EQUALJOIN*
set pages 1000 line 200

select empno, ename, deptno from emp;

select deptno, dname from dept;

select empno, ename, dname, d.loc from emp e, dept d
  where e.deptno = d.deptno;

select empno, ename, dname, d.loc from emp e, dept d
  where e.deptno = d.deptno
  and d.loc = 'CHICAGO';

-- NON-EQUALJOIN
select ename, sal from emp;

select grade, losal, hisal from salgrade;

select e.ename, e.sal, s.grade from emp e, salgrade s
  where e.sal between s.losal and s.hisal;

-- OUTER JOIN*
select ename, deptno from emp;

select deptno, dname from dept;

select e.ename, e.deptno, d.deptno from emp e, dept d
  where e.deptno(+) = d.deptno;

-- CATESIAN JOIN
select e.ename, e.sal, d.dname from emp e, dept d
  where d.deptno = 10 and e.sal > 100;

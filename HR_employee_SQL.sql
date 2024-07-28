/*1.	Create the Employee Table as per the below data in the table:*/
create schema hr_employee;
CREATE TABLE hr_employee(
    empno INT primary key,
    ename  VARCHAR(50),
    job VARCHAR(50),
    mgr INT,
    hire_date DATE,
    sal DECIMAL(10, 2),
    comm DECIMAL(10,2),
    deptno INT
    );
insert into hr_employee(empno, ename, job, mgr, hire_date, sal, comm, deptno) VALUES ('7369','SMITH','CLERK','7902','1890-12-17','800.00',NULL,'20');
insert into hr_employee(empno, ename, job, mgr, hire_date, sal, comm, deptno) VALUES('7499','ALLEN','SALESMAN','7698','1981-02-20','1600.00','300.00','30');
insert into hr_employee(empno, ename, job, mgr, hire_date, sal, comm, deptno) VALUES ('7521','WARD','SALESMAN','7698','1981-02-22','1250.00','500.00','30');
insert into hr_employee(empno, ename, job, mgr, hire_date, sal, comm, deptno) VALUES ('7566','JONES','MANAGER','7839','1981-04-02','2975.00',NULL,'20');
insert into hr_employee(empno, ename, job, mgr, hire_date, sal, comm, deptno) VALUES ('7654','MARTIN','SALESMAN','7698','1981-09-28','1250.00','1400.00','30');
insert into hr_employee(empno, ename, job, mgr, hire_date, sal, comm, deptno) VALUES ('7698','BLAKE','MANAGER','7839','1981-05-01','2850.00',NULL,'30');
insert into hr_employee(empno, ename, job, mgr, hire_date, sal, comm, deptno) VALUES ('7782','CLARK','MANAGER','7839','1981-06-09','2450.00',NULL,'10');
insert into hr_employee(empno, ename, job, mgr, hire_date, sal, comm, deptno) VALUES ('7788','SCOTT','ANALYST','7566','1987-04-19','3000.00',NULL,'20');
insert into hr_employee(empno, ename, job, mgr, hire_date, sal, comm, deptno) VALUES ('7839','KING','PRESIDENT',NULL,'1981-11-17','5000.00',NULL,'10');
insert into hr_employee(empno, ename, job, mgr, hire_date, sal, comm, deptno) VALUES ('7844','TURNER','SALESMAN','7698','1981-09-08','1500.00','0.00','30');
insert into hr_employee(empno, ename, job, mgr, hire_date, sal, comm, deptno) VALUES ('7876','ADAMS','CLERK','7788','1987-05-23','1100.00',NULL,'20');
insert into hr_employee(empno, ename, job, mgr, hire_date, sal, comm, deptno) VALUES ('7900','JAMES','CLERK','7698','1981-12-03','950.00',NULL,'30');
insert into hr_employee(empno, ename, job, mgr, hire_date, sal, comm, deptno) VALUES ('7902','FORD','ANALYST','7566','1981-12-03','3000.00',NULL,'20');
insert into hr_employee(empno, ename, job, mgr, hire_date, sal, comm, deptno) VALUES ('7934','MILLER','CLERK','7782','1982-01-23','1300.00',NULL,'10');
insert into hr_employee(empno, ename, job, mgr, hire_date, sal, comm, deptno) VALUES (NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
select * from hr_employee;

/*1.Ensure the Salary cannot be Less then Negative or Zero*/
ALTER TABLE hr_employee
ADD CONSTRAINT chk_sal CHECK (sal >= 0);
DELETE FROM hr_employee
WHERE empno IN (
    SELECT max(empno)
    from hr_employee
    GROUP BY (empno, ename, job, mgr, hire_date, sal, comm, deptno)
);

/* 2.	List the Names and salary of the employee whose salary is greater than 1000*/
SELECT ename,sal
FROM hr_employee
WHERE sal > 1000;

/*3.	List Employee Names whose names start with either A or S.*/
SELECT ename
FROM hr_employee
WHERE ename LIKE 'A%' OR ename LIKE 'S%';

/*4.	List average monthly salary for each job within each department*/
SELECT deptno, job, AVG(sal) AS avg_monthly_salary
FROM hr_employee
GROUP BY deptno, job;

/*5.Display the empno, Emp name and the Manager name under whom the Employee works.*/
SELECT e1.empno AS Empno, 
       e1.ename AS "Emp name", 
       e2.mgr AS "Manager_id"
FROM hr_employee e1
LEFT JOIN hr_employee e2 ON e1.mgr = e2.empno;

/*6.	Display Empname, department no, salary , Rank of salary in Organisation , Rank of Salary in their respective department*/
SELECT ename,deptno,sal,
    DENSE_RANK() OVER (ORDER BY sal DESC) AS Rank_of_salary_Organisation,
    DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS dept_salary_rank
FROM 
    hr_employee;
    
/*Empno cannot be null or Duplicate. */
UPDATE hr_employee SET comm= 0
WHERE comm IS NULL;  
UPDATE hr_employee SET mgr= 0
WHERE mgr IS NULL;
SELECT COALESCE(empno, ename, job, mgr, hire_date, sal, comm, deptno, 0)
AS empno, ename, job, mgr, hire_date, sal, comm, deptno
FROM hr_employee;

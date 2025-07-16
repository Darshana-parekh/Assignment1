drop database PROJECT;

CREATE DATABASE  IF NOT EXISTS PROJECT;

USE PROJECT;

DROP TABLE IF EXISTS EMP_TABLE;
DROP TABLE IF EXISTS DEPT_TABLE;
DROP TABLE IF EXISTS STUDENT_TABLE;
DROP TABLE IF EXISTS EMP_LOG_TABLE;

CREATE TABLE EMP_TABLE (
  Emp_No int PRIMARY KEY default 0,
  E_Name varchar(10) DEFAULT NULL,
  Job varchar (9) DEFAULT NULL,
  Mgr int DEFAULT NULL,
  Hiredate date DEFAULT NULL,
  Sal decimal (7,2) DEFAULT NULL,
  Comm decimal (7,2) DEFAULT NULL,
  Dep_No int,
  FOREIGN KEY (Dep_No) REFERENCES DEPT_TABLE (Dep_No)
  );

CREATE TABLE DEPT_TABLE (
	Dep_No int PRIMARY KEY default 0,
    D_Name varchar (14) default null,
    L_O_C varchar (13) default null
    );

CREATE TABLE STUDENT_TABLE (
	R_No int Primary key default 0,
    S_Name varchar (14) default Null,
    City varchar (20) default Null,
    State varchar (20) default Null
    );

CREATE TABLE EMP_LOG_TABLE (
	Emp_Id int default null,
    Log_Date date default null,
    New_Salary int default null,
    Action varchar (20) default null
    );

INSERT INTO DEPT_TABLE (Dep_No,D_Name,L_O_C) VALUES 
    (10,'ACCOUNTING','NEW YORK'),
    (20,'RESEARCH','DALLAS'),
    (30,'SALES','CHICAGO'),
    (40,'OPERATIONS','BOSTON');
    
    

INSERT INTO EMP_TABLE (Emp_No,E_Name,Job,Mgr,Hiredate,Sal,Comm,Dep_No) 
	values (7369,'SMITH','CLERK',7902,'1980-12-17',800.00,0,20),
	(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30),
	(7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30),
	(7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,0,20),
	(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30),
	(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,0,30),
	(7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,0,10),
	(7788,'SCOTT','ANALYST',7566,'1987-06-11',3000.00,0,20),
 	(7839,'KING','PRESIDENT',0,'1981-08-17',5000.00,0,10),
 	(7844,'TURNER','SALESMAN',7698,'1981-08-09',1500.00,0,20),
	(7876,'ADAMS','CLERK',7788,'1987-07-13',1100.00,0,20),
	(7900,'JAMES','CLERK',7698,'1981-03-12',950.00,0,30),
	(7902,'FORD','ANALYST',7566,'1981-03-12',3000.00,0,20),
	(7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,0,10);

select * from EMP_Table;

#Q1
select distinct(Job) from EMP_Table;

#Q2
select Dep_No,Job from EMP_Table
Group by Dep_No,Job
Order by Dep_No, Job Desc;

#Q3
select distinct(Job) from EMP_Table 
Group by Job
Order by Job Desc;

#Q4
select * from EMP_Table 
Where Hiredate <'1981-01-01';

#Q5
select Emp_No,E_name,Sal,(Sal/30) as Daily_Sal From EMP_Table 
Order by Sal*12;

#Q6
select Emp_No,E_name,Sal,Hiredate,
    timestampdiff(year,hiredate,Curdate()) as Exp
    from EMP_Table; 

#Q7
select * from EMP_Table 
	where Comm > Sal;

#Q8
SELECT * FROM EMP_Table
WHERE Job = 'CLERK' OR Job = 'ANALYST'
ORDER BY Job desc;

#Q9
SELECT Emp_No,E_Name,Job,Mgr,Comm,Dep_No,Sal,(Sal*12) as Annual_Sal from EMP_Table
Where (Sal*12) between 22000 and 45000;

#Q10
SELECT * FROM EMP_Table
where E_Name like 'S%';

#Q11
SELECT * FROM EMP_Table
where not Emp_No like '78%';

#Q12
SELECT * FROM EMP_Table
where Job = 'CLERK' and Dep_No = '20';

#Q13
select e.Emp_No,e.E_Name,e.Hiredate,
       m.Emp_No as Mgr_No,e.E_Name as Mgr_Name,e.Hiredate as Mgr_Hiredate
       from EMP_Table as e
       join EMP_Table as m
       on e.Mgr = m.Emp_No
       where e.Hiredate < m.Hiredate;

#Q14
SELECT * FROM EMP_Table
Where Dep_No = '20'
and job in (select distinct job from EMP_Table where Dep_No = '10');

#Q15
select * from EMP_Table
  where Sal in (select distinct Sal from EMP_Table
                where E_Name in ('SMITH','FORD') 
                order by Sal desc);

#Q16
Select * from EMP_Table
Where Job = 'CLERK' or Job = 'SALESMAN';

#Q17
select * from EMP_table
    where Dep_No = 10
    and Job not in(select distinct Job from Emp_Table
                where Dep_No = 20);

#Q18
SELECT * FROM EMP_Table
    ORDER BY Sal DESC
    LIMIT 1;
    
#Q19
select * from EMP_Table
    where Sal in (select max(Sal) from EMP_Table);

#Q20
SELECT Mgr,sum(Sal) as Total_Salary from EMP_Table
Group by Mgr;

#Q21
Select * from EMP_Table
Where E_Name Like 'A%';

#Q22
select Emp_No,E_Name,Job,Sal from EMP_Table
    where (Job,Sal) in (select distinct Job,min(Sal) from EMP_Table
                        group by Job 
                        order by Job );

#Q23
select * from EMP_Table
where Sal > (select Sal from EMP_table where E_Name = 'BLAKE');

#Q24
Drop view V1;
create view V1 as
   select E.E_Name,E.Job,D.D_Name,D.L_O_C 
   from EMP_Table E
   join dept_table D
   on E.Dep_No = D.Dep_No;
   
select * from V1;

#Q25
SELECT * FROM Dept_table;
SELECT * FROM EMP_Table;

DROP PROCEDURE DNO;
DELIMITER  //
CREATE PROCEDURE DNO (in x int)
begin  
	select EMP_Table.E_Name,Dept_table.D_Name
    from EMP_Table
    join Dept_table
    on EMP_Table.Dep_No = Dept_table.Dep_No
    where EMP_Table.Dep_No = x;
end //
delimiter ;

call DNO (20);   

#Q26
select * from student_table;

ALTER TABLE STUDENT_TABLE ADD COLUMN PIN BIGINT;

#Q27
alter table student_table
modify S_name varchar(100);
                   
select * from emp_log_table;
select * from Emp_Table;

/* Trigger */
drop trigger update_Salary;

delimiter //
create trigger update_Salary
after update on  Emp_Table
for each row
begin
   if old.Sal !=new.Sal then
   insert into Emp_log_table(Emp_Id,Log_Date,New_Salary,Action)
                values(old.Emp_No,now(),new.Sal,'Update Salary');
    end if ;
  end//
  delimiter ;
    
  update EMP_table
  set Sal=900
  where Emp_No =7369;
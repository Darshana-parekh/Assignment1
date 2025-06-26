CREATE DATABASE	try;

use try;

create table employees (
	Employee_id INT auto_increment primary key,
    name varchar (100),
    position varchar (100),
    salary decimal (10,2),
    hire_date date
    );
    
create table employee_audit (
	audit_id int auto_increment primary key,
    employee_id Int,
    name varchar (100),
    position varchar (100),
	salary decimal (10,2),
    hire_date date,
	action_date timestamp default current_timestamp
    );
    
INSERT INTO employees (name, position, salary, hire_date) 
VALUES ('John Doe','Software Engineer', 80000.00, '2022-01-15'),
('Jane Smith', 'Project Manager', 90000.00, '2021-05-22'),
('Alice Johnson', 'UX Designer', 75000.00, '2023-03-01'); 

select * from employees;
select * from  employee_audit;

DELIMITER $$
CREATE TRIGGER after_update_employees
AFTER insert ON employees
FOR EACH ROW
BEGIN
	INSERT INTO employee_audit(employee_id,name,position)
    values (new.employee_id,new.name,new.position);
END $$
DELIMITER ;

drop procedure AUTO_UPDATE_EMP;

delimiter $$
create procedure AUTO_UPDATE_EMP (in x int, in y varchar (50), in z varchar (50))
begin 
	INSERT INTO employees (employee_id,name,position)
    values (x, y, z);
end $$
delimiter ;


call AUTO_UPDATE_EMP(4,"Ajay1","Data Analyst");
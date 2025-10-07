drop database Market_Co;

CREATE DATABASE  IF NOT EXISTS Market_Co;

USE Market_Co;

drop table if exists company;

CREATE TABLE company (
  CompanyID int,
  CompanyName varchar(45),
  street varchar(45),
  City varchar(45),
  State varchar(2),
  Zip varchar(10),
  PRIMARY KEY (CompanyID)
);

drop table if exists Contact;

/*Ans: 1*/
Create Table Contact (
	ContactID int,
    CompanyID int,
    FirstName varchar (45),
    LastName varchar (45),
    Street varchar (45),
    City varchar (45),
    State varchar (2),
    Zip varchar (10),
    IsMain Boolean,
    Email varchar (45),
    Phone int,
    PRIMARY KEY (ContactID),
	FOREIGN KEY (CompanyID) REFERENCES company (CompanyID)
  );

drop table if exists Employee;

/*Ans 2*/
create table Employee (
	EmployeeID int,
    FirstName varchar (45),
    LastName varchar (45),
    Salary Decimal (10,2),
    Hire Date,
    JobTitle varchar (25),
    Email varchar (45),
    Phone varchar (12),
    Primary key (EmployeeID)
    );

drop table if exists ContactEmployee;

/*Ans 3*/
create table ContactEmployee (
	ContactEmployeeID int,
    ContactID int,
    EmployeeID int,
    ContactDate date,
    Description varchar (100),
    FOREIGN KEY (ContactID) REFERENCES Contact (ContactID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID)
    );

select * from company;

insert into company (CompanyID,CompanyName,street,City,State,Zip) value
	('001','Urban Outfitters Inc.','RD1','Surat','GJ','395009'),
    ('002','S_Textile','RD2','Surat','GJ','395009'),
    ('003','Vankar Market','RD3','Surat','GJ','395009');

select * from contact;

insert into contact (ContactID,CompanyID,FirstName,LastName,street,City,State,Zip,IsMain,Email,Phone) value
	('2001','001','Ram','Shah','RD4','Surat','GJ','395009','1','Ram@Gmail.com','0261'),
    ('2002','002','Lakhan','Shah','RD5','Surat','GJ','395009','2','Lakhan@Gmail.com','0261'),
    ('2003','003','Krishna','Shah','RD6','Surat','GJ','395009','3','Krishna@Gmail.com','0261');
    
select * from employee;

insert into employee(EmployeeID,FirstName,LastName,Salary,Hire,JobTitle,Email,Phone) values
	('4001','Sita','Patel','30.000','2002-01-02','Admin','Sita@gmail.com','022-8142728'),
    ('4002','Rukshmani','Yadav','35.000','2002-01-03','HR','Rukshmani@gmail.com','022-8142727'),
    ('4003','Urmila','Patel','32.000','2002-01-04','Secretary','Urmila@gmail.com','022-8142726');
    
insert into employee(EmployeeID,FirstName,LastName,Salary,Hire,JobTitle,Email,Phone) values
	('4004','Lesly','Bland','30.000','2002-01-02','Admin','Lesly@gmail.com','022-8142728');

select * from contactemployee;

insert into contactemployee (ContactEmployeeID,ContactID,EmployeeID,ContactDate,Description) value
	('3001','2001','4001','2001-01-01','Very Good in Excel'),
    ('3002','2002','4002','2001-02-02','Very Good in SQL'),
    ('3003','2003','4003','2001-03-03','Very Good in Ph');

/*Ans 4*/    
update employee set Phone = '215-555-8800' where Phone = '022-8142728';

/*Ans5*/
update company set CompanyName = 'Urban Outfitters' where CompanyName = 'Urban Outfitters Inc.';


update employee set FirstName = 'Dianne Connor' where FirstName = 'Sita';
update employee set FirstName = 'Jack Lee' where FirstName = 'Rukshmani';

select * from contactemployee;
/*Ans6*/
delete from contactemployee where ContactID = (select ContactID from Contact where FirstName = 'Dianne Connor') and EmployeeID = (select EmployeeID from Employee where FirstName = 'Jack Lee');

/*Ans7*/
select * from company;
select * from contact;
select * from company;
update company set CompanyName = 'Toll Brothers' where CompanyName = 'Vankar Market';

SELECT E.FirstName, E.LastName
FROM Employee E
JOIN ContactEmployee CE ON E.EmployeeID = CE.EmployeeID
JOIN Contact C ON CE.ContactID = C.ContactID
JOIN Company CO ON C.CompanyID = CO.CompanyID
WHERE CO.CompanyName = 'Toll Brothers';

/*Ans8*/
#% in a LIKE statement represents zero or more characters, meaning it matches any sequence of characters.

/*Ans9*/
#Normalization is the process oforganizing data in a database to minimize redundancy and improve data integrity.

/*Ans10*/
#A join in MySQL means combining records from two or more tables based on a related column between them

/*Ans11*/
#DDL : DATA DEFINITION LANGUAGE - SQL commands like CREATE, ALTER and DROP used to define or modify the structure of database objects
# DCL : DATA CONTROL LANGUAGE - Commands like GRANT and REVOKE used for access control and permissions
# DML : DATA MANIPULATION LANGUAGE - Commands like INSERT, UPDATE, DELETE and SELECT used to manipulate data within tables

/*Ans12*/
#Role and types of MySQL JOIN: The JOIN clause fetches related data from different tables.Common types: INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN.
--DQL 
--------------------------------------
--Display all employee data. 
SELECT * 
FROM Employee;

--Display employee first name, last name, salary, and department number.
SELECT Fname, Lname, Salary, Dno
FROM Employee;

--Display each employee’s full name and their annual commission (10% of annual salary) as ANNUAL_COMM.
SELECT Fname + ' ' + Lname AS Full_Name,(Salary * 12 * 0.10) AS ANNUAL_COMM
FROM Employee;

--Display employee ID and name for employees earning more than 1000 LE monthly
SELECT SSN, Fname, Lname
FROM Employee
WHERE Salary > 1000;

--Display employee ID and name for employees earning more than 10000 LE annually
SELECT SSN, Fname, Lname
FROM Employee
WHERE Salary * 12 > 10000;

--Display names and salaries of all female employees
SELECT Fname, Lname, Salary
FROM Employee
WHERE Sex = 'F';

--Display employees whose salary is between 2000 and 5000
SELECT *
FROM Employee
WHERE Salary BETWEEN 2000 AND 5000;

--Display employee names ordered by salary descending
SELECT Fname, Lname, Salary
FROM Employee
ORDER BY Salary DESC;

--Display the maximum, minimum, and average salary
SELECT MAX(Salary) AS Max_Salary, MIN(Salary) AS Min_Salary, AVG(Salary) AS Avg_Salary
FROM Employee;

--Display the total number of employees
SELECT COUNT(*) AS Total_Employees
FROM Employee;

--Display employees whose first name starts with 'A'
SELECT *
FROM Employee
WHERE Fname LIKE 'A%';

--Display employees who have no supervisor
SELECT *
FROM Employee
WHERE Superssn IS NULL;

--Display employees hired after 2020


--DML
--Insert your personal data
INSERT INTO Employee (SSN, Fname, Lname, Salary, Dno, Superssn)
VALUES (102672, 'Sharouq', 'AlBadi', 3000, 30, 112233);

--Insert another employee (friend) with NULL salary and supervisor
INSERT INTO Employee (SSN, Fname, Lname, Dno, Salary, Superssn)
VALUES (102660, 'Shahad', 'AlHosni', 30, NULL, NULL);

--Update your salary by 20%
UPDATE Employee
SET Salary = Salary * 1.20
WHERE SSN = 102672;

--Increase salaries by 5% for all employees in department 30
UPDATE Employee
SET Salary = Salary * 1.05
WHERE Dno = 30;

--Set commission to NULL for employees earning less than 2000


--Delete employees with NULL salary
DELETE FROM Employee
WHERE Salary IS NULL;


-----------------------------------------------------------------------------------------------------
--Join
--Display the department ID, department name, manager ID, and the full name of the manager.
select Dnum , Dname , MGRSSN, Fname+ ' '+ Lname as 'full Name'
from Departments, Employee
where SSN = MGRSSN

--Display the names of departments and the names of the projects they control.
select Dname , Pname
from Departments D, Project P
where D.Dnum = P.Dnum

-- Display full data of all dependents, along with the full name of the employee they depend on.

select ESSN,Dependent_name,D.Sex ,D.Bdate , Fname+ ' '+ Lname as 'full Name'
from Dependent D, Employee
where ESSN =SSN

--Display the project ID, name, and location of all projects located in Cairo or Alex.
select Pnumber, Pname,City 
from Project
where City = 'Cairo' or City ='Alex'

--Display all project data where the project name starts with the letter 'A'.
select * 
from Project
where Pname like 'A%'

--Display the IDs and names of employees in department 30 with a salary between 1000 and 2000 LE.
select SSN , Fname+ ' '+ Lname as 'full Name',Salary, Dnum 
from Employee ,Departments 
where Dnum=30 and Salary between 1000 and 2000

--Retrieve the names of employees in department 10 who work ≥ 10 hours/week on the "AL Rabwah" project.
select Fname+ ' '+ Lname as 'full Name' ,Dno , Pname , Hours
from Employee E , Works_for H ,Project P
where E.Dno=10 and H.Hours >=10 and Pname= 'AL Rabwah'

--Find the names of employees who are directly supervised by "Kamel Mohamed".
select E.Fname + ' ' + E.Lname AS Full_Name
from Employee E , Employee S
 where E.SuperSSN = S.SSN
  and S.Fname = 'Kamel' AND S.Lname = 'Mohamed'


--Retrieve the names of employees and the names of the projects they work on, sorted by project name.
select Fname + ' ' + Lname AS Full_Name , Pname
from Employee  , Project 
order by Pname 

--For each project located in Cairo, display the project number, controlling department name, manager's last name,address, and birthdate.
SELECT 
    P.Pnumber,
    D.Dname,
    E.Lname,
    P.City,
    E.Bdate
FROM Project P
JOIN Departments D
    ON P.Dnum = D.Dnum
JOIN Employee E
    ON D.MGRSSN = E.SSN
WHERE P.City = 'Cairo';
--Display all data of managers in the company.
select * from Departments

--Display all employees and their dependents, even if some employees have no dependents
select E.Fname + ' ' + E.Lname AS Full_Name , D.Dependent_name
from Employee E ,Dependent D
where D.ESSN =E.SSN



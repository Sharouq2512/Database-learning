create database UniversityDB

use UniversityDB
--DDL
create table Student(
S_Id int primary key ,
F_Name nvarchar(50) not null,
L_Name nvarchar(50) not null,
Phone_No int,
BOD date,

)

create table Department(
D_Id int primary key identity(1,1),
D_Name nvarchar(50) not null,

)

create table Course(
Course_Id int primary key,
Course_Name nvarchar not null,
Duration int ,
)
ALTER TABLE Course
ALTER COLUMN Course_Name nvarchar(50) not null;

create table Dep_Course(
Dep_Id int,
Cor_Id int,
Foreign key (Dep_Id) references Department(D_Id),
Foreign key (Cor_Id) references Course(Course_Id),
primary key (Dep_Id, Cor_Id)
)

create table Stud_Course(
Stud_Id int,
Cor_Id int
Foreign key (Stud_Id) references Student(S_Id),
Foreign key (Cor_Id) references Course(Course_Id),
)

create table Exams(
Exam_Code int primary key,
EDate date,
ETime time,
Room varchar(20),
Dep_Id int,
Foreign key (Dep_Id) references Department(D_Id),
)

create table Stud_Exams(
Stud_Id int,
E_Code int,
Foreign key (Stud_Id) references Student(S_Id),
Foreign key (E_Code) references Exams(Exam_Code),
)

create table Faculty(
F_Id int primary key,
Department nvarchar(50),
Fac_Name nvarchar(50),
Mobile_No int,
Salary int,
)

create table Subjects(
Subject_Id int primary key,
Subject_Name nvarchar(50),
Fac_Id int,
Foreign key (Fac_Id) references Faculty(F_Id),
)

create table Stud_Subject(
Stud_Id int,
Sub_Id int,
Foreign key (Stud_Id) references Student(S_Id),
Foreign key (Sub_Id) references Subjects(Subject_Id),
)
 
create table Hostel(
Hostel_Id int primary key,
Hostel_Name nvarchar(50) not null,
City nvarchar(50),
HState nvarchar(50),
HAddress nvarchar(50),
No_Of_Seats int,
Pin_Code int,
)

create table Stud_Faculty(
Stud_Id int,
Fac_Id int,
Foreign key (Stud_Id) references Student(S_Id),
Foreign key (Fac_Id) references Faculty(F_Id),
)

alter table Student
add Dep_Id int Foreign key references Department(D_Id)

alter table Student
add H_Id int Foreign key references Hostel(Hostel_Id)

--DML
INSERT INTO Department (D_Name)
VALUES	('Computer Science'),
('Mathematics'),
('Physics'),
('Chemistry'),
('Biology'),
('English'),
('History');

INSERT INTO Hostel (Hostel_Id, Hostel_Name, City, HState, HAddress, No_Of_Seats, Pin_Code) 
VALUES(1, 'Maple Hostel', 'Oman City', 'Oman', 'Street 1', 100, 12345),
	(2, 'Oak Hostel', 'Oman City', 'Oman', 'Street 2', 80, 12346),
	(3, 'Pine Hostel', 'Oman City', 'Oman', 'Street 3', 50, 12347),
	(4, 'Cedar Hostel', 'Oman City', 'Oman', 'Street 4', 60, 12348),
	(5, 'Birch Hostel', 'Oman City', 'Oman', 'Street 5', 70, 12349),
	(6, 'Spruce Hostel', 'Oman City', 'Oman', 'Street 6', 90, 12350),
	(7, 'Willow Hostel', 'Oman City', 'Oman', 'Street 7', 40, 12351);

INSERT INTO Student (S_Id, F_Name, L_Name, Phone_No, BOD, Dep_Id, H_Id) 
VALUES(101, 'Alice', 'Johnson', 98367453, '2000-05-12', 1, 1),
	(102, 'Bob', 'Smith', 79476253, '1999-11-23', 2, 2),
	(103, 'Charlie', 'Brown', 97354283, '2001-02-15', 1, 1),
	(104, 'Diana', 'White', 97308763, '2000-08-30', 3, 3),
	(105, 'Ethan', 'Green', 98723045, '2002-01-10', 2, 2),
	(106, 'Fiona', 'Black', 93872634, '2001-07-20', 3, 3),
	(107, 'George', 'King', 98007590, '2000-03-18', 1, 1);

INSERT INTO Course (Course_Id, Course_Name, Duration) VALUES
(201, 'Database Systems', 6),
(202, 'Calculus', 4),
(203, 'Physics I', 5),
(204, 'Data Structures', 5),
(205, 'Linear Algebra', 4),
(206, 'Organic Chemistry', 6),
(207, 'World History', 3);

INSERT INTO Dep_Course (Dep_Id, Cor_Id) VALUES
(1, 201),
(1, 204),
(2, 202),
(2, 205),
(3, 203),
(4, 206),
(7, 207);

INSERT INTO Stud_Course (Stud_Id, Cor_Id) VALUES
(101, 201),
(101, 204),
(102, 202),
(102, 205),
(103, 201),
(103, 204),
(104, 203),
(105, 205),
(106, 203),
(106, 206),
(107, 201),
(107, 204),
(101, 202);

INSERT INTO Exams (Exam_Code, EDate, ETime, Room, Dep_Id) VALUES
(301, '2025-12-20', '09:00', 'Room A', 1),
(302, '2025-12-22', '13:00', 'Room B', 2),
(303, '2025-12-24', '10:00', 'Room C', 3),
(304, '2025-12-26', '11:00', 'Room D', 4),
(305, '2025-12-28', '12:00', 'Room E', 5),
(306, '2025-12-29', '09:30', 'Room F', 6),
(307, '2025-12-30', '14:00', 'Room G', 7);

INSERT INTO Stud_Exams (Stud_Id, E_Code) VALUES
(101, 301),
(102, 302),
(103, 301),
(104, 303),
(105, 302),
(106, 306),
(107, 301),
(101, 302);

INSERT INTO Faculty (F_Id, Department, Fac_Name, Mobile_No, Salary) VALUES
(401, 'Computer Science', 'Dr. Alan Turing', 98765432, 5000),
(402, 'Mathematics', 'Dr. Ada Lovelace', 97865437, 4800),
(403, 'Physics', 'Dr. Isaac Newton', 78900098, 5200),
(404, 'Chemistry', 'Dr. Marie Curie', 78966653, 5100),
(405, 'Biology', 'Dr. Charles Darwin', 78889566, 4700),
(406, 'English', 'Dr. Shakespeare', 90078522, 4500),
(407, 'History', 'Dr. Herodotus', 95311268, 4600);

INSERT INTO Subjects (Subject_Id, Subject_Name, Fac_Id) VALUES
(501, 'Databases', 401),
(502, 'Algorithms', 401),
(503, 'Calculus', 402),
(504, 'Linear Algebra', 402),
(505, 'Mechanics', 403),
(506, 'Organic Chemistry', 404),
(507, 'World History', 407);

INSERT INTO Stud_Subject (Stud_Id, Sub_Id) VALUES
(101, 501),
(101, 502),
(102, 503),
(102, 504),
(103, 501),
(104, 505),
(105, 504),
(106, 506),
(107, 501),
(107, 502),
(101, 503);

INSERT INTO Stud_Faculty (Stud_Id, Fac_Id) VALUES
(101, 401),
(102, 402),
(103, 401),
(104, 403),
(105, 402),
(106, 404),
(107, 401),
(101, 402);

--Display all student records. 
select * from Student

alter table Student
add enrollment_Date date,
S_status nvarchar(50),
GPA decimal(3,2)

alter table Student
add Advisor nvarchar(50)

update Student set enrollment_Date= '2021-04-29' , S_status= 'Active' , GPA=3.1, Advisor='ms.Amna' where S_Id=103;
update Student set enrollment_Date= '2022-04-29' , S_status= 'Graduated' , GPA=3.01, Advisor='ms.Amna' where S_Id=101;
update Student set enrollment_Date= '2022-04-29' , S_status= 'Active' , GPA=2.9, Advisor='mr.Mohad' where S_Id=107;
update Student set enrollment_Date= '2023-04-29' , S_status= 'Active' , GPA=3.7, Advisor='ms.Ahlam' where S_Id=104;
update Student set enrollment_Date= '2021-04-29' , S_status= 'Graduated' , GPA=3.1, Advisor='ms.Amna' where S_Id=102;
update Student set enrollment_Date= '2025-04-29' , S_status= 'Graduated' , GPA=3.4, Advisor='Mr.Ahmed' where S_Id=105;
update Student set enrollment_Date= '2024-04-29' , S_status= 'Active' , GPA=2.2, Advisor='ms.Amna' where S_Id=106;


--Display each student's full name, enrollment date, and current status.
select F_Name + ' '+L_Name as Full_Name, enrollment_Date , S_status
from Student

--Display each course Course name and Duration.
SELECT Course_Name, Duration
FROM Course;

--Display each student’s full name and GPA as GPA Score. 
select F_Name + ' '+L_Name as Full_Name, GPA as GPA_Score
from Student

--List student IDs and names of students with GPA greater than 3.5. 
select F_Name + ' '+L_Name as Full_Name, GPA as GPA_Score 
from Student
where (GPA > 3.5)

--List students who enrolled before 2022. 
select F_Name + ' '+L_Name as Full_Name
from Student
where (enrollment_Date < '2022-01-01')

--Display students with GPA between 3.0 and 3.5. 
select F_Name + ' '+L_Name as Full_Name, GPA as GPA_Score 
from Student
where (GPA > 3.0 and GPA < 3.5)

--Display students ordered by GPA descending.
select *
from Student
ORDER BY GPA DESC 

--Display the maximum, minimum, and average GPA. 
select 
MAX(GPA) AS Max_GPA,
    MIN(GPA) AS Min_GPA,
    AVG(GPA) AS Avg_GPA
from Student

--Display total number of students. 
SELECT COUNT(*) AS Total_Students
FROM Student;

--Display students whose names end with 'a'. 
SELECT *
FROM Student
WHERE F_Name LIKE '%a';

--Display students with NULL advisor. 
SELECT *
FROM Student
WHERE Advisor is Null;

--Display students enrolled in 2021.
SELECT *
FROM Student
WHERE enrollment_Date BETWEEN '2021-01-01' AND '2021-12-31';

------------------------------------------------------------------------------------------------
--DML 

--Insert your data as a new student (Student ID = 300045, Program ID = 2, GPA = 3.6). 
INSERT INTO Student (S_Id, F_Name, L_Name,  GPA, enrollment_Date, S_status)
VALUES (300045, 'Sharouq', 'albadi', 3.6, '2022-09-17', 'Active');

--Insert another student (your friend) with GPA and advisor set to NULL. 
INSERT INTO Student (S_Id, F_Name, L_Name,  GPA,Advisor)
VALUES (300046, 'Shahad', 'Alhosni', 2.7,  null);

--Increase your GPA by 0.2. 
UPDATE Student
SET GPA = GPA + 0.2
WHERE S_Id = 300045;

--Set GPA to 2.0 for students with GPA below 2.0. 
UPDATE Student
SET GPA = 2.0
WHERE GPA < 2.0;

--Increase GPA by 0.1 for students enrolled before 2020. 
UPDATE Student
SET GPA = GPA + 0.1
WHERE enrollment_Date < '2020-01-01';

--Delete students with status 'Inactive'. 
DELETE FROM Student
WHERE S_Status = 'Inactive';
------------------------------------------------------------------------------------------------------
--Join



--Display the department ID, name, and the full name of the faculty managing it.
select D_Id , D_Name , Fac_Name 
from Department , Faculty

--Display each program's name and the name of the department offering it.
select Course_Name , D_Name
from Course , Department

--Display the full student data and the full name of their faculty advisor.
select F_Name + ' '+L_Name as Full_Name , Fac_Name
from Student ,Faculty

--Display class IDs, course titles, and room locations for classes in buildings 'A' or 'B'.
select C.Course_Id ,C.Course_Name , E.Room , D.D_Id
from Exams E inner join Department D 
on E.Dep_Id = D.D_Id
inner join Dep_Course DC
on D.D_Id = DC.Dep_Id
inner join Course C
on DC.Cor_Id = C.Course_Id
where E.Room like '%A' or E.Room like'%B'

--Display full data about courses whose titles start with "I" (e.g., "Introduction to...").
SELECT *
FROM Course
WHERE Course_Name LIKE 'I%';
--Display names of students in program ID 3 whose GPA is between 2.5 and 3.5.
SELECT F_Name, L_Name
FROM Student
WHERE Dep_Id = 3
AND GPA BETWEEN 2.5 AND 3.5;

--Retrieve student names in the Engineering program who earned grades ≥ 90 in the "Database" course.
SELECT S.F_Name, S.L_Name
FROM Student S
JOIN Stud_Course SC ON S.S_Id = SC.Stud_Id
JOIN Course C ON SC.Cor_Id = C.Course_Id
WHERE C.Course_Name = 'Database'
AND S.Dep_Id = (
    SELECT D_Id FROM Department WHERE D_Name = 'Engineering'
);
--Find names of students who are advised by "Dr. Ahmed Hassan".
SELECT S.F_Name, S.L_Name
FROM Student S
JOIN Stud_Faculty SF ON S.S_Id = SF.Stud_Id
JOIN Faculty F ON SF.Fac_Id = F.F_Id
WHERE F.Fac_Name = 'Dr. Ahmed Hassan';

--Retrieve each student's name and the titles of courses they are enrolled in, ordered by course title.
SELECT 
    S.F_Name, 
    S.L_Name, 
    C.Course_Name
FROM Student S
JOIN Stud_Course SC ON S.S_Id = SC.Stud_Id
JOIN Course C ON SC.Cor_Id = C.Course_Id
ORDER BY C.Course_Name;

--For each class in Building 'Main', retrieve class ID, course name, department name, and faculty name teaching the class.
SELECT 
    C.Course_Id,
    C.Course_Name,
	DC.Dep_Id,
	D.D_Id,
    D.D_Name,
    F.Fac_Name,
	E.Room,
	E.Dep_Id
FROM Course C inner JOIN Dep_Course DC
ON C.Course_Id = DC.Cor_Id
inner JOIN Department D
ON D.D_Id = DC.Dep_Id
inner JOIN Exams E
on DC.Dep_Id = E.Dep_Id
inner JOIN Faculty F
ON D.D_Name = F.Department
WHERE E.Room LIKE '%A';
--Display all faculty members who manage any department.
SELECT F.*
FROM Faculty F 
 Left JOIN Department D
 ON F.Department = D.D_Name;
--Display all students and their advisors' names, even if some students don’t have advisors yet
SELECT 
    S.F_Name,
    S.L_Name,
    F.Fac_Name AS Advisor
FROM Student S
LEFT JOIN Stud_Faculty SF ON S.S_Id = SF.Stud_Id
LEFT JOIN Faculty F ON SF.Fac_Id = F.F_Id;

select * from Course
select * from Department
select * from Dep_Course
select * from Faculty
select * from Exams
select * from Student
select * from Hostel
select * from Stud_Course
select * from Stud_Exams
select * from Stud_Faculty
select * from Stud_Subject
select * from Subjects
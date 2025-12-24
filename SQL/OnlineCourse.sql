create database OnlineCourse
use OnlineCourse

CREATE TABLE Instructors (
InstructorID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100),
JoinDate DATE
);

CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR(50)
);

CREATE TABLE Courses (
CourseID INT PRIMARY KEY,
Title VARCHAR(100),
InstructorID INT,
CategoryID INT,
Price DECIMAL(6,2),
PublishDate DATE,
FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Students (
StudentID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100),
JoinDate DATE
);

CREATE TABLE Enrollments (
EnrollmentID INT PRIMARY KEY,
StudentID INT,
CourseID INT,
EnrollDate DATE,
CompletionPercent INT,
Rating INT CHECK (Rating BETWEEN 1 AND 5),
FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

--------------------------------------------------------------------------

INSERT INTO Instructors VALUES
(1, 'Sarah Ahmed', 'sarah@learnhub.com', '2023-01-10'),
(2, 'Mohammed Al-Busaidi', 'mo@learnhub.com', '2023-05-21');

INSERT INTO Categories VALUES
(1, 'Web Development'),
(2, 'Data Science'),
(3, 'Business');

INSERT INTO Courses VALUES
(101, 'HTML & CSS Basics', 1, 1, 29.99, '2023-02-01'),
(102, 'Python for Data Analysis', 2, 2, 49.99, '2023-03-15'),
(103, 'Excel for Business', 2, 3, 19.99, '2023-04-10'),
(104, 'JavaScript Advanced', 1, 1, 39.99, '2023-05-01');

INSERT INTO Students VALUES
(201, 'Ali Salim', 'ali@student.com', '2023-04-01'),
(202, 'Layla Nasser', 'layla@student.com', '2023-04-05'),
(203, 'Ahmed Said', 'ahmed@student.com', '2023-04-10');

INSERT INTO Enrollments VALUES
(1, 201, 101, '2023-04-10', 100, 5),
(2, 202, 102, '2023-04-15', 80, 4),
(3, 203, 101, '2023-04-20', 90, 4),
(4, 201, 102, '2023-04-22', 50, 3),
(5, 202, 103, '2023-04-25', 70, 4),
(6, 203, 104, '2023-04-28', 30, 2),
(7, 201, 104, '2023-05-01', 60, 3);


----------------------------------------------------------------------------------
--Day 1 – Core Aggregation Practice

--1.Display all courses with prices.
select Title, Price from Courses

--2.Display all students with join dates.
select StudentID,FullName , JoinDate from Students

--3. Show all enrollments with completion percent and rating.
select EnrollmentID, CompletionPercent,Rating from Enrollments

--4. Count instructors who joined in 2023.
select count(InstructorID) from Instructors
where JoinDate >='2023-01-01'

--5. Count students who joined in April 2023.
select count(StudentID) from Students
where JoinDate >='2023-04-01'

----------------------------------------------------------------------------------

--Part 2: Beginner Aggregation

--1. Count total number of students.
select count(StudentID) from Students

--2. Count total number of enrollments.
select count(EnrollmentID) from Enrollments

--3. Find average rating per course.
select avg(Price) from Courses
group by CourseID

--4. Count courses per instructor.
select count(CourseID) from Courses
group by InstructorID

--5. Count courses per category.
select count(CourseID) from Courses
group by CategoryID

--6. Count students enrolled in each course.
SELECT 
    C.Title,
    COUNT(S.StudentID) AS StudentCount
FROM Students S
INNER JOIN Enrollments E
    ON S.StudentID = E.StudentID
	INNER JOIN Courses C
    ON E.CourseID = C.CourseID
GROUP BY C.Title;

--7. Find average course price per category.
select avg(Price) from Courses
group by CategoryID

--8. Find maximum course price.
select max(Price) from Courses

--9. Find min, max, and average rating per course.
select min (Price) as minimum,max(Price) as maximum ,avg(Price) as average from Courses
group by CourseID
--10. Count how many students gave rating = 5
select count(S.StudentID) 
from Students S inner join Enrollments E
on S.StudentID= E.StudentID
where Rating=5
------------------------------------------------------------------------------

--Part 3: Extended Beginner Practice

--11. Count enrollments per month.
select count(EnrollmentID) as enrollment ,month(EnrollDate) as mounth
from Enrollments
group by month(EnrollDate)

--12. Find average course price overall.
select avg(Price) from Courses
group by CourseID

--13. Count students per join month.
select count(StudentID) 
from Students 
group by month(joinDate)

--14. Count ratings per value (1–5).
select count(EnrollmentID) as countStud, Rating
from Enrollments
group by Rating

--15. Find courses that never received rating = 5.
select count(S.StudentID) 
from Students S inner join Enrollments E
on S.StudentID= E.StudentID
where Rating>= 1 and Rating< 5

--16. Count courses priced above 30.
select count(CourseID) 
from Courses
where Price>30

--17. Find average completion percentage.
select avg(CompletionPercent)
from Enrollments

--18. Find course with lowest average rating
SELECT TOP 1
    C.Title,
    AVG(E.Rating) AS AvgRating
FROM Courses C
INNER JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.Title
ORDER BY AvgRating ASC;

--Day 1 Mini Challenge
--Course Performance Snapshot
--Show:
--• Course title
--• Total enrollments
--• Average rating
--• Average completion %
SELECT 
    C.Title,
    COUNT(EnrollmentID) AS Total_enrollments, avg(Rating) as Rating ,avg(CompletionPercent) as Completion_Percent
FROM Students S
INNER JOIN Enrollments E
    ON S.StudentID = E.StudentID
	INNER JOIN Courses C
    ON E.CourseID = C.CourseID
GROUP BY C.Title;

----------------------------------------------------------------------------------

--Day 2 – JOIN + Aggregation + Analysis

--Part 4: JOIN + Aggregation

--1. Course title + instructor name + enrollments.
SELECT 
    C.Title AS Title,
    I.FullName,
    COUNT(E.EnrollmentID) AS countE
FROM Enrollments E
INNER JOIN Courses C
    ON E.CourseID = C.CourseID
INNER JOIN Instructors I
    ON C.InstructorID = I.InstructorID
GROUP BY 
    C.Title,
    I.FullName;

--2. Category name + total courses + average price.
select CategoryName , count(CourseID) , avg(Price)
from Categories C , Courses Co
where C.CategoryID=Co.CategoryID
group by CategoryName

--3. Instructor name + average course rating.
select I.FullName , avg(Rating)as Rate
FROM Instructors I
INNER JOIN Courses C
ON I.InstructorID = C.InstructorID
INNER JOIN Enrollments E
    ON E.CourseID = C.CourseID
group by I.FullName

--4. Student name + total courses enrolled.
SELECT 
    S.FullName,
    COUNT(E.CourseID) AS TotalCourses
FROM Students S
LEFT JOIN Enrollments E
    ON S.StudentID = E.StudentID
GROUP BY S.FullName;
--5. Category name + total enrollments.
SELECT 
    Cat.CategoryName,
    COUNT(E.EnrollmentID) AS TotalEnrollments
FROM Categories Cat
INNER JOIN Courses C
    ON Cat.CategoryID = C.CategoryID
LEFT JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY Cat.CategoryName;

--6. Instructor name + total revenue.
SELECT 
    I.FullName,
    SUM(C.Price) AS TotalRevenue
FROM Instructors I
INNER JOIN Courses C
    ON I.InstructorID = C.InstructorID
INNER JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY I.FullName;
--7. Course title + % of students completed 100%.
SELECT 
    C.Title,
   count (StudentID)
FROM Courses C
INNER JOIN Enrollments E
    ON C.CourseID = E.CourseID
	where CompletionPercent=100
GROUP BY C.Title;

------------------------------------------------------------------------------------

--Part 5: HAVING Practice

--Use HAVING only.

--1. Courses with more than 2 enrollments
SELECT 
    C.Title
FROM Courses C
INNER JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.Title
HAVING COUNT(E.EnrollmentID) > 2

--2. Instructors with average rating above 4.
SELECT 
    I.FullName
FROM Instructors I
INNER JOIN Courses C
    ON I.InstructorID = C.InstructorID
INNER JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY I.FullName
HAVING AVG(E.Rating) > 2;
--3. Courses with average completion below 60%.
SELECT 
    C.Title
FROM Courses C
INNER JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.Title
HAVING AVG(E.CompletionPercent) < 60;

--4. Categories with more than 1 course.
SELECT 
    Cat.CategoryName
FROM Categories Cat
INNER JOIN Courses C
    ON Cat.CategoryID = C.CategoryID
GROUP BY Cat.CategoryName
HAVING COUNT(C.CourseID) > 1;
--5. Students enrolled in at least 2 courses.
SELECT 
    S.FullName
FROM Students S
INNER JOIN Enrollments E
    ON S.StudentID = E.StudentID
GROUP BY S.FullName
HAVING COUNT(E.CourseID) >= 2;
----------------------------------------------------------------------------------------

select * from Categories
select * from Courses
select * from Enrollments
select * from Instructors
select * from Students

--Part 6: Analytical Thinking

--Answer using SQL + short explanation:

--1. Best performing course.
SELECT TOP 1
    C.Title,
    AVG(E.Rating) AS AvgRating
FROM Courses C
INNER JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.Title
ORDER BY AvgRating DESC;

--2. Instructor to promote.
SELECT TOP 1
    I.FullName,
    AVG(E.Rating) AS AvgRating
FROM Instructors I
INNER JOIN Courses C
    ON I.InstructorID = C.InstructorID
INNER JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY I.FullName
ORDER BY AvgRating DESC; 

--3. Highest revenue category.
SELECT TOP 1
    Cat.CategoryName,
    SUM(C.Price) AS TotalRevenue
FROM Categories Cat
INNER JOIN Courses C
    ON Cat.CategoryID = C.CategoryID
INNER JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY Cat.CategoryName
ORDER BY TotalRevenue DESC;

--4. Do expensive courses have better ratings?
SELECT 
    CASE 
        WHEN C.Price >= 500 THEN 'Expensive'
        ELSE 'Cheap'
    END AS PriceRange,
    AVG(E.Rating) AS AvgRating
FROM Courses C
INNER JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY 
    CASE 
        WHEN C.Price >= 500 THEN 'Expensive'
        ELSE 'Cheap'
    END;
--5. Do cheaper courses have higher completion?
SELECT 
    CASE 
        WHEN C.Price < 500 THEN 'Cheap'
        ELSE 'Expensive'
    END AS PriceRange,
    (COUNT(CASE WHEN E.CompletionPercent = 100 THEN 1 END) * 100.0
     / COUNT(E.EnrollmentID)) AS CompletionPercent
FROM Courses C
INNER JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY 
    CASE 
        WHEN C.Price < 500 THEN 'Cheap'
        ELSE 'Expensive'
    END;
----------------------------------------------------------------------------------------

--Final Challenge – Mini Analytics Report

--1. Top 3 courses by revenue.
SELECT TOP 3
    C.Title,
    SUM(C.Price) AS TotalRevenue
FROM Courses C
INNER JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.Title
ORDER BY TotalRevenue DESC;

--2. Instructor with most enrollments.
SELECT TOP 1
    I.FullName,
    COUNT(E.EnrollmentID) AS TotalEnrollments
FROM Instructors I
INNER JOIN Courses C
    ON I.InstructorID = C.InstructorID
INNER JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY I.FullName
ORDER BY TotalEnrollments DESC;

--3. Course with lowest completion rate.
SELECT TOP 1
    C.Title ,E.CompletionPercent
   
FROM Courses C
INNER JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY C.Title ,E.CompletionPercent 
order by E.CompletionPercent ASc

--4. Category with highest average rating.
SELECT TOP 1
    Cat.CategoryName,
    AVG(E.Rating) AS AvgRating
FROM Categories Cat
INNER JOIN Courses C
    ON Cat.CategoryID = C.CategoryID
INNER JOIN Enrollments E
    ON C.CourseID = E.CourseID
GROUP BY Cat.CategoryName
ORDER BY AvgRating DESC;

--5. Student enrolled in most courses.
SELECT TOP 1
    S.FullName,
    COUNT(E.CourseID) AS TotalCourses
FROM Students S
INNER JOIN Enrollments E
    ON S.StudentID = E.StudentID
GROUP BY S.FullName
ORDER BY TotalCourses DESC;


create database Hostel
use Hostel

CREATE TABLE Branches (
    Branch_Id INT PRIMARY KEY,
    BName VARCHAR(50) NOT NULL,
    Location VARCHAR(100)
);

CREATE TABLE Staff (
    S_Id INT PRIMARY KEY,
    SName VARCHAR(100) NOT NULL,
    J_Title VARCHAR(50),
    Salary DECIMAL(10,2),
    Branch_Id INT,
    FOREIGN KEY (Branch_Id) REFERENCES Branches(Branch_Id)
);


CREATE TABLE Customer (
    Cus_Id INT PRIMARY KEY,
    CName VARCHAR(50) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100)
);


CREATE TABLE Rooms (
    R_No INT PRIMARY KEY,
    RType VARCHAR(50),
    Rate DECIMAL(10,2),
    Branch_Id INT,
    FOREIGN KEY (Branch_Id) REFERENCES Branches(Branch_Id)
);


CREATE TABLE Booking (
    Book_Id INT PRIMARY KEY,
    Check_in DATE,
    Check_out DATE,
    Cus_Id INT,
    FOREIGN KEY (Cus_Id) REFERENCES Customer(Cus_Id)
);


CREATE TABLE Staff_Booking (
    S_Id INT,
    Book_Id INT,
    PRIMARY KEY (S_Id, Book_Id),
    FOREIGN KEY (S_Id) REFERENCES Staff(S_Id),
    FOREIGN KEY (Book_Id) REFERENCES Booking(Book_Id)
);


CREATE TABLE Booking_Rooms (
    Book_Id INT,
    R_No INT,
    Av_Rooms bit default 0,
    PRIMARY KEY (Book_Id, R_No),
    FOREIGN KEY (Book_Id) REFERENCES Booking(Book_Id),
    FOREIGN KEY (R_No) REFERENCES Rooms(R_No)
);

CREATE TABLE Customer_Rooms (
    Cus_Id INT,
    R_No INT,
    PRIMARY KEY (Cus_Id, R_No),
    FOREIGN KEY (Cus_Id) REFERENCES Customer(Cus_Id),
    FOREIGN KEY (R_No) REFERENCES Rooms(R_No)
);


INSERT INTO Branches (Branch_Id, BName, Location) VALUES
(1, 'Central Hostel', 'Downtown'),
(2, 'Northside Hostel', 'Uptown'),
(3, 'Eastview Hostel', 'East District'),
(4, 'Westend Hostel', 'West District'),
(5, 'Lakeside Hostel', 'Lakeshore');


INSERT INTO Staff (S_Id, SName, J_Title, Salary, Branch_Id) VALUES
(101, 'John Smith', 'Manager', 3000.00, 1),
(102, 'Alice Brown', 'Receptionist', 1800.00, 1),
(103, 'Mark Lee', 'Cleaner', 1200.00, 2),
(104, 'Sophia Davis', 'Manager', 3200.00, 3),
(105, 'James Wilson', 'Receptionist', 2000.00, 4);

INSERT INTO Customer (Cus_Id, CName, Phone, Email) VALUES
(201, 'Emma Johnson', '555-0101', 'emma.johnson@example.com'),
(202, 'Liam Martinez', '555-0102', 'liam.martinez@example.com'),
(203, 'Olivia Garcia', '555-0103', 'olivia.garcia@example.com'),
(204, 'Noah Rodriguez', '555-0104', 'noah.rodriguez@example.com'),
(205, 'Ava Hernandez', '555-0105', 'ava.hernandez@example.com');


INSERT INTO Rooms (R_No, RType, Rate, Branch_Id) VALUES
(301, 'Single', 50.00, 1),
(302, 'Double', 80.00, 1),
(303, 'Suite', 120.00, 2),
(304, 'Single', 55.00, 3),
(305, 'Double', 85.00, 4);

INSERT INTO Booking (Book_Id, Check_in, Check_out, Cus_Id) VALUES
(401, '2025-12-20', '2025-12-25', 201),
(402, '2025-12-21', '2025-12-23', 202),
(403, '2025-12-22', '2025-12-28', 203),
(404, '2025-12-24', '2025-12-26', 204),
(405, '2025-12-25', '2025-12-30', 205);


INSERT INTO Staff_Booking (S_Id, Book_Id) VALUES
(101, 401),
(102, 402),
(103, 403),
(104, 404),
(105, 405);


INSERT INTO Booking_Rooms (Book_Id, R_No, Av_Rooms) VALUES
(401, 301, 1),
(402, 302, 1),
(403, 303, 1),
(404, 304, 1),
(405, 305, 1);


INSERT INTO Customer_Rooms (Cus_Id, R_No) VALUES
(201, 301),
(202, 302),
(203, 303),
(204, 304),
(205, 305);

--DQL 
--Display all guest records. 
select * from Customer

--Display each guest’s name, contact number, and proof ID type.
select Cus_Id,CName,Phone from Customer

--Display all bookings with booking date, status, and total cost. 
select * from Booking

--Display each room number and its price per night as NightlyRate. 
select R_No, Rate as NightlyRate from Rooms

--List rooms priced above 1000 per night. 
select Rate from Rooms where (Rate>1000)

--Display staff members working as 'Receptionist'.
SELECT SName, J_Title, Salary
FROM Staff
WHERE J_Title = 'Receptionist';

--Display bookings made in 2024. 
SELECT *
FROM Booking
WHERE YEAR(Check_in) = 2024;

--Display bookings ordered by total cost descending.

--Display the maximum, minimum, and average room price. 
SELECT MAX(Rate) AS MaxPrice, MIN(Rate) AS MinPrice, AVG(Rate) AS AvgPrice
FROM Rooms;

--Display total number of rooms. 
SELECT COUNT(*) AS TotalRooms
FROM Rooms;

--Display guests whose names start with 'M'.
SELECT CName
FROM Customer
WHERE CName LIKE 'M%';

--Display rooms priced between 800 and 1500.
SELECT R_No, Rate
FROM Rooms
WHERE Rate BETWEEN 800 AND 1500;
------------------------------------------------------------------------------------------
--DML 
--Insert yourself as a guest (Guest ID = 9011). 
INSERT INTO Customer (Cus_Id, CName, Phone, Email)
VALUES (9011, 'sharouq', '555-9999', 'sharouq.email@example.com');

--Create a booking for room 205. 

--Insert another guest with NULL contact and proof details. 
INSERT INTO Customer (Cus_Id, CName, Phone, Email)
VALUES (9022, 'Anonymous Guest', NULL, NULL);

--Update your booking status to 'Confirmed'. 

--Increase room prices by 10% for luxury rooms. 
UPDATE Rooms
SET Rate = Rate * 1.10
WHERE RType = 'Suite';
--Update booking status to 'Completed' where checkout date is before today. 

--Delete bookings with status 'Cancelled'. 
DELETE FROM Booking
WHERE Status = 'Cancelled';

-----------------------------------------------------------------
--Join
--Display hotel ID, name, and the name of its manager.
SELECT b.Branch_Id, b.BName, s.SName AS Manager_Name
FROM Branches b
JOIN Staff s ON b.Branch_Id = s.Branch_Id
WHERE s.J_Title = 'Manager';

--Display hotel names and the rooms available under them.
SELECT b.BName, r.R_No, r.RType, r.Rate
FROM Branches b
JOIN Rooms r ON b.Branch_Id = r.Branch_Id;

--Display guest data along with the bookings they made.
SELECT c.Cus_Id, c.CName, c.Phone, c.Email,
       bk.Book_Id, bk.Check_in, bk.Check_out
FROM Customer c
LEFT JOIN Booking bk ON c.Cus_Id = bk.Cus_Id;

--Display bookings for hotels in 'Hurghada' or 'Sharm El Sheikh'.
SELECT bk.Book_Id, b.BName, b.Location, bk.Check_in, bk.Check_out
FROM Booking bk
JOIN Booking_Rooms br ON bk.Book_Id = br.Book_Id
JOIN Rooms r ON br.R_No = r.R_No
JOIN Branches b ON r.Branch_Id = b.Branch_Id
WHERE b.Location IN ('Hurghada', 'Sharm El Sheikh');
select * from Branches

--Display all room records where room type starts with "S" (e.g., "Suite", "Single").
SELECT *
FROM Rooms
WHERE RType LIKE 'S%';

--List guests who booked rooms priced between 1500 and 2500 LE.
SELECT DISTINCT c.CName
FROM Customer c
JOIN Booking bk ON c.Cus_Id = bk.Cus_Id
JOIN Booking_Rooms br ON bk.Book_Id = br.Book_Id
JOIN Rooms r ON br.R_No = r.R_No
WHERE r.Rate BETWEEN 50 AND 100;
--Retrieve guest names who have bookings marked as 'Confirmed' in hotel "Hilton Downtown".
SELECT DISTINCT c.CName
FROM Customer c
JOIN Booking bk ON c.Cus_Id = bk.Cus_Id
JOIN Booking_Rooms br ON bk.Book_Id = br.Book_Id
JOIN Rooms r ON br.R_No = r.R_No
JOIN Branches b ON r.Branch_Id = b.Branch_Id

--Find guests whose bookings were handled by staff member "Mona Ali".
SELECT DISTINCT c.CName
FROM Customer c
JOIN Booking bk ON c.Cus_Id = bk.Cus_Id
JOIN Staff_Booking sb ON bk.Book_Id = sb.Book_Id
JOIN Staff s ON sb.S_Id = s.S_Id
WHERE s.SName = 'Mona Ali';
--Display each guest’s name and the rooms they booked, ordered by room type.
SELECT c.CName, r.R_No, r.RType
FROM Customer c
JOIN Booking bk ON c.Cus_Id = bk.Cus_Id
JOIN Booking_Rooms br ON bk.Book_Id = br.Book_Id
JOIN Rooms r ON br.R_No = r.R_No
ORDER BY r.RType;
--For each hotel in 'Cairo', display hotel ID, name, manager name, and contact info.
SELECT b.Branch_Id, b.BName,
       s.SName AS Manager_Name
FROM Branches b
JOIN Staff s ON b.Branch_Id = s.Branch_Id
WHERE b.Location = 'Cairo'
  AND s.J_Title = 'Manager';
--Display all staff members who hold 'Manager' positions.
SELECT *
FROM Staff
WHERE J_Title = 'Manager';

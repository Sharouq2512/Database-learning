create database Airline
Use Airline


CREATE TABLE Airport (
    Airport_Code varchar(10) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    City VARCHAR(50),
    A_State VARCHAR(50)
);

CREATE TABLE Airplane_Type (
    TypeId INT PRIMARY KEY,
    Company VARCHAR(50),
    TypeName VARCHAR(50),
    Max_Seats INT,
    Airport_Code varchar(10),
    FOREIGN KEY (Airport_Code) REFERENCES Airport(Airport_Code)
);

CREATE TABLE Airplane (
    Airplane_Id INT PRIMARY KEY,
    Total_No_Seats INT NOT NULL,
    TypeId INT,
    FOREIGN KEY (TypeId) REFERENCES Airplane_Type(TypeId)
);

CREATE TABLE Flight_Fears (
    Flight_Id INT PRIMARY KEY,
    Airline VARCHAR(50),
    Weekdays VARCHAR(20),
    Restrictions VARCHAR(100)
);

CREATE TABLE Flight_Leg (
    Leg_No INT primary key,
    Flight_Id INT,
    Scheduled_Dep_Time dateTIME,
    Scheduled_Arr_Time dateTIME,
    Airport_Code varchar(10),
    FOREIGN KEY (Flight_Id) REFERENCES Flight_Fears(Flight_Id),
    FOREIGN KEY (Airport_Code) REFERENCES Airport(Airport_Code)
);

CREATE TABLE Leg_Instance (
    Leg_Id INT PRIMARY KEY,
    Leg_No INT,
    LDate DATE,
    No_Of_Av_Seat INT,
    Departure_Time TIME,
    Arrival_Time TIME,
    Airplane_Id INT,
    FOREIGN KEY (Airplane_Id) REFERENCES Airplane(Airplane_Id),
    FOREIGN KEY (Leg_No) REFERENCES Flight_Leg(Leg_No)
);

CREATE TABLE Reservation (
    Cus_Id INT primary key,
    CusName VARCHAR(50),
    Phone int,
    Leg_Id INT,
    Seat_No INT,
    FOREIGN KEY (Leg_Id) REFERENCES Leg_Instance(Leg_Id)
);

CREATE TABLE Fares (
    Flight_Id INT ,
    Code VARCHAR(10),
    Amount DECIMAL(10,2),
	FOREIGN KEY (Flight_Id) REFERENCES Flight_Fears(Flight_Id),
	primary key (Flight_Id)
);


INSERT INTO Airport VALUES
('CAI', 'Cairo International Airport', 'Cairo', 'Cairo'),
('DXB', 'Dubai International Airport', 'Dubai', 'Dubai'),
('MCT', 'Muscat International Airport', 'Muscat', 'Muscat'),
('JED', 'King Abdulaziz Airport', 'Jeddah', 'Makkah'),
('LHR', 'Heathrow Airport', 'London', 'England');

INSERT INTO Airplane_Type VALUES
(1, 'Boeing', 'Boeing 737', 180, 'CAI'),
(2, 'Airbus', 'A320', 160, 'DXB'),
(3, 'Boeing', 'Boeing 777', 350, 'MCT'),
(4, 'Airbus', 'A350', 320, 'JED'),
(5, 'Boeing', 'Boeing 747', 420, 'LHR');

INSERT INTO Airplane VALUES
(101, 180, 1),
(102, 160, 2),
(103, 350, 3),
(104, 320, 4),
(105, 420, 5);


INSERT INTO Flight_Fears VALUES
(1001, 'EgyptAir', 'Daily', 'None'),
(1002, 'Emirates', 'Daily', 'No refund'),
(1003, 'Oman Air', 'Mon,Wed', 'Refundable'),
(1004, 'Saudi Airlines', 'Fri,Sun', 'No changes'),
(1005, 'British Airways', 'Tue,Thu', 'Fee applies');

INSERT INTO Flight_Leg VALUES
(1, 1001, '2025-06-10 08:00', '2025-06-10 12:00', 'CAI'),
(2, 1002, '2025-06-11 09:00', '2025-06-11 13:00', 'DXB'),
(3, 1003, '2025-06-12 10:00', '2025-06-12 14:00', 'MCT'),
(4, 1004, '2025-06-13 11:00', '2025-06-13 15:00', 'JED'),
(5, 1005, '2025-06-14 12:00', '2025-06-14 18:00', 'LHR');


INSERT INTO Leg_Instance VALUES
(1, 1, '2025-06-10', 150, '08:00', '12:00', 101),
(2, 2, '2025-06-11', 90,  '09:00', '13:00', 102),
(3, 3, '2025-06-12', 120, '10:00', '14:00', 103),
(4, 4, '2025-06-13', 80,  '11:00', '15:00', 104),
(5, 5, '2025-06-14', 0,   '12:00', '18:00', 105);

INSERT INTO Reservation VALUES
(1, 'Ahmed Ali', '010123456', 1, 10),
(2, 'Sara Mohamed', '010876543', 2, 15),
(3, 'Omar Hassan', '011234567', 3, 20),
(4, 'Laila Noor', NULL, 4, 18),
(5, 'John Smith', '0044791122', 5, 22);

INSERT INTO Fares VALUES
(1001, 'ECO', 120.00),
(1005, 'BUS', 300.00),
(1002, 'ECO', 150.00),
(1003, 'ECO', 180.00),
(1004, 'BUS', 350.00);

--Display all flight leg records. 
select * from Flight_Leg

--Display each flight leg ID, scheduled departure time, and arrival time. 
select Flight_Id,Scheduled_Dep_Time,Scheduled_Arr_Time from Flight_Leg

--Display each airplane’s ID, type, and seat capacity.
select Airplane_Id, Total_No_Seats,TypeId from Airplane

--Display each flight leg’s ID and available seats as AvailableSeats. 
select Leg_Id , No_Of_Av_Seat from Leg_Instance

--List flight leg IDs with available seats greater than 100. 
select Leg_Id , No_Of_Av_Seat from Leg_Instance 
where (No_Of_Av_Seat> 100)

--List airplane IDs with seat capacity above 300. 
select Airplane_Id, Total_No_Seats from Airplane
where (Total_No_Seats> 300)

--Display airport codes and names where city = 'Cairo'. 
select Airport_Code ,Name from Airport where (city = 'Cairo')

--Display flight legs scheduled on 2025-06-10. 
select * from Flight_Leg where cast(Scheduled_Dep_Time as date)='2025-06-10'

--Display flight legs ordered by departure time. 
select * from Flight_Leg
order by Scheduled_Dep_Time

--Display the maximum, minimum, and average available seats. 
select max(No_Of_Av_Seat) as maximam ,min(No_Of_Av_Seat) as mininum, avg(No_Of_Av_Seat) as average from Leg_Instance

--Display total number of flight legs. 
select count(*) as Total from Flight_Leg

--Display airplanes whose type contains 'Boeing'.
SELECT A.Airplane_Id
FROM Airplane A
JOIN Airplane_Type AT ON A.TypeId = AT.TypeId
WHERE AT.TypeName LIKE '%Boeing%';
------------------------------------------------------------------------
--DML 


--Reduce available seats of your inserted flight leg by 5.
UPDATE Leg_Instance
SET No_Of_Av_Seat = No_Of_Av_Seat - 5
WHERE Leg_Id = 1;



--Update airplane seat capacity by +20 where capacity < 150. 
UPDATE Leg_Instance
SET No_Of_Av_Seat = No_Of_Av_Seat +20
WHERE No_Of_Av_Seat >150;

------------------------------------------------------------------------------
--join

--Display each flight leg's ID, schedule, and the name of the airplane assigned to it.
select Flight_Id ,Scheduled_Dep_Time ,Scheduled_Arr_Time , TypeName
from Flight_Leg F, Airplane_Type A
where F.Airport_Code= A.Airport_Code

--Display all flight numbers and the names of the departure and arrival airports.
select Flight_Id ,City
from Airport A,Flight_Leg F
where A.Airport_Code= F.Airport_Code

--Display all reservation data with the name and phone of the customer who made each booking.
select R.* , LDate, Departure_Time , Arrival_Time
from Reservation R , Leg_Instance L
where R.Leg_Id = L.Leg_Id

--Display IDs and locations of flights departing from 'CAI' or 'DXB'.
select Flight_Id , Airport_Code
from Flight_Leg
where Airport_Code like 'CAI' or Airport_Code like 'DXB'

--Display full data of flights whose names start with 'E'.
select * from Flight_Fears where Airline like 'E%'

--List customers who have bookings with total payment between 3000 and 5000.
select Cus_Id , CusName, Amount 
from
Reservation R inner join  Leg_Instance L
on R.Leg_Id= L.Leg_Id
inner join Flight_Leg F
on L.Leg_No= F.Leg_No
inner join Fares FA
on F.Flight_Id=FA.Flight_Id
where FA.Amount between 150 and 350

--Retrieve all passengers on 'Flight 110' who booked more than 2 seats.
select R.*
from Airplane A inner join Leg_Instance L
on A.Airplane_Id =L.Airplane_Id
inner join Reservation R
on L.Leg_Id =R. Leg_Id
where Seat_No >=20

--Display each passenger’s name and the flights they booked, ordered by flight date.
select CusName , TypeName , LDate
from Reservation R inner join Leg_Instance L
on R.Leg_Id=L.Leg_Id
inner join Airplane A
on L.Airplane_Id= A.Airplane_Id
inner join Airplane_Type T
on A.TypeId = T.TypeId
order by LDate

--For each flight departing from 'Cairo', display the flight number, departure time, and airline name.
select F.Flight_Id, Scheduled_Dep_Time, Airline
from Flight_Leg F,Flight_Fears
where Airport_Code like 'MCT'



select * from Airport
select * from Fares
select * from Flight_Leg
select * from Flight_Fears

select * from Reservation
select * from Airplane_Type
select * from Airplane
select * from Leg_Instance
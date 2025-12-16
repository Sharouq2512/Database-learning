create database Bank
use Bank

CREATE TABLE Branch (
    B_Id INT PRIMARY KEY,
    BAddress VARCHAR(100),
    PhoneNo VARCHAR(20)
);


CREATE TABLE Employee (
    E_Id INT PRIMARY KEY,
    EName VARCHAR(100),
    Position VARCHAR(50),
    B_Id INT,
    FOREIGN KEY (B_Id) REFERENCES Branch(B_Id)
);


CREATE TABLE Customer (
    C_Id INT PRIMARY KEY,
    CName VARCHAR(50) not null,
    CAddress VARCHAR(100),
    PhoneNo int,
    DOB DATE
);


CREATE TABLE Loans (
    L_Id INT PRIMARY KEY,
    LType VARCHAR(50),
    Issue_D DATE,
    Amount DECIMAL(15,2),
    E_Id INT,
    C_Id INT,
    FOREIGN KEY (E_Id) REFERENCES Employee(E_Id),
    FOREIGN KEY (C_Id) REFERENCES Customer(C_Id)
);


CREATE TABLE Account (
    A_No INT PRIMARY KEY,
    Balance DECIMAL(15,2),
    Saving DECIMAL(15,2),
    Checking DECIMAL(15,2),
    D_Creation DATE,
    C_Id INT,
    FOREIGN KEY (C_Id) REFERENCES Customer(C_Id)
);


CREATE TABLE Transactions (
    T_Id INT PRIMARY KEY,
    Amount DECIMAL(15,2),
    TDate DATE,
    Deposit DECIMAL(10,2),
    Withdrawals DECIMAL(10,2),
    Transfers DECIMAL(10,2),
    A_No INT,
    FOREIGN KEY (A_No) REFERENCES Account(A_No)
);


INSERT INTO Branch (B_Id, BAddress, PhoneNo) VALUES
(1, '123 Main St, Muscat', '96812345678'),
(2, '456 Al Khuwair St, Muscat', '96887654321'),
(3, '789 Seeb St, Muscat', '96811223344'),
(4, '321 Ruwi St, Muscat', '96844332211'),
(5, '654 Qurum St, Muscat', '96855667788');


INSERT INTO Employee (E_Id, EName, Position, B_Id) VALUES
(101, 'Ahmed Al-Busaidi', 'Manager', 1),
(102, 'Fatma Al-Harthy', 'Cashier', 2),
(103, 'Salim Al-Maskari', 'Loan Officer', 3),
(104, 'Layla Al-Rawahi', 'Receptionist', 4),
(105, 'Hassan Al-Farsi', 'Teller', 5);


INSERT INTO Customer (C_Id, CName, CAddress, PhoneNo, DOB) VALUES
(201, 'Mohammed Al-Salmi', '12 Seeb St, Muscat', 11112222, '1985-03-15'),
(202, 'Aisha Al-Hinai', '34 Ruwi St, Muscat', 22223333, '1990-07-22'),
(203, 'Omar Al-Khalili', '56 Qurum St, Muscat', 33334444, '1982-11-05'),
(204, 'Sara Al-Mahrouqi', '78 Muttrah St, Muscat', 44445555, '1995-02-28'),
(205, 'Hamed Al-Lawati', '90 Al Khuwair St, Muscat', 55556666, '1988-09-12');


INSERT INTO Loans (L_Id, LType, Issue_D, Amount, E_Id, C_Id) VALUES
(301, 'Home Loan', '2024-01-10', 50000.00, 103, 201),
(302, 'Car Loan', '2024-02-15', 15000.00, 103, 202),
(303, 'Personal Loan', '2024-03-20', 10000.00, 103, 203),
(304, 'Education Loan', '2024-04-25', 20000.00, 103, 204),
(305, 'Business Loan', '2024-05-30', 75000.00, 103, 205);


INSERT INTO Account (A_No, Balance, Saving, Checking, D_Creation, C_Id) VALUES
(401, 12000.00, 5000.00, 7000.00, '2023-01-05', 201),
(402, 8000.00, 3000.00, 5000.00, '2023-02-10', 202),
(403, 15000.00, 10000.00, 5000.00, '2023-03-15', 203),
(404, 2000.00, 2000.00, 0.00, '2023-04-20', 204),
(405, 50000.00, 25000.00, 25000.00, '2023-05-25', 205);


INSERT INTO Transactions (T_Id, Amount, TDate, Deposit, Withdrawals, Transfers, A_No) VALUES
(501, 1000.00, '2024-01-10', 1000.00, 0.00, 0.00, 401),
(502, 500.00, '2024-02-12', 0.00, 500.00, 0.00, 402),
(503, 2000.00, '2024-03-18', 2000.00, 0.00, 0.00, 403),
(504, 300.00, '2024-04-22', 0.00, 0.00, 300.00, 404),
(505, 1500.00, '2024-05-28', 1500.00, 0.00, 0.00, 405);

--DQL 
--Display all customer records. 
SELECT * FROM Customer;

--Display customer full name, phone, and membership start date.
SELECT C.CName, C.PhoneNo, A.D_Creation AS MembershipStartDate
FROM Customer C
JOIN Account A ON C.C_Id = A.C_Id;

--Display each loan ID, amount, and type. 
SELECT L_Id, Amount, LType
FROM Loans;

--Display account number and annual interest (5% of balance) as AnnualInterest. 
SELECT A_No, Balance * 0.05 AS AnnualInterest
FROM Account;

--List customers with loan amounts greater than 100000 LE. 

--List accounts with balances above 20000. 
SELECT A_No, Balance
FROM Account
WHERE Balance > 20000;

--Display accounts opened in 2023. 
SELECT *
FROM Account
WHERE YEAR(D_Creation) = 2023;

--Display accounts ordered by balance descending. 
SELECT *
FROM Account
ORDER BY Balance DESC;

--Display the maximum, minimum, and average account balance. 
SELECT MAX(Balance) AS MaxBalance, MIN(Balance) AS MinBalance, AVG(Balance) AS AvgBalance
FROM Account;

--Display total number of customers.
SELECT COUNT(*) AS TotalCustomers
FROM Customer;

--Display customers with NULL phone numbers. 
SELECT *
FROM Customer
WHERE PhoneNo IS NULL;

--Display loans with duration greater than 10 years. 

--------------------------------------------------------------------------------
--DML 
--Insert yourself as a new customer and open an account with balance 10000. 
INSERT INTO Customer (C_Id, CName, CAddress, PhoneNo, DOB)
VALUES (206, 'shaarouq', 'albadi', 12345678, '1990-01-01');

INSERT INTO Account (A_No, Balance, Saving, Checking, D_Creation, C_Id)
VALUES (406, 10000.00, 5000.00, 5000.00, GETDATE(), 206);

--Insert another customer with NULL phone and address. 
INSERT INTO Customer (C_Id, CName, CAddress, PhoneNo, DOB)
VALUES (207, 'Test Customer', NULL, NULL, '1995-05-05');

--Increase your account balance by 20%. 
UPDATE Account
SET Balance = Balance * 1.2
WHERE A_No = 406;

--Increase balance by 5% for accounts with balance less than 5000. 
UPDATE Account
SET Balance = Balance * 1.05
WHERE Balance < 5000;

--Update phone number to 'Not Provided' where phone is NULL.
UPDATE Customer
SET PhoneNo = 0
WHERE PhoneNo IS NULL;

--Delete closed accounts. 
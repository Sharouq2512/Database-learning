create database BankingSys

CREATE TABLE Customer ( 
CustomerID INT PRIMARY KEY, 
FullName NVARCHAR(100), 
Email NVARCHAR(100), 
Phone NVARCHAR(15), 
SSN CHAR(9) 
); 


CREATE TABLE Account ( 
    AccountID INT PRIMARY KEY, 
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID), 
    Balance DECIMAL(10, 2), 
    AccountType VARCHAR(50), 
    Status VARCHAR(20) 
); 
 

CREATE TABLE CTransaction ( 
    TransactionID INT PRIMARY KEY, 
    AccountID INT FOREIGN KEY REFERENCES Account(AccountID), 
    Amount DECIMAL(10, 2), 
    Type VARCHAR(10), -- Deposit, Withdraw 
    TransactionDate DATETIME 
); 
 

CREATE TABLE Loan ( 
    LoanID INT PRIMARY KEY, 
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID), 
    LoanAmount DECIMAL(12, 2), 
    LoanType VARCHAR(50), 
    Status VARCHAR(20) 
); 

INSERT INTO Customer (CustomerID, FullName, Email, Phone, SSN)
VALUES
(1, 'Mohammed Ahmed', 'mohammed@mail.com', '98346729', '123'),
(2, 'Fatima Ali',     'fatima@mail.com',   '93728763', '223'),
(3, 'Khaled Hussein', 'khaled@mail.com',   '93887745', '323'),
(4, 'Sara Youssef',   'sara@mail.com',     '92654889', '423'),
(5, 'Abdullah Salem', 'abdullah@mail.com', '78936456', '523');


INSERT INTO Account (AccountID, CustomerID, Balance, AccountType, Status)
VALUES
(101, 1, 1500.00,  'Saving',  'Active'),
(102, 2, 2500.50,  'Current', 'Active'),
(103, 3, 500.75,   'Saving',  'Inactive'),
(104, 4, 7800.00,  'Current', 'Active'),
(105, 5, 12000.00, 'Saving',  'Active');


INSERT INTO CTransaction (TransactionID, AccountID, Amount, Type, TransactionDate)
VALUES
(1001, 101, 200.00,  'Deposit',  GETDATE()),
(1002, 102, 500.00,  'Withdraw', DATEADD(DAY, -5, GETDATE())),
(1003, 103, 150.00,  'Deposit',  DATEADD(DAY, -10, GETDATE())),
(1004, 104, 1000.00, 'Withdraw', DATEADD(DAY, -20, GETDATE())),
(1005, 105, 300.00,  'Deposit',  DATEADD(DAY, -2, GETDATE()));


INSERT INTO Loan (LoanID, CustomerID, LoanAmount, LoanType, Status)
VALUES
(201, 1, 50000.00, 'Home Loan',      'Approved'),
(202, 2, 20000.00, 'Car Loan',       'Pending'),
(203, 3, 15000.00, 'Personal Loan',  'Approved'),
(204, 4, 80000.00, 'Home Loan',      'Rejected'),
(205, 5, 10000.00, 'Education Loan', 'Approved');


--View 
--1. Customer Service View 
--• Show only customer name, phone, and account status (hide sensitive info like SSN or balance). 

create view CusService 
as
select C.FullName, C.Phone,A.Status
from Customer C, Account A
where C.CustomerID = A.CustomerID

--2. Finance Department View 
--• Show account ID, balance, and account type.
create view FinanceDepartment 
as
select AccountID, Balance, AccountType
from Account

--3. Loan Officer View 
--• Show loan details but hide full customer information. Only include CustomerID.
create view LoanOfficer 
as
select * from Loan

--4. Transaction Summary View 
--• Show only recent transactions (last 30 days) with account ID and amount. 
CREATE VIEW vw_RecentTransactions
AS
SELECT AccountID, Amount, Type, TransactionDate
FROM CTransaction
WHERE TransactionDate >= DATEADD(DAY, -30, GETDATE());
CREATE DATABASE Banking_Enterprise3;
USE Banking_Enterprise3;
-- Create Dimension Tables
CREATE TABLE Customer_Dim (
 Customer_ID INT PRIMARY KEY,
 Name VARCHAR(100),
 Address VARCHAR(255),
 Segment VARCHAR(50)
);
CREATE TABLE Account_Dim (
 Account_ID INT PRIMARY KEY,
 Account_Type VARCHAR(50),
 Opening_Date DATE,
 Status VARCHAR(20)
);
CREATE TABLE Branch_Dim (
 Branch_ID INT PRIMARY KEY,
 Branch_Name VARCHAR(100),
 Location VARCHAR(100),
 Manager VARCHAR(100)
);
CREATE TABLE Time_Dim (
 Date_ID INT PRIMARY KEY,
 Date DATE,
Day INT,
 Month INT,
 Quarter INT,
 Year INT
);
-- Create Fact Table
CREATE TABLE Transaction_Fact (
 Transaction_ID INT PRIMARY KEY,
 Account_ID INT,
 Customer_ID INT,
 Branch_ID INT, Transaction_Amount DECIMAL(15, 2),
 Transaction_Date INT,
 FOREIGN KEY (Account_ID) REFERENCES Account_Dim(Account_ID),
 FOREIGN KEY (Customer_ID) REFERENCES Customer_Dim(Customer_ID),
 FOREIGN KEY (Branch_ID) REFERENCES Branch_Dim(Branch_ID),
 FOREIGN KEY (Transaction_Date) REFERENCES Time_Dim(Date_ID)
);
-- Create Loan_Fact Table
CREATE TABLE Loan_Fact (
 Loan_ID INT PRIMARY KEY,
 Customer_ID INT,
 Branch_ID INT,
 Loan_Amount DECIMAL(15, 2),
 Loan_Date INT,
 FOREIGN KEY (Customer_ID) REFERENCES Customer_Dim(Customer_ID),
 FOREIGN KEY (Branch_ID) REFERENCES Branch_Dim(Branch_ID),
 FOREIGN KEY (Loan_Date) REFERENCES Time_Dim(Date_ID)
);

-- Insert data into Customer_Dim
INSERT INTO Customer_Dim (Customer_ID, Name, Address, Segment) VALUES
(1, 'Rajesh Sharma', 'Mumbai, Maharashtra', 'Retail'),
(2, 'Priya Kapoor', 'Delhi, Delhi', 'Corporate'),
(3, 'Anil Kumar', 'Bangalore, Karnataka', 'Retail'),
(4, 'Sneha Mehta', 'Ahmedabad, Gujarat', 'Retail'),
(5, 'Amit Patel', 'Chennai, Tamil Nadu', 'SME');

-- Insert data into Account_Dim
INSERT INTO Account_Dim (Account_ID, Account_Type, Opening_Date, Status) VALUES
(101, 'Savings', '2020-02-10', 'Active'),
(102, 'Current', '2019-06-15', 'Active'),
(103, 'Savings', '2021-01-20', 'Inactive'),
(104, 'Current', '2022-05-01', 'Active');

-- Insert data into Branch_Dim
INSERT INTO Branch_Dim (Branch_ID, Branch_Name, Location, Manager) VALUES
(1, 'Mumbai Main Branch', 'Mumbai, Maharashtra', 'Suresh Deshmukh'),
(2, 'Delhi Main Branch', 'Delhi, Delhi', 'Anita Agarwal'),
(3, 'Bangalore Branch', 'Bangalore, Karnataka', 'Ravi Kumar'),
(4, 'Chennai Branch', 'Chennai, Tamil Nadu', 'Meena Iyer');

-- Insert data into Time_Dim
INSERT INTO Time_Dim (Date_ID, Date, Day, Month, Quarter, Year) VALUES
(1, '2023-01-10', 10, 1, 1, 2023),
(2, '2023-02-15', 15, 2, 1, 2023),
(3, '2023-03-12', 12, 3, 1, 2023),
(4, '2023-04-20', 20, 4, 2, 2023);

-- Insert data into Transaction_Fact
INSERT INTO Transaction_Fact (Transaction_ID, Account_ID, Customer_ID, Branch_ID, Transaction_Amount, Transaction_Date) VALUES
(1001, 101, 1, 1, 5000.00, 1),
(1002, 102, 2, 2, 15000.00, 2),
(1003, 103, 3, 3, 2000.00, 3),
(1004, 104, 4, 4, 100000.00, 4);

-- Insert data into Loan_Fact
INSERT INTO Loan_Fact (Loan_ID, Customer_ID, Branch_ID, Loan_Amount, Loan_Date) VALUES
(2001, 1, 1, 250000.00, 1),
(2002, 2, 2, 500000.00, 2),
(2003, 3, 3, 150000.00, 3),
(2004, 4, 4, 300000.00, 4);

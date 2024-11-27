-- Create the normalized tables for Snowflake Schema

CREATE DATABASE Banking_Enterprise2_Snowflake;
USE Banking_Enterprise2_Snowflake;

-- Create Customer_Segment Table (already normalized)
CREATE TABLE Customer_Segment (
    Segment_ID INT PRIMARY KEY,
    Segment_Name VARCHAR(50)
);

-- Create Customer Table (linked to Customer_Segment)
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    Segment_ID INT,
    FOREIGN KEY (Segment_ID) REFERENCES Customer_Segment(Segment_ID)
);

-- Create Account_Type Table (normalized from Account_Dim)
CREATE TABLE Account_Type (
    Account_Type_ID INT PRIMARY KEY,
    Account_Type_Name VARCHAR(50)
);

-- Create Account Table (linked to Account_Type)
CREATE TABLE Account (
    Account_ID INT PRIMARY KEY,
    Account_Type_ID INT,
    Opening_Date DATE,
    Status VARCHAR(20),
    FOREIGN KEY (Account_Type_ID) REFERENCES Account_Type(Account_Type_ID)
);

-- Create Branch_Location Table (normalized from Branch_Dim)
CREATE TABLE Branch_Location (
    Location_ID INT PRIMARY KEY,
    Location_Name VARCHAR(100)
);

-- Create Branch Table (linked to Branch_Location)
CREATE TABLE Branch (
    Branch_ID INT PRIMARY KEY,
    Branch_Name VARCHAR(100),
    Location_ID INT,
    Manager VARCHAR(100),
    FOREIGN KEY (Location_ID) REFERENCES Branch_Location(Location_ID)
);

-- Time_Dim Table (already normalized)
CREATE TABLE Time_Dim (
    Date_ID INT PRIMARY KEY,
    Date DATE,
    Day INT,
    Month INT,
    Quarter INT,
    Year INT
);

-- Create Fact Table (Transaction_Fact) that references all the dimension tables
CREATE TABLE Transaction_Fact (
    Transaction_ID INT PRIMARY KEY,
    Account_ID INT,
    Customer_ID INT,
    Branch_ID INT,
    Transaction_Amount DECIMAL(15, 2),
    Transaction_Date INT,
    FOREIGN KEY (Account_ID) REFERENCES Account(Account_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID),
    FOREIGN KEY (Transaction_Date) REFERENCES Time_Dim(Date_ID)
);

-- Insert data into Customer_Segment
INSERT INTO Customer_Segment (Segment_ID, Segment_Name) VALUES
(1, 'Retail'),
(2, 'Corporate'),
(3, 'SME'),
(4, 'Private Banking'),
(5, 'Wealth Management');

-- Insert data into Customer
INSERT INTO Customer (Customer_ID, Name, Address, Segment_ID) VALUES
(1, 'Rajesh Sharma', 'Mumbai, Maharashtra', 1),
(2, 'Priya Kapoor', 'Delhi, Delhi', 2),
(3, 'Anil Kumar', 'Bangalore, Karnataka', 1),
(4, 'Sneha Mehta', 'Ahmedabad, Gujarat', 1),
(5, 'Amit Patel', 'Chennai, Tamil Nadu', 3),
(6, 'Neha Verma', 'Pune, Maharashtra', 2),
(7, 'Vijay Singh', 'Jaipur, Rajasthan', 1),
(8, 'Rahul Roy', 'Hyderabad, Telangana', 3),
(9, 'Sanjay Gupta', 'Kolkata, West Bengal', 2),
(10, 'Deepak Agarwal', 'Chandigarh, Chandigarh', 1);

-- Insert data into Account_Type
INSERT INTO Account_Type (Account_Type_ID, Account_Type_Name) VALUES
(1, 'Savings'),
(2, 'Current'),
(3, 'Fixed Deposit'),
(4, 'Recurring Deposit'),
(5, 'Demat');

-- Insert data into Account
INSERT INTO Account (Account_ID, Account_Type_ID, Opening_Date, Status) VALUES
(101, 1, '2020-02-10', 'Active'),
(102, 2, '2019-06-15', 'Active'),
(103, 1, '2021-01-20', 'Inactive'),
(104, 2, '2022-05-01', 'Active'),
(105, 3, '2020-12-25', 'Active'),
(106, 1, '2021-08-17', 'Inactive'),
(107, 1, '2023-04-10', 'Active'),
(108, 2, '2018-11-05', 'Active'),
(109, 3, '2021-10-23', 'Active'),
(110, 1, '2020-09-18', 'Inactive');

-- Insert data into Branch_Location
INSERT INTO Branch_Location (Location_ID, Location_Name) VALUES
(1, 'Mumbai, Maharashtra'),
(2, 'Delhi, Delhi'),
(3, 'Bangalore, Karnataka'),
(4, 'Chennai, Tamil Nadu'),
(5, 'Hyderabad, Telangana'),
(6, 'Kolkata, West Bengal'),
(7, 'Pune, Maharashtra'),
(8, 'Ahmedabad, Gujarat'),
(9, 'Jaipur, Rajasthan'),
(10, 'Chandigarh, Chandigarh');

-- Insert data into Branch
INSERT INTO Branch (Branch_ID, Branch_Name, Location_ID, Manager) VALUES
(1, 'Mumbai Main Branch', 1, 'Suresh Deshmukh'),
(2, 'Delhi Main Branch', 2, 'Anita Agarwal'),
(3, 'Bangalore Branch', 3, 'Ravi Kumar'),
(4, 'Chennai Branch', 4, 'Meena Iyer'),
(5, 'Hyderabad Branch', 5, 'Kiran Reddy'),
(6, 'Kolkata Branch', 6, 'Amit Banerjee'),
(7, 'Pune Branch', 7, 'Nisha Patil'),
(8, 'Ahmedabad Branch', 8, 'Mahesh Bhatt'),
(9, 'Jaipur Branch', 9, 'Manoj Singh'),
(10, 'Chandigarh Branch', 10, 'Rajiv Malhotra');

-- Insert data into Time_Dim
INSERT INTO Time_Dim (Date_ID, Date, Day, Month, Quarter, Year) VALUES
(1, '2023-01-10', 10, 1, 1, 2023),
(2, '2023-02-15', 15, 2, 1, 2023),
(3, '2023-03-12', 12, 3, 1, 2023),
(4, '2023-04-20', 20, 4, 2, 2023),
(5, '2023-05-25', 25, 5, 2, 2023),
(6, '2023-06-30', 30, 6, 2, 2023),
(7, '2023-07-18', 18, 7, 3, 2023),
(8, '2023-08-22', 22, 8, 3, 2023),
(9, '2023-09-05', 5, 9, 3, 2023),
(10, '2023-10-28', 28, 10, 4, 2023);

-- Insert data into Transaction_Fact
INSERT INTO Transaction_Fact (Transaction_ID, Account_ID, Customer_ID, Branch_ID, Transaction_Amount, Transaction_Date) VALUES
(1001, 101, 1, 1, 5000.00, 1),
(1002, 102, 2, 2, 15000.00, 2),
(1003, 103, 3, 3, 2000.00, 3),
(1004, 104, 4, 4, 100000.00, 4),
(1005, 105, 5, 5, 75000.00, 5),
(1006, 106, 6, 6, 50000.00, 6),
(1007, 107, 7, 7, 2500.00, 7),
(1008, 108, 8, 8, 4500.00, 8),
(1009, 109, 9, 9, 65000.00, 9),
(1010, 110, 10, 10, 1200.00, 10);

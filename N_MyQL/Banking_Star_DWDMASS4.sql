CREATE DATABASE Banking_Enterprise1;
USE Banking_Enterprise1;
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
 Branch_ID INT,
 Transaction_Amount DECIMAL(15, 2),
 Transaction_Date INT,
 FOREIGN KEY (Account_ID) REFERENCES Account_Dim(Account_ID), FOREIGN KEY
(Customer_ID) REFERENCES Customer_Dim(Customer_ID),
 FOREIGN KEY (Branch_ID) REFERENCES Branch_Dim(Branch_ID),
 FOREIGN KEY (Transaction_Date) REFERENCES Time_Dim(Date_ID)
);
CREATE DATABASE Healthcare_SnowflakeSchema;
USE Healthcare_SnowflakeSchema;

-- Create Patient_Gender Table (Normalization of Patient_Dim)
CREATE TABLE Patient_Gender (
    Gender_ID INT PRIMARY KEY,
    Gender VARCHAR(10)
);

-- Create Patient Table
CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Gender_ID INT,
    Address VARCHAR(255),
    Date_of_Birth DATE,
    FOREIGN KEY (Gender_ID) REFERENCES Patient_Gender(Gender_ID)
);

-- Create Specialization Table (Normalization of Doctor_Dim)
CREATE TABLE Specialization (
    Specialization_ID INT PRIMARY KEY,
    Specialization_Name VARCHAR(100)
);

-- Create Doctor Table
CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Specialization_ID INT,
    Qualification VARCHAR(100),
    Department VARCHAR(100),
    FOREIGN KEY (Specialization_ID) REFERENCES Specialization(Specialization_ID)
);

-- Create Hospital_Location Table (Normalization of Hospital_Dim)
CREATE TABLE Hospital_Location (
    Location_ID INT PRIMARY KEY,
    Location_Name VARCHAR(100)
);

-- Create Hospital Table
CREATE TABLE Hospital (
    Hospital_ID INT PRIMARY KEY,
    Hospital_Name VARCHAR(100),
    Location_ID INT,
    Manager VARCHAR(100),
    FOREIGN KEY (Location_ID) REFERENCES Hospital_Location(Location_ID)
);

-- Create Time_Dim Table (No normalization needed)
CREATE TABLE Time_Dim (
    Time_ID INT PRIMARY KEY,
    Date DATE,
    Day INT,
    Month INT,
    Quarter INT,
    Year INT
);

-- Create Appointment Fact Table
CREATE TABLE Appointment_Fact (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Hospital_ID INT,
    Appointment_Date INT,
    Appointment_Cost DECIMAL(10, 2),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
    FOREIGN KEY (Hospital_ID) REFERENCES Hospital(Hospital_ID),
    FOREIGN KEY (Appointment_Date) REFERENCES Time_Dim(Time_ID)
);

-- Insert data into Patient_Gender
INSERT INTO Patient_Gender (Gender_ID, Gender) VALUES
(1, 'Male'),
(2, 'Female');

-- Insert data into Patient
INSERT INTO Patient (Patient_ID, Name, Gender_ID, Address, Date_of_Birth) VALUES
(1, 'Amit Sharma', 1, 'Mumbai, Maharashtra', '1985-04-12'),
(2, 'Priya Verma', 2, 'Delhi, Delhi', '1990-07-05'),
(3, 'Rahul Gupta', 1, 'Bangalore, Karnataka', '1987-03-20'),
(4, 'Sneha Mehta', 2, 'Ahmedabad, Gujarat', '1995-12-10'),
(5, 'Vikram Patel', 1, 'Chennai, Tamil Nadu', '1983-09-15'),
(6, 'Pooja Nair', 2, 'Pune, Maharashtra', '1992-01-25'),
(7, 'Anil Kumar', 1, 'Hyderabad, Telangana', '1978-06-18'),
(8, 'Ritu Singh', 2, 'Kolkata, West Bengal', '1997-11-30'),
(9, 'Sanjay Chauhan', 1, 'Jaipur, Rajasthan', '1989-08-22'),
(10, 'Neha Jain', 2, 'Chandigarh, Chandigarh', '1993-02-16');

-- Insert data into Specialization
INSERT INTO Specialization (Specialization_ID, Specialization_Name) VALUES
(1, 'Cardiologist'),
(2, 'Dermatologist'),
(3, 'Orthopedic'),
(4, 'Gynecologist'),
(5, 'Neurologist'),
(6, 'Pediatrician'),
(7, 'Oncologist'),
(8, 'ENT Specialist'),
(9, 'Psychiatrist'),
(10, 'Endocrinologist');

-- Insert data into Doctor
INSERT INTO Doctor (Doctor_ID, Name, Specialization_ID, Qualification, Department) VALUES
(1, 'Dr. Rakesh Sinha', 1, 'MBBS, MD', 'Cardiology'),
(2, 'Dr. Meera Nair', 2, 'MBBS, DDVL', 'Dermatology'),
(3, 'Dr. Anil Desai', 3, 'MBBS, MS', 'Orthopedics'),
(4, 'Dr. Neha Kapoor', 4, 'MBBS, MS', 'Gynecology'),
(5, 'Dr. Suresh Kumar', 5, 'MBBS, DM', 'Neurology'),
(6, 'Dr. Priya Sharma', 6, 'MBBS, MD', 'Pediatrics'),
(7, 'Dr. Vijay Singh', 7, 'MBBS, MD', 'Oncology'),
(8, 'Dr. Pooja Gupta', 8, 'MBBS, MS', 'ENT'),
(9, 'Dr. Raghav Pandey', 9, 'MBBS, MD', 'Psychiatry'),
(10, 'Dr. Sangeeta Roy', 10, 'MBBS, DM', 'Endocrinology');

-- Insert data into Hospital_Location
INSERT INTO Hospital_Location (Location_ID, Location_Name) VALUES
(1, 'Mumbai, Maharashtra'),
(2, 'Delhi, Delhi'),
(3, 'Bangalore, Karnataka'),
(4, 'Chennai, Tamil Nadu'),
(5, 'Hyderabad, Telangana'),
(6, 'Pune, Maharashtra'),
(7, 'Ahmedabad, Gujarat'),
(8, 'Jaipur, Rajasthan'),
(9, 'Chandigarh, Chandigarh'),
(10, 'Kolkata, West Bengal');

-- Insert data into Hospital
INSERT INTO Hospital (Hospital_ID, Hospital_Name, Location_ID, Manager) VALUES
(1, 'Apollo Hospital', 1, 'Suresh Mehta'),
(2, 'Max Healthcare', 2, 'Anita Kapoor'),
(3, 'Fortis Hospital', 3, 'Rahul Nair'),
(4, 'Manipal Hospital', 4, 'Vijay Reddy'),
(5, 'Care Hospitals', 5, 'Vikram Desai'),
(6, 'Ruby Hall Clinic', 6, 'Pooja Deshmukh'),
(7, 'Narayana Health', 7, 'Kiran Patel'),
(8, 'Jaipur Golden Hospital', 8, 'Rajesh Chauhan'),
(9, 'PGIMER', 9, 'Neha Malhotra'),
(10, 'Medanta', 10, 'Sanjeev Singh');

-- Insert data into Time_Dim
INSERT INTO Time_Dim (Time_ID, Date, Day, Month, Quarter, Year) VALUES
(1, '2024-01-10', 10, 1, 1, 2024),
(2, '2024-02-15', 15, 2, 1, 2024),
(3, '2024-03-20', 20, 3, 1, 2024),
(4, '2024-04-25', 25, 4, 2, 2024),
(5, '2024-05-30', 30, 5, 2, 2024),
(6, '2024-06-10', 10, 6, 2, 2024),
(7, '2024-07-15', 15, 7, 3, 2024),
(8, '2024-08-20', 20, 8, 3, 2024),
(9, '2024-09-25', 25, 9, 3, 2024),
(10, '2024-10-30', 30, 10, 4, 2024);

-- Insert data into Appointment_Fact
INSERT INTO Appointment_Fact (Appointment_ID, Patient_ID, Doctor_ID, Hospital_ID, Appointment_Date, Appointment_Cost) VALUES
(1, 1, 1, 1, 1, 500.00),
(2, 2, 2, 2, 2, 800.00),
(3, 3, 3, 3, 3, 1200.00),
(4, 4, 4, 4, 4, 1500.00),
(5, 5, 5, 5, 5, 1000.00),
(6, 6, 6, 6, 6, 700.00),
(7, 7, 7, 7, 7, 2000.00),
(8, 8, 8, 8, 8, 850.00),
(9, 9, 9, 9, 9, 900.00),
(10, 10, 10, 10, 10, 1100.00);


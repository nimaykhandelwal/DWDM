CREATE DATABASE Healthcare_GalaxySchema;
USE Healthcare_GalaxySchema;

-- Create Patient Dimension Table
CREATE TABLE Patient_Dim (
    Patient_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Gender VARCHAR(10),
    Address VARCHAR(255),
    Date_of_Birth DATE
);

-- Create Doctor Dimension Table
CREATE TABLE Doctor_Dim (
    Doctor_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Specialization VARCHAR(100),
    Qualification VARCHAR(100),
    Department VARCHAR(100)
);

-- Create Hospital Dimension Table
CREATE TABLE Hospital_Dim (
    Hospital_ID INT PRIMARY KEY,
    Hospital_Name VARCHAR(100),
    Location VARCHAR(100),
    Manager VARCHAR(100)
);

-- Create Time_Dim Table
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
    FOREIGN KEY (Patient_ID) REFERENCES Patient_Dim(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor_Dim(Doctor_ID),
    FOREIGN KEY (Hospital_ID) REFERENCES Hospital_Dim(Hospital_ID),
    FOREIGN KEY (Appointment_Date) REFERENCES Time_Dim(Time_ID)
);

-- Create Billing Fact Table
CREATE TABLE Billing_Fact (
    Billing_ID INT PRIMARY KEY,
    Patient_ID INT,
    Hospital_ID INT,
    Billing_Date INT,
    Total_Amount DECIMAL(10, 2),
    FOREIGN KEY (Patient_ID) REFERENCES Patient_Dim(Patient_ID),
    FOREIGN KEY (Hospital_ID) REFERENCES Hospital_Dim(Hospital_ID),
    FOREIGN KEY (Billing_Date) REFERENCES Time_Dim(Time_ID)
);
-- Insert data into Patient_Dim
INSERT INTO Patient_Dim (Patient_ID, Name, Gender, Address, Date_of_Birth) VALUES
(1, 'Amit Sharma', 'Male', 'Mumbai, Maharashtra', '1985-04-12'),
(2, 'Priya Verma', 'Female', 'Delhi, Delhi', '1990-07-05'),
(3, 'Rahul Gupta', 'Male', 'Bangalore, Karnataka', '1987-03-20'),
(4, 'Sneha Mehta', 'Female', 'Ahmedabad, Gujarat', '1995-12-10'),
(5, 'Vikram Patel', 'Male', 'Chennai, Tamil Nadu', '1983-09-15'),
(6, 'Pooja Nair', 'Female', 'Pune, Maharashtra', '1992-01-25'),
(7, 'Anil Kumar', 'Male', 'Hyderabad, Telangana', '1978-06-18'),
(8, 'Ritu Singh', 'Female', 'Kolkata, West Bengal', '1997-11-30'),
(9, 'Sanjay Chauhan', 'Male', 'Jaipur, Rajasthan', '1989-08-22'),
(10, 'Neha Jain', 'Female', 'Chandigarh, Chandigarh', '1993-02-16');

-- Insert data into Doctor_Dim
INSERT INTO Doctor_Dim (Doctor_ID, Name, Specialization, Qualification, Department) VALUES
(1, 'Dr. Rakesh Sinha', 'Cardiologist', 'MBBS, MD', 'Cardiology'),
(2, 'Dr. Meera Nair', 'Dermatologist', 'MBBS, DDVL', 'Dermatology'),
(3, 'Dr. Anil Desai', 'Orthopedic', 'MBBS, MS', 'Orthopedics'),
(4, 'Dr. Neha Kapoor', 'Gynecologist', 'MBBS, MS', 'Gynecology'),
(5, 'Dr. Suresh Kumar', 'Neurologist', 'MBBS, DM', 'Neurology'),
(6, 'Dr. Priya Sharma', 'Pediatrician', 'MBBS, MD', 'Pediatrics'),
(7, 'Dr. Vijay Singh', 'Oncologist', 'MBBS, MD', 'Oncology'),
(8, 'Dr. Pooja Gupta', 'ENT Specialist', 'MBBS, MS', 'ENT'),
(9, 'Dr. Raghav Pandey', 'Psychiatrist', 'MBBS, MD', 'Psychiatry'),
(10, 'Dr. Sangeeta Roy', 'Endocrinologist', 'MBBS, DM', 'Endocrinology');

-- Insert data into Hospital_Dim
INSERT INTO Hospital_Dim (Hospital_ID, Hospital_Name, Location, Manager) VALUES
(1, 'Apollo Hospital', 'Mumbai, Maharashtra', 'Suresh Mehta'),
(2, 'Max Healthcare', 'Delhi, Delhi', 'Anita Kapoor'),
(3, 'Fortis Hospital', 'Bangalore, Karnataka', 'Rahul Nair'),
(4, 'Manipal Hospital', 'Chennai, Tamil Nadu', 'Vijay Reddy'),
(5, 'Care Hospitals', 'Hyderabad, Telangana', 'Vikram Desai'),
(6, 'Ruby Hall Clinic', 'Pune, Maharashtra', 'Pooja Deshmukh'),
(7, 'Narayana Health', 'Ahmedabad, Gujarat', 'Kiran Patel'),
(8, 'Jaipur Golden Hospital', 'Jaipur, Rajasthan', 'Rajesh Chauhan'),
(9, 'PGIMER', 'Chandigarh, Chandigarh', 'Neha Malhotra'),
(10, 'Medanta', 'Gurgaon, Haryana', 'Sanjeev Singh');

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

-- Insert data into Billing_Fact
INSERT INTO Billing_Fact (Billing_ID, Patient_ID, Hospital_ID, Billing_Date, Total_Amount) VALUES
(1, 1, 1, 1, 2500.00),
(2, 2, 2, 2, 3500.00),
(3, 3, 3, 3, 1500.00),
(4, 4, 4, 4, 2200.00),
(5, 5, 5, 5, 1800.00),
(6, 6, 6, 6, 1400.00),
(7, 7, 7, 7, 3000.00),
(8, 8, 8, 8, 2800.00),
(9, 9, 9, 9, 2600.00),
(10, 10, 10, 10, 3200.00);


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

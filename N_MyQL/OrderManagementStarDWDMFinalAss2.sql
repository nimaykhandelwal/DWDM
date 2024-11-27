create database ordermanagement_ass1;
use ordermanagement_ass1;
CREATE TABLE Fact_Order (
 order_id INT PRIMARY KEY,
 customer_id INT,
 product_id INT,
 promotion_id INT,
 sales_rep_id INT,
 order_date DATE,
 requested_ship_date DATE,
 quantity INT,
 gross_amount DECIMAL(10, 2),
 discount_amount DECIMAL(10, 2),
 net_amount DECIMAL(10, 2),
 FOREIGN KEY (customer_id) REFERENCES Dim_Customer(customer_id),
 FOREIGN KEY (product_id) REFERENCES Dim_Product(product_id),
 FOREIGN KEY (promotion_id) REFERENCES Dim_Promotion(promotion_id),
 FOREIGN KEY (sales_rep_id) REFERENCES Dim_SalesRep(sales_rep_id)
);
CREATE TABLE Dim_Customer (
 customer_id INT PRIMARY KEY,
 customer_name VARCHAR(100),
 billing_address VARCHAR(255),
 shipping_address VARCHAR(255)
);
CREATE TABLE Dim_Product (
 product_id INT PRIMARY KEY,
 product_name VARCHAR(100),
 product_category VARCHAR(100),
 price DECIMAL(10, 2)
);
CREATE TABLE Dim_Promotion (
 promotion_id INT PRIMARY KEY,
 promotion_name VARCHAR(100),
 promotion_description VARCHAR(255)
);
CREATE TABLE Dim_SalesRep (
 sales_rep_id INT PRIMARY KEY,
 sales_rep_name VARCHAR(100),
 region VARCHAR(100)
);

INSERT INTO Dim_Customer (customer_id, customer_name, billing_address, shipping_address)
VALUES
(1, 'Ravi Kumar', '123 MG Road, Bangalore', '456 Brigade Road, Bangalore'),
(2, 'Sita Sharma', '789 Andheri East, Mumbai', '012 Bandra West, Mumbai'),
(3, 'Amit Gupta', '234 Sector 17, Chandigarh', '567 Sector 22, Chandigarh'),
(4, 'Priya Singh', '345 Park Street, Kolkata', '678 Salt Lake, Kolkata'),
(5, 'Rajesh Verma', '901 Hauz Khas, Delhi', '234 Connaught Place, Delhi'),
(6, 'Anita Desai', '567 Banjara Hills, Hyderabad', '890 Jubilee Hills, Hyderabad'),
(7, 'Vikram Mehta', '432 Koregaon Park, Pune', '765 Kalyani Nagar, Pune'),
(8, 'Lakshmi Iyer', '876 Adyar, Chennai', '109 Besant Nagar, Chennai'),
(9, 'Sunil Patil', '543 Viman Nagar, Pune', '876 Hinjewadi, Pune'),
(10, 'Pooja Reddy', '654 Jubilee Hills, Hyderabad', '321 Banjara Hills, Hyderabad');
INSERT INTO Dim_Product (product_id, product_name, product_category, price)
VALUES
(1, 'Laptop', 'Electronics', 50000.00),
(2, 'Smartphone', 'Electronics', 20000.00),
(3, 'Tablet', 'Electronics', 15000.00),
(4, 'Headphones', 'Accessories', 2000.00),
(5, 'Smartwatch', 'Accessories', 10000.00),
(6, 'Bluetooth Speaker', 'Accessories', 5000.00),
(7, 'Television', 'Home Appliances', 40000.00),
(8, 'Refrigerator', 'Home Appliances', 30000.00),
(9, 'Washing Machine', 'Home Appliances', 25000.00),
(10, 'Microwave Oven', 'Home Appliances', 15000.00);
INSERT INTO Dim_Promotion (promotion_id, promotion_name, promotion_description)
VALUES
(1, 'Diwali Offer', '10% off on all electronics'),
(2, 'New Year Sale', '15% off on all items'),
(3, 'Summer Bonanza', '20% off on home appliances'),
(4, 'Festive Season', '5% off on accessories'),
(5, 'Clearance Sale', '25% off on selected items');
INSERT INTO Dim_SalesRep (sales_rep_id, sales_rep_name, region)
VALUES
(1, 'Arjun Reddy', 'South'),
(2, 'Neha Kapoor', 'North'),
(3, 'Manoj Kumar', 'East'),
(4, 'Priyanka Singh', 'West'),
(5, 'Suresh Nair', 'Central');
INSERT INTO Fact_Order (order_id, customer_id, product_id, promotion_id, sales_rep_id,
order_date, requested_ship_date, quantity, gross_amount, discount_amount, net_amount)
VALUES
(1, 1, 1, 1, 1, '2024-07-01', '2024-07-05', 1, 50000.00, 5000.00, 45000.00),
(2, 2, 2, 2, 2, '2024-07-02', '2024-07-06', 2, 40000.00, 6000.00, 34000.00),
(3, 3, 3, 3, 3, '2024-07-03', '2024-07-07', 1, 15000.00, 3000.00, 12000.00),
(4, 4, 4, 4, 4, '2024-07-04', '2024-07-08', 3, 6000.00, 300.00, 5700.00),
(5, 5, 5, 5, 5, '2024-07-05', '2024-07-09', 1, 10000.00, 2500.00, 7500.00),
(6, 6, 6, 1, 1, '2024-07-06', '2024-07-10', 2, 10000.00, 1000.00, 9000.00),
(7, 7, 7, 2, 2, '2024-07-07', '2024-07-11', 1, 40000.00, 6000.00, 34000.00),
(8, 8, 8, 3, 3, '2024-07-08', '2024-07-12', 1, 30000.00, 6000.00, 24000.00),
(9, 9, 9, 4, 4, '2024-07-09', '2024-07-13', 1, 25000.00, 1250.00, 23750.00),
(10, 10, 10, 5, 5, '2024-07-10', '2024-07-14', 1, 15000.00, 3750.00, 11250.00);


SELECT 
    c.customer_name,
    p.product_name,
    pr.promotion_name,
    s.sales_rep_name,
    SUM(o.net_amount) AS total_net_amount
FROM 
    Fact_Order o
    JOIN Dim_Customer c ON o.customer_id = c.customer_id
    JOIN Dim_Product p ON o.product_id = p.product_id
    JOIN Dim_Promotion pr ON o.promotion_id = pr.promotion_id
    JOIN Dim_SalesRep s ON o.sales_rep_id = s.sales_rep_id
GROUP BY 
    c.customer_name,
    p.product_name,
    pr.promotion_name,
    s.sales_rep_name;



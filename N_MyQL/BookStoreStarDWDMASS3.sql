use DWDMASS3;

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    book_type VARCHAR(255),
    cost DECIMAL(10, 2)
);


CREATE TABLE location (
    location_id INT PRIMARY KEY,
    location_name VARCHAR(255)
);


CREATE TABLE author (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(255),
    age INT,
    country VARCHAR(255)
);


CREATE TABLE publication (
    publication_id INT PRIMARY KEY,
    publication_name VARCHAR(255),
    country VARCHAR(255),
    year INT
);


CREATE TABLE fact_sales (
    sale_id INT PRIMARY KEY,
    book_id INT,
    location_id INT,
    author_id INT,
    publication_id INT,
    quantity INT,
    profit DECIMAL(10, 2),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (location_id) REFERENCES location(location_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id),
    FOREIGN KEY (publication_id) REFERENCES publication(publication_id)
);


-- Insert data into Books Table
INSERT INTO books (book_id, book_type, cost) VALUES 
(1, 'Fiction', 15.99),
(2, 'Non-Fiction', 20.00),
(3, 'Science Fiction', 12.50),
(4, 'Fantasy', 10.00),
(5, 'Mystery', 8.99),
(6, 'Romance', 14.00),
(7, 'Thriller', 18.75),
(8, 'Horror', 11.50),
(9, 'Biography', 22.00),
(10, 'Self-Help', 9.99);

-- Insert data into Location Table
INSERT INTO location (location_id, location_name) VALUES 
(1, 'New York'),
(2, 'San Francisco'),
(3, 'Chicago'),
(4, 'Los Angeles'),
(5, 'Seattle'),
(6, 'Houston'),
(7, 'Boston'),
(8, 'Miami'),
(9, 'Dallas'),
(10, 'Philadelphia');

-- Insert data into Author Table
INSERT INTO author (author_id, author_name, age, country) VALUES 
(1, 'Author A', 45, 'USA'),
(2, 'Author B', 38, 'Canada'),
(3, 'Author C', 50, 'UK'),
(4, 'Author D', 40, 'Australia'),
(5, 'Author E', 35, 'India'),
(6, 'Author F', 42, 'USA'),
(7, 'Author G', 47, 'Germany'),
(8, 'Author H', 39, 'France'),
(9, 'Author I', 51, 'Japan'),
(10, 'Author J', 37, 'Brazil');

-- Insert data into Publication Table
INSERT INTO publication (publication_id, publication_name, country, year) VALUES 
(1, 'Pub A', 'USA', 2001),
(2, 'Pub B', 'Canada', 1999),
(3, 'Pub C', 'UK', 2005),
(4, 'Pub D', 'Australia', 2010),
(5, 'Pub E', 'India', 2015),
(6, 'Pub F', 'Germany', 2003),
(7, 'Pub G', 'France', 2008),
(8, 'Pub H', 'Japan', 2012),
(9, 'Pub I', 'Brazil', 2016),
(10, 'Pub J', 'South Korea', 2000);


--  quantity and profit per book type
SELECT b.book_type, SUM(f.quantity) AS total_quantity, SUM(f.profit) AS total_profit
FROM fact_sales f
JOIN books b ON f.book_id = b.book_id
GROUP BY b.book_type;

--  quantity and profit per location
SELECT l.location_name, SUM(f.quantity) AS total_quantity, SUM(f.profit) AS total_profit
FROM fact_sales f
JOIN location l ON f.location_id = l.location_id
GROUP BY l.location_name;

--  quantity and profit per author
SELECT a.author_name, SUM(f.quantity) AS total_quantity, SUM(f.profit) AS total_profit
FROM fact_sales f
JOIN author a ON f.author_id = a.author_id
GROUP BY a.author_name;

-- quantity and profit per publication
SELECT p.publication_name, SUM(f.quantity) AS total_quantity, SUM(f.profit) AS total_profit
FROM fact_sales f
JOIN publication p ON f.publication_id = p.publication_id
GROUP BY p.publication_name;



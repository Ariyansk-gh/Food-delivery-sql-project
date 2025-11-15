

/*FOOD DELIVERY APP DATABASE (SWIGGY / ZOMATO STYLE)
Author: Ariyan Shaikh
Description:
A clean, simple but professional SQL project including:
DDL, DML, JOINS, VIEWS, SUBQUERIES, UNIONS, TCL, DCL & more. */
------------------------------------------------------------------------------

-- Step 1: Create and Use Database
CREATE DATABASE food_delivery_app;
USE food_delivery_app;

-- Step 2: Create Tables

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_name VARCHAR(100),
    cuisine_type VARCHAR(50),
    city VARCHAR(50),
    rating DECIMAL(2,1)
);

CREATE TABLE menu_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT,
    item_name VARCHAR(100),
    price DECIMAL(8,2),
    category VARCHAR(50),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    restaurant_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

CREATE TABLE delivery_partners (
    partner_id INT PRIMARY KEY AUTO_INCREMENT,
    partner_name VARCHAR(100),
    vehicle_type VARCHAR(50),
    phone VARCHAR(15)
);

CREATE TABLE ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    customer_id INT,
    restaurant_id INT,
    rating INT,
    review TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);
----------------------------------------------------------------------------
   # Step 3: Insert Data 
   
-- Customers
INSERT INTO customers (full_name, phone, email, city) VALUES
('Ariyan Shaikh', '9876543210', 'ariyan@example.com', 'Mumbai'),
('Riya Patel', '9812276543', 'riya@example.com', 'Delhi'),
('Kabir Khan', '9898989898', 'kabir@example.com', 'Pune'),
('Sneha Mehta', '9123456780', 'sneha@example.com', 'Mumbai'),
('Amit Sharma', '9001122334', 'amit@example.com', 'Bangalore');

-- Restaurants
INSERT INTO restaurants (restaurant_name, cuisine_type, city, rating) VALUES
('Biryani House', 'North Indian', 'Mumbai', 4.5),
('Bombay Café', 'Fast Food', 'Mumbai', 4.2),
('Delhi Chole Bhature', 'North Indian', 'Delhi', 4.0),
('Idli Corner', 'South Indian', 'Bangalore', 4.3),
('Tandoori Flames', 'Mughlai', 'Pune', 4.4);

-- Menu Items
INSERT INTO menu_items (restaurant_id, item_name, price, category) VALUES
(1, 'Chicken Biryani', 220, 'Main Course'),
(1, 'Paneer Biryani', 200, 'Main Course'),
(2, 'Bombay Sandwich', 80, 'Snacks'),
(3, 'Chole Bhature', 150, 'Main Course'),
(4, 'Masala Dosa', 120, 'South Indian'),
(5, 'Tandoori Chicken', 250, 'Main Course');

-- Orders
INSERT INTO orders (customer_id, restaurant_id, order_date, total_amount, status) VALUES
(1, 1, '2024-02-01', 220, 'Delivered'),
(2, 3, '2024-02-02', 150, 'Delivered'),
(3, 5, '2024-02-03', 250, 'Delivered'),
(4, 2, '2024-02-05', 80, 'Cancelled'),
(5, 4, '2024-02-07', 120, 'Delivered');

-- Delivery Partners
INSERT INTO delivery_partners (partner_name, vehicle_type, phone) VALUES
('Ramesh Kumar', 'Bike', '9004567890'),
('Imran Khan', 'Scooter', '9008765432'),
('Aditi Verma', 'Bike', '9112233445');

-- Ratings
INSERT INTO ratings (order_id, customer_id, restaurant_id, rating, review) VALUES
(1, 1, 1, 5, 'Amazing biryani! Must try.'),
(2, 2, 3, 4, 'Loved it! Authentic taste.'),
(3, 3, 5, 5, 'Great tandoori, well cooked.'),
(5, 5, 4, 4, 'Crispy dosa, very tasty!');
------------------------------------------------------------------------------------------
/* A Quick recap :
I have created 5 interlinked tables using (foreign keys).
Added 5-7+ rows for analysis.
*/
-------------------------------------------------------------

/* 1. Data Definition Language (DDL) :
There are totaly 4 commands in DDL
1) Create
2) Drop
3) Alter 
4) Truncate
*/

-- Add a new column :
ALTER TABLE customers ADD address VARCHAR(200);

-- Modify a column :
ALTER TABLE restaurants MODIFY rating DECIMAL(3,2);

-- Drop a column :
ALTER TABLE delivery_partners DROP COLUMN vehicle_type;

-- Rename a table :
RENAME TABLE ratings TO restaurant_reviews;

DROP TABLE restaurant_reviews;
----------------------------------------------------------

/* 2. Data Manipulation Language:
1) Insert
2) Update
3) Delete
*/ 

-- Insert into customers :

INSERT INTO customers (full_name, phone, email, city) VALUES
('Ariyan Shaikh', '9876543210', 'ariyan@example.com', 'Mumbai'),
('Riya Patel', '9812276543', 'riya@example.com', 'Delhi'),
('Kabir Khan', '9898989898', 'kabir@example.com', 'Pune');
select * from customers;

-- Update :

UPDATE customers
SET city = 'Bangalore'
WHERE customer_id = 3;

-- Update restaurant rating :

UPDATE restaurants
SET rating = 4.8
WHERE restaurant_id = 1;

-- DELETE Commands:

DELETE FROM orders
WHERE status = 'Cancelled';

-- Delete customers from specific city :

/*DELETE FROM customers
WHERE city = 'Delhi';*/ # This won't work because we used foreign key.

-- SELECT Commands :

SELECT * FROM customers;

--  restaurants in Mumbai :

SELECT * FROM restaurants WHERE city = 'Mumbai';
----------------------------------------------------------------

/*  3.Transaction Control Language (TCL) :
1) Commit
2) Roll Back
3) Save Point
*/

START TRANSACTION;

INSERT INTO customers (full_name, phone, email, city) VALUES
('Sufiyan khan', '9876541210', 'sufiyan@example.com', 'Kolhapur');

SAVEPOINT before_delete;

delete from menu_items
where price = 220;

ROLLBACK TO before_delete; -- Undo delete, keep new course

COMMIT; -- Save all changes
---------------------------------------------------------------------------------------------------------

# Clauses :
-- We are using clauses to make the query more informative.

# SELECT & WHERE CLAUSE :

SELECT * FROM restaurants WHERE rating > 4.3;

# LIKE Clause :

SELECT * FROM customers WHERE full_name LIKE 'A%';

-- BETWEEN Clause :

SELECT * FROM orders
WHERE total_amount BETWEEN 100 AND 300;

/*  GROUP BY CLAUSE :
  GROUP BY Clause: The GROUP BY clause is used to group rows that have the same 
  values in one or more columns. 
*/

-- Total orders per restaurant

SELECT restaurant_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY restaurant_id;


/* ORDER BY CLAUSE :
   USED TO SORT THE DATA EITHER INTO ASCENDING OR DESCENDING ORDER.
*/     

SELECT * FROM customers
ORDER BY full_name ASC;

-- HAVING Clause :

-- Restaurants with more than 2 orders : 
SELECT restaurant_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY restaurant_id
HAVING COUNT(order_id) > 2;

/* DISTINCT CLAUSE :
  The DISTINCT clause is used in SQL to return only unique values from 
  a column or group of columns. 
*/

-- Find all unique departments
SELECT DISTINCT Cuisine_type FROM restaurants;

---------------------------------------------------------------------------------------------

# JOINS :

-- INNER JOIN

-- Get all orders with customer & restaurant details :

SELECT o.order_id, c.full_name, r.restaurant_name, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN restaurants r ON o.restaurant_id = r.restaurant_id;

-- LEFT JOIN

-- Show all customers even if they never placed an order :

SELECT c.full_name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- RIGHT JOIN

-- Show all menu items even if their restaurant has no orders :

SELECT r.restaurant_name, m.item_name
FROM menu_items m
RIGHT JOIN restaurants r ON m.restaurant_id = r.restaurant_id;

-- CROSS JOIN

SELECT c.full_name, r.restaurant_name
FROM customers c
CROSS JOIN restaurants r;
-------------------------------------------------------------------------

# SUBQUERIES (Single-row, Multi-row, and Nested) :

-- Find customers who spent above average

SELECT full_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders
    WHERE total_amount > (SELECT AVG(total_amount) FROM orders)
);

-- Subquery in SELECT
-- Show each order vs average order value

SELECT order_id, total_amount,
       (SELECT AVG(total_amount) FROM orders) AS avg_order_value
FROM orders;
-------------------------------------------------------------------------------

# UNION and UNION ALL Examples :
-- UNION is used to combine results from multiple SELECT statements
-- It removes duplicate rows by default.

-- Combine cities
SELECT city FROM customers
UNION
SELECT city FROM restaurants;

-- All names in the app
SELECT full_name AS name FROM customers
UNION
SELECT partner_name AS name FROM delivery_partners;
------------------------------------------------------------------------------

# VIEWS (Virtual Tables) :
-- A view is a saved SQL query that acts like a table.

-- View showing customer + order summary

CREATE VIEW customer_orders AS
SELECT c.full_name, c.city, o.order_id, o.total_amount, o.status
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- Select from the view

SELECT * FROM customer_orders;

-- Drop view

DROP VIEW customer_orders;







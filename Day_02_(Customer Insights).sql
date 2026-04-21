-- CUSTOMERS
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Alice', 'Johannesburg'),
(2, 'Bob', 'Cape Town'),
(3, 'Charlie', 'Durban'),
(4, 'David', 'Pretoria'),
(5, 'Eve', 'Johannesburg');

-- PRODUCTS
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50)
);

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics'),
(102, 'Phone', 'Electronics'),
(103, 'Shirt', 'Clothing'),
(104, 'Shoes', 'Clothing'),
(105, 'Watch', 'Accessories');

-- ORDERS
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

INSERT INTO orders VALUES
(1001, 1, '2024-01-01'),
(1002, 1, '2024-01-05'),
(1003, 2, '2024-01-02'),
(1004, 3, '2024-01-10'),
(1005, 4, '2024-01-12');

-- ORDER ITEMS
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO order_items VALUES
(1001, 101, 1),
(1001, 103, 2),
(1002, 102, 1),
(1003, 103, 1),
(1004, 104, 1);

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;


-- Find customers who placed ONLY ONE order
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM Customers c 
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) = 1;

-- Which customers have never placed a single order?
SELECT c.customer_name, c.customer_id 
FROM Customers c 
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

-- Show each customer and how many total orders they placed.
SELECT c.customer_name, COUNT(o.order_id) AS Total_orders
FROM Customers c 
INNER JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY  c.customer_name;



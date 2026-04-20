CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50),
    region VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category_id INT,
    price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product_id INT,
    quantity INT,
    order_date DATE
);

-- Insert Sample Data
INSERT INTO Categories VALUES (1, 'Electronics', 'North'), (2, 'Furniture', 'South'), (3, 'Clothing', 'East');
INSERT INTO Products VALUES (101, 'Laptop', 1, 1200), (102, 'Phone', 1, 800), (103, 'Chair', 2, 150), (104, 'Desk', 2, 300), (105, 'T-Shirt', 3, 25);
INSERT INTO Orders VALUES 
(1, 'Alice', 101, 1, '2024-01-01'), (2, 'Bob', 102, 2, '2024-01-02'), 
(3, 'Alice', 103, 1, '2024-01-03'), (4, 'Charlie', 101, 1, '2024-01-04'),
(5, 'Bob', 105, 10, '2024-01-05'), (6, 'David', 104, 2, '2024-01-06');

SELECT * FROM Categories;
SELECT * FROM Orders;
SELECT * FROM Products;

-- customers by revenue
SELECT 
    o.customer_name, 
    SUM(o.quantity * p.price) AS total_revenue
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY o.customer_name
HAVING SUM(o.quantity * p.price) > 0
ORDER BY total_revenue DESC;

-- Revenue per region
SELECT 
    c.region, 
    SUM(o.quantity * p.price) AS regional_revenue
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
JOIN Categories c ON p.category_id = c.category_id
GROUP BY c.region
HAVING regional_revenue > 500;

-- Most Sold Product per Category
SELECT 
    c.category_name, 
    p.product_name, 
    SUM(o.quantity) AS total_sold
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Orders o ON p.product_id = o.product_id
GROUP BY c.category_name, p.product_name
ORDER BY total_sold DESC;

-- High-Value Regions: List all regions that have generated more than $1,000 in total revenue.
SELECT 
    c.region, 
    SUM(o.quantity * p.price) AS total_revenue
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
JOIN Orders o ON p.product_id = o.product_id
GROUP BY c.region
HAVING SUM(o.quantity * p.price) > 1000;

-- Product Popularity: Find the names of products that have been ordered more than 5 times across all orders.
SELECT 
    p.product_name, 
    SUM(o.quantity) AS total_units_sold
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
GROUP BY p.product_name
HAVING SUM(o.quantity) > 5;

-- Customer Diversity: Find customers who have purchased items from more than one unique category
SELECT 
    o.customer_name, 
    COUNT(DISTINCT p.category_id) AS unique_categories_bought
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY o.customer_name
HAVING COUNT(DISTINCT p.category_id) > 1;

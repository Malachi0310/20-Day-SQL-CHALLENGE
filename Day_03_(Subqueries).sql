CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category_id INT,
    price DECIMAL(10, 2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    total_spend DECIMAL(10, 2)
);

INSERT INTO categories VALUES (1, 'Electronics'), (2, 'Kitchen'), (3, 'Fitness');

INSERT INTO products VALUES 
(101, 'Laptop', 1, 1200), (102, 'Mouse', 1, 25), (103, 'Monitor', 1, 300),
(201, 'Blender', 2, 150), (202, 'Toaster', 2, 40), (203, 'Air Fryer', 2, 200),
(301, 'Weights', 3, 50), (302, 'Yoga Mat', 3, 30), (303, 'Treadmill', 3, 1500);

INSERT INTO orders VALUES 
(1, 'Alice', 1250.00), (2, 'Bob', 45.00), (3, 'Charlie', 1500.00), 
(4, 'Diana', 200.00), (5, 'Ethan', 50.00), (6, 'Fiona', 800.00);

SELECT * FROM categories;
SELECT * FROM products;
SELECT * FROM orders;

-- Find all customers who have a total_spend higher than the average spend of all customers in the table
SELECT customer_name
FROM orders
WHERE total_spend > ( 
    SELECT AVG(total_spend)
    FROM orders
);

-- List the product_name and price of products that are more expensive than the average price of products within their same category.
SELECT p1.product_name, p1.price    
FROM products p1                     
WHERE p1.price > (                  
    SELECT AVG(p2.price)             
    FROM products p2                 
    WHERE p2.category_id = p1.category_id 
);

-- Identify the category_name from the categories table that has no products priced over $500.
SELECT category_name
FROM categories
WHERE category_id NOT IN (
    SELECT category_id
    FROM products
    WHERE price > 500
);

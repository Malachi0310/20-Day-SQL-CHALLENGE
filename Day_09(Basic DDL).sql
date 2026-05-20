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

ALTER TABLE orders
ADD email VARCHAR(100);

ALTER TABLE Orders
MODIFY customer_name VARCHAR(120);

ALTER TABLE Orders 
DROP COLUMN quantity;

ALTER TABLE Products
ADD created_at DATE;

DROP TABLE Orders;

RENAME TABLE Categories
TO Product_categories;

DESCRIBE  Products;

SHOW COLUMNS FROM Product_categories;

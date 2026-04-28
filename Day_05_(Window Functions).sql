CREATE TABLE employees (
    id INT,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

INSERT INTO employees (id, name, department, salary) VALUES
(1, 'Alice', 'IT', 60000),
(2, 'Bob', 'IT', 75000),
(3, 'Charlie', 'HR', 50000),
(4, 'David', 'HR', 50000),
(5, 'Eve', 'Finance', 90000),
(6, 'Frank', 'Finance', 85000);

SELECT * FROM employees;

-- their rank based on salary
SELECT 
    name, 
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS emp_rank
FROM employees;

-- rank within each department
SELECT name, salary, department,
       DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) 
       AS dept_rank
FROM employees;

-- a unique number for each employee based on salary (highest first)
SELECT name, salary,
       ROW_NUMBER() OVER(ORDER BY salary DESC) 
       AS salary_sorted
FROM  employees;

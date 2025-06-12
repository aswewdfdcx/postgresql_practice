CREATE TABLE departments (
  department_id   SERIAL PRIMARY KEY,
  department_name VARCHAR(50) NOT NULL,
  manager_id      INT
);

CREATE TABLE employees (
  employee_id   SERIAL PRIMARY KEY,
  first_name    VARCHAR(50) NOT NULL,
  last_name     VARCHAR(50) NOT NULL,
  department_id INT REFERENCES departments(department_id),
  hire_date     DATE NOT NULL
);

CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  first_name  VARCHAR(50) NOT NULL,
  last_name   VARCHAR(50) NOT NULL,
  email       VARCHAR(100) UNIQUE NOT NULL,
  created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  name       VARCHAR(100) NOT NULL,
  category   VARCHAR(50) NOT NULL,
  price      DECIMAL(10,2) NOT NULL,
  stock      INT NOT NULL
);

-- 5) Orders
CREATE TABLE orders (
  order_id     SERIAL PRIMARY KEY,
  customer_id  INT REFERENCES customers(customer_id),
  order_date   DATE NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL
);

-- 6) Order Items
CREATE TABLE order_items (
  order_item_id SERIAL PRIMARY KEY,
  order_id      INT REFERENCES orders(order_id),
  product_id    INT REFERENCES products(product_id),
  quantity      INT NOT NULL,
  unit_price    DECIMAL(10,2) NOT NULL
);

-- Insert sample departments (manager_id to be set after employees inserted)
INSERT INTO departments (department_id, department_name) VALUES
  (1, 'Sales'),
  (2, 'Marketing'),
  (3, 'Engineering');

-- Insert sample employees
INSERT INTO employees (employee_id, first_name, last_name, department_id, hire_date) VALUES
  (1, 'Tom',   'Clark', 1, '2020-01-15'),
  (2, 'Lisa',  'White', 2, '2019-08-01'),
  (3, 'Mark',  'Lee',   3, '2021-03-10'),
  (4, 'Sara',  'Patel', 1, '2022-06-25'),
  (5, 'James', 'King',  2, '2023-02-18');

-- Now set department managers
UPDATE departments SET manager_id = 1 WHERE department_id = 1;
UPDATE departments SET manager_id = 2 WHERE department_id = 2;
UPDATE departments SET manager_id = 3 WHERE department_id = 3;

-- Insert sample customers
INSERT INTO customers (customer_id, first_name, last_name, email, created_at) VALUES
  (1, 'John',  'Doe',    'john.doe@example.com',    '2024-12-01 10:00:00'),
  (2, 'Jane',  'Smith',  'jane.smith@example.com',  '2025-01-15 12:30:00'),
  (3, 'Alice', 'Johnson','alice.johnson@example.com','2025-02-20 09:45:00'),
  (4, 'Bob',   'Brown',  'bob.brown@example.com',   '2025-03-05 16:20:00'),
  (5, 'Carol', 'Davis',  'carol.davis@example.com', '2025-05-12 14:10:00');

-- Insert sample products
INSERT INTO products (product_id, name,                             category,      price,   stock) VALUES
  (101, 'Wireless Mouse',               'Electronics',  25.99, 100),
  (102, 'Mechanical Keyboard',          'Electronics',  79.99,  50),
  (103, 'USB-C Cable',                  'Accessories',   9.99, 200),
  (104, 'HDMI Adapter',                 'Accessories',  14.99, 150),
  (105, 'Laptop Stand',                 'Office',       29.99,  30),
  (106, 'Noise Cancelling Headphones',  'Electronics', 199.99,  20);

-- Insert sample orders
INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
  (1001, 1, '2025-04-01', 131.97),
  (1002, 2, '2025-04-02',  79.99),
  (1003, 3, '2025-04-03',  19.98),
  (1004, 1, '2025-05-01', 199.99),
  (1005, 4, '2025-05-05',  44.97),
  (1006, 5, '2025-05-10',  79.94),
  (1007, 2, '2025-05-15', 303.95);

-- Insert sample order items
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
  (1, 1001, 101, 2, 25.99),
  (2, 1001, 102, 1, 79.99),
  (3, 1002, 102, 1, 79.99),
  (4, 1003, 103, 2,  9.99),
  (5, 1004, 106, 1,199.99),
  (6, 1005, 104, 3, 14.99),
  (7, 1006, 103, 5,  9.99),
  (8, 1006, 105, 1, 29.99),
  (9, 1007, 101, 4, 25.99),
  (10,1007, 106, 1,199.99);

select * from customers;

SELECT first_name, last_name FROM employees;

SELECT name, price FROM products;

SELECT DISTINCT category FROM products;

SELECT COUNT(*) FROM orders;

SELECT AVG(price) AS average_price FROM products;

SELECT MIN(unit_price) AS minimum_unit_price FROM order_items;

SELECT MAX(total_amount) AS maximum_total FROM orders;

SELECT COUNT(*) FROM customers WHERE created_at > '2025-01-01';

SELECT SUM(stock) AS total_stock FROM products;

SELECT email FROM customers WHERE email LIKE '%example.com%';

SELECT * FROM orders WHERE order_date = '2025-05-01';

SELECT * FROM employees WHERE hire_date < '2021-01-01';

SELECT * FROM products WHERE price > 50;

SELECT * FROM customers WHERE last_name LIKE 'D%';

SELECT * FROM orders WHERE total_amount BETWEEN 50 AND 200;

SELECT * FROM products ORDER BY stock DESC;

SELECT * FROM products ORDER BY price DESC LIMIT 3;

SELECT * FROM customers LIMIT 2;

SELECT * FROM employees OFFSET 2;

SELECT * FROM products ORDER BY price ;

SELECT * FROM customers ORDER BY created_at DESC;

SELECT * FROM orders ORDER BY order_date;

SELECT * FROM orders ORDER BY order_date DESC LIMIT 5;

SELECT * FROM employees ORDER BY last_name,first_name ;

SELECT * FROM products WHERE category = 'Electronics' ORDER BY stock DESC;

SELECT * FROM customers LIMIT 3 OFFSET 1;

SELECT * FROM orders ORDER BY total_amount DESC LIMIT 2;

SELECT * FROM departments ORDER BY department_name;

SELECT * FROM order_items ORDER BY quantity DESC;

SELECT * FROM customers WHERE customer_id = 3;

SELECT * FROM products WHERE price >= 100;

SELECT * FROM orders WHERE total_amount <> 79.99;

SELECT * FROM employees WHERE department_id <= 2;

SELECT * FROM order_items WHERE quantity < 3;

SELECT * FROM products WHERE stock BETWEEN 30 AND 100;

SELECT * FROM orders WHERE order_date <> '2025-04-01';

SELECT * FROM customers WHERE created_at >= '2025-02-01';

SELECT * FROM products WHERE category = 'Office';

select * from (SELECT * FROM orders WHERE total_amount > (SELECT AVG(total_amount) FROM orders)) "o*";

SELECT * FROM employees WHERE hire_date = '2022-06-25';

SELECT * FROM products WHERE name LIKE '%Headphones%';

SELECT * FROM customers WHERE email NOT LIKE '%example.com%';

SELECT * FROM orders WHERE order_id IN (1001, 1004, 1007);

SELECT * FROM products WHERE product_id NOT IN (101, 103);  





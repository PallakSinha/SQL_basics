DROP DATABASE sales;
CREATE DATABASE if not exists sales;
USE sales;
CREATE TABLE customers 
(
    customer_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2)
);
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

SELECT * FROM sales.customers;
INSERT INTO customers (customer_id, name, email)
VALUES (1, 'Aaron', 'aaron34@gmail.com');

SELECT name FROM customers WHERE name='Aaron';

INSERT INTO sales.customers (customer_id, name, email) 
VALUES (2, 'Barry', 'barry213@gmail.com'),
(3, 'Colin', '44colin@gmail.com');

SET SQL_SAFE_UPDATES = 1;

UPDATE customers
SET name='Colin' WHERE customer_id=2;
UPDATE customers
SET name='Barry' WHERE customer_id=3;

SELECT *
FROM customers
ORDER BY name ASC;

ALTER TABLE customers
ADD column (country VARCHAR(15));

INSERT INTO customers (country)
VALUES ('USA'),('Canada'),('USA');

SET SQL_SAFE_UPDATES = 0;

DELETE FROM customers
WHERE name IS NULL AND email IS NULL;

UPDATE customers
SET country='USA' WHERE customer_id=1;
UPDATE customers
SET country='Canada' WHERE customer_id=2;
UPDATE customers
SET country='USA' WHERE customer_id=3;

SELECT COUNT(customer_id), Country
FROM customers
GROUP BY country;

USE sales;
SELECT order_id,
  DATE_FORMAT(order_date, '%d-%m-%Y') AS readable_date
FROM orders;
INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES 
(101, 1, '2024-04-03', 500),
(102, 2, '2024-04-16', 2000),
(103, 3, '2024-05-11', 750);
SELECT order_id,
  DATE_FORMAT(order_date, '%d-%m-%Y') AS readable_date
FROM orders;

SELECT customers.name, orders.order_id, orders.total_amount
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id;

SELECT customers.name, orders.order_id, orders.total_amount
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id;

SELECT customers.name, orders.order_id, orders.total_amount
FROM customers
RIGHT JOIN orders ON customers.customer_id = orders.customer_id;


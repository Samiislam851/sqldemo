CREATE DATABASE bookstore_db;

CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    price NUMERIC(11,2) NOT NULL CHECK (price >= 0),
    stock INT DEFAULT 0 CHECK (stock >= 0),
    published_year DATE
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    joined_date DATE
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(id),
    book_id INTEGER REFERENCES books(id),
    quantity INTEGER NOT NULL CHECK(quantity > 0),
    order_date DATE DEFAULT CURRENT_DATE
);

-- insert data ---
INSERT INTO books (title, author, price, stock, published_year)
VALUES 
('The Pragmatic Programmer', 'Andrew Hunt', 40.00, 10, 1999),
('Clean Code', 'Robert C. Martin', 35.00, 5, 2008),
('You Don''t Know JS', 'Kyle Simpson', 30.00, 8, 2014),
('Refactoring', 'Martin Fowler', 50.00, 3, 1999),
('Database Design Principles', 'Jane Smith', 20.00, 0, 2018);

INSERT INTO customers (name, email, joined_date)
VALUES 
('Alice', 'alice@email.com', '2023-01-10'),
('Bob', 'bob@email.com', '2022-05-15'),
('Charlie', 'charlie@email.com', '2023-06-20');

INSERT INTO orders (customer_id, book_id, quantity, order_date)
VALUES 
(1, 2, 1, '2024-03-10'),
(2, 1, 1, '2024-02-20'),
(1, 3, 2, '2024-03-05');


-- Questions and answers --

-- 1. Find books that are out of stock. --
SELECT * FROM public.books WHERE public.books.stock = 0;

-- 2. Retrieve the most expensive book in the store.
SELECT * FROM public.books ORDER BY price DESC LIMIT 1;

--  3. Find the total number of orders placed by each customer.
SELECT c.name as name, count(o.id) as total_orders FROM
public.customers as c join public.orders as o
on c.id = o.customer_id 
GROUP BY c.name
ORDER BY count(o.id) DESC;

-- 4. Calculate the total revenue generated from book sales.
select  SUM(quantity * price) as total_revenue from 
public.orders as o join public.books as b 
on o.book_id = b.id; 

--- 5. List all customers who have placed more than one order.
SELECT c.name, count(o.id) from
public.orders as o join public.customers as c 
on o.customer_id = c.id
GROUP BY c.name 
HAVING COUNT(o.id) > 1 ;

--- 6. Find the average price of books in the store.
SELECT ROUND(AVG(price),2) FROM public.books;

--- 7.  Increase the price of all books published before 2000 by 10%.

UPDATE public.books
SET price = price + price*.1
where public.books.published_year < 2000;

--- 8. Delete customers who haven't placed any orders.
DELETE FROM public.customers c
WHERE NOT EXISTS (
    SELECT 1 from public.orders o WHERE o.customer_id = c.id
);


-- ------------- Bonus section -----------------
-- 1. What is postgresql? 
--     - Postgresql is an Object Relational Database Management System that uses SQL for its query Laguage.
--       It has built in support for transactions and is ACID compliant. It supports advanced data structures like JSONB and also supports user defined custom types. It has object oriented features lke schemas and objects.

-- 2. What is the purpose of a database schema in PostgreSQL?
--     - Schema is used for creating different namespaces inside a database that organizes and groups related data together like tables, functions etc.

-- 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.
--     - A Primary Key uniquely identifies each row in a table, while a Foreign Key links one table to another by referencing a key of the related table.

-- 4. What is the difference between the VARCHAR and CHAR data types?
--     - Varchar stores variable lengtth strings and uses only as much space as needed. Char on the other hand uses all the spaces it was declared with (fixed size).

-- 5. Explain the purpose of the WHERE clause in a SELECT statement.
--     - WHERE clause is used to define a condition in select statement.

-- 6. What are the LIMIT and OFFSET clauses used for?
--     - Most commonly these are used for pagination. Limit defines how many number of rows it will return and OFFSET defines how many data to skip.

-- 7. How can you modify data using UPDATE statements?
--     -  we can modify data using and update statements like the example below: 
--     UPDATE table_name 
--     SET colname1 = value1, colname2  = value2
--     where condition
-- 8. What is the significance of the JOIN operation, and how does it work in PostgreSQL?
--     - the join is used to combine two tables against rows in an rdbms. it is essential for normalized database. 
--         SELECT c.name, o.id AS order_id, o.order_date
--         FROM customers c
--         JOIN orders o ON c.id = o.customer_id;
--     what happens :
--     1. Postgres scans customers and orders
--     2. for each customer it finds all orders where  orders.customer_id = customers.id
--     3. combines matching rows into one result row.

-- 9. Explain the GROUP BY clause and its role in aggregation operations.
--     - It groups rows that have the same values in specified columns so we can apply aggregate functions like COUNT, SUM, AVG, etc. to each group.

-- 10. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?
--     - In PostgreSQL, aggregate functions like COUNT(), SUM(), and AVG() compute summaries over rows
--     COUNT() counts rows,
--     SUM() adds numeric values,
--     and AVG() calculates averages.
--     They can be applied to all rows or grouped using GROUP BY to calculate per-group summaries

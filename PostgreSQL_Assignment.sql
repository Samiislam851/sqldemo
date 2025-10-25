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


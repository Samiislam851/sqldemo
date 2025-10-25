## 1. What is postgresql? 
    Postgresql is an Object Relational Database Management System that uses SQL for its query Laguage.
    It has built in support for transactions and is ACID compliant. It supports advanced data structures like JSONB and also supports user defined custom types. It has object oriented features lke schemas and objects.

## 2. What is the purpose of a database schema in PostgreSQL?
    Schema is used for creating different namespaces inside a database that organizes and groups related data together like tables, functions etc.
    
    Example of creating and using a schema for views:
    ```sql
    CREATE SCHEMA reporting;
    CREATE VIEW reporting.sales_summary AS
    SELECT * FROM sales;
    ```

## 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.
    A Primary Key uniquely identifies each row in a table, while a Foreign Key links one table to another by referencing a key of the related table.
    
    Example using views with keys:
    ```sql
    CREATE VIEW order_details AS
    SELECT o.order_id, c.customer_name 
    FROM orders o
    JOIN customers c ON o.customer_id = c.id;
    ```

## 4. What is the difference between the VARCHAR and CHAR data types?
    Varchar stores variable lengtth strings and uses only as much space as needed. Char on the other hand uses all the spaces it was declared with (fixed size).
    
    Example in a view:
    ```sql
    CREATE VIEW user_names AS 
    SELECT CAST(name AS VARCHAR(50)) AS formatted_name FROM users;
    ```

## 5. Explain the purpose of the WHERE clause in a SELECT statement.
    WHERE clause is used to define a condition in select statement.
    
    Example with views:
    ```sql
    CREATE VIEW active_users AS
    SELECT * FROM users WHERE status = 'active';
    ```

## 6. What are the LIMIT and OFFSET clauses used for?
    Most commonly these are used for pagination. Limit defines how many number of rows it will return and OFFSET defines how many data to skip.
    
    Example with views:
    ```sql
    CREATE VIEW top_10_customers AS
    SELECT * FROM customers
    ORDER BY purchase_amount DESC
    LIMIT 10;
    ```

## 7. How can you modify data using UPDATE statements?
     we can modify data using and update statements like the example below: 
    ```sql
    UPDATE table_name 
    SET colname1 = value1, colname2  = value2
    where condition
    
    -- Example with updatable view:
    CREATE VIEW active_employees AS
    SELECT * FROM employees WHERE status = 'active';
    UPDATE active_employees SET salary = salary * 1.1;
    ```

## 8. What is the significance of the JOIN operation, and how does it work in PostgreSQL?
    the join is used to combine two tables against rows in an rdbms. it is essential for normalized database. 

    ```sql
    CREATE VIEW customer_orders AS
    SELECT c.name, o.id AS order_id, o.order_date
    FROM customers c
    JOIN orders o ON c.id = o.customer_id;
    ```
    
    what happens :
    1. Postgres scans customers and orders
    2. for each customer it finds all orders where  orders.customer_id = customers.id
    3. combines matching rows into one result row.

## 9. Explain the GROUP BY clause and its role in aggregation operations.
    It groups rows that have the same values in specified columns so we can apply aggregate functions like COUNT, SUM, AVG, etc. to each group.
    
    Example with views:
    ```sql
    CREATE VIEW sales_by_category AS
    SELECT category, SUM(amount) as total_sales
    FROM sales
    GROUP BY category;
    ```

## 10. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?
    In PostgreSQL, aggregate functions like COUNT(), SUM(), and AVG() compute summaries over rows
    COUNT() counts rows,
    SUM() adds numeric values,
    and AVG() calculates averages.
    They can be applied to all rows or grouped using GROUP BY to calculate per-group summaries
    
    Example with views:
    ```sql
    CREATE VIEW sales_statistics AS
    SELECT 
        COUNT(*) as total_orders,
        SUM(amount) as total_revenue,
        AVG(amount) as average_order_value
    FROM
## 1. What is postgresql? 
Postgresql is an Object Relational Database Management System that uses SQL for its query Laguage.
It has built in support for transactions and is ACID compliant. It supports advanced data structures like JSONB and also supports user defined custom types. It has object oriented features lke schemas and objects.

## 2. What is the purpose of a database schema in PostgreSQL?
   Schema is used for creating different namespaces inside a database that organizes and groups related data together like tables, functions etc.

## 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.
   A Primary Key uniquely identifies each row in a table, while a Foreign Key links one table to another by referencing a key of the related table.

## 4. What is the difference between the VARCHAR and CHAR data types?
   Varchar stores variable lengtth strings and uses only as much space as needed. Char on the other hand uses all the spaces it was declared with (fixed size).

## 5. Explain the purpose of the WHERE clause in a SELECT statement.
  WHERE clause is used to define a condition in select statement.

## 6. What are the LIMIT and OFFSET clauses used for?
  Most commonly these are used for pagination. Limit defines how many number of rows it will return and OFFSET defines how many data to skip.

## 7. How can you modify data using UPDATE statements?
  we can modify data using and update statements like the example below:
   
    UPDATE table_name 
    SET colname1 = value1, colname2  = value2
    where condition

## 8. What is the significance of the JOIN operation, and how does it work in PostgreSQL?
the join is used to combine two tables against rows in an rdbms. it is essential for normalized database. 
           
    SELECT c.name, o.id AS order_id, o.order_date
    FROM customers c
    JOIN orders o ON c.id = o.customer_id;

what happens :
1. Postgres scans customers and orders
2. for each customer it finds all orders where  orders.customer_id = customers.id
3. combines matching rows into one result row.

## 9. Explain the GROUP BY clause and its role in aggregation operations.
 It groups rows that have the same values in specified columns so we can apply aggregate functions like COUNT, SUM, AVG, etc. to each group.

## 10. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?
In PostgreSQL, aggregate functions like COUNT(), SUM(), and AVG() compute summaries over rows

COUNT() counts rows,
SUM() adds numeric values,
and AVG() calculates averages.
They can be applied to all rows or grouped using GROUP BY to calculate per-group summaries

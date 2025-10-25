CREATE TABLE customers (
  customerid INT PRIMARY KEY,
  customername VARCHAR2(50),
  contactno VARCHAR2(15),
  address VARCHAR2(100),
  city VARCHAR2(50),
  postalcode VARCHAR2(20),
  country VARCHAR2(50)
);
desc customers;

CREATE TABLE employees (
  employeeid INT PRIMARY KEY,
  lastname VARCHAR2(50),
  firstname VARCHAR2(50),
  birthdate DATE
);
desc employees;

CREATE TABLE orders_8 (
  orderid INT PRIMARY KEY,
  customerid INT,
  employeeid INT,
  orderdate DATE,
  shipperid INT,
  CONSTRAINT fk_customer FOREIGN KEY (customerid) REFERENCES customers(customerid),
  CONSTRAINT fk_employee FOREIGN KEY (employeeid) REFERENCES employees(employeeid)
);
desc orders_8;

insert into customers values(1, 'Alice Johnson', '123-456-7890', '123 Elm St', 'Los Angeles', '10001', 'USA');
insert into customers values(2, 'Bob Smith', '234-567-8901', '454 Oak St', 'Los Angeles', '90001', 'USA');
insert into customers values(3, 'Charlie Brown', '345-678-9012', '789 Pine St', 'Los Angeles', 'EC1A 1BB', 'USA');
insert into customers values(4, 'Diana Prince', '456-789-0123', '321 Maple St', 'Paris', '75001', 'France');
insert into customers values(5, 'Evan Davis', '567-890-1234', '654 Cedar St', 'Los Angeles', '10115', 'USA');
select * from customers;
 
insert into employees values(1, 'Adams', 'Mike', TO_DATE('1990-07-15', 'YYYY-MM-DD'));
insert into employees values(4, 'Clark', 'Anna', TO_DATE('1985-09-30', 'YYYY-MM-DD'));
insert into employees values(2, 'Morgan', 'Sally', TO_DATE('1982-11-10', 'YYYY-MM-DD'));
insert into employees values(3, 'Bryant', 'David', TO_DATE('1978-01-05', 'YYYY-MM-DD'));
select * from employees;

insert into orders_8 values(1, 1, 1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 2);
insert into orders_8 values(2, 2, 2, TO_DATE('2023-02-15', 'YYYY-MM-DD'), 2);
insert into orders_8 values(3, 3, 3, TO_DATE('2023-03-20', 'YYYY-MM-DD'), 1);
insert into orders_8 values(4, 1, 4, TO_DATE('2023-04-10', 'YYYY-MM-DD'), 3);
insert into orders_8 values(5, 1, 2, TO_DATE('2023-05-05', 'YYYY-MM-DD'), 1);

select * from orders_8;

--1 Query 1: Select all customers ordered by name 
SELECT * FROM Customers ORDER BY CustomerName ASC;
    
-- Query 2: Select all employees ordered by birthdate descending
SELECT * FROM Orders_8 ORDER BY OrderDate ASC;
 
-- Query 3: Employees born after January 1, 1980, ordered by birthdate descending
SELECT * FROM employees 
WHERE birthdate > TO_DATE('1980-01-01', 'YYYY-MM-DD') 
ORDER BY birthdate DESC;  

-- Query 4: 
SELECT o.* FROM orders_8 o JOIN Customers c ON o.CustomerID = c.CustomerID WHERE c.Country = 'USA' ORDER BY o.OrderDate DESC;

-- Query 5: Customer orders count
SELECT CustomerID, COUNT(*) AS TotalOrders FROM orders_8 GROUP BY CustomerID;

-- Query 6: Total customers per city
SELECT city, COUNT(customerid) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

-- Query 7: Customer order count with join and order by order count descending
SELECT c.customerid, c.customername, COUNT(o.orderid) AS total_orders
FROM customers c
JOIN orders_8 o ON c.customerid = o.customerid
GROUP BY c.customerid, c.customername
HAVING COUNT(o.orderid) > 2;


-- Query 8
SELECT city, COUNT(customerid) AS totalcustomers
FROM customers
GROUP BY city
HAVING COUNT(customerid) > 3
ORDER BY totalcustomers DESC; 
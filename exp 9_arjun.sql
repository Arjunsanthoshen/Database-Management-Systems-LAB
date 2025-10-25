create table items (
    itemid number primary key,
    itemname varchar(50),
    category varchar(50),
    price int,
    instock int
);

create table customers (
    custid int primary key,
    custname varchar(50),
    address varchar(30),
    state varchar(30)
);

create table Orders_8 (
    orderid int primary key,
    itemid int,
    custid int,
    quantity int,
    orderdate date,
    foreign key (itemid) references items(itemid),
    foreign key (custid) references customers(custid)
);

create table delivery (
    deliveryid int primary key,
    custid int,
    orderid int,
    foreign key (custid) references customers(custid),
    foreign key (orderid) references Orders_8(orderid)
);


insert into items values (101, 'iphone 15', 'mobile', 1000, 10);
insert into items values (102, 'macbook pro', 'laptop', 3500, 5);
insert into items values (103, 'lenovo', 'laptop', 6000, 2); 
insert into items values (104, 'samsung GalaxyS4', 'mobile', 2000, 15); 
insert into items values (105, 'ps5', 'console', 7500, 7);
select * from items;

insert into customers values (1, 'arjun', 'Thalassery', 'kerala');
insert into customers values (2, 'smith', 'choondacherry', 'kerala');
insert into customers values (3, 'joel', 'Changanassery', 'kerala');
insert into customers values (4, 'melbin',  'Kolkata', 'west bengal');
insert into customers values (5, 'elvin', 'Bengaluru', 'karnataka');
select * from customers;

insert into orders_8 values (201, 101, 1, 1, TO_DATE('2012-12-15', 'YYYY-MM-DD'));
insert into orders_8 values (202, 102, 2, 1, TO_DATE('2015-06-14', 'YYYY-MM-DD'));
insert into orders_8 values (203, 103, 3, 1, TO_DATE('2016-01-10', 'YYYY-MM-DD'));
insert into orders_8 values (204, 104, 1, 1, TO_DATE('2020-09-09', 'YYYY-MM-DD'));
insert into orders_8 values (205, 104, 5, 1, TO_DATE('2021-01-01', 'YYYY-MM-DD')); 
insert into orders_8 values (206, 105, 4, 1, TO_DATE('2022-05-01', 'YYYY-MM-DD'));
select * from orders_8;

insert into delivery values (301, 2, 202);
insert into delivery values (302, 3, 203);
insert into delivery values (303, 1, 204);
insert into delivery values (304, 1, 201); 
insert into delivery values (305, 5, 205);
select * from delivery;

--1
SELECT * FROM customers c JOIN orders_8 o ON c.custid = o.custid;

--2
SELECT  * FROM customers c JOIN delivery d ON c.custid = d.custid;  

--3
SELECT c.custname, o.orderdate FROM customers c JOIN orders_8 o ON c.custid = o.custid WHERE LOWER(c.custname) LIKE 's%';

--4
SELECT c.custname,i.itemname, i.price FROM items i JOIN orders_8 o ON i.itemid = o.itemid
JOIN customers c ON c.custid = o.custid  WHERE LOWER(c.custname) = 'elvin';

--5
SELECT DISTINCT c.*,o.orderid
FROM customers c
JOIN orders_8 o ON c.custid = o.custid
WHERE o.orderdate > TO_DATE('2013-01-01', 'YYYY-MM-DD')
AND o.orderid NOT IN (SELECT orderid FROM delivery);

--6
SELECT itemid FROM orders_8
UNION
SELECT o.itemid
FROM orders_8 o
LEFT JOIN delivery d ON o.orderid = d.orderid
where d.orderId is null ;

--7
SELECT DISTINCT c.custname
FROM Customers c
JOIN Orders_8 o ON c.custid = o.custid
JOIN Delivery d ON o.orderid = d.orderid;

--8
SELECT c.custname
FROM Customers c
JOIN Orders_8 o ON c.custid = o.custid
MINUS
SELECT c.custname
FROM Customers c
JOIN Orders_8 o ON c.custid = o.custid
JOIN Delivery d ON o.orderid = d.orderid;

--9
SELECT custname
FROM (
  SELECT c.custname, COUNT(*) AS order_count
  FROM Customers c
  JOIN Orders_8 o ON c.custid = o.custid
  GROUP BY c.custname
  ORDER BY order_count DESC
)
WHERE ROWNUM = 1;

--10
SELECT c.*
FROM Customers c
JOIN Orders_8 o ON c.custid = o.custid
JOIN Items i ON o.itemid = i.itemid
GROUP BY c.custid, c.custname, c.address, c.state
HAVING SUM(i.price * o.quantity) > 5000;

--11
SELECT custname, address
FROM Customers
WHERE custid NOT IN (
  SELECT custid FROM Orders_8
  WHERE itemid = (SELECT itemid FROM Items WHERE itemname = 'Samsung GalaxyS4')
);

--12
SELECT c.custid, c.custname, o.orderid, o.orderdate
FROM Customers c
LEFT JOIN Orders_8 o ON c.custid = o.custid;

SELECT c.custid, c.custname, o.orderid, o.orderdate
FROM Customers c
RIGHT JOIN Orders_8 o ON c.custid = o.custid;
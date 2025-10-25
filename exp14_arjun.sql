SET SERVEROUTPUT ON;

--1
CREATE OR REPLACE FUNCTION factorial(n IN NUMBER)
RETURN NUMBER
AS
    fact NUMBER := 1;
BEGIN
    FOR i IN 1..n LOOP
        fact := fact * i;
    END LOOP;
    RETURN fact;
END;
/
 
DECLARE
    num NUMBER;
    result NUMBER;
BEGIN
    num := &num;
    result := factorial(num);

    DBMS_OUTPUT.PUT_LINE('Factorial of ' || num || ' is: ' || result);
END;
/

--2
create table student_details(roll int,marks int,phone int);
INSERT INTO student_details (roll, marks, phone) VALUES (1, 30, 8989899);
INSERT INTO student_details (roll, marks, phone) VALUES (2, 20, 34343439);
INSERT INTO student_details (roll, marks, phone) VALUES (3, 50, 355539);
INSERT INTO student_details (roll, marks, phone) VALUES (4, 30, 67686899);
select * from student_details;

CREATE OR REPLACE PROCEDURE pr1 AS
BEGIN
    UPDATE student_details SET marks = marks + (marks * 0.05);
END;
/

BEGIN
  pr1;
END;
/
select * from student_details;

--3
CREATE TABLE mystudent (
    id INT PRIMARY KEY,
    name VARCHAR2(50),
    m1 INT,
    m2 INT,
    m3 INT,
    total INT,
    grade CHAR(1)
);
/

CREATE OR REPLACE FUNCTION f1(total_marks INT) 
RETURN VARCHAR2 
AS
    grade VARCHAR2(1);
BEGIN
    IF total_marks >= 240 THEN
        grade := 'A';
    ELSIF total_marks >= 180 THEN
        grade := 'B';
    ELSIF total_marks >= 120 THEN
        grade := 'C';
    ELSIF total_marks >= 60 THEN
        grade := 'D';
    ELSE
        grade := 'F';
    END IF;
    RETURN grade;
END;
/
 
CREATE OR REPLACE PROCEDURE p1(stu_id INT) AS
    v_total INT;
    v_grade VARCHAR2(1);
BEGIN
    SELECT m1 + m2 + m3 INTO v_total FROM mystudent WHERE id = stu_id;
    v_grade := f1(v_total);
    UPDATE mystudent
    SET total = v_total,
        grade = v_grade
    WHERE id = stu_id;
    COMMIT;
END;
/

DECLARE 
    v_id NUMBER := &id;
    v_name VARCHAR2(50) := '&name';
    v_m1 NUMBER := &m1;
    v_m2 NUMBER := &m2;
    v_m3 NUMBER := &m3;
BEGIN
    INSERT INTO mystudent(id, name, m1, m2, m3) VALUES(v_id, v_name, v_m1, v_m2, v_m3);
    p1(v_id);
    dbms_output.put_line('Student record inserted and grade updated successfully.');
END;
/

select * from mystudent;

--TRIGGERS


CREATE TABLE customer_details (
    cust_id INT PRIMARY KEY,
    cust_name VARCHAR2(50),
    address VARCHAR2(100)
);

CREATE TABLE emp_details (
    empid INT PRIMARY KEY,
    empname VARCHAR2(50),
    salary NUMBER
);

CREATE TABLE cust_count (count_row INT);
insert into cust_count values(0);
commit

--1
CREATE OR REPLACE TRIGGER trg_insert_customer
AFTER INSERT ON customer_details
FOR EACH ROW
BEGIN
     DBMS_OUTPUT.PUT_LINE('New customer joined with id : ' || :NEW.cust_id);
END;
/

insert into customer_details values(1,'arjun','Thalassery');

--2

CREATE OR REPLACE TRIGGER trg_check_salary
BEFORE INSERT OR UPDATE ON emp_details
FOR EACH ROW
BEGIN
    IF :NEW.salary > 20000 THEN
        DBMS_OUTPUT.PUT_LINE('warning : entered value ' || :NEW.salary || ' >20000');
    END IF;
END;
/

insert into emp_details values(1,'arjun','30000');

select * from emp_details;

--3

CREATE OR REPLACE TRIGGER trg_cust_count_modify
AFTER INSERT OR DELETE ON customer_details
FOR EACH ROW
BEGIN
  IF INSERTING THEN
    UPDATE cust_count SET count_row = count_row + 1;
  ELSIF DELETING THEN
    UPDATE cust_count SET count_row = count_row - 1;
  END IF;
END;
/


SELECT * FROM cust_count;

INSERT INTO customer_details (cust_id, cust_name, address) VALUES (1, 'Arjun', 'Thalassery');
INSERT INTO customer_details (cust_id, cust_name, address) VALUES (2, 'Doraemon', 'japan');

select * from customer_details;

DELETE FROM customer_details WHERE cust_id = 1;
SELECT * FROM cust_count;

--4

CREATE TABLE deleted_emp (
    empid INT,
    empname VARCHAR2(50),
    salary NUMBER,
    deleted_on DATE
);

CREATE TABLE updated_emp (
    empid INT,
    old_salary NUMBER,
    new_salary NUMBER,
    updated_on DATE
);

CREATE OR REPLACE TRIGGER trg_emp_changes
AFTER DELETE OR UPDATE ON emp_details
FOR EACH ROW
BEGIN
  IF DELETING THEN
    INSERT INTO deleted_emp(empid, empname, salary, deleted_on)
    VALUES (:OLD.empid, :OLD.empname, :OLD.salary, SYSDATE);
  ELSIF UPDATING THEN
    INSERT INTO updated_emp(empid, old_salary, new_salary, updated_on)
    VALUES (:OLD.empid, :OLD.salary, :NEW.salary, SYSDATE);
  END IF;
END;
/


INSERT INTO emp_details (empid, empname, salary) VALUES (2, 'Bob', 6000);
SELECT * FROM emp_details;

UPDATE emp_details SET salary = 7000 WHERE empid = 2;
COMMIT;

DELETE FROM emp_details WHERE empid = 1;
COMMIT;

SELECT * FROM deleted_emp;
SELECT * FROM updated_emp;
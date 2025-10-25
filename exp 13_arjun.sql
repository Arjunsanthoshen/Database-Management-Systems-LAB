SET SERVEROUTPUT ON;

--1
declare 
  f number:=1;
  i number :=1;
  n number;
begin
  n:= &n;
  while i<=n loop
    f:= f*i ;
    i:=i+1;
  end loop;
  dbms_output.put_line('Factorial of ' || n || ' = ' || f);
end;
/

--2
DECLARE
  a NUMBER := 10;
  b NUMBER := 30;
  c NUMBER := 20;
  greatest NUMBER;
BEGIN
  IF a >= b AND a >= c THEN
    greatest := a;
  ELSIF b >= a AND b >= c THEN
    greatest := b;
  ELSE
    greatest := c;
  END IF;
  dbms_output.put_line('Greatest number is: ' || greatest);
END;
/

--3
DECLARE
  a NUMBER := &a;
  b NUMBER := &b;
  operator CHAR := '&operator';
  result NUMBER;
BEGIN
  CASE operator
    WHEN '+' THEN
      result := a + b;
    WHEN '-' THEN
      result := a - b;
    WHEN '*' THEN
      result := a * b;
    WHEN '/' THEN
      IF b = 0 THEN
        dbms_output.put_line('Error: Division by zero is not allowed.');
      ELSE
        result := a / b;
      END IF;
  END CASE;
    dbms_output.put_line(a || ' ' || operator || ' ' || b || ' = ' || result);
END;
/

--4
DECLARE
  n NUMBER := &n; 
  first NUMBER := 0;
  second NUMBER := 1;
  next NUMBER;
BEGIN
  IF n <= 0 THEN
    dbms_output.put_line('Please enter a positive number');
  ELSE
    dbms_output.put_line('Fibonacci Series for ' || n || ':');
    WHILE n > 0 LOOP
      dbms_output.put_line(first);
      next := first + second;
      first := second;
      second := next;
      n := n - 1;
      --i := i + 1;
    END LOOP;
  END IF;
END;
/

--5
DECLARE
  a NUMBER := &a;
  b NUMBER := &b;
  result NUMBER;
BEGIN
  result := a / b;
  dbms_output.put_line('Result: ' || result);

EXCEPTION
  WHEN ZERO_DIVIDE THEN
    dbms_output.put_line('Error: Division by zero exception caught.');
END;
/

--6
DECLARE
  v_emp_name VARCHAR2(100);
  v_emp_id NUMBER := &emp_id;
BEGIN
  SELECT employee_name INTO v_emp_name
  FROM employees
  WHERE employee_id = v_emp_id;
  
  dbms_output.put_line('Employee Name: ' || v_emp_name);

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('Error: No data found for employee id ' || v_emp_id);
END;
/


CREATE OR REPLACE PACKAGE Mypk1 AS
    PROCEDURE proc1(a IN NUMBER, b IN NUMBER, sum OUT NUMBER, avg OUT NUMBER, prod OUT NUMBER);
    PROCEDURE proc2(num IN NUMBER, result OUT NUMBER);
    FUNCTION fn11(num IN NUMBER) RETURN VARCHAR2;
    FUNCTION fn22(a IN NUMBER, b IN NUMBER, c IN NUMBER) RETURN NUMBER;
END Mypk1;
/

CREATE OR REPLACE PACKAGE BODY Mypk1 AS
    PROCEDURE proc1(a IN NUMBER, b IN NUMBER, sum OUT NUMBER, avg OUT NUMBER, prod OUT NUMBER) IS
    BEGIN
        sum := a + b;
        avg := (a + b) / 2;
        prod := a * b;
    END proc1;

    PROCEDURE proc2(num IN NUMBER, result OUT NUMBER) IS
    BEGIN
        result := SQRT(num);
    END proc2;

    FUNCTION fn11(num IN NUMBER) 
    RETURN VARCHAR2 IS
    BEGIN
        IF MOD(num, 2) = 0 THEN
            RETURN 'Even';
        ELSE
            RETURN 'Odd';
        END IF;
    END fn11;

    FUNCTION fn22(a IN NUMBER, b IN NUMBER, c IN NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN a + b + c;
    END fn22;

END Mypk1;
/

SET SERVEROUTPUT ON;

DECLARE
    a NUMBER;
    b NUMBER;
    s NUMBER;
    av NUMBER;
    p NUMBER;
    num NUMBER;
    res_even VARCHAR2(10);
    total NUMBER;
BEGIN    
    a := &first_number_for_addition;
    b := &second_number_for_addition;
    Mypk1.proc1(a, b, s, av, p); -- Sum, average, and product
    DBMS_OUTPUT.PUT_LINE('Sum = ' || s);
    DBMS_OUTPUT.PUT_LINE('Average = ' || av);
    DBMS_OUTPUT.PUT_LINE('Product = ' || p);
   
    num := &number_for_square_root;  
    Mypk1.proc2(num, p); -- Square root
    DBMS_OUTPUT.PUT_LINE('Square root of ' || num || ' = ' || p);
    
    num := &number_to_check_even_odd;
    res_even := Mypk1.fn11(num);  -- Even or Odd
    DBMS_OUTPUT.PUT_LINE('The number ' || num || ' is ' || res_even);

    a := &first_number_for_sum3;
    b := &second_number_for_sum3;
    num := &third_number_for_sum3;
    total := Mypk1.fn22(a, b, num); -- Sum of three numbers
    DBMS_OUTPUT.PUT_LINE('Sum of three numbers = ' || total);
END;
/
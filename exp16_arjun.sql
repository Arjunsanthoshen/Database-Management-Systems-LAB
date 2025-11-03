--1
CREATE TABLE bank_details (
    accno NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    balance NUMBER,
    adate DATE
);

CREATE TABLE bank_interest (
    accno NUMBER PRIMARY KEY,
    interest NUMBER
);

INSERT INTO bank_details VALUES (1001, 'Aby', 3005, TO_DATE('10-OCT-2015', 'DD-MON-YYYY'));
INSERT INTO bank_details VALUES (1002, 'Alan', 4000, TO_DATE('05-MAY-1995', 'DD-MON-YYYY'));
INSERT INTO bank_details VALUES (1003, 'Amal', 5000, TO_DATE('16-MAR-1992', 'DD-MON-YYYY'));
INSERT INTO bank_details VALUES (2020, 'Ben', 7000, TO_DATE('12-JAN-2020', 'DD-MON-YYYY'));
INSERT INTO bank_details VALUES (2021, 'Cara', 6500, TO_DATE('23-FEB-2023', 'DD-MON-YYYY'));
INSERT INTO bank_details VALUES (2022, 'Derek', 8200, TO_DATE('15-MAY-2025', 'DD-MON-YYYY'));
INSERT INTO bank_details VALUES (2023, 'Eva', 5400, TO_DATE('30-JUL-2023', 'DD-MON-YYYY'));
INSERT INTO bank_details VALUES (2024, 'Finn', 4800, TO_DATE('08-APR-2020', 'DD-MON-YYYY'));
INSERT INTO bank_details VALUES (2025, 'Grace', 9100, TO_DATE('19-SEP-2025', 'DD-MON-YYYY'));
INSERT INTO bank_details VALUES (2026, 'Hank', 7300, TO_DATE('27-NOV-2023', 'DD-MON-YYYY'));
COMMIT;

--PL/SQL block using cursor
DECLARE
    CURSOR bank_cur IS SELECT accno, balance FROM bank_details;
    v_accno bank_details.accno%TYPE; -- Variable to hold account number of same datatype as accno column
    v_balance bank_details.balance%TYPE;
    v_interest NUMBER; -- no %type since its calculated
BEGIN
    OPEN bank_cur;
    LOOP
        FETCH bank_cur INTO v_accno, v_balance;
        EXIT WHEN bank_cur%NOTFOUND;
       
        v_interest := 0.08 * v_balance;
       
        INSERT INTO bank_interest (accno, interest) VALUES (v_accno, v_interest);
    END LOOP;
    CLOSE bank_cur;
    COMMIT;
END;
/

SELECT * FROM bank_interest;

------ 2

CREATE TABLE students1 (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    m1 NUMBER,
    m2 NUMBER,
    m3 NUMBER,
    total NUMBER,
    grade VARCHAR2(5)
);

INSERT INTO students1 VALUES (1, 'Aby', 95, 92, 90, NULL, NULL);
INSERT INTO students1 VALUES (2, 'Ben', 85, 80, 83, NULL, NULL);
INSERT INTO students1 VALUES (3, 'Cara', 78, 82, 79, NULL, NULL);
INSERT INTO students1 VALUES (4, 'Derek', 67, 70, 65, NULL, NULL);
INSERT INTO students1 VALUES (5, 'Eva', 55, 58, 60, NULL, NULL);
COMMIT;

SELECT * FROM students1;

-- PL/SQL block using CURSOR
DECLARE
    CURSOR stu_cur IS SELECT id, m1, m2, m3 FROM students1;
    v_id students1.id%TYPE;
    v_m1 students1.m1%TYPE;
    v_m2 students1.m2%TYPE;
    v_m3 students1.m3%TYPE;
    v_total NUMBER;
    v_avg NUMBER;
    v_grade VARCHAR2(5);
BEGIN
    OPEN stu_cur;
    LOOP
        FETCH stu_cur INTO v_id, v_m1, v_m2, v_m3;
        EXIT WHEN stu_cur%NOTFOUND;

        -- Calculate total and average
        v_total := v_m1 + v_m2 + v_m3;
        v_avg := v_total / 3;

        -- Determine grade
        IF v_avg >= 90 THEN
            v_grade := 'S';
        ELSIF v_avg >= 80 THEN
            v_grade := 'A+';
        ELSIF v_avg >= 70 THEN
            v_grade := 'A';
        ELSIF v_avg >= 60 THEN
            v_grade := 'B';
        ELSIF v_avg >= 50 THEN
            v_grade := 'C';
        ELSE
            v_grade := 'F';
        END IF;

        -- Update total and grade
        UPDATE students1 SET total = v_total, grade = v_grade WHERE id = v_id;

    END LOOP;
    CLOSE stu_cur;
    COMMIT;
END;
/

SELECT * FROM STUDENTS1;


--  3 
CREATE TABLE people_list (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    dt_joining DATE,
    place VARCHAR2(50)
);

CREATE TABLE exp_list (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    experience NUMBER
);

INSERT INTO people_list VALUES (1, 'Aby', TO_DATE('15-MAR-2010', 'DD-MON-YYYY'), 'Kochi');
INSERT INTO people_list VALUES (2, 'Ben', TO_DATE('12-DEC-2015', 'DD-MON-YYYY'), 'Chennai');
INSERT INTO people_list VALUES (3, 'Cara', TO_DATE('25-JAN-2008', 'DD-MON-YYYY'), 'Delhi');
INSERT INTO people_list VALUES (4, 'Derek', TO_DATE('05-FEB-2020', 'DD-MON-YYYY'), 'Mumbai');
INSERT INTO people_list VALUES (5, 'Eva', TO_DATE('01-JUN-2009', 'DD-MON-YYYY'), 'Bangalore');
COMMIT;

--PL/SQL block using CURSOR to calculate experience and insert into exp_list
DECLARE
    CURSOR people_cur IS SELECT id, name, dt_joining FROM people_list;
    v_id people_list.id%TYPE;
    v_name people_list.name%TYPE;
    v_dt_joining people_list.dt_joining%TYPE;
    v_experience NUMBER;
BEGIN
    OPEN people_cur;
    LOOP
        FETCH people_cur INTO v_id, v_name, v_dt_joining;
        EXIT WHEN people_cur%NOTFOUND;

        -- Calculate experience in years
        v_experience := TRUNC(MONTHS_BETWEEN(SYSDATE, v_dt_joining) / 12);

        IF v_experience > 10 THEN
            INSERT INTO exp_list (id, name, experience) VALUES (v_id, v_name, v_experience);
        END IF;
    END LOOP;
    CLOSE people_cur;
    COMMIT;
END;
/

SELECT * FROM exp_list;



--4

CREATE TABLE employee_list (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    monthly_salary NUMBER
);

INSERT INTO employee_list VALUES (1, 'Aby', 4000); -- Annual 48000 ? 25%
INSERT INTO employee_list VALUES (2, 'Ben', 10000); -- Annual 120000 ? 20%
INSERT INTO employee_list VALUES (3, 'Cara', 25000); -- Annual 300000 ? 15%
INSERT INTO employee_list VALUES (4, 'Derek', 60000); -- Annual 720000 ? 10%
INSERT INTO employee_list VALUES (5, 'Eva', 15000); -- Annual 180000 ? 20%
COMMIT;

--  PL/SQL block using CURSOR
DECLARE
    CURSOR emp_cur IS SELECT id, monthly_salary FROM employee_list;
    v_id employee_list.id%TYPE;
    v_salary employee_list.monthly_salary%TYPE;
    v_annual NUMBER;
    v_new_salary NUMBER;
BEGIN
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO v_id, v_salary;
        EXIT WHEN emp_cur%NOTFOUND;

        -- Calculate annual salary
        v_annual := v_salary * 12;

        -- Apply increment based on annual salary
        IF v_annual < 60000 THEN
            v_new_salary := v_salary + (v_salary * 0.25);
        ELSIF v_annual >= 60000 AND v_annual <= 200000 THEN
            v_new_salary := v_salary + (v_salary * 0.20);
        ELSIF v_annual > 200000 AND v_annual <= 500000 THEN
            v_new_salary := v_salary + (v_salary * 0.15);
        ELSE
            v_new_salary := v_salary + (v_salary * 0.10);
        END IF;

        -- Update monthly salary
        UPDATE employee_list SET monthly_salary = v_new_salary WHERE id = v_id;
    END LOOP;
    CLOSE emp_cur;
    COMMIT;
END;
/

SELECT * FROM employee_list;
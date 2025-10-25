    --step 1    
CREATE TABLE bank (
    bankname VARCHAR2(50),
    headoffice VARCHAR2(50),
    branch VARCHAR2(50),
    branchcode VARCHAR2(10) PRIMARY KEY
);

--step 2

INSERT INTO bank VALUES ('SBI', 'Mumbai', 'Kochi', 'B001');
INSERT INTO bank VALUES ('SBI', 'Mumbai', 'Chennai', 'B002');
INSERT INTO bank VALUES ('HDFC', 'Mumbai', 'Bengaluru', 'B003');
savepoint sp1;

--step 3
INSERT INTO bank VALUES ('ICICI', 'Mumbai', 'Delhi', 'B004');
select * from bank;
Savepoint sp2;

--step 4
update bank set branch = 'Hyderabad' where Branchcode = 'B004'; 
DELETE FROM bank WHERE branchcode = 'B003';
select * from bank;

--step 5
ROLLBACK TO sp2;
SELECT * FROM bank;

ROLLBACK TO sp1;
SELECT * FROM bank;

--step 6
COMMIT;
ROLLBACK to sp2;
SELECT * FROM bank;
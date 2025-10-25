--step 1    
CREATE TABLE bank1 (
    bankname VARCHAR2(50),
    headoffice VARCHAR2(50),
    branch VARCHAR2(50),
    branchcode VARCHAR2(10) PRIMARY KEY
);

--step 2

INSERT INTO bank1 VALUES ('SBI', 'Mumbai', 'Kochi', 'B001');
INSERT INTO bank1 VALUES ('SBI', 'Mumbai', 'Chennai', 'B002');
INSERT INTO bank1 VALUES ('HDFC', 'Mumbai', 'Bengaluru', 'B003');
INSERT INTO bank1 VALUES ('ICICI', 'Mumbai', 'Delhi', 'B004');
INSERT INTO bank1 VALUES ('yes bank', 'Thalassery', 'kerala', 'B005');
select * from bank1;

--GRANT
Grant select on Bank1 to c23csb18;
select * from c23csb18.Bank1;

--REVOKE
Revoke select on Bank1 from c23csb18;  
select * from c23csb18.Bank1; 
show databases;
use testdb;
CREATE TABLE dept (
    deptno int PRIMARY KEY,
    dname  VARCHAR(20),
    loc    VARCHAR(20)
);
INSERT INTO dept VALUES (10, 'HR', 'Delhi');
INSERT INTO dept VALUES (20, 'IT', 'Mumbai');
rename table dept to department;
alter table department
add column PINCODE int not null default 0;
alter table department
rename column dname to dept_name;
alter table department
modify loc char(10);
SELECT * FROM department;
drop table department;

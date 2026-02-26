SHOW DATABASES;
USE employees;

-- 1️⃣ Create DEPARTMENT table FIRST
CREATE TABLE DEPARTMENT (
    DNO INT PRIMARY KEY,
    Dname VARCHAR(20),
    Mgrstartdate INT,
    MgrSSN INT
);

-- 2️⃣ Insert department data
INSERT INTO DEPARTMENT VALUES (1, 'HR', 2020, 101);
INSERT INTO DEPARTMENT VALUES (2, 'Finance', 2021, 102);
INSERT INTO DEPARTMENT VALUES (3, 'IT', 2019, 103);
INSERT INTO DEPARTMENT VALUES (4, 'Marketing', 2022, 104);

-- 3️⃣ Create employee2 table AFTER department
CREATE TABLE employee2 (
    Fname VARCHAR(20),
    LName VARCHAR(20),
    SSN INT PRIMARY KEY,
    Address VARCHAR(20),
    sex CHAR(1),
    salary INT,
    superSSN INT,
    DNO INT,
    FOREIGN KEY (DNO) REFERENCES DEPARTMENT(DNO)
);

-- 4️⃣ Insert employee data
INSERT INTO employee2 
(Fname, LName, SSN, Address, sex, salary, superSSN, DNO)
VALUES 
('Amit', 'Shrestha', 115, 'Chitwan', 'M', 48000, 113, 4);
INSERT INTO employee2 
(Fname, LName, SSN, Address, sex, salary, superSSN, DNO)
VALUES 
('Ram', 'Thapa', 117, 'Pokhara', 'M', 55000, 115, 1),
('Gita', 'Rai', 118, 'Lalitpur', 'F', 47000, 117, 2),
('Hari', 'Gurung', 119, 'Bhaktapur', 'M', 60000, 117, 3),
('Nita', 'Sharma', 120, 'Biratnagar', 'F', 52000, 118, 5);

-- 5️⃣ Query with corrected department name (Marketing instead of research)
SELECT E.Fname, E.LName,
E.salary * 1.10 AS increased_salary
FROM employee2 E
JOIN DEPARTMENT D 
ON E.DNO = D.DNO
WHERE D.Dname = 'Marketing';

-- 6️⃣ Aggregate query (Corrected department name)
SELECT SUM(E.salary) AS total_salary,
       MAX(E.salary) AS max_salary,
       MIN(E.salary) AS min_salary,
       AVG(E.salary) AS avg_salary
FROM employee2 E
JOIN DEPARTMENT D 
ON E.DNO = D.DNO
WHERE D.Dname = 'HR';

-- 7️⃣ Select employees by existing department
SELECT Fname, LName 
FROM employee2
WHERE DNO = 4;
SELECT Fname,Lname from employee2 employees
WHERE exists(SELECT 1 FROM employee2 employees
where e.DNO=4 and E.SSN=e.SSN);

SELECT D.DNO, 
       D.Dname, 
       COUNT(E.SSN) AS total_employees
FROM DEPARTMENT D
JOIN employee2 E
ON D.DNO = E.DNO
GROUP BY D.DNO, D.Dname
HAVING COUNT(E.SSN) >= 2;

ALTER TABLE employee2
ADD DOB DATE;
UPDATE employee2 
SET DOB = '1995-06-15'
WHERE SSN = 115;

UPDATE employee2 
SET DOB = '1992-03-10'
WHERE SSN = 116;

UPDATE employee2 
SET DOB = '1988-01-20'
WHERE SSN = 117;

SELECT Fname, LName, DOB
FROM employee2
WHERE DOB BETWEEN '1990-01-01' AND '1999-12-31';
SELECT E.Fname, 
       E.LName, 
       D.Dname AS Department_Name
FROM employee2 E
JOIN DEPARTMENT D
ON E.DNO = D.DNO;


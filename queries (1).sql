-- 1. Create employee table
CREATE TABLE employee(
    EmployeeID VARCHAR2(20) PRIMARY KEY,
    FirstName VARCHAR2(20),
    LastName VARCHAR2(20),
    Gender CHAR(1),
    DateofBirth DATE,
    Designation VARCHAR2(50),
    DepartmentName VARCHAR2(20),
    ManagerId VARCHAR2(20),
    JoinedDate DATE,
    Salary NUMBER(10)
);

-- 2. Insert employee records
INSERT INTO employee VALUES(
'0012','Season','Maharjan','M',
TO_DATE('1996-04-02','YYYY-MM-DD'),
'Engineer',
'Software Management',
'0005',
TO_DATE('2022-04-02','YYYY-MM-DD'),
5000000
);

INSERT INTO employee VALUES(
'0011','Ramesh','Rai','M',
TO_DATE('2000-04-02','YYYY-MM-DD'),
'Manager',
'Software Management',
'0003',
TO_DATE('2022-04-02','YYYY-MM-DD'),
1000000
);

-- 3. Display all employees
SELECT * FROM employee;

-- 4. Update the gender of an employee
UPDATE employee
SET Gender = 'M'
WHERE EmployeeID = '003';

-- 5. Display first name, current date, date of birth, and age (>25)
SELECT FirstName,
SYSDATE AS CurrentDate,
DateofBirth,
FLOOR(MONTHS_BETWEEN(SYSDATE, DateofBirth)/12) AS Age
FROM employee
WHERE FLOOR(MONTHS_BETWEEN(SYSDATE, DateofBirth)/12) > 25;

-- 6. Find the oldest employee
SELECT *
FROM employee
WHERE DateofBirth = (
    SELECT MIN(DateofBirth)
    FROM employee
);

-- 7. Find the youngest employee
SELECT *
FROM employee
WHERE DateofBirth = (
    SELECT MAX(DateofBirth)
    FROM employee
);

-- 8. Display maximum salary department-wise
SELECT DepartmentName, MAX(Salary) AS MaxSalary
FROM employee
GROUP BY DepartmentName;

-- 9. List employees who act as managers
SELECT FirstName
FROM employee
WHERE EmployeeID IN (
    SELECT ManagerID
    FROM employee
);

-- 10. Display most recently joined employee
SELECT *
FROM employee
WHERE JoinedDate = (
    SELECT MAX(JoinedDate)
    FROM employee
);

-- 11. Employees whose first name ends with 's'
SELECT *
FROM employee
WHERE FirstName LIKE '%s';

-- 12. Employees whose first name ends with 'n'
SELECT *
FROM employee
WHERE FirstName LIKE '%n';

-- 13. Employees whose first name starts with 's' and ends with 'n'
SELECT *
FROM employee
WHERE FirstName LIKE 's%n';
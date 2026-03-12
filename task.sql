create database TechSolutionDB;
Use TechSolutionDB;
CREATE table Department(
 DeptIDINT int PRIMARY KEY,
 DeptName varchar(20),
 location varchar(20)
);

DROP TABLE Employee;

CREATE TABLE Employee(
EmpID INT PRIMARY KEY,
FirstName VARCHAR(20),
LastName VARCHAR(20),
Gender CHAR(1),
Salary decimal(10,2),
HireDate DATE,
DeptIDINT INT,
FOREIGN KEY (DeptIDINT) REFERENCES Department(DeptIDINT)
);
DROP TABLE Project;

CREATE TABLE Project(
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(20),
    StartDate DATE,
    EndDate DATE,
    Budget INT
);
create table works_on(
EmpID int,
projectid int,
Hoursworked int,
 PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);
INSERT INTO Department VALUES
(1,'IT','New York'),
(2,'HR','London'),
(3,'Finance','Tokyo'),
(4,'Marketing','Paris'),
(5,'Support','Sydney');
INSERT INTO Project VALUES
(101,'WebsiteDev','2024-01-10','2024-06-10',50000),
(102,'MobileApp','2024-02-01','2024-07-01',60000),
(103,'CloudMigration','2024-03-15','2024-09-15',80000),
(104,'SecurityUpgrade','2024-04-01','2024-08-01',40000),
(105,'AIResearch','2024-05-20','2024-12-20',90000);
INSERT INTO Employee VALUES
(1,'John','Smith','M',5000,'2022-01-10',1),
(2,'Emma','Johnson','F',4500,'2021-03-15',2),
(3,'Liam','Brown','M',6000,'2020-07-20',3),
(4,'Olivia','Davis','F',5500,'2023-02-01',4),
(5,'Noah','Wilson','M',4800,'2022-11-05',5);
INSERT INTO Works_On VALUES
(1,101,40),
(2,102,35),
(3,103,50),
(4,104,30),
(5,105,45);
UPDATE Employee
SET Salary = Salary + (Salary * 0.10)
WHERE EmpID = 2;
DELETE FROM Works_On
WHERE ProjectID = 105;
DELETE FROM Project
WHERE ProjectID = 105;
SELECT *
FROM Employee
WHERE Salary > 50000;
SELECT FirstName, LastName, Salary
FROM Employee
ORDER BY Salary DESC;
SELECT *
FROM Employee
WHERE DeptIDINT = 1;
SELECT D.DeptName, COUNT(E.EmpID) AS TotalEmployees
FROM Department D
JOIN Employee E ON D.DeptIDINT = E.DeptIDINT
GROUP BY D.DeptName;
SELECT *
FROM Employee
WHERE HireDate > '2022-01-01';
SELECT E.FirstName, E.LastName, D.DeptName
FROM Employee E
JOIN Department D
ON E.DeptIDINT = D.DeptIDINT;
SELECT E.FirstName, E.LastName, P.ProjectName
FROM Employee E
JOIN Works_On W ON E.EmpID = W.EmpID
JOIN Project P ON W.ProjectID =P.ProjectId;
SELECT DeptIDINT, AVG(Salary) AS AverageSalary
FROM Employee
GROUP BY DeptIDINT;
SELECT D.DeptName, COUNT(E.EmpID) AS TotalEmployees
FROM Department D
JOIN Employee E ON D.DeptIDINT = E.DeptIDINT
GROUP BY D.DeptName
ORDER BY TotalEmployees DESC
LIMIT 1;
SELECT FirstName, LastName, Salary
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);
-- Create a view for high salary employees (salary > 60000)
CREATE VIEW HighSalaryEmployees AS
SELECT EmpID, FirstName, LastName, Salary, DeptIDINT
FROM Employee
WHERE Salary > 6000;
DROP VIEW HighSalaryEmployees;

CREATE INDEX idx_LastName ON Employee(LastName);







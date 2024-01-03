--WITH CTE_Employee as 
--(
--SELECT FirstName, LastName, Gender, Salary,
--COUNT(Gender) OVER (PARTITION by Gender) AS "Total Gender",
--AVG(Salary) OVER (PARTITION BY Gender) as "Average Salary"
--FROM 
--EmployeeDemographics AS Demo 
--Join EmployeeSalary AS Salary
--ON Demo.EmployeeID = Salary.EmployeeID
--WHERE Salary > 45000
--)
--SELECT FirstName, LastName FROM CTE_Employee

-- Temp Table -- Temporary Table
CREATE TABLE #temp_employee (
EmployeeID int, 
JobTitle varchar(50),
Salary int
)

-- Select from a Temp Table - Employee...
SELECT * FROM #temp_employee

-- Delete a row from the #temp table...
DELETE FROM #temp_employee
WHERE EmployeeID = 1

-- Insert into a temp table..
INSERT INTO #temp_employee VALUES
(1001, 'HR', 45000)

INSERT INTO #temp_employee
SELECT * FROM EmployeeSalary

-- Create a temp table for employee_2
DROP TABLE IF EXISTS #Temp_Employee2
CREATE TABLE #Temp_Employee2(
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

--Insert the query into a temp table...
INSERT INTO #Temp_Employee2
SELECT JobTitle, COUNT(JobTitle) AS 'Job Title Count', AVG(Age) AS 'Average Age', AVG(Salary) AS 'Average Salary'
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
ON emp.EmployeeID = sal.EmployeeID
GROUP BY  JobTitle

SELECT * FROM #temp_employee2

-- How to drop/delete a table...
DROP TABLE IF EXISTS EmployeeRecords



-- String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower
DROP TABLE IF EXISTS EmployeeErrors
CREATE TABLE EmployeeErrors 
(
	EmployeeID varchar(50),
	FirstName varchar(50),
	LastName varchar(50)
)

INSERT INTO EmployeeErrors VALUES 
('1001  ', 'Jimbo', 'Halbert'),
('  1002', 'Pamela', 'Beasely'),
('1005', 'TOby', 'Flenderson - Fired')


SELECT * FROM EmployeeErrors


-- Using Trim, LTRIM, RTRIM
SELECT EmployeeID, TRIM(EmployeeID) AS 'IDTRIM' FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) AS 'IDTRIM' FROM EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID) AS 'IDTRIM' FROM EmployeeErrors

-- Using Replace
SELECT LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors

UPDATE EmployeeErrors
SET LastName = 'Flenderson'
WHERE EmployeeID = 1005


SELECT LOWER(LastName) FROM EmployeeErrors

-- Stored procedures...

CREATE PROCEDURE TEST
AS
SELECT * FROM EmployeeDemographics
EXEC TEST

CREATE PROCEDURE Temp_Employee_3 AS
CREATE TABLE #temp_employee_3 (
JobTitle varchar(100),
EmployeesPerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO #temp_employee_3
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary) 
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT * FROM #temp_employee_3

EXEC Temp_Employee_3

-- Subquery in Where
SELECT EmployeeID, JobTitle, Salary FROM EmployeeSalary
WHERE EmployeeID in (SELECT EmployeeID FROM EmployeeDemographics WHERE Age > 30)

SELECT * FROM EmployeeDemographics
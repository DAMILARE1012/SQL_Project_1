SELECT * FROM EmployeeDemographics 
Right Outer Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


SELECT EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary FROM EmployeeDemographics
Right Outer Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT JobTitle, AVG(EmployeeSalary.Salary) AS 'Average Salary' FROM EmployeeSalary
Inner Join EmployeeDemographics
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle


SELECT EmployeeRecords.Name, MAX(Skills_Level) FROM EmployeeRecords
Left Outer Join EmployeeDemographics
ON EmployeeRecords.EmployeeID = EmployeeDemographics.EmployeeID
GROUP BY Name

SELECT EmployeeID, FirstName, LastName FROM EmployeeDemographics
UNION
SELECT EmployeeID, JobTitle, Salary FROM EmployeeSalary

--SELECT FirstName, LastName, Age,
--CASE
--	WHEN Age > 30 THEN 'Old'
--	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
--	ELSE 'Baby'
--END AS 'Category'
--FROM EmployeeDemographics
--ORDER BY Age DESC

--SELECT FirstName, LastName, Age, JobTitle, Salary,
--CASE
--	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * 0.1)
--	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
--	WHEN JobTitle = 'HR' THEN Salary + (Salary * .00001)
--	ELSE Salary + (Salary * 0.03)
--END AS 'New Payment'
--FROM EmployeeDemographics
--JOIN EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--SELECT JobTitle, COUNT(JobTitle) AS 'Job Category' FROM EmployeeDemographics
--JOIN EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
-- WHERE 'Job Category' > 6
--GROUP BY JobTitle
--HAVING COUNT(JobTitle) > 4


SELECT * FROM EmployeeDemographics

UPDATE EmployeeDemographics
SET EmployeeID = 1008
WHERE FirstName = 'Kevin' AND LastName = 'Malone'

SELECT * FROM EmployeeDemographics

SELECT * FROM EmployeeSalary

DELETE FROM EmployeeSalary
WHERE EmployeeID = 1001 AND JobTitle = 'Salesman'

INSERT INTO EmployeeSalary VALUES
(1001, 'Accountant', 45000)


--SELECT JobTitle, COUNT(JobTitle) FROM 
--EmployeeDemographics Inner Join  EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--GROUP BY  JobTitle
--HAVING COUNT(JobTitle) > 1

--SELECT FirstName + ' ' + LastName AS 'Full Name', Age, JobTitle, Salary
--FROM EmployeeDemographics AS Demo
--JOIN EmployeeSalary AS Salary
--ON Demo.EmployeeID = Salary.EmployeeID

--SELECT Demo.EmployeeID, Demo.FirstName, Demo.LastName, Salary.JobTitle, Salary.Salary FROM EmployeeDemographics AS Demo
--Left Outer Join EmployeeSalary AS Salary
--ON Demo.EmployeeID = Salary.EmployeeID
--WHERE JobTitle IS NOT NULL

SELECT * FROM EmployeeDemographics

SELECT * FROM EmployeeSalary
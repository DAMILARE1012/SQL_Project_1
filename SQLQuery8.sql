USE [SQL_Tutorial]
GO
/****** Object:  StoredProcedure [dbo].[Temp_Employee_3]    Script Date: 31/12/2023 13:18:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Temp_Employee_3] 
@JobTitle nvarchar(100)
AS
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
WHERE JobTitle = @JobTitle
GROUP BY JobTitle

SELECT * FROM #temp_employee_3
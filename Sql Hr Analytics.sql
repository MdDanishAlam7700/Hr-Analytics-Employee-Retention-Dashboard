SELECT * FROM hr_1;
SELECT * FROM hr_2;

-- 1.) Average Attrition rate for all Departments
SELECT department,
       CONCAT(ROUND(AVG(CASE WHEN Attrition = 'Yes' THEN 1.0 ELSE 0.0 END) * 100, 2), '%') 
       as Attrition_Rate
FROM hr_1
GROUP BY department;

-- 2.)Average Hourly rate of Male Research Scientist
SELECT CONCAT(FORMAT(AVG(HourlyRate), 2), '%') as AvgHourlyRatePercentage
FROM hr_1 
WHERE Gender = 'Male' AND JobRole = 'Research Scientist';

-- 3.)Attrition rate Vs Monthly income stats
SELECT 
     hr_2.MonthlyIncome,
     CONCAT(FORMAT(AVG(CASE WHEN hr_1.Attrition = 'Yes' THEN 1 ELSE 0 END) * 100, 2), '%') 
     as Attrition_Rate
FROM hr_1 
JOIN hr_2 ON hr_1.EmployeeNumber = hr_2.`Employee ID`
GROUP BY hr_2.MonthlyIncome;

-- 4.) Average working years for each Department
SELECT 
    a.Department,
    AVG(b.TotalWorkingYears) as AverageWorkingYears
FROM hr_1 a
JOIN hr_2 b ON a.EmployeeNumber = b.`Employee ID`
GROUP BY a.Department;

-- 5.) Departmentwise No of Employees
SELECT Department, SUM(EmployeeCount) as Emp_Count
FROM hr_1
GROUP BY Department;

-- 6.) Count of Employees based on Educational Fields
SELECT EducationField , SUM(EmployeeCount) AS Total_Employee
FROM hr_1
GROUP BY EducationField;

-- 7.) Job Role Vs Work life balance
SELECT 
    a.JobRole,
    b.WorkLifeBalance
FROM hr_1 a
JOIN hr_2 b ON a.EmployeeNumber = b.`Employee ID`;

-- 8.) Attrition rate Vs Year since last promotion relation
SELECT 
    CONCAT(FORMAT(AVG(CASE WHEN a.Attrition = 'Yes' THEN 1.0 ELSE 0 END) * 100, 2), '%') 
    as Attrition_Rate,
    b.YearsSinceLastPromotion
FROM hr_1 a
JOIN hr_2 b ON a.EmployeeNumber = b.`Employee ID`
GROUP BY b.YearsSinceLastPromotion;

-- 9.) Gender based Percentage of Employee
SELECT 
    Gender, 
    FORMAT((COUNT(Gender) * 100.0 / (SELECT COUNT(*) FROM hr_1)), 2) 
    as `Employees %`
FROM hr_1
GROUP BY Gender;

-- 10.) Monthly New Hire vs Attrition Trendline
WITH NewHires AS (
    SELECT `Month Of Joining` AS Month,
	COUNT(*) AS NewHires
    FROM hr_2
    GROUP BY  `Month Of Joining`
),
TotalAttritions AS (
    SELECT COUNT(*) AS Attritions
    FROM hr_1
    WHERE Attrition = 'Yes'
)
SELECT n.Month, n.NewHires, a.Attritions
FROM NewHires n
LEFT JOIN TotalAttritions a ON 1=1 
ORDER BY n.Month;

-- 11.)Deptarment / Job Role wise job satisfaction
 SELECT 
    JobRole, 
    AVG(JobSatisfaction) as AverageJobSatisfaction
FROM hr_1
GROUP BY JobRole;




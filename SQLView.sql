USE AdventureWorksDW2019;

select * from DimEmployee
select * from DimDepartmentGroup

-- View serveris
-- Selleks, et saada soovitud tulemus, me peaksime ühendama kaks tabelit omavahel
SELECT EmployeeKey, FirstName, BaseRate, Gender, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup 
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey

-- Nüüd loome view, kus kasutame JOIN-i
CREATE VIEW vWEmployeeByDepartment
AS
SELECT EmployeeKey, FirstName, BaseRate, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey
-- Käivita
SELECT * FROM vWEmployeeByDepartment

-- View, mis tagastab ainult Corporate osakonna töötajad
CREATE VIEW vWCorporateDepartment_Employees
AS
SELECT EmployeeKey, FirstName, BaseRate, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey
WHERE DimDepartmentGroup.DepartmentGroupName = 'Corporate'
-- Käivita
SELECT * FROM vWCorporateDepartment_Employees

-- View, kus ei ole BaseRate veergu
CREATE VIEW vWEmployeesNonConfData
AS
SELECT EmployeeKey, FirstName, Gender, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey
-- Käivita
SELECT * FROM vWEmployeesNonConfData

-- View, mis tagastab summeeritud andmed töötajate koondarvest.
CREATE VIEW vWEmployeesCountByDepartment
AS
SELECT DepartmentName, COUNT(DepartmentGroupKey) AS TotalEmployees
FROM DimEmployee
JOIN DimDepartmentGroup
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey
GROUP BY DepartmentName
-- Käivita
SELECT * FROM vWEmployeesCountByDepartment

-- Kui soovid vaadata view definitsiooni
sp_helptext vWName
-- Kui soovid muuta view-d
ALTER VIEW
-- Kui soovid kustutada view-d 
DROP VIEW vWName

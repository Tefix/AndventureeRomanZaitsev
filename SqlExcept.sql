USE AdventureWorksDW2019;

select * from DimEmployee
select * from DimCustomer

-- Except operaator tagastab unikaalsed read vasakust p�ringust.
SELECT EmployeeKey, FirstName, Gender
FROM DimEmployee
EXCEPT
SELECT CustomerKey, FirstName, Gender
FROM DimCustomer

-- Order by n�uet v�ib kasutada ainult kord peale paremat p�ringut
SELECT EmployeeKey, FirstName, Gender, BaseRate
FROM DimEmployee
WHERE BaseRate >= 10
EXCEPT
SELECT CustomerKey, FirstName, Gender, YearlyIncome
FROM DimCustomer
WHERE YearlyIncome >= 20000
ORDER BY FirstName


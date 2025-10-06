select * from DimEmployee


CREATE FUNCTION fn_ILTVF_GetEmployees()
RETURNS TABLE
AS
RETURN
(SELECT EmployeeKey, FirstName, 
        CAST(BirthDate AS DATE) AS DOB
    FROM dbo.DimEmployee
);
select * from fn_ILTVF_GetEmployees();
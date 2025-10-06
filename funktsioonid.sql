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

CREATE FUNCTION fn_MSTVF_GetEmployees()
RETURNS @Table TABLE 
(
    EmloyeeKey INT, 
    FirstName NVARCHAR(20), 
    DOB DATE
)
AS
BEGIN
    INSERT INTO @Table
    SELECT 
        EmployeeKey, 
        FirstName, 
        CAST(BirthDate AS DATE)
    FROM DimEmployee;

    RETURN;
END;

SELECT * FROM fn_MSTVF_GetEmployees();

select * from DimEmployee
--- Esimine Funktsion
Create Function fn_GetEmployeeNameById(@EmployeeKey int)

Returns nvarchar(20)
as
Begin
return (select FirstName from DimEmployee Where EmployeeKey = @EmployeeKey)
End

sp_helptext fn_GetEmployeeNameById
-----alter function 
Alter Function fn_GetEmployeeNameById(@EmployeeKey int)

Returns nvarchar(20)
With Encryption 
as
begin
Return (select FirstName from DimEmployee Where EmployeeKey = @EmployeeKey)
End

sp_helptext fn_GetEmployeeNameById

----Alter Function 
Alter Function fn_GetEmployeeNameById(@EmployeeKey int)
Returns vachar(20)
With SchemaBinding
as
Begin
Return (Select FirstName from DimEmployee where EmployeeKey = @EmployeeKey)
end
 
 
 DROP TABLE tblEmployees


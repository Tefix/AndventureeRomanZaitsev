select * from DimEmployee
--- Esimine Funktsion
Create Function fn_GetEmployeeNameById(@EmployeeKey int)

Returns nvarchar(20)
as
Begin
return (select FirstName from DimEmployee Where EmployeeKey = @EmployeeKey)
End

sp_helptext fn_GetEmployeeNameById
-----
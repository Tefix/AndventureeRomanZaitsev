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
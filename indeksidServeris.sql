
SELECT * FROM DimEmployee
CREATE INDEX IX_DimEmployee_BaseRate
ON DimEmployee(BaseRate ASC)
-- Kui soovid vaadata Indeksit
EXEC sp_help DimEmployee;
-- Kui soovid kustutada indeksit
DROP INDEX DimEmployee.IX_DimEmployee_BaseRate

-- Loob klasterindeksi veeru FirstName järgi, et kiirendada otsingut ja sortimist
CREATE CLUSTERED INDEX IX_tblEmployee_Name 
ON tblEmployee(FirstName);

DROP INDEX tblEmployee.PK__tblEmplo__3214EC070A9D95DB;

-- Loob klasterindeksi veergude Gender ja Salary järgi, et optimeerida päringuid nende väljade alusel
CREATE CLUSTERED INDEX IX_tblEmployee_Gender_salary
ON tblEmployee(Gender DESC, Salary ASC);

-- Loob mitteklasterindeksi veeru FirstName järgi, et kiirendada otsingut ilma andmete salvestusjärjestust muutmata
CREATE NONCLUSTERED INDEX IX_tblEmployee_Name 
ON tblEmployee(FirstName);
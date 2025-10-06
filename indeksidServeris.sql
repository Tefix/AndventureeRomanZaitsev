
SELECT * FROM DimEmployee
CREATE INDEX IX_DimEmployee_BaseRate
ON DimEmployee(BaseRate ASC)
-- Kui soovid vaadata Indeksit
EXEC sp_help DimEmployee;
-- Kui soovid kustutada indeksit
DROP INDEX DimEmployee.IX_DimEmployee_BaseRate

-- Loob klasterindeksi veeru FirstName j�rgi, et kiirendada otsingut ja sortimist
CREATE CLUSTERED INDEX IX_tblEmployee_Name 
ON tblEmployee(FirstName);

DROP INDEX tblEmployee.PK__tblEmplo__3214EC070A9D95DB;

-- Loob klasterindeksi veergude Gender ja Salary j�rgi, et optimeerida p�ringuid nende v�ljade alusel
CREATE CLUSTERED INDEX IX_tblEmployee_Gender_salary
ON tblEmployee(Gender DESC, Salary ASC);

-- Loob mitteklasterindeksi veeru FirstName j�rgi, et kiirendada otsingut ilma andmete salvestusj�rjestust muutmata
CREATE NONCLUSTERED INDEX IX_tblEmployee_Name 
ON tblEmployee(FirstName);

- Unikaalne ja mitte-unikaalne indeks
-- Kui soovid vaadata Indeksit
EXEC sp_helpindex DimEmployee;

-- Kuidas saab luua unikaalset mitte-klastreeritud indeksit FirstName ja LastName veeru p�hjal
CREATE UNIQUE NONCLUSTERED INDEX UIX_DimEmployee_FirstName_LastName
On DimEmployee(FirstName, LastName)

--Kui peaksid lisama unikaalse piirangu, siis unikaalne indeks luuakse tagataustal. Selle t�estuseks lisame koodiga unikaalse piirangu City veerule.
ALTER TABLE DimEmployee 
ADD CONSTRAINT UQ_DimEmployee_Title
UNIQUE NONCLUSTERED (Title)
-- K�ivita
EXECUTE SP_HELPCONSTRAINT DimEmployee

-- Kui soovin ainult viie rea tagasi l�kkamist ja viie mitte korduva sisestamist, siis selleks kasutatakse IGNORE_DUP_KEY valikut.
CREATE UNIQUE INDEX IX_DimEmployee_Title
ON DimEmployee(Title)
WITH IGNORE_DUP_KEY

-- Indeksi plussid ja miinused
-- Indeksist l�htuvalt on kergem �les otsida palkasid, mis j��vad vahemikku 4000 kuni 8000 ning kasutada reaaadressi.
SELECT * FROM DimEmployee WHERE BaseRate > 5 AND BaseRate < 10

-- Kui soovid uuendada v�i kustutada rida, siis SQL server peab esmalt leidma rea ja indeks saab aidata seda otsingut kiirendada.
DELETE FROM DimEmployee WHERE BaseRate = 9.50
UPDATE DimEmployee SET BaseRate = 50 WHERE BaseRate = 9.25
-- K�ivita
SELECT * FROM DimEmployee

-- See v�listab p�ringu k�ivitamisel ridade sorteerimise, mis oluliselt  suurendab  protsessiaega.
SELECT * FROM DimEmployee ORDER BY BaseRate

-- BaseRate veeru indeks saab aidata ka allpool olevat p�ringut. Seda tehakse indeksi tagurpidi skanneerimises.
SELECT * FROM DimEmployee ORDER BY BaseRate DESC

-- GROUP BY p�ringud saavad kasu indeksitest. Kui soovid grupeerida t��tajaid sama palgaga, siis p�ringumootor saab kasutada BaseRate veeru indeksit
SELECT BaseRate, COUNT(BaseRate) AS Total
FROM DimEmployee
GROUP BY BaseRate
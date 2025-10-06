
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

- Unikaalne ja mitte-unikaalne indeks
-- Kui soovid vaadata Indeksit
EXEC sp_helpindex DimEmployee;

-- Kuidas saab luua unikaalset mitte-klastreeritud indeksit FirstName ja LastName veeru põhjal
CREATE UNIQUE NONCLUSTERED INDEX UIX_DimEmployee_FirstName_LastName
On DimEmployee(FirstName, LastName)

--Kui peaksid lisama unikaalse piirangu, siis unikaalne indeks luuakse tagataustal. Selle tõestuseks lisame koodiga unikaalse piirangu City veerule.
ALTER TABLE DimEmployee 
ADD CONSTRAINT UQ_DimEmployee_Title
UNIQUE NONCLUSTERED (Title)
-- Käivita
EXECUTE SP_HELPCONSTRAINT DimEmployee

-- Kui soovin ainult viie rea tagasi lükkamist ja viie mitte korduva sisestamist, siis selleks kasutatakse IGNORE_DUP_KEY valikut.
CREATE UNIQUE INDEX IX_DimEmployee_Title
ON DimEmployee(Title)
WITH IGNORE_DUP_KEY

-- Indeksi plussid ja miinused
-- Indeksist lähtuvalt on kergem üles otsida palkasid, mis jäävad vahemikku 4000 kuni 8000 ning kasutada reaaadressi.
SELECT * FROM DimEmployee WHERE BaseRate > 5 AND BaseRate < 10

-- Kui soovid uuendada või kustutada rida, siis SQL server peab esmalt leidma rea ja indeks saab aidata seda otsingut kiirendada.
DELETE FROM DimEmployee WHERE BaseRate = 9.50
UPDATE DimEmployee SET BaseRate = 50 WHERE BaseRate = 9.25
-- Käivita
SELECT * FROM DimEmployee

-- See välistab päringu käivitamisel ridade sorteerimise, mis oluliselt  suurendab  protsessiaega.
SELECT * FROM DimEmployee ORDER BY BaseRate

-- BaseRate veeru indeks saab aidata ka allpool olevat päringut. Seda tehakse indeksi tagurpidi skanneerimises.
SELECT * FROM DimEmployee ORDER BY BaseRate DESC

-- GROUP BY päringud saavad kasu indeksitest. Kui soovid grupeerida töötajaid sama palgaga, siis päringumootor saab kasutada BaseRate veeru indeksit
SELECT BaseRate, COUNT(BaseRate) AS Total
FROM DimEmployee
GROUP BY BaseRate
USE AdventureWorksDW2019

SELECT * FROM DimProduct

-- Arvutame iga toote müügi kogusumma, kasutades GROUP BY klauslit toote nime järgi
SELECT EnglishProductName, SUM(SafetyStockLevel) AS TotalSales 
FROM DimProduct
GROUP BY EnglishProductName

-- Kuvame ainult need tooted, mille müügi kogusumma ületab 800 ühikut, kasutades HAVING tingimust
SELECT EnglishProductName, SUM(SafetyStockLevel) AS TotalSales 
FROM DimProduct
GROUP BY EnglishProductName
HAVING SUM(SafetyStockLevel) > 800

-- Kui kasutada WHERE tingimust, et filtreerida kogusummat, tekib viga, kuna WHERE ei tööta agregaatfunktsioonidega
-- Seetõttu kasutame filtreerimiseks HAVING-u
SELECT EnglishProductName, SUM(SafetyStockLevel) AS TotalSales 
FROM DimProduct
GROUP BY EnglishProductName
HAVING SUM(SafetyStockLevel) > 800

-- Valime ainult need read, kus tootenimed on 'Chain' või 'Front Brakes' ning arvutame nende müügi kogusumma
SELECT EnglishProductName, SUM(SafetyStockLevel) AS TotalSales 
FROM DimProduct
WHERE EnglishProductName IN ('Chain', 'Front Brakes')
GROUP BY EnglishProductName

-- Filtreerime tooted pärast rühmitamist, kuvades ainult 'Chain' ja 'Front Brakes' nimelisi tooteid
SELECT EnglishProductName, SUM(SafetyStockLevel) AS TotalSales 
FROM DimProduct
GROUP BY EnglishProductName
HAVING EnglishProductName IN ('Chain', 'Front Brakes')

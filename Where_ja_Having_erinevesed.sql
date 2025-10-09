USE AdventureWorksDW2019

SELECT * FROM DimProduct

-- Arvutame iga toote m��gi kogusumma, kasutades GROUP BY klauslit toote nime j�rgi
SELECT EnglishProductName, SUM(SafetyStockLevel) AS TotalSales 
FROM DimProduct
GROUP BY EnglishProductName

-- Kuvame ainult need tooted, mille m��gi kogusumma �letab 800 �hikut, kasutades HAVING tingimust
SELECT EnglishProductName, SUM(SafetyStockLevel) AS TotalSales 
FROM DimProduct
GROUP BY EnglishProductName
HAVING SUM(SafetyStockLevel) > 800

-- Kui kasutada WHERE tingimust, et filtreerida kogusummat, tekib viga, kuna WHERE ei t��ta agregaatfunktsioonidega
-- Seet�ttu kasutame filtreerimiseks HAVING-u
SELECT EnglishProductName, SUM(SafetyStockLevel) AS TotalSales 
FROM DimProduct
GROUP BY EnglishProductName
HAVING SUM(SafetyStockLevel) > 800

-- Valime ainult need read, kus tootenimed on 'Chain' v�i 'Front Brakes' ning arvutame nende m��gi kogusumma
SELECT EnglishProductName, SUM(SafetyStockLevel) AS TotalSales 
FROM DimProduct
WHERE EnglishProductName IN ('Chain', 'Front Brakes')
GROUP BY EnglishProductName

-- Filtreerime tooted p�rast r�hmitamist, kuvades ainult 'Chain' ja 'Front Brakes' nimelisi tooteid
SELECT EnglishProductName, SUM(SafetyStockLevel) AS TotalSales 
FROM DimProduct
GROUP BY EnglishProductName
HAVING EnglishProductName IN ('Chain', 'Front Brakes')

/* Connections */

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;




/* SIMPLE Where */

-- Start with basic select of all columns from Product table 
SELECT * 
FROM Production.Product 
WHERE ListPrice < $100;
-- This filters to only products with a list price under $100


-- Get the name and color for products having a color value set (not null)
SELECT Name, Color 
FROM Production.Product 
WHERE Color IS NOT NULL;

--Filter for online orders (OnlineOrderFlag = 1 means online order)
SELECT * 
FROM Sales.SalesOrderHeader 
WHERE OnlineOrderFlag = 1;




/* Using the Like Wildcard */

-- Find products with "brake" in the name
SELECT Name 
FROM Production.Product 
WHERE Name LIKE '%brake%';

-- Get all products starting with "AR-" and having a 5 as the second digit
SELECT * 
FROM Production.Product 
WHERE ProductNumber LIKE 'AR-5%';

-- Exclude any products names with "mountain" in the text
SELECT Name 
FROM Production.Product 
WHERE Name NOT LIKE '%Mountain%';


/* Using the Not criteria */

-- Cheap Products
SELECT * 
FROM Production.Product 
WHERE NOT ListPrice > $100;

-- Old Orders
SELECT * 
FROM Sales.SalesOrderHeader 
WHERE NOT OrderDate > '2015-01-01';

-- Non-Bike Products
SELECT * 
FROM Production.Product 
WHERE NOT Name LIKE '%bike%'




/* Using the AND criteria */

-- Expensive and Heavy Products
SELECT * 
FROM Production.Product 
WHERE ListPrice > $100 AND Weight > 10;

-- Medium Metal Bike Parts
SELECT * 
FROM Production.Product 
WHERE Name LIKE '%bike%' 
AND Size = 'M';

-- Expensive Big Products
SELECT * 
FROM Production.Product 
WHERE StandardCost > 50 
AND Size > 50;



/* Using the OR criteria */

-- Cheap or Small Products
SELECT * 
FROM Production.Product 
WHERE ListPrice < $50 OR Size = 'Small';

-- Recent (for this table) or Big Orders
SELECT * 
FROM Sales.SalesOrderHeader 
WHERE OrderDate > '20150101' OR TotalDue > $5000;

-- Bikes or Helmets
SELECT * 
FROM Production.Product 
WHERE Name LIKE '%bike%' OR Name LIKE '%helmet%';



/* Ordering Ascending Results */

-- Display products from lowest to highest standard cost
SELECT Name, StandardCost
FROM Production.Product 
ORDER BY StandardCost ASC;


--Sales orders starting from the lowest subtotal amounts
SELECT SalesOrderID, SubTotal 
FROM Sales.SalesOrderHeader 
ORDER BY SubTotal ASC;

-- Show work orders chronologically with the earliest started first
SELECT * 
FROM Production.WorkOrder
ORDER BY StartDate ASC;



/* Ordering Descending Results */

-- Show most expensive products first sorted by ListPrice
SELECT Name, ListPrice 
FROM Production.Product 
ORDER BY ListPrice DESC;

-- Highest total due sales orders first
SELECT SalesOrderID, TotalDue
FROM Sales.SalesOrderHeader 
ORDER BY TotalDue DESC;

-- Show work orders chronologically with the latest started first
SELECT * 
FROM Production.WorkOrder
ORDER BY StartDate DESC;










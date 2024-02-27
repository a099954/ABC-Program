/* Connections */

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;

/* SIMPLE Where */

-- Start with basic select of all columns from Product table 
SELECT * 
FROM Production.Product 
WHERE ListPrice < 100;
-- This filters to only products with a list price under $100

-- Get the name and color for products having a color value set (not null)
SELECT Name, Color 
FROM Production.Product 
WHERE Color IS NOT NULL;

--Filter for online orders (OnlineOrderFlag = 1 means online order)
SELECT * 
FROM Sales.SalesOrderHeader 
WHERE OnlineOrderFlag = 1;
-- This query retrieves all online orders by checking the OnlineOrderFlag column.

/* Using the Like Wildcard */

-- Find products with "brake" in the name
SELECT Name 
FROM Production.Product 
WHERE Name LIKE '%brake%';
-- This query finds products with "brake" in their name, using the '%' wildcard for flexibility.

-- Get all products starting with "AR-" and having a 5 as the second digit
SELECT * 
FROM Production.Product 
WHERE ProductNumber LIKE 'AR-5%';
-- This query retrieves products with a ProductNumber starting with "AR-" and having '5' as the second character.

-- Exclude any products names with "mountain" in the text
SELECT Name 
FROM Production.Product 
WHERE Name NOT LIKE '%Mountain%';
-- This query excludes products with "mountain" in their name using the NOT LIKE clause.

/* Using the Not criteria */

-- Cheap Products
SELECT * 
FROM Production.Product 
WHERE NOT ListPrice > 100;
-- This query retrieves products with a ListPrice less than or equal to $100 using the NOT operator.

-- Old Orders
SELECT * 
FROM Sales.SalesOrderHeader 
WHERE NOT OrderDate > '2015-01-01';
-- This query selects orders with OrderDate before January 1, 2015, using the NOT operator.

-- Non-Bike Products
SELECT * 
FROM Production.Product 
WHERE NOT Name LIKE '%bike%';
-- This query excludes products with "bike" in their name using the NOT LIKE clause.

/* Using the AND criteria */

-- Expensive and Heavy Products
SELECT * 
FROM Production.Product 
WHERE ListPrice > 100 AND Weight > 10;
-- This query retrieves products with a ListPrice over $100 and a Weight greater than 10.

-- Medium Metal Bike Parts
SELECT * 
FROM Production.Product 
WHERE Name LIKE '%bike%' 
AND Size = 'M';
-- This query selects medium-sized metal bike parts using the AND operator.

-- Expensive Big Products
SELECT * 
FROM Production.Product 
WHERE StandardCost > 50 
AND Size > 50;
-- This query retrieves products with a StandardCost greater than $50 and a Size greater than 50.

/* Using the OR criteria */

-- Cheap or Small Products
SELECT * 
FROM Production.Product 
WHERE ListPrice < 50 OR Size = 'Small';
-- This query selects products with a ListPrice less than $50 or a Size of 'Small' using the OR operator.

-- Recent (for this table) or Big Orders
SELECT * 
FROM Sales.SalesOrderHeader 
WHERE OrderDate > '20150101' OR TotalDue > 5000;
-- This query retrieves orders with OrderDate after January 1, 2015, or TotalDue greater than $5000 using the OR operator.

-- Bikes or Helmets
SELECT * 
FROM Production.Product 
WHERE Name LIKE '%bike%' OR Name LIKE '%helmet%';
-- This query selects products with "bike" or "helmet" in their name using the OR operator.

/* Ordering Ascending Results */

-- Display products from lowest to highest standard cost
SELECT Name, StandardCost
FROM Production.Product 
ORDER BY StandardCost ASC;
-- This query sorts products by ascending StandardCost, from lowest to highest.

-- Sales orders starting from the lowest subtotal amounts
SELECT SalesOrderID, SubTotal 
FROM Sales.SalesOrderHeader 
ORDER BY SubTotal ASC;
-- This query orders sales orders by ascending SubTotal, showing the lowest amounts first.

-- Show work orders chronologically with the earliest started first
SELECT * 
FROM Production.WorkOrder
ORDER BY StartDate ASC;
-- This query orders work orders by ascending StartDate, displaying the earliest started first.

/* Ordering Descending Results */

-- Show most expensive products first sorted by ListPrice
SELECT Name, ListPrice 
FROM Production.Product 
ORDER BY ListPrice DESC;
-- This query sorts products by descending ListPrice, showing the most expensive first.

-- Highest total due sales orders first
SELECT SalesOrderID, TotalDue
FROM Sales.SalesOrderHeader 
ORDER BY TotalDue DESC;
-- This query orders sales orders by descending TotalDue, displaying the highest total due first.

-- Show work orders chronologically with the latest started first
SELECT * 
FROM Production.WorkOrder
ORDER BY StartDate DESC;
-- This query orders work orders by descending StartDate, displaying the latest started first.

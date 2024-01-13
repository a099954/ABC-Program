/* Connections */

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;




/* SIMPLE SELECT */

-- Start with basic select of all columns from Product table 
SELECT *
FROM Production.Product




/* SPECIFIC COLUMNS */

-- We can specify just the columns we want:
SELECT Name, ProductNumber, Color
FROM Production.Product
-- This makes the result set simpler and easier to understand 

-- Select 3 columns 
SELECT Name, ProductNumber, Color 
FROM Production.Product;   

-- Rename all columns 
SELECT ProductNumber AS PN, 
    Name AS Product, 
    Color AS PColor 
FROM Production.Product;  



/* SIMPLE Transformations */

-- Concat columns together  
SELECT Name + ' ' + Color AS ProductInfo 
FROM Production.Product; 

-- Simple mathematical operation
SELECT ListPrice * 1.1 AS NewPrice
FROM Production.Product;




/* TOP N ROWS */

-- We can limit to only a subset of rows

-- Select top 10 rows 
SELECT TOP 10 * 
FROM Production.Product;  
-- See sample of rows rather than full dataset

-- Select bottom 10 rows
SELECT TOP 10 * 
FROM Production.Product 
ORDER BY Name DESC;
-- Alternative to see last records  

-- Get the top 5 most expensive products
SELECT TOP 5 Name, ListPrice  
FROM Production.Product
ORDER BY ListPrice DESC

-- Get the top 10 products by name
SELECT TOP 10 Name
FROM Production.Product
ORDER BY Name DESC
-- Order by is allowed here to determine the "top" rows

-- Return top 10% of rows 
SELECT TOP 10 PERCENT *
FROM Person.Person



/* DISTINCT */ 

-- We can select distinct values to remove duplicates

-- Get the unique colors available
SELECT DISTINCT Color
FROM Production.Product

-- Select distinct top 5 colors 
SELECT DISTINCT TOP 5 Color 
FROM Production.Product;

-- Count distinct colors
SELECT COUNT(DISTINCT Color) 
FROM Production.Product; 





/* COLUMN ALIASES */  

-- Give columns custom names

SELECT Name AS 'Product Name', 
       ListPrice AS 'Cost'
FROM Production.Product

-- Shorten Column Name
SELECT ProductNumber AS PN, 
       Name AS ProdName,
       SafetyStockLevel AS SSL 
FROM Production.Product

-- Create new column with custom name
SELECT Name,
       ListPrice,
       ListPrice * 1.2 AS DiscountPrice
FROM Production.Product

-- Concate 2 columns with custom name
SELECT Name + ' (' + ProductNumber + ')' AS ProductInfo  
FROM Production.Product




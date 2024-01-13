/* Connections */

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;




/* Product Tables Exercises - Aggregates  */


-- Question 1) Find the average weight of products

        SELECT AVG(Weight) AS AverageWeight 
        FROM Production.Product 
        WHERE Weight IS NOT NULL;

-- Question 2) Find the minimum and maximum list price of products

        SELECT MIN(ListPrice) AS MinPrice, 
        MAX(ListPrice) AS MaxPrice 
        FROM Production.Product;

-- Question 3) Count the number of unique product colors

        SELECT COUNT(DISTINCT Color) AS NumColors 
        FROM Production.Product 
        WHERE Color IS NOT NULL;



/* Product Tables Exercises - Group By  */


-- Question 1) Group products by size and return the total for each ProductID (as ProductCount) per size
-- Hint use Count(ProductID)

        SELECT Size, COUNT(ProductID) AS ProductCount  
        FROM Production.Product 
        WHERE Size IS NOT NULL
        GROUP BY Size;

-- Question 2) Update the previous query to order the groups by ProductCount in descending order

        SELECT Size, COUNT(ProductID) AS ProductCount
        FROM Production.Product
        WHERE Size IS NOT NULL 
        GROUP BY Size
        ORDER BY ProductCount DESC;

-- Question 3) Modify the query to only return the top 3 sizes by ProductCount

        SELECT TOP 3 Size, COUNT(ProductID) AS ProductCount
        FROM Production.Product
        WHERE Size IS NOT NULL
        GROUP BY Size
        ORDER BY ProductCount DESC;



/* Product Tables Exercises - Having Clause */


-- Question 1) Group products by color and return the total for each ProductID (as ProductCount) per color
-- Hint use Count(ProductID)

        SELECT Color, COUNT(ProductID) AS ProductCount
        FROM Production.Product
        GROUP BY Color;

-- Question 2) Update to only return colors that have over 50 products
-- Hint use Count(ProductID) in HAVING clause

        SELECT Color, COUNT(ProductID) AS ProductCount
        FROM Production.Product
        GROUP BY Color 
        HAVING COUNT(ProductID) > 50;


-- Question 3) Sort filtered color groups by descending count

        SELECT Color, COUNT(ProductID) AS ProductCount
        FROM Production.Product
        GROUP BY Color
        HAVING COUNT(ProductID) > 50 
        ORDER BY ProductCount DESC;

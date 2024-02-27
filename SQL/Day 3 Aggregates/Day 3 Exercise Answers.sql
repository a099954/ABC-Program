/* Connect to the AdventureWorks2012 database */
USE AdventureWorks2012;

/* Product Tables Exercises - Aggregates  */

-- Question 1) Find the average weight of products
-- This query calculates the average weight of products in the Product table, excluding rows where the Weight is NULL.
SELECT AVG(Weight) AS AverageWeight 
FROM Production.Product 
WHERE Weight IS NOT NULL;

-- Question 2) Find the minimum and maximum list price of products
-- This query retrieves the minimum and maximum list prices of products from the Product table.
SELECT MIN(ListPrice) AS MinPrice, 
       MAX(ListPrice) AS MaxPrice 
FROM Production.Product;

-- Question 3) Count the number of unique product colors
-- This query counts the number of distinct (unique) product colors in the Product table, excluding NULL values.
SELECT COUNT(DISTINCT Color) AS NumColors 
FROM Production.Product 
WHERE Color IS NOT NULL;

/* Product Tables Exercises - Group By  */

-- Question 1) Group products by size and return the total for each ProductID (as ProductCount) per size
-- Hint use Count(ProductID)
-- This query groups products by their size and counts the number of products in each size category.
SELECT Size, COUNT(ProductID) AS ProductCount  
FROM Production.Product 
WHERE Size IS NOT NULL
GROUP BY Size;

-- Question 2) Update the previous query to order the groups by ProductCount in descending order
-- This query adds an ORDER BY clause to the previous query to sort the size groups by ProductCount in descending order.
SELECT Size, COUNT(ProductID) AS ProductCount
FROM Production.Product
WHERE Size IS NOT NULL 
GROUP BY Size
ORDER BY ProductCount DESC;

-- Question 3) Modify the query to only return the top 3 sizes by ProductCount
-- This query limits the results to the top 3 sizes with the highest ProductCount.
SELECT TOP 3 Size, COUNT(ProductID) AS ProductCount
FROM Production.Product
WHERE Size IS NOT NULL
GROUP BY Size
ORDER BY ProductCount DESC;

/* Product Tables Exercises - Having Clause */

-- Question 1) Group products by color and return the total for each ProductID (as ProductCount) per color
-- Hint use Count(ProductID)
-- This query groups products by color and counts the number of products in each color category.
SELECT Color, COUNT(ProductID) AS ProductCount
FROM Production.Product
GROUP BY Color;

-- Question 2) Update to only return colors that have over 50 products
-- Hint use Count(ProductID) in HAVING clause
-- This query filters the color groups to include only those with more than 50 products using the HAVING clause.
SELECT Color, COUNT(ProductID) AS ProductCount
FROM Production.Product
GROUP BY Color 
HAVING COUNT(ProductID) > 50;

-- Question 3) Sort filtered color groups by descending count
-- This query adds an ORDER BY clause to sort the filtered color groups by ProductCount in descending order.
SELECT Color, COUNT(ProductID) AS ProductCount
FROM Production.Product
GROUP BY Color
HAVING COUNT(ProductID) > 50 
ORDER BY ProductCount DESC;


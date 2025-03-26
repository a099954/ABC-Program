/* Connect to the AdventureWorks2012 database */
USE AdventureWorks2012;

/* Calculate Total Sales for a Specific Year Range */

/* Calculate the total sales amount for orders between 2005 and 2007 */
SELECT SUM(TotalDue) AS TotalSales 
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2005-01-01' AND '2007-12-31';

/* Calculate Total Line Amount for a Specific Sales Order */

/* Calculate the total line amount for Sales Order #43659 */
SELECT SUM(LineTotal) AS TotalLineAmount 
FROM Sales.SalesOrderDetail 
WHERE SalesOrderID = 43659;

/* Calculate Average List Price of Products */

/* Calculate the average list price of all products */
SELECT AVG(ListPrice) AS AverageListPrice 
FROM Production.Product;

/* Calculate Average Line Total for Sales Order Details */

/* Calculate the average line total across all sales order details */
SELECT AVG(LineTotal) AS AverageLineTotal 
FROM Sales.SalesOrderDetail;

/* Find Min and Max List Prices for Products */

/* Retrieve the minimum and maximum list prices for products */
SELECT MIN(ListPrice) AS MinListPrice, 
       MAX(ListPrice) AS MaxListPrice 
FROM Production.Product;

/* Count Rows and Distinct Values */

/* Count the total number of products */
SELECT COUNT(*) AS TotalProducts
FROM Production.Product;

/* Count the number of distinct colors in the Product table */
SELECT COUNT(DISTINCT Color) AS UniqueColors
FROM Production.Product;

/* Grouping and Aggregating Data */

/* Group sales orders by year and calculate total sales for each year */
SELECT YEAR(OrderDate) AS OrderYear, 
       SUM(TotalDue) AS TotalSales 
FROM Sales.SalesOrderHeader 
GROUP BY YEAR(OrderDate);

/* Group products by size and calculate average weight, excluding null weights */
SELECT Size, 
       AVG(Weight) AS AverageWeight 
FROM Production.Product
WHERE Weight IS NOT NULL 
GROUP BY Size;

/* Filtering Groups with HAVING Clause */

/* Group products by subcategory and count products, filtering for groups with more than 20 products */
SELECT ProductSubcategoryID, 
       COUNT(ProductID) AS ProductCount 
FROM Production.Product 
GROUP BY ProductSubcategoryID
HAVING COUNT(ProductID) > 20;

/* Group products by color and calculate average standard cost, filtering for average cost over $100 */
SELECT Color, 
       AVG(StandardCost) AS AverageCost 
FROM Production.Product 
WHERE Color IS NOT NULL 
GROUP BY Color 
HAVING AVG(StandardCost) > 100;
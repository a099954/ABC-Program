/* Connections */

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;




/* SIMPLE INNER JOINS */

-- Join products and subcategories

       SELECT *
       FROM Production.Product p 
       INNER JOIN Production.ProductSubcategory ps 
         ON p.ProductSubcategoryID = ps.ProductSubcategoryID;

-- Join product and product model

       SELECT *
       FROM Production.ProductModel pm 
       INNER JOIN Production.Product p 
         ON p.ProductModelID = pm.ProductModelID;




/* SIMPLE LEFT JOINS */

-- Get all products with their product model name

       SELECT p.Name, pm.Name AS ModelName 
       FROM Production.Product p 
       LEFT JOIN Production.ProductModel pm 
         ON p.ProductModelID = pm.ProductModelID;

-- Get all inventory snapshots with product name

       SELECT p.Name, pi.Shelf, pi.Quantity
       FROM Production.Product p 
       LEFT JOIN Production.ProductInventory pi 
         ON p.ProductID = pi.ProductID;




/* SIMPLE RIGHT JOINS */


-- Get all product models with any matching products

       SELECT p.Name, pm.Name AS ModelName 
       FROM Production.Product p 
       RIGHT JOIN Production.ProductModel pm 
         ON p.ProductModelID = pm.ProductModelID;

-- Get all product inventory snapshots with product info

       SELECT p.Name, pi.Shelf, pi.Quantity 
       FROM Production.Product p 
       RIGHT JOIN Production.ProductInventory pi 
         ON p.ProductID = pi.ProductID;



/* FULL OUTER JOINS */

-- Get all products and product models with matches and non-matches

       SELECT p.Name, pm.Name AS ModelName
       FROM Production.Product p 
       FULL OUTER JOIN Production.ProductModel pm 
         ON p.ProductModelID = pm.ProductModelID;

-- Get inventory snapshots combined with all products, even those lacking snapshots
       SELECT p.Name, pi.Shelf, pi.Quantity 
       FROM Production.Product p
       FULL OUTER JOIN Production.ProductInventory pi 
         ON p.ProductID = pi.ProductID;




/* JOINS with Aggregates */

-- Average reseller sales amount per year:

       SELECT YEAR(sh.OrderDate) AS OrderYear, AVG(sd.LineTotal) AS AverageSales
       FROM Sales.SalesOrderHeader sh 
       INNER JOIN Sales.SalesOrderDetail sd
         ON sh.SalesOrderID = sd.SalesOrderID 
       GROUP BY YEAR(sh.OrderDate);

-- How many times has each product been ordered?

       SELECT p.Name as Product, COUNT(sod.SalesOrderDetailID) AS OrderCount
       FROM Production.Product as p
       INNER JOIN Sales.SalesOrderDetail AS sod
         ON sod.ProductID = p.ProductID
       GROUP BY p.Name

-- Total historical on-hand inventory quantities for each product

       SELECT p.Name AS Product, SUM(inv.Quantity) AS TotalQuantity  
       FROM Production.Product p
       JOIN Production.ProductInventory inv
         ON p.ProductID = inv.ProductID
       GROUP BY p.Name
       ORDER BY TotalQuantity DESC


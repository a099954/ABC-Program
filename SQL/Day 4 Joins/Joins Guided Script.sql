/* Connections */

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;




/* SIMPLE INNER JOINS */

-- Join products and subcategories
-- This INNER JOIN combines products and their subcategories, ensuring that only matching records are included.
-- It's useful for retrieving information about products and their corresponding subcategories.
SELECT *
FROM Production.Product p 
INNER JOIN Production.ProductSubcategory ps 
  ON p.ProductSubcategoryID = ps.ProductSubcategoryID;

-- Join product and product model
-- This INNER JOIN connects products to their associated product models.
-- It's valuable for obtaining a unified view of products and their corresponding models.
SELECT *
FROM Production.ProductModel pm 
INNER JOIN Production.Product p 
  ON p.ProductModelID = pm.ProductModelID;




/* SIMPLE LEFT JOINS */

-- Get all products with their product model name
-- This LEFT JOIN retrieves all products along with their respective product model names.
-- It's helpful for displaying product details, even if some products have no associated models.
SELECT p.Name, pm.Name AS ModelName 
FROM Production.Product p 
LEFT JOIN Production.ProductModel pm 
  ON p.ProductModelID = pm.ProductModelID;

-- Get all inventory snapshots with product name
-- This LEFT JOIN combines product information with inventory snapshots.
-- It's useful for seeing product names alongside their inventory data, even when some products have no inventory records.
SELECT p.Name, pi.Shelf, pi.Quantity
FROM Production.Product p 
LEFT JOIN Production.ProductInventory pi 
  ON p.ProductID = pi.ProductID;




/* SIMPLE RIGHT JOINS */


-- Get all product models with any matching products
-- This RIGHT JOIN retrieves all product models and includes any associated products.
-- It's beneficial when you want to ensure that all product models are included, even if some have no corresponding products.
SELECT p.Name, pm.Name AS ModelName 
FROM Production.Product p 
RIGHT JOIN Production.ProductModel pm 
  ON p.ProductModelID = pm.ProductModelID;

-- Get all product inventory snapshots with product info
-- This RIGHT JOIN combines product data with inventory snapshots.
-- It's helpful for viewing inventory details alongside product information, ensuring that all snapshots are included.
SELECT p.Name, pi.Shelf, pi.Quantity 
FROM Production.Product p 
RIGHT JOIN Production.ProductInventory pi 
  ON p.ProductID = pi.ProductID;



/* FULL OUTER JOINS */

-- Get all products and product models with matches and non-matches
-- This FULL OUTER JOIN combines products and product models, including both matching and non-matching records.
-- It's useful when you want to create a comprehensive list of products and their corresponding models, including those with no matches.
SELECT p.Name, pm.Name AS ModelName
FROM Production.Product p 
FULL OUTER JOIN Production.ProductModel pm 
  ON p.ProductModelID = pm.ProductModelID;

-- Get inventory snapshots combined with all products, even those lacking snapshots
-- This FULL OUTER JOIN combines product information with inventory snapshots, ensuring that all products are included, whether they have snapshots or not.
SELECT p.Name, pi.Shelf, pi.Quantity 
FROM Production.Product p
FULL OUTER JOIN Production.ProductInventory pi 
  ON p.ProductID = pi.ProductID;




/* JOINS with Aggregates */

-- Average reseller sales amount per year:
-- This INNER JOIN aggregates sales data by year and calculates the average sales amount for each year.
-- It's useful for understanding the yearly sales performance.
SELECT YEAR(sh.OrderDate) AS OrderYear, AVG(sd.LineTotal) AS AverageSales
FROM Sales.SalesOrderHeader sh 
INNER JOIN Sales.SalesOrderDetail sd
  ON sh.SalesOrderID = sd.SalesOrderID 
GROUP BY YEAR(sh.OrderDate);

-- How many times has each product been ordered?
-- This INNER JOIN aggregates data to count how many times each product has been ordered.
-- It's helpful for assessing product popularity based on order counts.
SELECT p.Name as Product, COUNT(sod.SalesOrderDetailID) AS OrderCount
FROM Production.Product as p
INNER JOIN Sales.SalesOrderDetail AS sod
  ON sod.ProductID = p.ProductID
GROUP BY p.Name

-- Total historical on-hand inventory quantities for each product
-- This JOIN aggregates data to calculate the total historical on-hand inventory quantities for each product.
-- It's useful for inventory management and understanding product stock levels.
SELECT p.Name AS Product, SUM(inv.Quantity) AS TotalQuantity  
FROM Production.Product p
JOIN Production.ProductInventory inv
  ON p.ProductID = inv.ProductID
GROUP BY p.Name
ORDER BY TotalQuantity DESC



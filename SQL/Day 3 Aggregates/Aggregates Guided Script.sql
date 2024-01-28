/* Connect to the AdventureWorks2012 database */
USE AdventureWorks2012;

/* Calculate Total Sales for a Specific Year Range */

-- This command selects the sum of TotalDue from the SalesOrderHeader table.
-- It calculates the total sales amount for sales orders made between 2005 and 2007.
-- Aggregate functions like SUM are important for summarizing and obtaining total values from large datasets.
SELECT SUM(TotalDue) AS TotalSales 
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2005-01-01' AND '2007-12-31';

/* Calculate Total Line Amount for a Specific Sales Order */

-- This command selects the sum of LineTotal from the SalesOrderDetail table.
-- It calculates the total line amount for a specific sales order (Sales Order #43659).
-- SUM is crucial for calculating sums of values within specific subsets of data.
SELECT SUM(LineTotal) AS TotalLineAmount 
FROM Sales.SalesOrderDetail 
WHERE SalesOrderID = 43659;

/* Calculate Average List Price of Products */

-- This command calculates the average list price of all products in the Product table.
-- AVG is essential for calculating measures of central tendency, like the mean.
SELECT AVG(ListPrice) AS AverageListPrice 
FROM Production.Product;

/* Calculate Average Line Total for Sales Order Details */

-- This command calculates the average line total across all sales order details.
-- AVG is useful for understanding the average value of a particular attribute across a dataset.
SELECT AVG(LineTotal) AS AverageLineTotal 
FROM Sales.SalesOrderDetail;

/* Calculate Average Pay Rate from Employee Pay History */

-- This command calculates the average pay rate from the Rate column in the EmployeePayHistory table.
-- AVG helps in calculating average values for numeric data, such as pay rates.
SELECT AVG(Rate) AS AveragePayRate 
FROM HumanResources.EmployeePayHistory;

/* Find Min and Max List Prices for Products */

-- This command retrieves the minimum and maximum list prices for products.
-- MIN and MAX are important for finding extreme values and value ranges within data.
SELECT MIN(ListPrice) AS MinListPrice, 
       MAX(ListPrice) AS MaxListPrice 
FROM Production.Product;

/* Find Earliest and Latest Hire Dates for Employees */

-- This command identifies the earliest and latest hire dates among employees.
-- MIN and MAX are valuable for finding the earliest and latest dates or values in a dataset.
SELECT MIN(HireDate) AS EarliestHire, 
       MAX(HireDate) AS LatestHire 
FROM HumanResources.Employee;

/* Count Rows and Distinct Values */

-- This command counts the total number of rows in the Product table.
-- COUNT is essential for counting the number of rows or distinct values in a dataset.
SELECT COUNT(*) 
FROM Production.Product;

-- This command counts the number of rows where the Color column is not null.
-- COUNT can be used to count non-null values in a specific column.
SELECT COUNT(Color) 
FROM Production.Product;

-- This command counts the number of distinct (unique) values in the Color column.
-- COUNT and COUNT(DISTINCT) help in calculating unique counts for categorical data.
SELECT COUNT(DISTINCT Color) 
FROM Production.Product;

-- This command counts the number of distinct (unique) TerritoryID values in the Sales.Customer table.
-- COUNT(DISTINCT) is useful for counting unique values in a specific column.
SELECT COUNT(DISTINCT TerritoryID) 
FROM Sales.Customer;

/* Grouping and Aggregating Data */

-- This command groups sales orders by year (using the YEAR function) and calculates the total sales for each year.
-- GROUP BY is essential for segmenting data into meaningful groups for aggregation.
SELECT YEAR(OrderDate) AS OrderYear, 
       SUM(TotalDue) AS TotalSales 
FROM Sales.SalesOrderHeader 
GROUP BY YEAR(OrderDate);

-- This command groups products by size and calculates the average weight for each size, excluding null weights.
-- GROUP BY is used to create groups based on unique values in a column for aggregation.
SELECT Size, 
       AVG(Weight) AS AverageWeight 
FROM Production.Product
WHERE Weight IS NOT NULL 
GROUP BY Size;

-- This command groups products by style and finds the minimum list price for each style.
-- GROUP BY is valuable for grouping data by specific attributes to perform aggregate calculations.
SELECT Style, 
       MIN(ListPrice) AS MinimumListPrice 
FROM Production.Product 
WHERE Style IS NOT NULL
GROUP BY Style;

/* Filtering Groups with HAVING Clause */

-- This command groups products by product subcategory and counts the number of products in each subcategory.
-- It then filters the groups, focusing only on those with more than 20 products.
-- The HAVING clause is used to filter aggregated results based on specific conditions.
SELECT ProductSubcategoryID, 
       COUNT(ProductID) AS ProductCount 
FROM Production.Product 
GROUP BY ProductSubcategoryID
HAVING COUNT(ProductID) > 20;

-- This command groups products by color and calculates the average standard cost for each color.
-- It filters the groups to include only those with an average standard cost over $100.
-- HAVING is crucial for filtering groups based on aggregate results, enabling you to focus on significant groups.
SELECT Color, 
       AVG(StandardCost) AS AverageCost 
FROM Production.Product 
WHERE Color IS NOT NULL 
GROUP BY Color HAVING AVG(StandardCost) > 100;

-- This command groups products by size and calculates the total quantity in stock for each size.
-- It filters the groups to include only those with a total quantity of at least 5000 in stock.
-- HAVING is used to filter groups based on aggregate conditions, allowing you to focus on specific subsets of data.
SELECT Size, 
       SUM(SafetyStockLevel) AS TotalQuantity
FROM Production.Product 
WHERE Size IS NOT NULL 
GROUP BY Size HAVING SUM(SafetyStockLevel) > 5000;

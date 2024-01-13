/* Connections */

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;




/* Using SUM */

-- Total sales amount for all sales orders in 2012
        
        SELECT SUM(TotalDue) AS TotalSales 
        FROM Sales.SalesOrderHeader
        WHERE OrderDate BETWEEN '2005-01-01' AND '2007-12-31';

--  Sum of line totals for all details for Sales Order #43659

        SELECT SUM(LineTotal) AS TotalLineAmount 
        FROM Sales.SalesOrderDetail 
        WHERE SalesOrderID = 43659;



/* Using AVG */

 -- Average list price of products

        SELECT AVG(ListPrice) AS AverageListPrice 
        FROM Production.Product;

-- Average line total across all sales order details

        SELECT AVG(LineTotal) AS AverageLineTotal 
        FROM Sales.SalesOrderDetail;

-- Average rate from the employee pay history table

        SELECT AVG(Rate) AS AveragePayRate 
        FROM HumanResources.EmployeePayHistory;



/* Using MIN & MAX */

-- The lowest and highest list prices for products

        SELECT MIN(ListPrice) AS MinListPrice, 
        MAX(ListPrice) AS MaxListPrice 
        FROM Production.Product;

-- Earliest and latest hire dates for employees

        SELECT MIN(HireDate) AS EarliestHire, 
        MAX(HireDate) AS LatestHire 
        FROM HumanResources.Employee;



/* Using Count and Distinct */

-- Count total rows in Product table

        SELECT COUNT(*) 
        FROM Production.Product;

-- Count products that have a color specified
        SELECT COUNT(Color) 
        FROM Production.Product;

-- Count distinct product colors

        SELECT COUNT(DISTINCT Color) 
        FROM Production.Product;

-- Count distinct customer territories

        SELECT COUNT(DISTINCT TerritoryID) 
        FROM Sales.Customer;



/* Using the GROUP BY Clause */

--Total sales by year

        SELECT YEAR(OrderDate) AS OrderYear, 
        SUM(TotalDue) AS TotalSales 
        FROM Sales.SalesOrderHeader 
        GROUP BY YEAR(OrderDate);


-- Average weight by product size

        SELECT Size, 
        AVG(Weight) AS AverageWeight 
        FROM Production.Product
        WHERE Weight IS NOT NULL 
        GROUP BY Size;


--Minimum list price by style:

        SELECT Style, 
        MIN(ListPrice) AS MinimumListPrice 
        FROM Production.Product 
        WHERE Style IS NOT NULL
        GROUP BY Style;




/* Using the HAVING Clause */

--Product categories with more than 20 products

    SELECT ProductSubcategoryID, 
    COUNT(ProductID) AS ProductCount 
    FROM Production.Product 
    GROUP BY ProductSubcategoryID
    HAVING COUNT(ProductID) > 20;


-- Product colors with an average standard cost over $100

        SELECT Color, 
        AVG(StandardCost) AS AverageCost 
        FROM Production.Product 
        WHERE Color IS NOT NULL 
        GROUP BY Color HAVING AVG(StandardCost) > 100;


-- Product sizes with at least 5000 total quantity in stock

        SELECT Size, 
        SUM(SafetyStockLevel) AS TotalQuantity
        FROM Production.Product 
        WHERE Size IS NOT NULL 
        GROUP BY Size HAVING SUM(SafetyStockLevel) > 5000;


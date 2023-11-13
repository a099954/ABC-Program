USE AdventureWorks2019

-- 1) Using the `HumanResources.Employee` table, find out how many employees with 'Supervisor' in their title are salaried and how many are not.
SELECT SalariedFlag, COUNT(*)
FROM HumanResources.Employee
WHERE JobTitle LIKE '%Supervisor%'
GROUP BY SalariedFlag

-- 2) Using the `HumanResources.Employee` table, determine the total amount of vacation hours, sick leave hours, and number of employees broken down by marital status and salaried status (`SalariedFlag`).
SELECT MaritalStatus, SalariedFlag, COUNT(BusinessEntityID), SUM(VacationHours), SUM(SickLeaveHours)
FROM HumanResources.Employee
GROUP BY MaritalStatus, SalariedFlag

-- 3) Using the `HumanResources.Employee` table, determine the number of employees with each job title. Include the average of combined vacation and sick leave hours for each job title as well. Sort the result from highest average hours to lowest.
SELECT JobTitle, COUNT(*), AVG(VacationHours + SickLeaveHours)
FROM HumanResources.Employee
GROUP BY JobTitle
ORDER BY 3 DESC

-- 4) Using the `HumanResources.Employee` table, determine the number of employees with each job title. Include the average of combined vacation and sick leave hours for each job title as well. Only include job titles with 5 or more employees. Sort the result from highest average hours to lowest.
SELECT JobTitle, COUNT(*), AVG(VacationHours + SickLeaveHours)
FROM HumanResources.Employee
GROUP BY JobTitle
HAVING COUNT(*) >= 5
ORDER BY 3 DESC

-- 5) Using the `HumanResources.EmployeePayHistory` table, determine the number of time each employee's pay rate has changed, the difference between their highest rate and lowest rate, and the date of their most recent rate change. Only include results for employees who have had a rate change.
SELECT BusinessEntityID, COUNT(*), MAX(Rate) - MIN(Rate), MAX(RateChangeDate)
FROM HumanResources.EmployeePayHistory
GROUP BY BusinessEntityID
HAVING COUNT(*) > 1

-- 6) Using the `Production.Product` table, determine the average list price, average standard cost, and range of standard cost for all bike frames. The results should be broken down by bike frame models, grouping together different sizes for the same frame.
-- > Hint: You can isolate the bike frame model by using all but the last three characters in the `ProductNumber`.
SELECT SUBSTRING(ProductNumber,1, LEN(ProductNumber)-3), AVG(ListPrice), AVG(StandardCost), MAX(StandardCost) - MIN(StandardCost)
FROM Production.Product
WHERE Name LIKE '%Frame%'
GROUP BY SUBSTRING(ProductNumber,1, LEN(ProductNumber)-3)

-- 7) Using the `Production.Product` table, group the products by product category (using the first two characters of the ProductNumber), and find out the average standard cost and average list price by product category. Only include rows that have a value for the Color, and limit results to only product categories where both of the averages are greater than 0.
SELECT LEFT(ProductNumber,2), AVG(StandardCost), AVG(ListPrice)
FROM Production.Product
WHERE Color IS NOT NULL
GROUP BY LEFT(ProductNumber,2)
HAVING AVG(StandardCost) > 0 AND AVG(ListPrice) > 0

-- 8) Using the `Sales.SalesOrderDetail` table, find the number of different products, total quantity of items, and total cost for each order. Include a column with the ProductIDs of each product included in the order. Only show results for orders with at least 10 distinct products.
SELECT SalesOrderID, COUNT(ProductID), STRING_AGG(ProductID,', '), SUM(OrderQty), SUM(LineTotal)
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING COUNT(ProductID) >= 10

-- 9) Use the `Purchasing.ShipMethod` table to find the ShipMethodID for cargo transport and save it to a variable called `@CargoID`. Using this variable, query the `Sales.SalesOrderHeader` table to find the number of sales, average freight cost, and total freight cost for sales shipped by cargo transport. The results should be broken down by territory and year the order was placed, and sorted on both as well.
DECLARE @CargoID INT
SELECT @CargoID = ShipMethodID
FROM Purchasing.ShipMethod
WHERE Name LIKE '%Cargo%'

SELECT TerritoryID, YEAR(OrderDate), COUNT(*), AVG(Freight), SUM(Freight)
FROM Sales.SalesOrderHeader
WHERE ShipMethodID = @CargoID
GROUP BY TerritoryID, YEAR(OrderDate)
ORDER BY TerritoryID, YEAR(OrderDate)

-- 10) Using the `Sales.SalesOrderDetail` table, find the total value (`LineTotal`) and quantity sold of all products that have a unit price less than 50. Results should be broken down by ProductID and year modified (use `ModifiedDate`). Only include results with a total value of 20,000 or more. Sort the results by ProductID and year modified.

SELECT ProductID, YEAR(ModifiedDate), SUM(LineTotal), SUM(OrderQty)
FROM Sales.SalesOrderDetail
WHERE UnitPrice < 50
GROUP BY ProductID, YEAR(ModifiedDate)
HAVING SUM(LineTotal) >= 20000
ORDER BY ProductID, YEAR(ModifiedDate)
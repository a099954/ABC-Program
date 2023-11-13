USE AdventureWorks2019;

/* Basic SQL */

-- Get all records, all fields in HR's department table.
SELECT * FROM HumanResources.Department

-- Get the first 5 records - all fields - of Employee
SELECT TOP 5 * FROM HumanResources.Employee

-- Get the unique values for marital status
SELECT DISTINCT MaritalStatus FROM HumanResources.Employee

/* Filtering */

-- Get only the department names that belong to Manufacturing.
SELECT Name FROM HumanResources.Department WHERE GroupName = 'Manufacturing'

-- What are the unique department groups that have 'and' in their name?
SELECT DISTINCT GroupName FROM HumanResources.Department WHERE GroupName LIKE '%and%'

-- Which employees (first and last names) were hired in the first quarter of 2010?  Use the mathematical operators.
SELECT FirstName, LastName FROM HumanResources.Employee 
JOIN Person.Person ON HumanResources.Employee.BusinessEntityID = Person.BusinessEntityID
WHERE HireDate >= '2010-01-01' AND HireDate <= '2010-03-31'

-- Which employees (first and last name) were hired in January 2011?  Use the BETWEEN CLAUSE.
SELECT FirstName, LastName FROM HumanResources.Employee 
JOIN Person.Person ON HumanResources.Employee.BusinessEntityID = Person.BusinessEntityID
WHERE HireDate BETWEEN '2011-01-01' AND '2011-01-31'

-- Which products (name) do not have a color?
SELECT Name FROM Production.Product WHERE Color IS NULL

-- Which products (name) have a color?
SELECT Name FROM Production.Product WHERE Color IS NOT NULL

-- Get the last 5 records names from the person table if it was sorted alphabetically by last name, then first name.
SELECT TOP 5 FirstName, LastName FROM Person.Person ORDER BY LastName DESC, FirstName DESC

/* Aggregates */

-- What is the breakdown of genders for employees?
SELECT Gender, COUNT(Gender) FROM HumanResources.Employee GROUP BY Gender

-- What is the average age of current employees?  
SELECT  AVG(DATEDIFF(yyyy,BirthDate,GETDATE()))
FROM HumanResources.Employee
WHERE CurrentFlag = 1

-- What is the average age by gender of current employees?
SELECT  Gender, AVG(DATEDIFF(yyyy,BirthDate,GETDATE()))
FROM HumanResources.Employee
WHERE CurrentFlag = 1
GROUP BY Gender

-- How many employees were hired in 2017?  Use the YEAR function.
SELECT COUNT(BusinessEntityId) NumberOfEmployees FROM HumanResources.Employee WHERE YEAR(HireDate) = 2007

-- How many employees were hired in 2017?  Use the mathematical operators.
SELECT COUNT(BusinessEntityId) NumberOfEmployees FROM HumanResources.Employee WHERE HireDate >= '2007-01-01' AND HireDate <= '2007-12-31'

-- How many employees were hired in 2017?  Use the BETWEEN CLAUSE.
SELECT COUNT(BusinessEntityId) NumberOfEmployees FROM HumanResources.Employee WHERE HireDate BETWEEN '2007-01-01' AND '2007-12-31'

-- What are the earliest and latest due dates for sales orders?  Use the AS keyword for naming the results.
SELECT MIN(DueDate) AS Earliest, MAX(DueDate) AS Latest FROM Sales.SalesOrderHeader

/*
Get the following values:
- Least total due
- Average total due
- Most total due
- Total count of unique orders due
- Sum of total due

Do not use AS in the alias declaration.
*/
SELECT MIN(TotalDue) LeastTotalDue, AVG(TotalDue) AverageTotalDue, MAX(TotalDue) MostTotalDue, COUNT (DISTINCT SalesOrderID) CountTotalDue, SUM(TotalDue) GrandTotalDue
FROM Sales.SalesOrderHeader

/* Joins */

-- Get the first 10 unique job titles that belong to Manufacturing
SELECT DISTINCT TOP 10 E.JobTitle
FROM HumanResources.Employee E
JOIN HumanResources.EmployeeDepartmentHistory EDH ON EDH.BusinessEntityID = E.BusinessEntityID
JOIN HumanResources.Department D ON D.DepartmentID = EDH.DepartmentID

-- Get all work orders with their product names and scrap reasons (even if they don't include a scrap reason).

SELECT WorkOrderID, P.Name Product, SR.Name ScrapReason
FROM Production.WorkOrder WO
JOIN Production.Product P ON P.ProductID = WO.ProductID
LEFT OUTER JOIN Production.ScrapReason SR ON SR.ScrapReasonID = WO.ScrapReasonID

-- Get all work orders with their product names without scrap reasons.

SELECT WorkOrderID, P.Name Product
FROM Production.WorkOrder WO
JOIN Production.Product P ON P.ProductID = WO.ProductID
WHERE WO.ScrapReasonID IS NULL

-- Get all work orders with their product names and scrap reasons only if they have a scrap reason.

SELECT WorkOrderID, P.Name Product, SR.Name ScrapReason
FROM Production.WorkOrder WO
JOIN Production.Product P ON P.ProductID = WO.ProductID
LEFT OUTER JOIN Production.ScrapReason SR ON SR.ScrapReasonID = WO.ScrapReasonID
WHERE WO.ScrapReasonID IS NOT NULL

/* Subqueries */

-- Get the Order ID, Order Date, Due Date, Ship Date for orders ordered in June 2013 where Marketing is the sales reason
SELECT SOH.SalesOrderID, OrderDate, DueDate, ShipDate FROM Sales.SalesOrderHeader SOH
JOIN Sales.SalesOrderHeaderSalesReason  SOHSR ON SOH.SalesOrderID = SOHSR.SalesOrderID
WHERE SalesReasonID IN
(SELECT SalesReasonID FROM Sales.SalesReason WHERE ReasonType = 'Marketing')
AND OrderDate >= '2013-06-01' AND OrderDate <= '2013-06-30'

-- Get the purchase order id, total for the purchase order, and total for all purchase orders due in 2013.

SELECT PurchaseOrderID, DueDate, SUM(LineTotal) POTotal, (SELECT SUM(LineTotal) FROM Purchasing.PurchaseOrderDetail WHERE YEAR(DueDate) = 2013) PO2013Total
FROM Purchasing.PurchaseOrderDetail POD
WHERE YEAR(DueDate) = 2013
GROUP BY PurchaseOrderID, DueDate
ORDER BY PurchaseOrderID, DueDate

-- Get the purchase order id, vendor name, total for the purchase order,  total for all purchase orders, and average line total for all purchase orders due in 2014 greater than the average line total for all purchase orders due in 2014.

SELECT POH.PurchaseOrderID, V.Name, DueDate, SUM(LineTotal) POTotal, (SELECT SUM(LineTotal) FROM Purchasing.PurchaseOrderDetail WHERE YEAR(DueDate) = 2014) PO2014Total, (SELECT AVG(LineTotal) FROM Purchasing.PurchaseOrderDetail WHERE YEAR(DueDate) = 2014) PO2014Average
FROM Purchasing.PurchaseOrderDetail POD
JOIN Purchasing.PurchaseOrderHeader POH ON POH.PurchaseOrderID = POD.PurchaseOrderID
JOIN Purchasing.Vendor V ON V.BusinessEntityID = POH.VendorID
WHERE YEAR(DueDate) = 2014
GROUP BY POH.PurchaseOrderID, V.Name, DueDate
HAVING SUM(LineTotal) > (SELECT AVG(LineTotal) FROM Purchasing.PurchaseOrderDetail WHERE YEAR(DueDate) = 2014)
ORDER BY PurchaseOrderID, DueDate


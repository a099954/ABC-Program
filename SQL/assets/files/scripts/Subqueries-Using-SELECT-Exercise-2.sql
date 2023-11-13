USE AdventureWorks2019

-- 1) For each SalesOrderID in `Sales.SalesOrderDetail`, find the combined line total for all lines in the order. Include a column with the overall sum of all line totals. Sort the results by the order line totals, from largest to smallest.
SELECT SalesOrderID, SUM(LineTotal), (SELECT SUM(LineTotal) FROM Sales.SalesOrderDetail)
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY 2 DESC;

-- 2) For each product in the `Production.Product` table, find the ProductID, product name and the total quantity of that product ordered (from the `Sales.SalesOrderDetail` table). Order the results on total quantity ordered, from largest to smallest.
SELECT ProductID, Name, 
    (SELECT SUM(OrderQty)
     FROM Sales.SalesOrderDetail
     WHERE Sales.SalesOrderDetail.ProductID = Production.Product.ProductID)
FROM Production.Product
ORDER BY 3 DESC;

-- 3) For each product in the `Production.Product` table, find the ProductID, product name and the most common quantity that product is ordered in (from the `Sales.SalesOrderDetail` table). Order the results on the most common quantity ordered, from largest to smallest.
SELECT ProductID, Name,
    (SELECT TOP 1 OrderQty
    FROM Sales.SalesOrderDetail
    WHERE Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
    GROUP BY OrderQty
    ORDER BY COUNT(*) DESC)
FROM Production.Product
ORDER BY 3 DESC;

-- (Alternative solution including the count of purchases for the top quantity of each item)
SELECT ProductID, Name,
    (SELECT TOP 1 CONCAT(OrderQty,' : ', COUNT(*))
    FROM Sales.SalesOrderDetail
    WHERE Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
    GROUP BY OrderQty
    ORDER BY COUNT(*) DESC)
FROM Production.Product
ORDER BY 3 DESC;

-- 4) For each employee in the `Person.Person` table (employees have a PersonType of 'EM'), find their first, middle, and last names, as well as their age (in years) and the average age for all employees (from the `HumanResources.Employee` table).
SELECT FirstName, MiddleName, LastName,
    (SELECT DATEDIFF(yy, BirthDate, GETDATE())
    FROM HumanResources.Employee
    WHERE HumanResources.Employee.BusinessEntityID = Person.Person.BusinessEntityID),
    (SELECT AVG(DATEDIFF(yy, BirthDate, GETDATE()))
     FROM HumanResources.Employee)
FROM Person.Person
WHERE PersonType LIKE 'EM';

-- 5) For each job title in the `HumanResources.Employee` table, find the average age in years for employees with that job title and include the overall most common age in years for all employees.
SELECT JobTitle, AVG(DATEDIFF(yy, BirthDate, GETDATE())),
    (SELECT TOP 1 DATEDIFF(yy, BirthDate, GETDATE())
    FROM HumanResources.Employee
    GROUP BY DATEDIFF(yy, BirthDate, GETDATE())
    ORDER BY COUNT(*) DESC)
FROM HumanResources.Employee
GROUP BY JobTitle;

-- 6) For each employee in the `HumanResources.Employee` table, find the LoginID, job title, vacation hours, and sick leave hours. Include two additional columns with the overall average of vacation hours and average of sick leave hours for all employees.
SELECT LoginID, JobTitle, VacationHours, SickLeaveHours,
    (SELECT AVG(VacationHours)
    FROM HumanResources.Employee),
    (SELECT AVG(SickLeaveHours)
    FROM HumanResources.Employee)
FROM HumanResources.Employee;

-- 7) For each married employee in the `Human.Resources.Employee` table (married employees have a MaritalStatus of 'M'), find the LoginID, job title, vacation hours, and sick leave hours. Include two additional columns with the overall average of vacation hours and average of sick leave hours for all married employees. 
SELECT LoginID, JobTitle, VacationHours, SickLeaveHours,
    (SELECT AVG(VacationHours)
    FROM HumanResources.Employee
    WHERE MaritalStatus LIKE 'M'),
    (SELECT AVG(SickLeaveHours)
    FROM HumanResources.Employee
    WHERE MaritalStatus LIKE 'M')
FROM HumanResources.Employee
WHERE MaritalStatus LIKE 'M';

-- 8) For each job title in the `Human.Resources.Employee` table, find the average number of vacation hours and average number of sick leave hours for married employees with that job title. Include two additional columns with the overall average of vacation hours and average of sick leave hours for all married employees. 
SELECT JobTitle, AVG(VacationHours), AVG(SickLeaveHours),
    (SELECT AVG(VacationHours)
    FROM HumanResources.Employee
    WHERE MaritalStatus LIKE 'M'),
    (SELECT AVG(SickLeaveHours)
    FROM HumanResources.Employee
    WHERE MaritalStatus LIKE 'M')
FROM HumanResources.Employee
WHERE MaritalStatus LIKE 'M'
GROUP BY JobTitle;

-- 9) For each product in the `Production.Product` table, find the shelf and bin location (from the `Production.ProductInventory` table) where the largest quantity of each product is stored. Shelf and bin location should be in `shelf-bin` format (e.g. `A-1`, `C-5`, etc.).
SELECT Name,
    (SELECT TOP 1 CONCAT(Shelf,'-',Bin)
     FROM Production.ProductInventory
     WHERE Production.ProductInventory.ProductID = Production.Product.ProductID
     GROUP BY CONCAT(Shelf,'-',Bin)
     ORDER BY SUM(Quantity) DESC)
FROM Production.Product;

-- 10) For each product in the `Production.Product` table with a standard cost greater than 0, find the ProductID and name, as well as the difference between the current standard cost and oldest standard cost for that product (in the `Production.ProductCostHistory` table). Also include the oldest list price for that product (from the `Production.ProductListPriceHistory` table). Order the results on the column with the difference between current and earliest standard cost, from largest to smallest.
SELECT ProductID, Name,
    StandardCost - (SELECT TOP 1 StandardCost
                    FROM Production.ProductCostHistory
                    WHERE Production.ProductCostHistory.ProductID = Production.Product.ProductID
                    ORDER BY StartDate ASC),
    (SELECT TOP 1 ListPrice
    FROM Production.ProductListPriceHistory
    WHERE Production.ProductListPriceHistory.ProductID = Production.Product.ProductID
    ORDER BY StartDate ASC)
FROM Production.Product
WHERE StandardCost > 0
ORDER BY 3 DESC;
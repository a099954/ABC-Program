USE AdventureWorks2019
GO

-- How many employees were hired by year?
SELECT YEAR(HireDate) HireYear, 
    COUNT(BusinessEntityID) AS EmployeeCount
FROM HumanResources.Employee
GROUP BY YEAR(HireDate)
ORDER BY YEAR(HireDate) DESC

-- What are the minimum and maximum differences between the order date and ship date on sales orders?
SELECT MIN(DATEDIFF(d,OrderDate,ShipDate)) MinDiff,MAX(DATEDIFF(d,OrderDate,ShipDate)) MaxDiff
FROM Sales.SalesOrderHeader

-- How many months of data are available for each year?  Keep in mind that we need count of unique months.
SELECT YEAR(OrderDate) OrderYear, COUNT(DISTINCT MONTH(OrderDate)) NumberOfMonths
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate)

-- When was the first order placed?  When was the last order placed?
SELECT MIN(OrderDate) AS FirstOrderDate, 
        MAX(OrderDate) AS LastOrderDate
FROM Sales.SalesOrderHeader

-- What do the number of sales and average sales look for each day of the week?  Spell out the day of the week.
SELECT FORMAT(OrderDate,'dddd') OrderDayOfWeek, COUNT(SalesOrderID) NumberOfSales, AVG(TotalDue) AvgSales  
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2012
GROUP BY FORMAT(OrderDate,'dddd'), DATEPART(weekday,OrderDate)
ORDER BY DATEPART(weekday,OrderDate)

-- What products are taking longer than scheduled?
SELECT WorkOrderID, ProductID, DATEDIFF(d,ScheduledStartDate,ScheduledEndDate) ScheduledTime, DATEDIFF(d,ActualStartDate,ActualEndDate) ActualTime
FROM Production.WorkOrderRouting
WHERE DATEDIFF(d,ScheduledStartDate,ScheduledEndDate) < DATEDIFF(d,ActualStartDate,ActualEndDate) 

-- What products are more than 2 weeks over schedule?
SELECT WorkOrderID, ProductID, DATEDIFF(d,ActualStartDate,ActualEndDate) - DATEDIFF(d,ScheduledStartDate,ScheduledEndDate) DatesOverSchedule
FROM Production.WorkOrderRouting
WHERE DATEDIFF(d,ActualStartDate,ActualEndDate) - DATEDIFF(d,ScheduledStartDate,ScheduledEndDate) > 14 
ORDER BY DatesOverSchedule DESC

-- What's the difference between actual costs and planned costs on work order routing?
SELECT WorkOrderID, ProductID, DATEDIFF(d,ActualStartDate,ActualEndDate) - DATEDIFF(d,ScheduledStartDate,ScheduledEndDate) DatesOverSchedule, ActualCost - PlannedCost OverCost
FROM Production.WorkOrderRouting
WHERE DATEDIFF(d,ScheduledStartDate,ScheduledEndDate) < DATEDIFF(d,ActualStartDate,ActualEndDate) 
AND (ActualCost - PlannedCost) > 0
ORDER BY DatesOverSchedule DESC
/* bad  estimates, good on cost? */

-- What's the most popular day for putting in purchase orders?
SELECT DATENAME(weekday,OrderDate) POWeekDay, COUNT(PurchaseOrderID) POCount
FROM Purchasing.PurchaseOrderHeader
GROUP BY DATENAME(weekday,OrderDate),DATEPART(weekday,OrderDate)
ORDER BY DATEPART(weekday,OrderDate)

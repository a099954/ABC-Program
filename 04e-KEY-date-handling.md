# Exercise: Date Handling - INSTRUCTOR KEY

## Introduction

You have been presented with a data set called AdventureWorks2019. We want to learn more about the company, its employees, orders, invoices, and purchase orders.

## Instructions

1. Create a SQL file with queries to answer the questions.
1. Check your answers with the student key to see if you are on the right track.

Bring questions to class.

## Questions

1. How many employees were hired by year?

    ```sql
    SELECT YEAR(HireDate), COUNT(BusinessEntityID)
    FROM HumanResources.Employee
    GROUP BY YEAR(HireDate)
    ORDER BY YEAR(HireDate) DESC
    ```

2. What are the minimum and maximum differences between the order date and the ship date on sales orders?

    ```sql
    SELECT MIN(DATEDIFF(d, OrderDate, ShipDate)),
        MAX(DATEDIFF(d, OrderDate, ShipDate))
    FROM Sales.SalesOrderHeader
    ```

3. How many months of data are available for each year? Keep in mind that we need a count of unique months.

    ```sql
    SELECT YEAR(OrderDate), COUNT(DISTINCT MONTH(OrderDate))
    FROM Sales.SalesOrderHeader
    GROUP BY YEAR(OrderDate)
    ORDER BY YEAR(OrderDate)
    ```

4. When was the first order placed? When was the last order placed?

    ```sql
    SELECT MIN(OrderDate), MAX(OrderDate)
    FROM Sales.SalesOrderHeader
    ```

5. What does the number of sales and average sales look like for each day of the week? Spell out the day of the week.

    ```sql
    SELECT FORMAT(OrderDate, 'dddd'), COUNT(SalesOrderID), AVG(TotalDue)  
    FROM Sales.SalesOrderHeader
    WHERE YEAR(OrderDate) = 2012
    GROUP BY FORMAT(OrderDate, 'dddd'), DATEPART(WEEKDAY, OrderDate)
    ORDER BY DATEPART(WEEKDAY, OrderDate)
    ```

6. What products are taking longer than scheduled?

    ```sql
    SELECT WorkOrderID, ProductID, DATEDIFF(d,ScheduledStartDate,ScheduledEndDate), DATEDIFF(d,ActualStartDate,ActualEndDate)
    FROM Production.WorkOrderRouting
    WHERE DATEDIFF(d,ScheduledStartDate,ScheduledEndDate) < DATEDIFF(d,ActualStartDate,ActualEndDate) 
    ```

7. What products are more than two weeks over schedule?

    ```sql
    SELECT WorkOrderID, ProductID,
        DATEDIFF(d,ActualStartDate,ActualEndDate) - DATEDIFF(d,ScheduledStartDate,ScheduledEndDate)
    FROM Production.WorkOrderRouting
    WHERE DATEDIFF(d,ActualStartDate,ActualEndDate) - DATEDIFF(d,ScheduledStartDate,ScheduledEndDate) > 14 
    ORDER BY DATEDIFF(d,ActualStartDate,ActualEndDate) - DATEDIFF(d,ScheduledStartDate,ScheduledEndDate) DESC
    ```

8. What's the difference between actual and planned costs on work order routing?

    ```sql
    SELECT WorkOrderID, ProductID,
        DATEDIFF(d,ActualStartDate,ActualEndDate) - DATEDIFF(d,ScheduledStartDate,ScheduledEndDate),
        ActualCost - PlannedCost
    FROM Production.WorkOrderRouting
    WHERE DATEDIFF(d,ScheduledStartDate,ScheduledEndDate) < DATEDIFF(d,ActualStartDate,ActualEndDate)
        AND (ActualCost - PlannedCost) > 0
    ORDER BY DATEDIFF(d,ActualStartDate,ActualEndDate) - DATEDIFF(d,ScheduledStartDate,ScheduledEndDate) DESC
    ```

9. What's the most popular day of the week for putting in purchase orders?

    ```sql
    SELECT DATENAME(WEEKDAY, OrderDate), COUNT(PurchaseOrderID)
    FROM Purchasing.PurchaseOrderHeader
    GROUP BY DATENAME(WEEKDAY, OrderDate), DATEPART(WEEKDAY, OrderDate)
    ORDER BY DATEPART(WEEKDAY, OrderDate)
    ```
    

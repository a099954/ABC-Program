SELECT r.date_format
FROM master.sys.dm_exec_requests r
WHERE r.session_id = @@SPID;

SELECT GETDATE() GetDate, GETUTCDATE() GetUtcDate, SYSDATETIME(), SYSUTCDATETIME(), SYSDATETIMEOFFSET()

SELECT GETDATE(), FORMAT(GETDATE(),'hh:mm:ss'), FORMAT(GETDATE(),'MM-dd-yyyy'), FORMAT(GETDATE(),'MM/dd/yy')


USE WideWorldImporters
GO

-- YEAR
SELECT YEAR(InvoiceDate), 
    SUM(TotalChillerItems) AS ChillerItems, 
    SUM(TotalDryItems) AS DryItems 
FROM Sales.Invoices
GROUP BY YEAR(InvoiceDate)
ORDER BY YEAR(InvoiceDate) DESC

SELECT MIN(InvoiceDate) as EarliestInvoice, MAX(InvoiceDate) as LatestInvoice
FROM Sales.Invoices

-- YEAR and MONTH
SELECT YEAR(InvoiceDate) AS Year, 
    MONTH(InvoiceDate) AS Month,
    SUM(TotalChillerItems) AS ChillerItems, 
    SUM(TotalDryItems) AS DryItems 
FROM Sales.Invoices
WHERE YEAR(InvoiceDate) = 2016 OR YEAR(InvoiceDate) = 2015
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY YEAR(InvoiceDate) DESC, MONTH(InvoiceDate)

-- MIN and MAX

SELECT MIN(InvoiceDate) AS FirstInvoiceDate, 
        MAX(InvoiceDate) AS LastInvoiceDate
FROM Sales.Invoices

-- Day 
SELECT DAY(InvoiceDate) AS Day,
    COUNT(InvoiceID) AS NumberOfInvoices,
    SUM(TotalChillerItems) AS ChillerItems, 
    SUM(TotalDryItems) AS DryItems 
FROM Sales.Invoices
WHERE YEAR(InvoiceDate) = 2016 AND Month(InvoiceDate) = 4
GROUP BY DAY(InvoiceDate)
ORDER BY DAY(InvoiceDate)

-- Day of Week
SELECT YEAR(InvoiceDate) Year,DATEPART(q,InvoiceDate) AS Quarter,
    SUM(TotalChillerItems) AS ChillerItems, 
    SUM(TotalDryItems) AS DryItems 
FROM Sales.Invoices
WHERE YEAR(InvoiceDate) IN (2014,2015)
GROUP BY YEAR(InvoiceDate),DATEPART(q,InvoiceDate)
ORDER BY YEAR(InvoiceDate),DATEPART(q,InvoiceDate)

-- Today's Day
SELECT DATENAME(WEEKDAY,GETDATE())

-- Items by Day Name
SELECT DATENAME(WEEKDAY,InvoiceDate) AS Day,
    SUM(TotalChillerItems) AS ChillerItems, 
    SUM(TotalDryItems) AS DryItems 
FROM Sales.Invoices
WHERE YEAR(InvoiceDate) = 2016
GROUP BY DATENAME(WEEKDAY,InvoiceDate)

-- Ordered by Name
SELECT DATENAME(WEEKDAY,InvoiceDate) AS Day,    
    SUM(TotalChillerItems) AS ChillerItems, 
    SUM(TotalDryItems) AS DryItems 
FROM Sales.Invoices
WHERE YEAR(InvoiceDate) = 2016
GROUP BY DATENAME(WEEKDAY,InvoiceDate)
ORDER BY DATENAME(WEEKDAY,InvoiceDate)

-- DATEPART guidance: https://docs.microsoft.com/en-us/sql/t-sql/functions/datepart-transact-sql?view=sql-server-ver15
SELECT DATENAME(WEEKDAY,InvoiceDate) AS Day,    
    COUNT(InvoiceDate) AS NumberOfInvoices     
FROM Sales.Invoices
GROUP BY DATENAME(WEEKDAY,InvoiceDate), DATEPART(dw, InvoiceDate)
ORDER BY DATEPART(dw, InvoiceDate)

-- DATEDIFF: https://docs.microsoft.com/en-us/sql/t-sql/functions/datediff-transact-sql?view=sql-server-ver15
-- DATEFROMPARTS: https://docs.microsoft.com/en-us/sql/t-sql/functions/datefromparts-transact-sql?view=sql-server-ver15
DECLARE @firstOfYear date
SET @firstOfYear = DATEFROMPARTS(YEAR(GETDATE()),1,1)
SELECT @firstOfYear

SELECT CAST('2021-01-01 00:00:00.000' as datetime)
SELECT CAST('2021-01-01 00:00:00.000000 -04:00' as datetime2)
SELECT CAST('2021-01-01 00:00:00.000000 -04:00' as datetimeoffset)

SELECT DATEDIFF(d,OrderDate,ExpectedDeliveryDate)
FROM Purchasing.PurchaseOrders
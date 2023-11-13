-- Collation

USE Master
GO
SELECT
 NAME, 
 COLLATION_NAME
FROM sys.Databases
 ORDER BY DATABASE_ID ASC
GO

-- Regex

USE WideWorldImporters
GO


-- PATINDEX
SELECT FullName FROM Application.People WHERE PATINDEX('%kriti%',FullName) > 0

-- Not equal
SELECT FullName FROM Application.People WHERE PATINDEX('%kriti%',FullName) <> 0

-- Not equal
SELECT FullName FROM Application.People WHERE PATINDEX('%kriti%',FullName) != 0

-- Use COLLATE to force accent and case sensitivity with _BIN
SELECT FullName FROM Application.People WHERE PATINDEX('A%B%',FullName) > 0
SELECT FullName FROM Application.People WHERE PATINDEX('A%B%',FullName COLLATE Latin1_General_BIN) > 0

-- LIKE

-- Starts with either U or Y
SELECT FullName FROM Application.People WHERE FullName LIKE '[UY]%'

-- Ends with U or Y
SELECT FullName FROM Application.People WHERE FullName LIKE '%[UY]'

-- 'kriti' example with LIKE instead of PATINDEX
SELECT FullName FROM Application.People WHERE FullName LIKE '%kriti%'

-- All names that start X-Z
SELECT FullName FROM Application.People WHERE FullName LIKE '[X-Z]%'

-- All names that start X-Z with 'a' as the second letter
SELECT FullName FROM Application.People WHERE FullName LIKE '[X-Z]a%'

-- All names that end with a vowel and y
SELECT FullName FROM Application.People WHERE FullName LIKE '%[aeiou]y'

-- All names that end with a vowel and y that aren't "-n*y"
SELECT FullName FROM Application.People WHERE FullName LIKE '%[^n][aeiou]y'

-- Adding a case sensitivity check
SELECT FullName FROM Application.People WHERE FullName COLLATE Latin1_General_BIN LIKE '%D%[^n][aeiou]y'

-- No collation, defaults to the database collation
SELECT FullName FROM Application.People WHERE FullName LIKE '%D%[^n][aeiou]y'

-- Find email addresses that don't match a pattern
SELECT EmailAddress 
FROM Application.People 
WHERE EmailAddress NOT LIKE '%[A-Z0-9][@][A-Z0-9]%[.][A-Z0-9]%'

-- DATES

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
    SUM(TotalChillerItems) AS ChillerItems, 
    SUM(TotalDryItems) AS DryItems 
FROM Sales.Invoices
WHERE YEAR(InvoiceDate) = 2016
GROUP BY DAY(InvoiceDate)
ORDER BY DAY(InvoiceDate)

-- Day of Week

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
    DATEPART(dw, InvoiceDate) AS DayOfWeek,
    SUM(TotalChillerItems) AS ChillerItems, 
    SUM(TotalDryItems) AS DryItems 
FROM Sales.Invoices
WHERE YEAR(InvoiceDate) = 2016
GROUP BY DATENAME(WEEKDAY,InvoiceDate), DATEPART(dw, InvoiceDate)
ORDER BY DATEPART(dw, InvoiceDate)

-- DATEDIFF: https://docs.microsoft.com/en-us/sql/t-sql/functions/datediff-transact-sql?view=sql-server-ver15
-- DATEFROMPARTS: https://docs.microsoft.com/en-us/sql/t-sql/functions/datefromparts-transact-sql?view=sql-server-ver15
SELECT DATEDIFF(d,
                DATEFROMPARTS(YEAR(GETDATE()),1,1),
                GETDATE()
        )

SELECT DATEDIFF(d,
                CAST('2021-01-01' AS date),
                GETDATE()
        )

SELECT DATEDIFF(d,
        CAST('01/01/2021' AS date),
        GETDATE()
)

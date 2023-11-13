USE WideWorldImporters

/* WHERE keyword */
SELECT * FROM Warehouse.Colors WHERE ColorName='Blue'

-- What if we use double quotes?
SELECT * FROM Warehouse.Colors WHERE ColorName="Blue"

-- Don't need quotes for numbers
SELECT * FROM Warehouse.Colors WHERE ColorID=2

-- Less than
SELECT ColorID, ColorName FROM Warehouse.Colors WHERE ColorID < 5

-- Less than or equal
SELECT ColorID, ColorName FROM Warehouse.Colors WHERE ColorID <= 5

/* Working with NULL */

SELECT TOP 5 CustomerName, CreditLimit FROM Sales.Customers WHERE CreditLimit IS NULL
SELECT TOP 3 CustomerName, CreditLimit FROM Sales.Customers WHERE CreditLimit IS NOT NULL

/* CASE Statement */

-- Default value in place of NULL
SELECT TOP 3 CustomerName, 
CASE
    WHEN CreditLimit IS NULL THEN 9999999999
    ELSE CreditLimit
END 
FROM Sales.Customers

-- AS for alias
SELECT TOP 3 CustomerName, 
CASE
    WHEN CreditLimit IS NULL THEN 9999999999
    ELSE CreditLimit
END AS CreditLimit 
FROM Sales.Customers

/* CONVERT and CAST */

-- CAST
SELECT TOP 3 CustomerName, 
CASE
   WHEN CreditLimit IS NULL THEN 'No Limit'
   ELSE CAST(CreditLimit AS varchar(20))
END AS CreditLimit 
FROM Sales.Customers

-- CONVERT
SELECT TOP 3 CustomerName, 
CASE
   WHEN CreditLimit IS NULL THEN 'No Limit'
   ELSE CONVERT(varchar(20),CreditLimit)
END AS CreditLimit 
FROM Sales.Customers

/*
For the names we know have limits, we can use the IN keyword to limit them.
For those who have no limits - such as Tailspin Toys - we can use the LIKE keyword to filter the customer name.
We can use the OR keyword to join those clauses. We will explain the OR keyword after we run this query.
To ensure we get more than just the Tailspin Toys entries, we can use an ORDER BY clause with the field name we want to order by - in this case, CustomerName.  
Since we are not specifying what order to use, the CustomerName will sort alphabetically, A-to-Z.
*/
SELECT TOP 5 CustomerName, CASE
    WHEN CreditLimit IS NULL THEN 'No Limit'
    ELSE CAST(CreditLimit AS varchar(20))
END AS CreditLimit
FROM Sales.Customers
WHERE CustomerName IN ('Eric Torres', 'Cosmina Vlad', 'Bala Dixit') OR CustomerName LIKE 'Tailspin%'
ORDER BY CustomerName

/* OR keyword */
SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE YEAR(AccountOpenedDate) = 2015 OR YEAR(AccountOpenedDate) = 2016 ORDER BY AccountOpenedDate DESC

/* LIKE keyword */

-- Starts with
SELECT * FROM Warehouse.Colors WHERE ColorName LIKE 'Blue%'

-- Ends with
SELECT * FROM Warehouse.Colors WHERE ColorName LIKE '%Blue'

-- In the middle
SELECT * FROM Warehouse.Colors WHERE ColorName LIKE '%Blue%'

-- What if a single quote is in the value?
SELECT CustomerName FROM Sales.Customers WHERE CustomerName LIKE '%''%'

/* Date Functions */

-- YEAR
SELECT YEAR(AccountOpenedDate) FROM Sales.Customers

-- DISTINCT
SELECT DISTINCT YEAR(AccountOpenedDate) FROM Sales.Customers

-- WHERE YEAR()
SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE YEAR(AccountOpenedDate) = 2014

/* AND keyword */

-- SQL Variables and SELECT +
DECLARE @ShahAccountDate DATETIME
SELECT @ShahAccountDate = AccountOpenedDate FROM Sales.Customers WHERE CustomerName = 'Dipti Shah'
SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE MONTH(AccountOpenedDate) = MONTH(@ShahAccountDate) AND YEAR(AccountOpenedDate) = YEAR(@ShahAccountDate)


-- AND NOT LIKE
SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE YEAR(AccountOpenedDate) = 2013 AND CustomerName NOT LIKE '%Toys%'

/* BETWEEN keyword */
SELECT CustomerName, CreditLimit FROM Sales.Customers WHERE CreditLimit BETWEEN 2500.00 AND 3000.00

-- Alpha BETWEEN
SELECT CustomerName FROM Sales.Customers WHERE CustomerName BETWEEN 'A' AND 'B' ORDER BY CustomerName

-- Alpha BETWEEN with more filtering
SELECT CustomerName FROM Sales.Customers WHERE CustomerName BETWEEN 'Ar' AND 'Bz' ORDER BY CustomerName

-- SET for variables, BETWEEN with variables
DECLARE @StartDate date, @EndDate date 
SET @StartDate = '2014-01-01' -- YYYY-MM-DD format, surrounded by single quotes
SET @EndDate = '2014-06-30'

SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE AccountOpenedDate BETWEEN @StartDate AND @EndDate

-- BETWEEN variable and value
DECLARE @CustomerAccountDate DATE
SELECT @CustomerAccountDate = AccountOpenedDate FROM Sales.Customers WHERE CustomerName = 'Aive Petrov' -- '2013-08-10'
SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE AccountOpenedDate BETWEEN @CustomerAccountDate AND '2013-08-31'

-- EOMONTH
DECLARE @CustomerAccountDate DATE
SELECT @CustomerAccountDate = AccountOpenedDate FROM Sales.Customers WHERE CustomerName = 'Aive Petrov' -- '2013-08-10'
SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE AccountOpenedDate BETWEEN @CustomerAccountDate AND EOMONTH(@CustomerAccountDate)

DECLARE @Today datetime = GETDATE()
SELECT @Today, EOMONTH(@Today,-1), EOMONTH(@Today), EOMONTH(@Today,1)

/* AS Keyword */

-- With AS
DECLARE @Today datetime = GETDATE()
SELECT @Today AS 'Today', EOMONTH(@Today,-1) AS 'EndOfLastMonth', EOMONTH(@Today) AS 'EndOfThisMonth', EOMONTH(@Today,1) AS 'EndOfNextMonth'

-- AS Optional
DECLARE @Today datetime = GETDATE()
SELECT @Today 'Today', EOMONTH(@Today,-1) 'EndOfLastMonth', EOMONTH(@Today) 'EndOfThisMonth', EOMONTH(@Today,1) 'EndOfNextMonth'

/* IN keyword */

-- Numeric values
SELECT ColorID, ColorName FROM Warehouse.Colors WHERE ColorID IN (1, 4, 6)

-- Dates
SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE AccountOpenedDate IN ('2014-05-14','2014-11-13', '2014-12-03')

/* ORDER BY */

-- Date range
SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE YEAR(AccountOpenedDate) = 2014 ORDER BY AccountOpenedDate

-- DESC keyword
SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE YEAR(AccountOpenedDate) = 2014 ORDER BY AccountOpenedDate DESC

-- WHERE ORDER BY
SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE AccountOpenedDate = '2013-01-01' AND CustomerName NOT LIKE '%Toys%' ORDER BY CustomerName

-- Update data to get a case to happen
UPDATE Sales.Customers SET AccountOpenedDate='2015-09-23' WHERE CustomerName = 'Sylvie Laramee'

-- Date Descending, CustomerName Ascending
SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE YEAR(AccountOpenedDate) != 2013 ORDER BY AccountOpenedDate DESC, CustomerName ASC

-- Leaving off ASC
SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE YEAR(AccountOpenedDate) != 2013 ORDER BY AccountOpenedDate DESC, CustomerName

-- IN with strings, ordered by date
SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE CustomerName IN ('Nguyen Banh', 'Erik Malk', 'Emma Van Zant', 'Damodara Trivedi') ORDER BY AccountOpenedDate
USE WideWorldImporters

-- 1) Using the `Sales.InvoiceLines` table, find out the total quantity of each stock item that has been sold.
SELECT StockItemID, SUM(Quantity)
FROM Sales.InvoiceLines
GROUP BY StockItemID

-- 2) Using the `Sales.InvoiceLines` table, for items with UnitPrices greater than 20, find out the total quantity of each stock item that has been sold.
SELECT StockItemID, SUM(Quantity)
FROM Sales.InvoiceLines
WHERE UnitPrice > 20
GROUP BY StockItemID

-- 3) Using the `Sales.InvoiceLines` table, for items with UnitPrices greater than 20, find out the total quantity of each stock item that has been sold. Filter the results to only items with total quantities greater than 6000.
SELECT StockItemID, SUM(Quantity)
FROM Sales.InvoiceLines
WHERE UnitPrice > 20
GROUP BY StockItemID
HAVING SUM(Quantity) > 6000

-- 4) Using the `Sales.InvoiceLines` table, determine the average quantity ordered for each stock item with 'chocolate' in the description. Filter the results to only stock items where the total quantity ordered is between 10000 and 20000.
SELECT StockItemID, [Description], AVG(Quantity)
FROM Sales.InvoiceLines
WHERE [Description] LIKE '%chocolate%'
GROUP BY StockItemID, [Description]
HAVING SUM(Quantity) BETWEEN 10000 AND 20000

-- 5) Using the `Sales.InvoiceLines` table, find the average profit per item for all stock items that are sold in quantities of 100 or more on average.
--    > Hint: The `LineProfit` is the total profit over the whole quantity of items.
SELECT StockItemID, AVG(LineProfit/Quantity)
FROM Sales.InvoiceLines
GROUP BY StockItemID
HAVING AVG(Quantity) >= 100

-- 6) How many people (in `Application.People`) are associated with each phone number?
SELECT PhoneNumber, COUNT(*)
FROM Application.People
GROUP BY PhoneNumber

-- 7) How many customer transactions were finalized on each date in `Sales.CustomerTransactions`? Sort the results from the earliest date to the latest date. Exclude rows with missing values for `FinalizationDate`.
SELECT FinalizationDate, COUNT(*)
FROM Sales.CustomerTransactions
WHERE FinalizationDate IS NOT NULL
GROUP BY FinalizationDate
ORDER BY FinalizationDate

-- 8)How many customer transactions were finalized and what was the maximum transaction amount for each month/year in `Sales.CustomerTransactions` (i.e. How many in 01/2013? How many in 02/2013)? Sort the results from the earliest date to the latest date. Exclude rows with missing values for `FinalizationDate`.
SELECT YEAR(FinalizationDate), MONTH(FinalizationDate), COUNT(*), MAX(TransactionAmount)
FROM Sales.CustomerTransactions
WHERE FinalizationDate IS NOT NULL
GROUP BY YEAR(FinalizationDate), MONTH(FinalizationDate)
ORDER BY YEAR(FinalizationDate), MONTH(FinalizationDate)

-- 9) Using `Application.TransactionTypes`, determine the `TransactionTypeID` for Customer Invoices, and then use that to calculate the number of Customer Invoices and total `TransactionAmounts` for each customer in `Sales.CustomerTransactions`. Sort the result by `CustomerID`, from smallest to largest.
DECLARE @InvoiceTransaction INT
SELECT @InvoiceTransaction = TransactionTypeID
FROM Application.TransactionTypes
WHERE TransactionTypeName = 'Customer Invoice'

SELECT CustomerID, COUNT(*), SUM(TransactionAmount)
FROM Sales.CustomerTransactions
WHERE TransactionTypeID = @InvoiceTransaction
GROUP BY CustomerID, TransactionTypeID
ORDER BY CustomerID

-- 10) How many stock items are listed with each combination of tags and what is the average unit price for items by tags?
SELECT Tags, COUNT(*), AVG(UnitPrice)
FROM Warehouse.StockItems
GROUP BY Tags

-- 11) Using `Warehouse.StockItemHoldings`, find the total difference between `QuantityOnHand` and `LastStocktakeQuantity` for each `BinLocation`. Only include results with total differences greater than 10000.
SELECT BinLocation, SUM(QuantityOnHand - LastStocktakeQuantity)
FROM Warehouse.StockItemHoldings
GROUP BY BinLocation
HAVING SUM(QuantityOnHand - LastStocktakeQuantity) > 10000

-- 12) Using `Warehouse.StockItemHoldings`, find the total difference between `QuantityOnHand` and `LastStocktakeQuantity` for each `BinLocation` area (indicated by the letters at the start of each `BinLocation`).
SELECT SUBSTRING(BinLocation, 0, CHARINDEX('-', BinLocation)), SUM(QuantityOnHand - LastStocktakeQuantity)
FROM Warehouse.StockItemHoldings
GROUP BY SUBSTRING(BinLocation, 0, CHARINDEX('-', BinLocation))

-- 13) How many people (in `Application.People`) are there with email addresses ending in each domain name? (i.e. How many have '@example.com'? How many have '@tailspintoys.com'?)
SELECT SUBSTRING(EmailAddress,CHARINDEX('@',EmailAddress)+1,LEN(EmailAddress)), COUNT(*)
FROM Application.People
WHERE EmailAddress IS NOT NULL
GROUP BY SUBSTRING(EmailAddress,CHARINDEX('@',EmailAddress)+1,LEN(EmailAddress))

-- 14) Using `Sales.Invoices`, find the total number of dry and chiller items delivered to each Suite (where `DeliveryInstructions` specifies a Suite). Only include results where the total number of items is less than 300.
SELECT DeliveryInstructions, SUM(TotalDryItems + TotalChillerItems)
FROM Sales.Invoices
WHERE SUBSTRING(DeliveryInstructions, 0, CHARINDEX(' ', DeliveryInstructions)) LIKE 'Suite'
GROUP BY DeliveryInstructions
HAVING SUM(TotalDryItems + TotalChillerItems) < 300

-- 15) Using Sales.Invoices, find the number of invoices and total number of dry and chiller items delivered for orders that were received by people whose last name starts with a vowel (not counting "y"). Only include results with 115 or more invoices.
SELECT ConfirmedReceivedBy, SUM(TotalDryItems + TotalChillerItems), COUNT(InvoiceID)
FROM Sales.Invoices
WHERE SUBSTRING(ConfirmedReceivedBy, CHARINDEX(' ', ConfirmedReceivedBy)+1, 1) IN ('a','e','i','o','u') 
GROUP BY ConfirmedReceivedBy
HAVING COUNT(InvoiceID) >= 115
USE WideWorldImporters

-- 1) For each customer in the `Sales.Customers` table, find the CustomerName and count of transactions for that customer in the `Sales.CustomerTransactions` table. Sort the result on count of transactions from most to least.
SELECT CustomerName,
    (SELECT COUNT(CustomerID)
     FROM Sales.CustomerTransactions
     WHERE Sales.CustomerTransactions.CustomerID = Sales.Customers.CustomerID)
FROM Sales.Customers
ORDER BY 2 DESC

-- 2) For each customer in the `Sales.Customers` table, find the CustomerName and the total transaction amount for that customer in the `Sales.CustomerTransactions` table. Only include customers without a BuyingGroupID. Sort the results on total transaction amount from largest to smallest.
SELECT CustomerName,
    (SELECT SUM(TransactionAmount)
     FROM Sales.CustomerTransactions
     WHERE Sales.CustomerTransactions.CustomerID = Sales.Customers.CustomerID)
FROM Sales.Customers
WHERE BuyingGroupID IS NULL
ORDER BY 2 DESC

-- 3) Using the `Sales.CustomerTransactions` table, find the CustomerID, CustomerTransactionID, and TransactionAmount for all 'Customer Invoice' transactions (hint: use the `Application.TransactionTypes` table to get the corresponding ID). Include a column with the overall average transaction amount for all 'Customer Invoice' transactions. Sort the results on CustomerID from highest to lowest.
DECLARE @InvoiceID INT
SELECT @InvoiceID = TransactionTypeID
FROM Application.TransactionTypes
WHERE TransactionTypeName LIKE '%Customer Invoice%'

SELECT CustomerID, CustomerTransactionID, TransactionAmount,
    (SELECT AVG(TransactionAmount)
     FROM Sales.CustomerTransactions
     WHERE TransactionTypeID = @InvoiceID)
FROM Sales.CustomerTransactions
WHERE TransactionTypeID = @InvoiceID
ORDER BY CustomerID DESC

-- 4) Using the `Sales.OrderLines` table, calculate the total price (including quantity purchased and tax rate in the calculation) for each OrderID. Use a subquery to include a column showing the combined total price for all orders. Sort the results based on the total price for each order, from highest to lowest.
SELECT OrderID,
    SUM((Quantity*UnitPrice)*(1+(TaxRate/100))), 
    (SELECT SUM((Quantity*UnitPrice)*(1+(TaxRate/100)))
     FROM Sales.OrderLines)
FROM Sales.OrderLines
GROUP BY OrderID
ORDER BY 2 DESC

-- 5) For each order in the `Sales.Orders` table, include the OrderID and OrderDate as well as the total price (from the `Sales.OrderLines` table) for that OrderID.
SELECT OrderID, OrderDate,
    (SELECT SUM((Quantity*UnitPrice)*(1+(TaxRate/100)))
     FROM Sales.OrderLines
     WHERE Sales.OrderLines.OrderID = Sales.Orders.OrderID)
FROM Sales.Orders

-- Alternative query solution
SELECT OrderID,
    (SELECT OrderDate
     FROM Sales.Orders
     WHERE Sales.Orders.OrderID = Sales.OrderLines.OrderID),
    SUM((Quantity*UnitPrice)*(1+(TaxRate/100)))
FROM Sales.OrderLines
GROUP BY OrderID
ORDER BY OrderID

-- 6) For each item in the `Warehouse.StockItems` table, find the item name, unit price, and maximum quantity ordered in the `Sales.OrderLines` table.
SELECT StockItemName, UnitPrice,
    (SELECT MAX(Quantity)
    FROM Sales.OrderLines
    WHERE Sales.OrderLines.StockItemID = Warehouse.StockItems.StockItemID)
FROM Warehouse.StockItems

-- 7) For each item in the `Warehouse.StockItems` table, find the item name and the date (in 'MM/dd/yyyy' format) of the most recent transaction (from `Warehouse.StockItemTransactions`) for that item. Sort the results from the oldest date to the most recent.
SELECT StockItemName,
    (SELECT TOP 1 FORMAT(TransactionOccurredWhen, 'MM/dd/yyyy')
     FROM Warehouse.StockItemTransactions
     WHERE Warehouse.StockItemTransactions.StockItemID = Warehouse.StockItems.StockItemID
     ORDER BY TransactionOccurredWhen DESC)
FROM Warehouse.StockItems
ORDER BY 2 ASC

-- 8) For each item in the `Warehouse.StockItems` table, find the item name and the most common quantity the item is ordered in (from `Sales.OrderLines`). Sort the results on the most common quantity ordered, from largest to smallest.
SELECT StockItemName,
    (SELECT TOP 1 Quantity
     FROM Sales.OrderLines
     WHERE Sales.OrderLines.StockItemID = Warehouse.StockItems.StockItemID
     GROUP BY Quantity
     ORDER BY COUNT(*) DESC)
FROM Warehouse.StockItems
ORDER BY 2 DESC

-- 9) For all items in the `Sales.OrderLines` table with a unit price of 10 or lower, find the StockItemID, average quantity ordered, and difference between the average quantity for that item and the overall average quantity ordered for all items with a unit price of 10 or lower. Sort the results based on the column with the difference, from most positive to most negative.
SELECT StockItemID, AVG(Quantity), 
    AVG(Quantity) - (SELECT AVG(Quantity)
                     FROM Sales.OrderLines
                     WHERE UnitPrice <= 10)
FROM Sales.OrderLines
WHERE UnitPrice <= 10
GROUP BY StockItemID
ORDER BY 3 DESC

-- 10) Using the `Sales.InvoiceLines` table, find the InvoiceID, description, and extended price for all invoice lines with StockItemID 227. Include a column with the extended price for each invoice as a percentage of the overall total price for all items with StockItemID 227. Sort the results on the ExtendedPrice, from highest to lowest.
SELECT InvoiceID, Description, ExtendedPrice, 
    (ExtendedPrice/(SELECT SUM(ExtendedPrice)
     FROM Sales.InvoiceLines
     WHERE StockItemID = 227))*100
FROM Sales.InvoiceLines
WHERE StockItemID = 227
ORDER BY 3 DESC
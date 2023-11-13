USE WideWorldImporters

-- 1) Select all customer names and delivery postal codes for customers with delivery postal codes located in Inglewood, CA (Postal codes starting with 903).
SELECT CustomerName, DeliveryPostalCode
FROM Sales.Customers
WHERE DeliveryPostalCode LIKE '903%'

-- 2) Find all customer names and phone numbers for customers using phone numbers with Philadelphia, New York City, and Boston area codes (215, 212, 339)
SELECT CustomerName, PhoneNumber
FROM Sales.Customers
WHERE LEFT(PhoneNumber, 5) IN ('(215)','(212)','(339)')

-- 3) Select all customer names and credit limits for all customers with a credit limit between 1500 and 2200 (inclusive). Order by CreditLimit descending.
SELECT CustomerName, CreditLimit
FROM Sales.Customers
WHERE CreditLimit BETWEEN 1500 AND 2200
ORDER BY CreditLimit DESC

-- 4) Find all names and email addresses for people (in Application.People) whose email address is from "wingtiptoys.com".
SELECT FullName, EmailAddress
FROM Application.People
WHERE EmailAddress LIKE '%wingtiptoys%'

-- 5) Find the names of all people (in Application.People) whose first and last names end with the same letter.
SELECT FullName
FROM Application.People
WHERE RIGHT(SUBSTRING(FullName,0,CHARINDEX(' ',FullName)),1) = RIGHT(SUBSTRING(FullName,CHARINDEX(' ',FullName)+ 1,LEN(FullName)),1)

-- 6) Select the name and other languages for all people (in Application.People) who speak either Dutch or Arabic.
SELECT FullName, OtherLanguages
FROM Application.People
WHERE (OtherLanguages LIKE '%Dutch%' OR OtherLanguages LIKE '%Arabic%')

-- 7) Select the name and other languages for all people (in Application.People) who speak either Dutch or Arabic, but not Finnish.
SELECT FullName, OtherLanguages
FROM Application.People
WHERE (OtherLanguages LIKE '%Dutch%' OR OtherLanguages LIKE '%Arabic%')
    AND (OtherLanguages NOT LIKE '%Finnish%')

-- 8) Select the SupplierTransactionID, TransactionDate, and TransactionAmount for all SupplierTransactions where the transaction date occurred in 2013 or 2015 and the transaction amount was negative. Sort by transaction amount, ascending.
SELECT SupplierTransactionID, TransactionDate, TransactionAmount
FROM Purchasing.SupplierTransactions
WHERE YEAR(TransactionDate) IN (2013, 2015)
    AND TransactionAmount < 0
ORDER BY TransactionAmount ASC

-- 9) Using Sales.Invoices, find all unique names of people who confirmed receiving invoices whose initials are P.B.
SELECT DISTINCT ConfirmedReceivedBy
FROM Sales.Invoices
WHERE ConfirmedReceivedBy LIKE 'P% B%'

-- 10) Using the Warehouse.StockItems table, find the item name and the difference between the RecommendedRetailPrice and the UnitPrice (taking into account the TaxRate) for all 16GB USBs.
SELECT StockItemName, RecommendedRetailPrice - (UnitPrice*(1 + (TaxRate/100)))
FROM Warehouse.StockItems
WHERE StockItemName LIKE '%USB%' AND Tags LIKE '%16GB%'

-- 11) Find the name and UnitPackageID for all stock items (in Warehouse.StockItems) that have a UnitPackageID corresponding to the PackageTypeName "Pair" (in Warehouse.PackageTypes).
-- Hint: First declare a variable and assign it the value of the PackageTypeID for PackageTypeName "Pair". Then use this variable to query for StockItems with the associated UnitPackageID.
DECLARE @PackageID INT
SELECT @PackageID = PackageTypeID
FROM Warehouse.PackageTypes
WHERE PackageTypeName LIKE 'Pair'

SELECT StockItemName, UnitPackageID
FROM Warehouse.StockItems
WHERE UnitPackageID = @PackageID

-- 12) Find the names of all people (in Application.People) whose last name is only 2 letters long. Sort the results alphabetically ascending by last name.
SELECT FullName
FROM Application.People
WHERE LEN(SUBSTRING(FullName, CHARINDEX(' ',FullName)+1,LEN(FullName))) = 2
ORDER BY SUBSTRING(FullName, CHARINDEX(' ',FullName)+1,LEN(FullName))
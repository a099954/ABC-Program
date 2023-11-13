USE WideWorldImporters

-- What colors start with Dark?
SELECT ColorID, ColorName 
FROM Warehouse.Colors
WHERE ColorName LIKE 'Dark%'

-- Which colors are 5-lettered colors?
SELECT ColorName
FROM Warehouse.Colors
WHERE LEN(ColorName) = 5

-- What are the color names for the following ColorIDs - 1,11, 15, and 36? Use the OR keyword.
SELECT ColorName, ColorID 
FROM Warehouse.Colors 
WHERE ColorID = 1 OR ColorID = 11 OR ColorID=15 OR ColorID=36

-- What are the color names for the following ColorIDs - 1,11, 15, and 36? Use the IN keyword.
SELECT ColorName, ColorID 
FROM Warehouse.Colors 
WHERE ColorID IN (1, 11, 15, 36)

-- Which customers have the PostalCityId of 242?
SELECT CustomerName
FROM Sales.Customers
WHERE PostalCityId = 242

-- Are there any customers with the delivery postal code of 90210?
SELECT CustomerName FROM Sales.Customers WHERE DeliveryPostalCode = '90210'

-- Which customers start with 'An'?
SELECT CustomerName FROM Sales.Customers WHERE CustomerName LIKE 'An%'

-- Which customers start with 'An'?
SELECT CustomerName FROM Sales.Customers WHERE CustomerName BETWEEN 'An' AND 'Ao'

-- Which customers have phone numbers that follow the pattern of 555-?  What are their phone numbers?
SELECT CustomerName, PhoneNumber FROM Sales.Customers WHERE PhoneNumber LIKE '%555-%'

-- Which customer has deliveries to Shop 2 and a PO Box in Emilyville?
SELECT * FROM Sales.Customers WHERE DeliveryAddressLine1 = 'Shop 2' and PostalAddressLine2 = 'Emilyville'

-- What are the unique delivery methods on the Customers table?
SELECT DISTINCT DeliveryMethodID From Sales.Customers

-- Who are the last 5 customers when ordered alphabetically? Hint: The last 5 customers alphabetically are the first 5 customers reverse alphabetically.
SELECT TOP 5 CustomerName FROM Sales.Customers ORDER BY CustomerName DESC

-- Which accounts were created between July 1 and December 31 of 2015 ordered from latest to earliest, then alphabetical by customer name? Use the comparison operators of \<, \>, and =.
SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE AccountOpenedDate >= '2015-07-01' AND AccountOpenedDate <= '2015-12-31' ORDER BY AccountOpenedDate DESC, CustomerName

-- Which accounts were created between July 1 and December 31 of 2015 ordered from latest to earliest, then alphabetical by customer name? Use the BETWEEN clause.
SELECT CustomerName, AccountOpenedDate FROM Sales.Customers WHERE AccountOpenedDate BETWEEN '2015-07-01' AND '2015-12-31' ORDER BY AccountOpenedDate DESC, CustomerName

-- What are the credit limits for Dipti Shah, Ivana Hadrabova, Emma Salpa, and Ian Olofsson? Order them lowest to highest credit limits.
SELECT CustomerName, CreditLimit FROM Sales.Customers WHERE CustomerName IN ('Dipti Shah','Ivana Hadrabova', 'Emma Salpa', 'Ian Olofsson') ORDER BY CreditLimit

-- What are 5 accounts that do not have a buying group assigned to it?
SELECT TOP 5 CustomerName, BuyingGroupId FROM Sales.Customers WHERE BuyingGroupId IS NULL

-- What are 5 accounts that have a buying group assigned to it?
SELECT TOP 5 CustomerName, BuyingGroupId FROM Sales.Customers WHERE BuyingGroupId IS NOT NULL

-- It is on the learner to find a pattern to include at least 2 of the named customers in the IN clause and 2 for the LIKE clause
-- They can use CAST or CONVERT
-- For more thoughts, ask them why they chose the type for casting or converting.

/*
Show 5 customers with the following details:

- At least 2 customers must not have a buying group assigned - call these customers out with the IN clause
- At least 2 customers must have a buying group assigned - call these customers out with a LIKE clause
- When the buying group is NULL, show 'No Buyer'.  Alias this column as BuyerGroup.
- Order By BuyerGroup
*/
SELECT TOP 5 CustomerName,
CASE WHEN BuyingGroupId IS NULL THEN 'No Buyer'
ELSE CAST(BuyingGroupId AS char(1))
END AS BuyerGroup
 FROM Sales.Customers 
 WHERE CustomerName IN ('Eric Torres','Cosmina Vlad','Bala Dixit') OR CustomerName LIKE 'Tailspin%(%MT%)'
 ORDER BY BuyerGroup

SELECT TOP 5 CustomerName,
CASE WHEN BuyingGroupId IS NULL THEN 'No Buyer'
ELSE CONVERT(char(1),BuyingGroupId)
END AS BuyerGroup
FROM Sales.Customers 
WHERE CustomerName IN ('Eric Torres','Cosmina Vlad','Bala Dixit') OR CustomerName LIKE 'Tailspin%(%MT%)'
ORDER BY BuyerGroup
# Exercise: Filtering SQL - INSTRUCTOR KEY

## Introduction

In the Filtering SQL lesson, we introduced the `WHERE` clause and multiple ways to filter our results. For this exercise:

1. Create a new SQL file.
1. Set the connection in SQL Server Management Studio (SSMS) to look at Wide World Importers.
1. Write these queries.

## Exercise

1. Write a `SELECT` query that gets the color IDs and names for all colors that start with `Dark`.

```sql
-- What colors start with Dark?
SELECT ColorID, ColorName
FROM Warehouse.Colors
WHERE ColorName LIKE 'Dark%'
```

2. Write a `SELECT` query that gets all color names that are 51-characters long.

```sql
-- Which colors are 5-lettered colors?
SELECT ColorName
FROM Warehouse.Colors
WHERE LEN(ColorName) = 5
```

3. Write a `SELECT` query that gets the color names for colors with the following IDs: 1, 11, 15, and 36. Use the `OR` keyword.

```sql
-- What are the color names for the following ColorIDs - 1,11, 15, and 36? Use the OR keyword.
SELECT ColorName, ColorID
FROM Warehouse.Colors
WHERE ColorID = 1 OR ColorID = 11 OR ColorID=15 OR ColorID=36
```

4. Write a `SELECT` query that gets the color names for colors with the following IDs: 1, 11, 15, and 36. Use the `IN` keyword.

```sql
-- What are the color names for the following ColorIDs - 1,11, 15, and 36? Use the IN keyword.
SELECT ColorName, ColorID
FROM Warehouse.Colors
WHERE ColorID IN (1, 11, 15, 36)
```

5. Write a `SELECT` query that gets the customer names for all customers with a postal city ID of 242.

```sql
-- Which customers have the PostalCityId of 242?
SELECT CustomerName
FROM Sales.Customers
WHERE PostalCityId = 242
```

6. Write a `SELECT` query that gets customer names where the delivery postal code is 90210.

```sql
-- Are there any customers with the delivery postal code of 90210?
SELECT CustomerName
FROM Sales.Customers
WHERE DeliveryPostalCode = '90210'
```

7. Write a `SELECT` query that gets the customer names that start with `An` using `LIKE`.

```sql
-- Which customers start with 'An'?
SELECT CustomerName
FROM Sales.Customers
WHERE CustomerName LIKE 'An%'
```

8. Write a `SELECT` query that gets the customer names that start with `An` using `BETWEEN`.

```sql
-- Which customers start with 'An'?
SELECT CustomerName
FROM Sales.Customers
WHERE CustomerName BETWEEN 'An' AND 'Ao'
```

9. Write a `SELECT` query that gets a list of customer names and phone numbers where the phone number contains `555-`.

```sql
-- Which customers have phone numbers that follow the pattern of 555-?
SELECT CustomerName, PhoneNumber
FROM Sales.Customers
WHERE PhoneNumber LIKE '%555-%'
```

10. Write a `SELECT` query that gets customers that have deliveries to `Shop 2` and a PO Box in `Emilyville`.

```sql
-- Which customer has deliveries to Shop 2 and a PO Box in Emilyville?
SELECT *
FROM Sales.Customers
WHERE DeliveryAddressLine1 = 'Shop 2' AND PostalAddressLine2 = 'Emilyville'
```

11. Write a `SELECT` query that gets unique delivery methods from the customers table.

```sql
-- What are the unique delivery methods on the Customers table?
SELECT DISTINCT DeliveryMethodID
FROM Sales.Customers
```

12. Write a `SELECT` query that gets the last 5 customers ordered alphabetically.
    > Hint: The last 5 customers are the first 5 customers reverse alphabetically.

```sql
-- Who are the last 5 customers when ordered alphabetically?
SELECT TOP 5 CustomerName
FROM Sales.Customers
ORDER BY CustomerName DESC
```

1.  Write a `SELECT` query that gets the customer name and account opened date for all accounts opened between July 1, 2015, and December 31, 2015. Order it by the newest opened account and then by the customer name. Use the `>=` and `<=` operators for your filter.

```sql
-- Which accounts were created between July 1 and December 31 of 2015, ordered from latest to earliest, then alphabetical by customer name? Use the comparison operators of \<, \>, and =.
SELECT CustomerName, AccountOpenedDate
FROM Sales.Customers
WHERE AccountOpenedDate >= '2015-07-01' AND AccountOpenedDate <= '2015-12-31'
ORDER BY AccountOpenedDate DESC, CustomerName
```

14. Write a `SELECT` query that gets the customer name and account opened date for all accounts opened between July 1, 2015, and December 31, 2015. Order it by the newest opened account and then by the customer name. Use the `BETWEEN` clause.

```sql
-- Which accounts were created between July 1 and December 31 of 2015 ordered from latest to earliest, then alphabetical by customer name? Use the BETWEEN clause.
SELECT CustomerName, AccountOpenedDate
FROM Sales.Customers
WHERE AccountOpenedDate BETWEEN '2015-07-01' AND '2015-12-31'
ORDER BY AccountOpenedDate DESC, CustomerName
```

15. Write a `SELECT` query that gets the credit limits for Dipti Shah, Ivana Hadrabova, Emma Salpa, and Ian Olofsson. Order them from lowest to highest limits.

```sql
-- What are the credit limits for Dipti Shah, Ivana Hadrabova, Emma Salpa, and Ian Olofsson? Order them lowest to highest credit limits.
SELECT CustomerName, CreditLimit
FROM Sales.Customers
WHERE CustomerName IN ('Dipti Shah','Ivana Hadrabova', 'Emma Salpa', 'Ian Olofsson')
ORDER BY CreditLimit
```

16. Write a `SELECT` query that gets the first 5 accounts that do not have buying groups assigned to them.

```sql
-- What are 5 accounts that do not have a buying group assigned to it?
SELECT TOP 5 CustomerName, BuyingGroupId
FROM Sales.Customers
WHERE BuyingGroupId IS NULL
```

17. Write a `SELECT` query that gets the first 5 accounts with buying groups assigned to them.

```sql
-- What are 5 accounts that have a buying group assigned to it?
SELECT TOP 5 CustomerName, BuyingGroupId
FROM Sales.Customers
WHERE BuyingGroupId IS NOT NULL
```

18. Write a `SELECT` query that meets the following criteria:

- At least 2 customers must not have a buying group assigned - call these customers out with the `IN` clause
- At least 2 customers must have a buying group assigned - call these customers out with a `LIKE` clause
- When the buying group is `NULL`, show 'No Buyer'

```sql
-- It is on the learner to find a pattern to include at least 2 of the named customers in the IN clause and 2 for the LIKE clause
-- They can use CAST or CONVERT
-- For more thoughts, ask them why they chose the type for casting or converting.

/*
Show 5 customers with the following details:

- At least 2 customers must not have a buying group assigned - call these customers out with the IN clause
- At least 2 customers must have a buying group assigned - call these customers out with a LIKE clause
- When the buying group is NULL, show 'No Buyer'
*/
-- Solution using CAST
SELECT TOP 5 CustomerName,
    CASE
        WHEN BuyingGroupId IS NULL THEN 'No Buyer'
        ELSE CAST(BuyingGroupId AS char(1))
    END
FROM Sales.Customers
WHERE CustomerName IN ('Eric Torres','Cosmina Vlad','Bala Dixit')
    OR CustomerName LIKE 'Tailspin%(%MT%)'

-- Solution using CONVERT
SELECT TOP 5 CustomerName,
    CASE
        WHEN BuyingGroupId IS NULL THEN 'No Buyer'
        ELSE CONVERT(char(1),BuyingGroupId)
    END
FROM Sales.Customers
WHERE CustomerName IN ('Eric Torres','Cosmina Vlad','Bala Dixit')
    OR CustomerName LIKE 'Tailspin%(%MT%)'
```

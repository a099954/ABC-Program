# Exercise: Basic SQL - INSTRUCTOR KEY

## Introduction

In the Basic SQL lesson, we introduced various string and math functions that are built into SQL Server as well as a basic `SELECT` query to pull fields from a table. For this exercise:

1. Create a new SQL file.
1. Set the connection in SQL Server Management Studio (SSMS) to look at Wide World Importers.
1. Write these queries.

## Exercise

1. Write a `SELECT` query that uses the string `All for one, and one for all.`

```sql
-- Basic string
SELECT 'All for one, and one for all'
```

2. Write `SELECT` queries that use the `+` operator to combine the following strings:

* `All for one,` and `and one for all`
* `All `, `for one `, `, and `, `one for`, and `all`

```sql
-- String concatenation with +
SELECT 'All for one, ' + 'and one for all'

SELECT 'All ' + 'for one ' + ', and ' + ' one for ' + 'all'
```

3. Write a `SELECT` query that returns the count of characters for the string `All for one, and one for all`

```sql
-- String length
SELECT LEN('All for one, and one for all')
```

4. Write a `SELECT` query that uses the `CONCAT` function to combine `All for one, ` and ` and one for all`.

```sql
-- String concatenation
SELECT CONCAT('All for one,', ' and one for all')
```

5. Write `SELECT` query for the following cases:

* Split `All for one, and one for all.` on space.
* Split `All for one, and one for all.` on a comma.

```sql
-- String SPLIT on space
SELECT * FROM STRING_SPLIT('All for one, and one for all.', ' ')

-- String SPLIT on comma
SELECT * FROM STRING_SPLIT('All for one, and one for all.', ',')
```

6. Write a `SELECT` query to get the top 5 full names from the `Application.People` table. Then write another `SELECT` query to get the full name, first name, and last initial of the person for the first 5 people.

Hint: Use the query in the lesson as a starting point for how to use `SUBSTRING`.

```sql
-- Top 5 FullNames
SELECT TOP 5 FullName FROM Application.People

-- Substrings
SELECT TOP 5 FullName,
    SUBSTRING(FullName, 0, CHARINDEX(' ', FullName)+1),
    LEFT(SUBSTRING(FullName, CHARINDEX(' ', FullName)+1, LEN(FullName)), 1)
FROM Application.People
```

7. Write a `SELECT` query for the category name and the pattern index where the name starts with G for the first 8 customer category names.

```sql
SELECT TOP 8 CustomerCategoryName, PATINDEX('G%', CustomerCategoryName)
FROM Sales.CustomerCategories
```

8. Write a `SELECT` query for the category name and the pattern index where the name starts with G and contains an R as well for the first 8 customer category names.

```sql
SELECT TOP 8 CustomerCategoryName, PATINDEX('G%R%', CustomerCategoryName)
FROM Sales.CustomerCategories
```

/_ SQL and Math _/

-- Basic Math, matching types

9. Write a `SELECT` query that adds 6 and 6.

```sql
SELECT 6 + 6
```

10. Write a `SELECT` query that divides 5 by 2.

```sql
SELECT 5/2
```

11. Write a `SELECT` query that divides 5.0 by 2.0.

```sql
SELECT 5.0/2.0
```

12. Write a `SELECT` query that divides 5 by 2.0.

```sql
-- Basic Math, mixing types
SELECT 5/2.0
```

13. Write a `SELECT` query that divides 5.0 by 2.

```sql
SELECT 5.0/2
```

14. Write a `SELECT` query that gets the base type for the result of 5 divided by 2.0.

```sql
-- Checking data types
SELECT SQL_VARIANT_PROPERTY(5/2.0,'BaseType')
```

15. Write a `SELECT` query that gets the base type for the result of 5.0 divided by 2.

```sql
SELECT SQL_VARIANT_PROPERTY(5.0/2,'BaseType')
```

16. Write a `SELECT` query to get the absolute value of -5.

```sql
-- ABS
SELECT ABS(-5)
```

17. Write a `SELECT` query for 6 multiplied by 2.

```sql
SELECT 6 * 2
```

18. Write a `SELECT` query for 6 multiplied by 2.0.

```sql
SELECT 6 * 2.0
```

19. Write a `SELECT` query for 6 divided by 2.

```sql
SELECT 6/2
```

20. Write a `SELECT` query that includes 2 values - 6 divided by 4 and its remainder.
    Hint: The remainder uses an operator other than the division operator.

```sql
SELECT 6/4, 6 % 4 -- dividend and remainder
```

21. Write a `SELECT` query for 6 squared.

```sql
SELECT SQUARE(6)
```

22. Write a `SELECT` query to get all the fields from the `Sales.CustomerCategories` table.

```sql
SELECT * FROM Sales.CustomerCategories
```

23. Write a `SELECT` query to get all of the customer category names.

```sql
SELECT CustomerCategoryName FROM Sales.CustomerCategories
```

24. Write a `SELECT` query to get the first 8 customer category names.

```sql
SELECT TOP 8 CustomerCategoryName FROM Sales.CustomerCategories
```

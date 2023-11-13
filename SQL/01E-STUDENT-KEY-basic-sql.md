# Exercise: Basic SQL - STUDENT KEY

## Introduction

In the Basic SQL lesson, we introduced various string and math functions that are built into SQL Server as well as a basic `SELECT` query to pull fields from a table. For this exercise:

1. Create a new SQL file.
1. Set the connection in SQL Server Management Studio (SSMS) to look at Wide World Importers.
1. Write these queries.

The student key contains general guidance to assure you that you are on the right track.

## Exercise

1. Write a `SELECT` query that uses the string `All for one, and one for all.`

```
All for one, and one for all
```

2. Write `SELECT` queries that use the `+` operator to combine the following strings:

* `All for one,` and `and one for all`
* `All `, `for one `, `, and `, `one for`, and `all`

```
All for one, and one for all
```

3. Write a `SELECT` query that returns the count of characters for the string `All for one, and one for all`

```
28
```

4. Write a `SELECT` query that uses the `CONCAT` function to combine `All for one, ` and ` and one for all`.

```sql
All for one, and one for all
```

5. Write `SELECT` query for the following cases:

* Split `All for one, and one for all.` on space.
* Split `All for one, and one for all.` on a comma.

```
All
for
one,
and
one
for
all.

All for one
 and one for all.
```

6. Write a `SELECT` query to get the top 5 full names from the `Application.People` table. Then write another `SELECT` query to get the full name, first name, and last initial of the person for the first 5 people.

Hint: Use the query in the lesson as a starting point for how to use `SUBSTRING`.

```
Aahlada Thota
Aakarsha Nookala
Aakriti Bhamidipati
Aakriti Byrraju
Aamdaal Kamasumdram

Aahlada Thota           Aahlada     T
Aakarsha Nookala        Aakarsha    N
Aakriti Bhamidipati     Aakriti     B
Aakriti Byrraju         Aakriti     B
Aamdaal Kamasumdram     Aamdaal     K

```

7. Write a `SELECT` query for the category name and the pattern index where the name starts with G for the first 8 customer category names.

```
Agent               0
Computer Store      0
Corporate           0
General Retailer    1
Gift Store          1
Novelty Shop        0
Supermarket         0
Wholesaler          0
```

8. Write a `SELECT` query for the category name and the pattern index where the name starts with G and contains an R as well for the first 8 customer category names.

```
Agent               0
Computer Store      0
Corporate           0
General Retailer    1
Gift Store          1
Novelty Shop        0
Supermarket         0
Wholesaler          0
```

9. Write a `SELECT` query that adds 6 and 6.

```
12
```

10. Write a `SELECT` query that divides 5 by 2.

```
2
```

11. Write a `SELECT` query that divides 5.0 by 2.0.

```
2.500000
```

12. Write a `SELECT` query that divides 5 by 2.0.

```
2.500000
```

13. Write a `SELECT` query that divides 5.0 by 2.

```
2.500000
```

14. Write a `SELECT` query that gets the base type for the result of 5 divided by 2.0.

```
numeric
```

15. Write a `SELECT` query that gets the base type for the result of 5.0 divided by 2.

```
numeric
```

16. Write a `SELECT` query to get the absolute value of -5.

```
5
```

17. Write a `SELECT` query for 6 multiplied by 2.

```
12
```

18. Write a `SELECT` query for 6 multiplied by 2.0.

```
12.0
```

19. Write a `SELECT` query for 6 divided by 2.

```
3
```

20. Write a `SELECT` query that includes 2 values - 6 divided by 4 and its remainder.
    Hint: The remainder uses an operator other than the division operator.

```
1   2
```

21. Write a `SELECT` query for 6 squared.

```
36
```

22. Write a `SELECT` query to get all the fields from the `Sales.CustomerCategories` table.

| CustomerCategoryID | CustomerCategoryName | LastEditedBy | ValidFrom                   | ValidTo                     |
| ------------------ | -------------------- | ------------ | --------------------------- | --------------------------- |
| 1                  | Agent                | 1            | 2013-01-01 00:00:00.0000000 | 9999-12-31 23:59:59.9999999 |
| 2                  | Wholesaler           | 1            | 2013-01-01 00:00:00.0000000 | 9999-12-31 23:59:59.9999999 |
| 3                  | Novelty Shop         | 1            | 2013-01-01 00:00:00.0000000 | 9999-12-31 23:59:59.9999999 |
| 4                  | Supermarket          | 1            | 2013-01-01 00:00:00.0000000 | 9999-12-31 23:59:59.9999999 |
| 5                  | Computer Store       | 1            | 2013-01-01 00:00:00.0000000 | 9999-12-31 23:59:59.9999999 |
| 6                  | Gift Store           | 1            | 2013-01-01 00:00:00.0000000 | 9999-12-31 23:59:59.9999999 |
| 7                  | Corporate            | 1            | 2013-01-01 00:00:00.0000000 | 9999-12-31 23:59:59.9999999 |
| 8                  | General Retailer     | 1            | 2013-01-01 00:00:00.0000000 | 9999-12-31 23:59:59.9999999 |

23. Write a `SELECT` query to get all of the customer category names.

```
Agent
Computer Store
Corporate
General Retailer
Gift Store
Novelty Shop
Supermarket
Wholesaler
```

24. Write a `SELECT` query to get the first 8 customer category names.

```
Agent
Computer Store
Corporate
General Retailer
Gift Store
Novelty Shop
Supermarket
Wholesaler
```

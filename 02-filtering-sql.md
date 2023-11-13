# Lesson: Filtering and Ordering Results in SQL

## Introduction

In our first steps with SQL, we can grab all the data from a table and filter what fields come back by explicitly calling them out in the `SELECT` clause. We can filter our datasets further by using the `WHERE` keyword.  You may want to see the results in a particular order as well, and we can take care of that with the `ORDER BY` clause. In this lesson, we will learn more tips and tricks for filtering and ordering our SQL results.

## Learning Outcomes

By the end of this lesson, you will be able to:

1. Filter SQL results with the `WHERE` clause.
2. Get results for a date range.
3. Handle `NULL` values in results.
4. Find values based on a pattern.
5. Order results based on fields.

## Filtering Results

As we look at filtering, we are going to start with the `Warehouse.Colors` table in the `WideWorldImporters` dataset. Notice that there are lots of colors with Blue in their name. What are those colors?  Can we filter our results using SQL?

### WHERE keyword

We can filter our SQL results using the `WHERE` keyword. Let's start with getting the record where the ColorName is equal to Blue. The query for this is:

```sql
SELECT ColorID, ColorName 
FROM Warehouse.Colors 
WHERE ColorName='Blue'
```

The results are:

| ColorID     | ColorName |
| ----------- | ----------- |
| 4   | Blue       |


We can use the `=` operator to find records that have values equal to a particular value. Since Blue is a string, you can use single quotes to surround the value.

What if you use double quotes? Try this:

```sql
SELECT ColorID, ColorName 
FROM Warehouse.Colors 
WHERE ColorName="Blue"
```

You should receive an error message similar to this one:

```text
Msg 207, Level 16, State 1, Line 1
Invalid column name 'Blue'.
```

You need to surround string values in quotes.

> What if the value contains quotes?  Stay tuned, as we will explain that here shortly!

Do you need quotes if the value is a number?  Let's see what color has the ColorID of 2.  We can do that with this query:

```sql
SELECT ColorID, ColorName 
FROM Warehouse.Colors 
WHERE ColorID=2
```

The results are:

| ColorID     | ColorName |
| ----------- | ----------- |
| 2   | Beige     |

Beige happened to be the color with the ColorID of 2. We did not need to use quotes for a numeric value. However, we need it for strings.

Suppose we want colors that have an ID less than 5. We can use `<` for "less than", `>` for "greater than", and a combination of those with `=` - using `<=` for "less than or equal to" and `>=` for "greater than or equal to" - to filter numeric values. For colors with IDs less than 5, this is the query:

```sql
SELECT ColorID, ColorName 
FROM Warehouse.Colors 
WHERE ColorID < 5
```

The results are:

| ColorID     | ColorName |
| ----------- | ----------- |
| 1   | Azure     |
| 2   | Beige     |
| 3   | Black     |
| 4   | Blue     |

If we wanted to include the value equal to 5, we could use `<=` to find all colors with IDs less than or equal to 5.

```sql
SELECT ColorID, ColorName 
FROM Warehouse.Colors 
WHERE ColorID <= 5
```

The results are:

| ColorID     | ColorName |
| ----------- | ----------- |
| 1   | Azure     |
| 2   | Beige     |
| 3   | Black     |
| 4   | Blue     |
| 5  | Charcoal     |


### Working with NULL

`NULL` is a keyword in SQL that represents the absence of a value. When working with `NULL`, there are some things to keep in mind:

* We can filter `NULL` values in our `WHERE` clause.
  * If we want to see only null values, we use `IS NULL`.
  * If we want to see only values and exclude the `NULL` values, we use `IS NOT NULL`.
* When there is a `NULL` value, you may want to use a default value in your query. We can use `CASE` to check a condition and assign a different value.

![Screenshot of the columns from Sales.Customers - including CustomerID (not null), CustomerName (not null), BillToCustomerID (not null), CustomerCategoryID (not null), BuyingGroupID (null), PrimaryContactPersonID (not null), AlternateContactPersionID (null)](assets/images/null-in-columns.png)

When we look at the columns on Sales.Customers in the list of fields in SQL Server Management Studio, you can see if there are columns that allow `NULL` by the presence of "null" in the description following the column name. If the columns do not allow `NULL` values, you will see "not null" in the column description. For our `NULL` examples, we will be working with the CreditLimit field.

Since we may be returning a lot of records, let's look at the first five records. We can use this with the TOP keyword as part of the `SELECT` clause. First, let's look at those who have `NULL` credit limits. We will use `IS NULL` in our `WHERE` clause.

```sql
SELECT TOP 5 CustomerName, CreditLimit 
FROM Sales.Customers 
WHERE CreditLimit IS NULL
```

The results are:

| CustomerName     | CreditLimit |
| ----------- | ----------- |
| Tailspin Toys (Head Office)   |NULL     |
| Tailspin Toys (Sylvanite, MN)   | NULL    |
| Tailspin Toys (Peeples Valley, AZ)  | NULL    |
| Tailspin Toys (Medicine Lodge, KS)   | NULL    |
| Tailspin Toys (Gasport, NY)  | NULL |


Now let's look at the top 3 records where a CreditLimit is set. We want records where the credit limit is not null, so we will use `IS NOT NULL` in the `WHERE` clause.

```sql
SELECT TOP 3 CustomerName, CreditLimit 
FROM Sales.Customers 
WHERE CreditLimit IS NOT NULL
```

The results are:

| CustomerName     | CreditLimit |
| ----------- | ----------- |
| Eric Torres|3000.00     |
| Cosmina Vlad| 2940.00    |
| Bala Dixit| 2000.00    |

### CASE expression

Suppose we want to show customers with their credit limits, and for those who have no limit, we want to show 9999999999. We can achieve this with the `CASE` expression in our `SELECT` clause.

The `CASE` expression allows us to use conditional logic to set a value.

We are only grabbing the first three records to keep our data small.

```sql
SELECT TOP 3 CustomerName, 
CASE
    WHEN CreditLimit IS NULL THEN 9999999999
    ELSE CreditLimit
END 
FROM Sales.Customers
```

The results are:

| CustomerName     | (No column name) |
| ----------- | ----------- |
| Tailspin Toys (Head Office)   |9999999999.00     |
| Tailspin Toys (Sylvanite, MN)   | 9999999999.00    |
| Tailspin Toys (Peeples Valley, AZ)  | 9999999999.00    |

Notice that the `CASE` expression comes back without a column name. It is common practice to use an alias when working with `CASE` expression.  We use the `AS` keyword to set the alias for the `CASE` results.

```sql
SELECT TOP 3 CustomerName, 
CASE
    WHEN CreditLimit IS NULL THEN 9999999999
    ELSE CreditLimit
END AS CreditLimit 
FROM Sales.Customers
```

The results are:

| CustomerName     | CreditLimit |
| ----------- | ----------- |
| Tailspin Toys (Head Office)   |9999999999.00     |
| Tailspin Toys (Sylvanite, MN)   | 9999999999.00    |
| Tailspin Toys (Peeples Valley, AZ)  | 9999999999.00    |

### CONVERT and CAST

With our example, it may make more sense to show 'No Limit' when the CreditLimit field is null. However, we cannot use this query:

```sql
SELECT TOP 3 CustomerName, 
CASE
   WHEN CreditLimit IS NULL THEN 'No Limit'
   ELSE CreditLimit
END AS CreditLimit 
FROM Sales.Customers
```

Try running that code.  You should see the following error:

```text
Error converting data type varchar to numeric.
```

Remember that the CreditLimit is a numeric value, whereas 'No Limit' is a string. This is what is known as a type mismatch - column values need to have the same type throughout and cannot mix types.

`CAST` and `CONVERT` can be used to change the credit limit to a string. Before we use them, let's understand why there are two keywords involved:

* `CAST` is ANSI SQL specific, whereas `CONVERT` is specific to SQL Server.  
* `CAST` uses the AS keyword not as a column alias but as a type assignment operator, assigning a type to the value.  
* `CONVERT` can be used for formatting, especially with date-time values.

We can convert values from numeric to string using the `CAST` or `CONVERT` keywords. Let's look at how we use these.

First, let's try using `CAST`:

```sql
SELECT TOP 3 CustomerName, 
CASE
   WHEN CreditLimit IS NULL THEN 'No Limit'
   ELSE CAST(CreditLimit AS varchar(20))
END AS CreditLimit 
FROM Sales.Customers
```

The results are:

| CustomerName     | CreditLimit |
| ----------- | ----------- |
| Tailspin Toys (Head Office)   |No Limit    |
| Tailspin Toys (Sylvanite, MN)   | No Limit    |
| Tailspin Toys (Peeples Valley, AZ)  | No Limit    |

Now, let's look at `CONVERT`:

```sql
SELECT TOP 3 CustomerName, 
CASE
   WHEN CreditLimit IS NULL THEN 'No Limit'
   ELSE CONVERT(varchar(20),CreditLimit)
END AS CreditLimit 
FROM Sales.Customers
```

The results are:

| CustomerName     | CreditLimit |
| ----------- | ----------- |
| Tailspin Toys (Head Office)   |No Limit    |
| Tailspin Toys (Sylvanite, MN)   | No Limit    |
| Tailspin Toys (Peeples Valley, AZ)  | No Limit    |

Since our query results do not show a good mix of those with limits and those with no limits, let's use a `WHERE` clause to include those we know who have limits and those we know that do not.

* For the names we know have limits, we can use the `IN` keyword to limit them.
* For those who have no limits - such as Tailspin Toys - we can use the `LIKE` keyword to filter the customer name.
* We can use the `OR` keyword to join those clauses.  We will explain the `OR` keyword after we run this query.
* To ensure we get more than just the Tailspin Toys entries, we can use an `ORDER BY` clause with the field name we want to order by - in this case, CustomerName.  Since we are not specifying what order to use, the CustomerName will sort alphabetically, A-to-Z.

```sql
SELECT TOP 5 CustomerName, CASE
    WHEN CreditLimit IS NULL THEN 'No Limit'
    ELSE CAST(CreditLimit as varchar(20))
END AS CreditLimit
FROM Sales.Customers
WHERE CustomerName IN ('Eric Torres', 'Cosmina Vlad', 'Bala Dixit') OR CustomerName LIKE 'Tailspin%'
ORDER BY CustomerName
```

The results may be like these:

| CustomerName     | CreditLimit |
| ----------- | ----------- |
| Bala Dixit  |2000.00  |
| Cosmina Vlad   | 2940.00   |
| Eric Torres  | 3000.00   |
| Tailspin Toys (Absecon, NJ)  | No Limit    |
| Tailspin Toys (Aceitunas, PR)  | No Limit    |

### OR keyword

The `OR` keyword is used between clauses when you want one condition or another condition to be met.  In the above example, we wanted customers with the name in the collection of names in the `IN` clause or customers with Tailspin at the start of their name based on the `LIKE` clause.  As long as the name meets one of those, it will appear in the results.

Suppose our salesperson came to us wanting to see accounts that were opened in 2015 and 2016, newest account to oldest. An account opened date only has one year. We can find accounts that were opened in 2015 `OR` were open in 2016. The query for this is:

```sql
SELECT CustomerName, AccountOpenedDate 
FROM Sales.Customers 
WHERE YEAR(AccountOpenedDate) = 2015 
    OR YEAR(AccountOpenedDate) = 2016 
ORDER BY AccountOpenedDate DESC
```

The result should include 23 rows.

### LIKE keyword

Let's go back to strings, specifically Blue. There are various shades of blue with blue in their name. We can use the `LIKE` operator with its `%` wildcard to search text. Suppose we want to find all color names that start with Blue. The query looks like this:

```sql
SELECT ColorID, ColorName 
FROM Warehouse.Colors 
WHERE ColorName LIKE 'Blue%'
```

The results are:

| ColorID    | ColorName |
| ----------- | ----------- |
| 4 |Blue     |

There is one color name that starts with Blue. Suppose we want to see all color names that end with Blue. That query looks like this:

```sql
SELECT ColorID, ColorName 
FROM Warehouse.Colors 
WHERE ColorName LIKE '%Blue'
```

The results are:

| ColorID    | ColorName |
| ----------- | ----------- |
| 4 |Blue     |
| 22| Navy Blue    |
| 29| Royal Blue    |

There are three colors that end in blue - Blue, Navy Blue, and Royal Blue. What if we wanted to check for color names that have Blue anywhere? That query looks like this:

```sql
SELECT ColorID, ColorName 
FROM Warehouse.Colors 
WHERE ColorName LIKE '%Blue%'
```

The `%` wildcard character - a place holder for "anything" - can be used multiple times when building a pattern to use in searching text.

So:

* 'Blue%' means colors that start with Blue and anything following it.
* '%Blue' means colors that start with anything but must end in Blue.
* '%Blue%' means colors that can start with anything and end with anything but must contain Blue somewhere in the value.

#### Escaping Quotes

Now let's address the question we brought up earlier - what if our data contains a single quote?  When you are searching for a single quote in your data, it needs to be escaped - a way to tell the SQL engine that you mean it as a single quote. To tell the SQL Engine that you want it as a single quote, you need to put another single quote before it.

So suppose we want to find customers with single quotes in their name. We can use `LIKE` to filter our results and use double single quotes to search for a single quote. 

We can build the `LIKE` expression with the following steps:

* Use starting and ending single quotes to surround the phrase.
* Use `%` at the beginning and end of the string to match.  The name can start and end with anything.
* `''` - This is two single quotes in the middle of the `LIKE` match.  Two single quotes together like this represent a literal, single quote.  So we want any CustomerName that contains a single quote.

The query to find customers with single quotes in their name is:

```sql
SELECT CustomerName 
FROM Sales.Customers 
WHERE CustomerName LIKE '%''%'
```

The results are:

| CustomerName    |
| ----------- | 
| Wingtip Toys (Kapa'a, HI) | 

### Date Functions

When filtering data, you may want to filter in a date range. With the Sales.Customers table, there is an AccountOpenedDate field that tracks when the customer account has opened.  We can use the `YEAR()` function to see what years the customers were established.  That query looks like this:

```sql
SELECT YEAR(AccountOpenedDate) 
FROM Sales.Customers
```

Running this query shows a lot of repeated years - 663 rows. We can use the `DISTINCT` keyword in the `SELECT` clause to get the unique values. So let's update the query.

```sql
SELECT DISTINCT YEAR(AccountOpenedDate) 
FROM Sales.Customers
```

The results are:

| (No column name) |
| ----------- | 
| 2013 | 
| 2014 | 
| 2015 | 
| 2016 | 

Suppose we want to see which customers opened accounts in 2014. We only care about the CustomerName and AccountOpenedDate. Let's look at the following query:

```sql
SELECT CustomerName, AccountOpenedDate 
FROM Sales.Customers 
WHERE YEAR(AccountOpenedDate) = 2014
```

This returns 14 customers with AccountOpenedDate values ranging from '2014-01-15' to '2014-12-03'.

### AND keyword

Suppose you have a salesperson who remembered bringing in the Dipti Shah account. That salesperson wanted to see what accounts were added in a month. Rather than looking up the date and writing a query to find all accounts in that month, we can store Dipti's account-opened date in a variable and then query for all accounts added in that month. You can do this by using `MONTH()` to filter for a month, `AND` to allow additional filtering, and `YEAR()` to filter the year.

We are going to store Dipti Shah's account opened date in a variable to use later.  SQL variables are declared with the `DECLARE` keyword, the variable name preceded by an at-sign `@`, and the variable type. The variable declaration may also include an assignment using the`=`operator and a value. Multiple variables can be declared with variable names and types in a single `DECLARE` statement.

We can use a `SELECT` clause with the `=` operator to save a value in a variable. That looks like this:

```sql
DECLARE @ShahAccountDate DATETIME
SELECT @ShahAccountDate = AccountOpenedDate 
FROM Sales.Customers 
WHERE CustomerName = 'Dipti Shah'

SELECT CustomerName, AccountOpenedDate 
FROM Sales.Customers 
WHERE MONTH(AccountOpenedDate) = MONTH(@ShahAccountDate) 
    AND YEAR(AccountOpenedDate) = YEAR(@ShahAccountDate)
```

The salesperson was having a conversation with some others and wanted to know about the accounts opened in 2013 for companies that don't have Toys in their name. Tailspin Toys and Wingtip Toys both started with the Wide World Importers in 2013. The salesperson wants a list of customers who are not them.

We can use our `AND` clause to filter for the year and a `LIKE` clause to filter the customer name. We can add the `NOT` keyword to say we want all customers that do not match our pattern - `NOT LIKE`. The query for all customer accounts opened in 2013 that don't have Toys in their name looks like this:

```sql
SELECT CustomerName, AccountOpenedDate 
FROM Sales.Customers 
WHERE YEAR(AccountOpenedDate) = 2013 
    AND CustomerName NOT LIKE '%Toys%'
```

There are 224 rows in this result set.

### BETWEEN keyword

The `AND` keyword is used for more than just joining clauses in the `WHERE` clause. It is also used as part of the `BETWEEN` clause that can appear in a `WHERE` clause.

The `BETWEEN` clause is inclusive of the starting and ending values. In the following example, we want to find customers who have credit limits between 2500.00 and 3000.00. The results will include those who have credit limits of 2500.00, those who have credit limits of 3000.00, and those who have credit limits between those values.

```sql
SELECT CustomerName, CreditLimit 
FROM Sales.Customers 
WHERE CreditLimit BETWEEN 2500.00 AND 3000.00
```

There are 46 customers within that credit range.

`BETWEEN` can work with alphabetical ranges as well. Suppose we want customers whose names are between 'A' and 'B'. That query looks like this:

```sql
SELECT CustomerName 
FROM Sales.Customers 
WHERE CustomerName BETWEEN 'A' AND 'B' 
ORDER BY CustomerName
```

There are 32 customers whose names fall in this range.

Notice that there are no results that start with 'B'. This is because it is looking for whole strings that start with 'A' and stop at 'B'. If we had a customer named 'B', they would be included in the results. To understand how `BETWEEN` works with alphabetical clauses, change the starting or ending values and experiment. For example, what if we had said between 'Ar' and 'Bz'?

```sql
SELECT CustomerName 
FROM Sales.Customers 
WHERE CustomerName BETWEEN 'Ar' AND 'Bz' 
ORDER BY CustomerName
```

There are 18 customers in this range.

The `BETWEEN` clause can be used with dates as well. Suppose we want to find out which customers opened their accounts in the first half of the year. We can use the `BETWEEN` keyword in our `WHERE` clause to filter our records to a date between a start and end date. We use the `AND` keyword to separate the beginning and ending clauses of the `BETWEEN` clause.

> We are referring to dates in the YYYY-MM-DD format, surrounding the values in single quotes.

The `SET` keyword can also be used to set a variable value.

Consider the following block of code:

```sql
DECLARE @StartDate date, @EndDate date 
SET @StartDate = '2014-01-01' -- YYYY-MM-DD format, surrounded by single quotes
SET @EndDate = '2014-06-30'

SELECT CustomerName, AccountOpenedDate 
FROM Sales.Customers 
WHERE AccountOpenedDate BETWEEN @StartDate AND @EndDate
```

The results are:

|CustomerName	|AccountOpenedDate|
| ----------- | ----------- |
|Tuulikki Linna	|2014-01-15|
|Daniella Cavalcante	|2014-01-17|
|Serdar ozden	|2014-02-22|
|Emma Van Zant	|2014-05-14|
|Veronika Necesana	|2014-05-18|
|Chompoo Atitarn	|2014-06-18|


The salesperson came back and wanted to find out what accounts were added after Aive Petrov's account, though also in the same month and year. We could approach this as follows:

* Find when Aive Petrov's account was opened. Store that in a variable.
* Write a query where the account opened date is between Aive Petrov's update and the end of the month - Once we know Aive's account opened date, we can figure out the end of the month manually.

Consider the following block of code:

```sql
DECLARE @CustomerAccountDate DATE
SELECT @CustomerAccountDate = AccountOpenedDate 
FROM Sales.Customers 
WHERE CustomerName = 'Aive Petrov' -- '2013-08-10'

SELECT CustomerName, AccountOpenedDate 
FROM Sales.Customers 
WHERE AccountOpenedDate BETWEEN @CustomerAccountDate AND '2013-08-31'
```

The results are:

|CustomerName	|AccountOpenedDate|
| ----------- | ----------- |
|Aive Petrov	|2013-08-10|
|David Novacek|	2013-08-15|

We can also use `EOMONTH()` to calculate the end of the month for a date. So our query would look like this:

```sql
DECLARE @CustomerAccountDate DATE
SELECT @CustomerAccountDate = AccountOpenedDate 
FROM Sales.Customers 
WHERE CustomerName = 'Aive Petrov' -- '2013-08-10'

SELECT CustomerName, AccountOpenedDate 
FROM Sales.Customers 
WHERE AccountOpenedDate BETWEEN @CustomerAccountDate AND EOMONTH(@CustomerAccountDate)
```

The results are:

|CustomerName	|AccountOpenedDate|
| ----------- | ----------- |
|Aive Petrov	|2013-08-10|
|David Novacek|	2013-08-15|


`EOMONTH()` can be used to calculate the end of a month based on a date passed in as well as an optional month shift.

* If we pass in a negative month shift, `EOMONTH()` calculates for prior months.
* If we do not pass in a month shift, `EOMONTH()` calculates only for the date passed in.
* If we pass in a positive month shift, `EOMONTH()` calculates for future months.

Consider the following query. We are going to use GETDATE() to get the current date.

```sql
DECLARE @Today datetime = GETDATE()
SELECT @Today, EOMONTH(@Today,-1), EOMONTH(@Today), EOMONTH(@Today,1)
```

The results will be something along these lines:

|(No column Name	|(No column Name	|(No column Name	|(No column Name |
| ----------- | ----------- |----------- |----------- |
|2021-03-22 16:32:48.343M	|2021-02-28	|2021-03-31	|2021-04-30|


### AS keyword

In that last query, the column names came back as "(No column name)". When looking at results, it could be easy to get lost in nameless columns. We can use the `AS` keyword in our `SELECT` clause to assign column names to these values.

```sql
DECLARE @Today datetime = GETDATE()
SELECT @Today AS 'Today', EOMONTH(@Today,-1) AS 'EndOfLastMonth', EOMONTH(@Today) AS 'EndOfThisMonth', EOMONTH(@Today,1) AS 'EndOfNextMonth'
```

The results will be something along these lines:

|Today	|EndOfLastMonth	|EndOfThisMonth	|EndOfNextMonth|
| ----------- | ----------- |----------- |----------- |
|2021-03-22 16:32:48.343M	|2021-02-28	|2021-03-31	|2021-04-30|


The `AS` keyword for aliases applies to columns and tables, as we will see in the lesson where we connect tables.  In these particular cases, the `AS` keyword is optional.  It can be replaced as a space between the field name and the alias.  The above query with the column aliases without the keyword would be:

```sql
DECLARE @Today datetime = GETDATE()
SELECT @Today 'Today', EOMONTH(@Today,-1) 'EndOfLastMonth', EOMONTH(@Today) 'EndOfThisMonth', EOMONTH(@Today,1) 'EndOfNextMonth'
```

The results will be something along these lines:

|Today	|EndOfLastMonth	|EndOfThisMonth	|EndOfNextMonth|
| ----------- | ----------- |----------- |----------- |
|2021-03-22 16:32:48.343M	|2021-02-28	|2021-03-31	|2021-04-30|

### IN keyword

We can use the `IN` keyword in our `WHERE` clause to filter values from within a group. Suppose we want to find the colors on the Warehouse.Colors table that have ColorIDs: 1, 4, and 6. We can use the `IN` operator for that as well.  That query is:

```sql
SELECT ColorID, ColorName 
FROM Warehouse.Colors 
WHERE ColorID IN (1, 4, 6)
```

The results are:

| ColorID    | ColorName |
| ----------- | ----------- |
| 1 |Azure     |
| 4| Blue    |
| 6| Chartreuse    |


We can also use `IN` with dates. Consider this example where we know that we want accounts opened on 2014-05-14, 2014-11-13, and 2014-12-03.

Here is the query:

```sql
SELECT CustomerName, AccountOpenedDate 
FROM Sales.Customers 
WHERE AccountOpenedDate IN ('2014-05-14','2014-11-13', '2014-12-03')
```

The results are:

| CustomerName	|AccountOpenedDate|
| ----------- | ----------- |
|Emma Van Zant	|2014-05-14|
|Erik Malk	|2014-11-13|
|Damodara Trivedi|	2014-12-03|

## Ordering Results with the ORDER BY clause

By default, search results come back in an order that seems logical - typically in the natural order of the primary key. This means string keys are alphabetical A-Z, numeric keys 0-9, and other fields in their natural lower to higher - **ascending** - sort order. We can use the `ORDER BY` clause, after the `WHERE` clause, to control the order of the results.

We want to see when these accounts were opened, oldest to newest in 2014, so ascending. This query is:

```sql
SELECT CustomerName, AccountOpenedDate 
FROM Sales.Customers 
WHERE YEAR(AccountOpenedDate) = 2014 
ORDER BY AccountOpenedDate
```

The `ORDER BY` clause takes in a list of fields and directions. There are two directions for sorting:

* Ascending - lowest to highest, A-Z, 0-9, earliest date to latest date - considered the natural sort and does not necessarily need to be specified. However, you can use ASC to denote sorting ascending.
* Descending - highest to lowest, Z-A, 9-0, the latest date to earliest date - noted with the DESC shortcut.

Let's order our customers of 2014 from latest to earliest accounts. For this, we will need the `ORDER BY` clause after the `WHERE` clause with AccountOpenedDate `DESC` to indicate we want to sort by the account opened date latest to earliest. This query looks like:

```sql
SELECT CustomerName, AccountOpenedDate 
FROM Sales.Customers 
WHERE YEAR(AccountOpenedDate) = 2014 
ORDER BY AccountOpenedDate DESC
```

The salesperson wants to know what accounts - besides the Toys accounts - were opened on 2013-01-01 and would like the customers listed alphabetically.  Here is that query:

```sql
SELECT CustomerName, AccountOpenedDate 
FROM Sales.Customers 
WHERE AccountOpenedDate = '2013-01-01' 
    AND CustomerName NOT LIKE '%Toys%' 
ORDER BY CustomerName
```

Now they want a list of all the accounts opened in years other than 2013, ordered by latest to earliest and alphabetical for accounts that share the same day. We can do this by having multiple fields and directions in our `ORDER BY` clause. As our sample data does not have this case, we can cause this to happen. We are going to update the record for Sylvie Laramee and set their account opened date to an existing date, shared with Amrita Ganguly.

```sql
UPDATE Sales.Customers 
SET AccountOpenedDate='2015-09-23' 
WHERE CustomerName = 'Sylvie Laramee'
```

Now that we have customers who have the same AccountOpenedDate, let's see how we write the query to sort them latest to earliest and then alphabetically by customer name.  Here is the query:

```sql
SELECT CustomerName, AccountOpenedDate 
FROM Sales.Customers 
WHERE YEAR(AccountOpenedDate) != 2013 
ORDER BY AccountOpenedDate DESC, CustomerName ASC
```

We could also have left off the `ASC` keyword in the ORDER BY clause, as that is the assumed order direction if no order direction is specified.  Here is the query without the `ASC` keyword:

```sql
SELECT CustomerName, AccountOpenedDate 
FROM Sales.Customers 
WHERE YEAR(AccountOpenedDate) != 2013 
ORDER BY AccountOpenedDate DESC, CustomerName
```

Our salesperson came to us with a list of people they want to find account opening dates for. This is their list:

* Nguyen Banh
* Erik Malk
* Emma Van Zant
* Damodara Trivedi

They would like the accounts listed in the order their accounts were opened.

We can use the `IN` keyword in our `WHERE` clause to filter for values in a group of values. Let's take a look at the following query:

```sql
SELECT CustomerName, AccountOpenedDate 
FROM Sales.Customers 
WHERE CustomerName IN ('Nguyen Banh', 'Erik Malk', 'Emma Van Zant', 'Damodara Trivedi') 
ORDER BY AccountOpenedDate
```

The results are:

| CustomerName	|AccountOpenedDate|
| ----------- | ----------- |
|Emma Van Zant	|2014-05-14|
|Erik Malk	|2014-11-13|
|Damodara Trivedi|	2014-12-03|
|Nguyen Banh|	2015-01-22|

## Conclusion

In this lesson, we learned how to filter our query results further with the `WHERE` clause.  We were able to find values that match a pattern with the `LIKE` keyword.  We were able to filter for ranges using mathematical operators `>=` and `<=`, the `IN` keyword, and the `BETWEEN` keyword.  Finally, we learned how to order our results set with the `ORDER BY` clause.  Now you are able to filter and order your SQL results.

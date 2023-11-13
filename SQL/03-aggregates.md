# Lesson: Aggregates in SQL

## Introduction

From a data analysis perspective, it may help to get a general overview of columns quantitatively when working with SQL. Aggregation in SQL allows us to get quantitative insight quickly through sums, averages, minimums, maximums, and other aggregations. Strings can also be grouped and aggregated for building strings. In this lesson, we will look at common aggregations in SQL.

## Learning Outcomes

By the end of this lesson, you will be able to:

1. Calculate the average of a numerical value for a group.
1. Determine the minimum and maximum numerical value for a group.
1. Count the number of values and unique values for a field.
1. Aggregate strings into a delimited list.

## What is an aggregate?  How are they used?

An **aggregate** is a way of calculating values and breaking them down for an entire dataset or groups. It provides a calculation or grouping and returns a single value for the whole dataset or a single value for each group.  

Suppose we want total dollar values for purchase orders, orders, or invoices. We can use aggregates to calculate the sums of multiple purchase orders and overall. If we want to find the minimum and maximum values for those purchase orders or invoices, we can also do that with aggregates.

Suppose we are teachers with students' assignment grades in a table. We can use aggregates to tell us what students are at the top, which are at the bottom, what the average grade is, how many assignments were submitted, and how many unique students are enrolled in our class.

Let's look at how we work with aggregates in SQL, working in the Wide World Importers database.

## Minimum, Maximum, and Average

The warehouse manager wondered if we could assist in tracking their cold room temperatures. They want to know the minimum, maximum, and average temperature for the cold room. We can calculate the average with `AVG()`. Minimum and maximum are similar - each has a function that takes one parameter, the field they need to aggregate.  Minimum is found with `MIN()`, and maximum is found with `MAX()`. This is the query for the minimum temperature, maximum temperature, and average temperature in the cold room:

```sql
SELECT MIN(Temperature), 
       MAX(Temperature), 
       AVG(Temperature)
FROM Warehouse.ColdRoomTemperatures
```

The results are:

| (No column name) | (No column name) | (No column name) |
|--- |--- |--- |
| 3.00 | 4.70 | 3.750000 |

The warehouse stores stock items, and the warehouse manager wanted to find out the average typical weight per unit of all stock items.

We can calculate the average of a field using `AVG()`. The `AVG()` function takes one parameter - the field to calculate the average over. We do not need to use a `WHERE` clause since we want the typical average weight per unit for all stock items. This is the query to get the typical average weight per unit for all stock items:

```sql
SELECT AVG(TypicalWeightPerUnit) FROM Warehouse.StockItems
```

The average, typical weight per unit comes back as 1.833920.

The warehouse manager wants to know the average, typical weight per unit by supplier. We can aggregate and run calculations over groups using the' GROUP BY' clause. This is the query to get the typical average weight per unit by the supplier:

```sql
SELECT SupplierID, AVG(TypicalWeightPerUnit)
FROM Warehouse.StockItems
GROUP BY SupplierID
```

The results are:

| SupplerID | (No column name) |
|--- |--- |
| 1 | 0.281250 |
| 2 | 0.250000 |
| 4 | 0.337162 |
| 5 | 0.150000 |
| 7 | 3.261194 |
| 10 | 8.955555 |
| 12 | 0.156666 |

The marketing team found out that we had access to a variety of data and wondered if we could look at the special deals. They first wanted to know the average discount amount and average discount percentages for all special deals. The query to get the average discount amount and average discount percentages for the special deals is as follows:

```sql
SELECT AVG(DiscountAmount), AVG(DiscountPercentage)
FROM Sales.SpecialDeals
```

The average discount amount is `NULL`. The DiscountAmount field might not be used. The average discount percent is 12.500000.

Now, marketing wants to know the minimum and maximum discount percentages.  The query to get the minimum and maximum percentages is:

```sql
SELECT MIN(DiscountPercentage), MAX(DiscountPercentage)
FROM Sales.SpecialDeals
```
The special deals percentages results are:

| (No column name) | (No column name) |
|--- |--- |
| 10.000 | 15.000 |

There is a difference between the percentages. Seeing there are different values, the marketing team is curious.

## `COUNT` and `COUNT(DISTINCT)`

With different values for the minimum and maximum, the marketing team is wondering how many special deals exist and for what percentages. We can group by percentage and use `COUNT()` to count the values. The query to get the number of special deals for each percentage is:

```sql
SELECT DiscountPercentage, COUNT(DiscountPercentage)
FROM Sales.SpecialDeals
GROUP BY DiscountPercentage
```

The results are:

| DiscountPercentage | (No column name) |
|--- |--- |
| 10.000 | 1 |
| 15.000 | 1 |

The purchasing department heard we were aggregating data and wanted to be included. They wondered how many supplier transactions were done over the company's life and how many unique suppliers there are. We can approach this with two ways of using `COUNT()`:

- `COUNT(SupplierID)` on the `Purchasing.SupplierTransactions` table to get the number of transactions
- `COUNT(DISTINCT SupplierID)` on the `Purchasing.SupplierTransactions` table to get the number of unique suppliers

The query to get the number of transactions and the number of unique suppliers is:

```sql
SELECT COUNT(SupplierID), COUNT(DISTINCT SupplierID)
FROM Purchasing.SupplierTransactions
```

The results are:

| (No column name) | (No column name) |
|--- |--- |
| 2438 | 7 |

The purchasing department wants all transactions with an outstanding balance grouped by supplier. Now we need to include a `WHERE` clause. The order for writing the query is as follows:

```sql
SELECT
FROM
WHERE
GROUP BY
```

The query to get all transactions with an outstanding balance, grouped by the supplier, is as follows:

```sql
SELECT SupplierID, COUNT(SupplierTransactionID)
FROM Purchasing.SupplierTransactions
WHERE OutstandingBalance > 0
GROUP BY SupplierID
```

The results are:

| SupplierID | (No column name) |
|--- |--- |
| 4 | 1 |
| 7 | 1 |

## Aggregating strings with `STRING_AGG`

Strings can also be aggregated. The head of sales is new to the company and wants a list of states for each sales territory. We can use `STRING_AGG()` to aggregate strings into a single value. `STRING_AGG()` takes two parameters:

* Field to aggregate
* Separator for creating the string

For our example, we want the sales territory and the states separated by a comma and a space for readability. This is the query:

```sql
SELECT SalesTerritory, STRING_AGG(StateProvinceCode,', ')
FROM Application.StateProvinces
GROUP BY SalesTerritory
```

The output looks like this:

| Sales Territory | (No column name) |
|--- |--- |
| External | PR, VI |
| Far West | WA, OR, AK, CA, HI, NV |
| Great Lakes | MI, IL, IN, OH, WI |
| Mideast | PA, DE, DC, MD, NJ, NY |
| New England | NH, MA, CT, ME, RI, VT |
| Plains | SD, MN, MO, NE, ND, IA, KS |
| Rocky Mountain | ID, CO, MT, UT, WY |
| Southeast | WV, VA, TN, SC, MS, NC, KY, LA, FL, GA, AL, AR |
| Southwest | AZ, NM, TX, OK |

## Working with SQL Variables

Sometimes, SQL variables are used when working with aggregates, mainly for storing aggregate values from one query and using them in another. Let's take a look at how we can do this.

For this example, we want to get the least populated and most populated countries. Our approach is this:

1. Create `bigint` variables for storing the highest and lowest populations.  We will use variables named `@HighestPopulation` and `@SmallestPopulation`.
1. Get the highest and lowest populations using `MAX()` and `MIN()`, and store them in the variables created in step 1.
1. Re-query the countries table to get the country names for countries with populations equal to the highest or lowest population.

Our SQL looks like this:

```sql
DECLARE @HighestPopulation bigint
DECLARE @SmallestPopulation bigint

SELECT @HighestPopulation = MAX(LatestRecordedPopulation), @SmallestPopulation = MIN(LatestRecordedPopulation) 
FROM Application.Countries

SELECT CountryName, LatestRecordedPopulation 
FROM Application.Countries 
WHERE LatestRecordedPopulation = @HighestPopulation
    OR LatestRecordedPopulation = @SmallestPopulation
```

| CountryName | LatestRecordedPopulation |
|--- |--- |
| China | 1392157488 |
| Nauru | 14019 |

## Adding `ORDER BY` to our Aggregate Queries

So far, our queries have used `SELECT`, `FROM`, `WHERE`, and `GROUP BY`.  Now let's add an `ORDER BY` clause to get used to stacking all of these clauses.

The sales manager wants a list of delivery postal codes and the number of customers in each postal code. They want the list ordered from the most to the least, sorted by postal code. This is the query to achieve customer counts by postal code in order of most customers to least, then postal code:

```sql
SELECT DeliveryPostalCode, COUNT(CustomerID)
FROM Sales.Customers
GROUP BY DeliveryPostalCode
ORDER BY COUNT(CustomerID) DESC, DeliveryPostalCode
```

There are 453 postal codes in the results.

The warehouse manager came back to talk with us about the cold room. They want to see the number of readings and the earliest and latest recorded date. The query to achieve this is:

```sql
SELECT COUNT(ColdRoomTemperatureID), MIN(RecordedWhen), MAX(RecordedWhen)
FROM Warehouse.ColdRoomTemperatures
```

The results are:

| (No column name) | (No column name) | (No column name) |
|--- |--- |--- |
| 4 | 2016-05-31 23:59:24.0000000 | 2016-05-31 23:59:24.0000000 |

The warehouse manager explains that there are multiple sensors in the cold room. They want to know the minimum, maximum, and average readings and the number of readings for each sensor for May 2016. They would like this information ordered by the sensor number.

The approach to the query looks like this:

1. Get all of the aggregates in the `SELECT` clause.
1. Put the table name in the `FROM` clause.
1. Specify the period filter in the `WHERE` clause.
1. Group the aggregates by the sensor number - as we want our data for each sensor - in the `GROUP BY` clause.
1. Order the results with the `ORDER BY` clause.

This is an approach to the problem using the `YEAR()` and `MONTH()` date functions:

```sql
SELECT ColdRoomSensorNumber, MIN(Temperature), MAX(Temperature), 
    AVG(Temperature), COUNT(ColdRoomTemperatureID)
FROM Warehouse.ColdRoomTemperatures
WHERE YEAR(RecordedWhen) = 2016 AND MONTH(RecordedWhen) = 5
GROUP BY ColdRoomSensorNumber
ORDER BY ColdRoomSensorNumber
```

The results are:

|ColdRoomSensorNumber| (No column name) | (No column name) | (No column name) | (No column name) |
|--- |--- |--- |--- |--- |
| 1 | 3.72 | 3.72 | 3.720000 | 1 |
| 2 | 4.70 | 4.70 | 4.700000 | 1 |
| 3 | 3.00 | 3.00 | 3.000000 | 1 |
| 4 | 3.58 | 3.58 | 3.580000 | 1 |

This is an approach using the `BETWEEN` clause. Note that our values include the full date and time expression - this formatting matches how the field is formatted.

```sql
SELECT ColdRoomSensorNumber, MIN(Temperature), MAX(Temperature), 
    AVG(Temperature), COUNT(ColdRoomTemperatureID)
FROM Warehouse.ColdRoomTemperatures
WHERE RecordedWhen BETWEEN '2016-05-01 00:00:00.0000000' AND '2016-05-31 23:59:59.9999999'
GROUP BY ColdRoomSensorNumber
ORDER BY ColdRoomSensorNumber
```

This approach uses the mathematical operators of `>=` and `<=`. We use the same full date and time values that we used in the `BETWEEN` expression. Whenever working with dates and times, look at how the data is formatted and structure your query values to follow that pattern.

```sql
SELECT ColdRoomSensorNumber, MIN(Temperature), MAX(Temperature), 
    AVG(Temperature), COUNT(ColdRoomTemperatureID)
FROM Warehouse.ColdRoomTemperatures
WHERE RecordedWhen >= '2016-05-01 00:00:00.0000000'
    AND RecordedWhen <= '2016-05-31 23:59:59.9999999'
GROUP BY ColdRoomSensorNumber
ORDER BY ColdRoomSensorNumber
```

## `HAVING` clause

We can aggregate values for a whole dataset and groups. However, we still need to introduce filtering those data results based on aggregate values. We can filter our results on aggregate values using the `HAVING` clause.  

Our accounting department wanted more insight into the invoices in the system. They want to find all invoices with the number of items invoiced with the invoice totals exceeding $30,000. The approach for this query is:

1. Get the `InvoiceID`, the sum of quantity, and the sum of the extended price in the `SELECT` clause.
2. Put the invoice lines table in the `FROM` clause.
3. Group by `InvoiceID` so that our sums are by invoice.
4. Bring in the `HAVING` clause, and check that the sum of the extended price is greater than 30000.00.

This is the query to find all invoices that are greater than $30,000:

```sql
SELECT InvoiceID, SUM(ExtendedPrice), SUM(Quantity)
FROM Sales.InvoiceLines
GROUP BY InvoiceID
HAVING SUM(ExtendedPrice) > 30000.00
```

Ten invoices meet these criteria.

There was another question from the team about the customers who have been invoiced for both dry and chiller items in 2016. They would like the list of the most dry items, the most chiller items, and the customer ID. The approach for this query is:

1. Get the customer id, the sum of the total dry items, and the sum of the total chiller items in the `SELECT` clause.
1. Put the invoices table in the `FROM` clause.
1. Check the year in the `WHERE` clause.
1. Group the customer ID sums with the `GROUP BY` clause.
1. Add the check where they have total dry and chiller items greater than 0 in the `HAVING` clause.
1. Order our results in the `ORDER BY` clause, including aggregates.

The query is:

```sql
SELECT CustomerID, SUM(TotalDryItems), SUM(TotalChillerItems)
FROM Sales.Invoices
WHERE YEAR(InvoiceDate) = 2016
GROUP BY CustomerID
HAVING SUM(TotalDryItems) > 0 AND SUM(TotalChillerItems) > 0
ORDER BY SUM(TotalDryItems) DESC, SUM(TotalChillerItems) DESC, CustomerID
```

There are 507 rows returned in this query.

## Conclusion

From a data analysis perspective, it may help get a general overview of columns quantitatively when working with SQL. We looked at sums, averages, minimums, maximums, and counts. We also saw how strings could be grouped and aggregated to compile lists of strings. In this lesson, we saw how we could get these values for the whole dataset and data groups.

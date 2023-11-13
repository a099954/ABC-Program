# Lesson: Date Handling in SQL

## Introduction

Invoice aging, reviewing quarterly sales, managing shifts, and checking how long parts are at a station as part of a work order are some of the many business tasks that revolve around dates and times. SQL Server has many data types and functions to assist with temporal data. In this lesson, we will look at the data types and functions used for dates and times in SQL Server.

## Learning Outcomes

By the end of this lesson, you will be able to:

1. Explain how to find the date formats for a database. 
1. Identify data types that are used for storing temporal data. 
1. Name at least five functions for getting pieces of dates. 
1. Name at least three functions used for date calculations. 

## Dates and Date Formatting in SQL

It is important to understand your dates' format when working with SQL, as different date formats between source and target data can cause headaches.

You can get the active date format for your current SQL session by querying a system view `sys.dm_exec_requests` specifically for the `date_format` field. We can limit the date format to the current session by using the internal variable `@@SPID`. This is the query:

```sql
SELECT date_format
FROM master.sys.dm_exec_requests
WHERE session_id = @@SPID;
```

Our output was:

| date_format |
| ---- |
| mdy |

This means that our session prefers dates in the `Month-Day-Year` format. However, the SQL standard date is the ISO 8601 definition for date - `Year (4 digits)-Month-Day`. SQL Server will work with both the session format and the ISO format. It is highly recommended to use the ISO format - `yyyy-mm-dd` - when possible to avoid confusion. There are more details on these format strings later in this lesson.

## Data Types

SQL Server has an assortment of data types available for a temporal date, including:

* `date`
* `time`
* `datetime`
* `datetime2`
* `datetimeoffset`

Let's explore these a little further.

### `date` 

Consider using the `date` data type when you only need to track a date without a time - such as a holiday, pay date, or school start date. Unless otherwise specified in system settings, this data type returns the ISO format of a date. It returns the year, month, and day in date format.

### `time` 

When you need to track time on its own - perhaps for scheduling a daily update, keeping track of work shifts, or doing math in counting hours between checkpoints, consider working with the `time` data type.  This type returns the hours, minutes, seconds, and milliseconds.

### `datetime` 

The oldest date type in the SQL data types covered in this lesson is `datetime`. This data type stores both the date and time.

In SQL, we can use the `GETDATE()` and `GETUTCDATE()` functions to get the current date and time in `datetime` values. `GETDATE()` shows the current time based on the server's **offset** - the time off of Greenwich Mean Time (GMT, `+0:00` from UTC). UTC is short for Coordinated Universal Time.  `GETUTCDATE()` shows the current time with the offset factored in.

For this example, the SQL Server's offset is `-04:00`:

  * `GETDATE()` returns `2021-08-05 14:42:40.103`
  * `GETUTCDATE()` returns `2021-08-05 18:42:40.103`

Notice that the `GETUTCDATE()` response is equal to the `GETDATE()` with the offset adjusted to `+0:00`.

> When an offset is applied, negative offsets are added to the local time. Positive offsets are subtracted from the local time.

If you have data coming from multiple sources and need to standardize on a uniform time, `GETUTCDATE()` can handle that. However, if you need to preserve the local time and its offset, we will cover another data type soon.

### `datetime2` 

`datetime2` is another data type in SQL that is used for storing a combination of date and time.  `datetime2` differs from `datetime` on a few points:

  * Accuracy: `datetime` is accurate to 333 nanoseconds, whereas `datetime2` is accurate to 100 nanoseconds.
  * Range: `datetime` has a range of `1753-01-01` to `9999-12-31`, while `datetime2` has a range of `0001-01-01` to `9999-12-31`.
  * Storage:
    * `datetime` has a fixed storage at 8 bytes, while `datetime2` has a variable storage amount between 6-8 bytes.
    * `datetime2`'s storage is dependent on the date's precision. If the date's precision is 3 or lower, a `datetime2` value is stored at 6 bytes. If the date's precision value is 4 or 5 decimal point values, a `datetime2` value is stored at 7 bytes. A `datetime2` value could take 8 bytes for all other precision values.

`SYSDATETIME()` and `SYSUTCDATETIME()` return `datetime2` values, one in server local time and one in UTC, respectively.

For this example, the server's offset is `-04:00`.

The `datetime` values are:
  * `GETDATE()` returns `2021-08-05 14:42:40.103`
  * `GETUTCDATE()` returns `2021-08-05 18:42:40.103`

The `datetime2` values are:
  * `SYSDATETIME()` returns `2021-08-05 14:42:40.1043180`
  * `SYSUTCDATETIME()` returns `2021-08-05 18:42:40.1043180`

If you need to store more precise dates or work with dates with a precision of 5 or less, consider working with `datetime2`.

### `datetimeoffset` 

The `datetimeoffset` data type takes date and time and includes the offset value as part of the `datetimeoffset` value.

Use `SYSDATETIMEOFFSET()` when you need the current date, time, and offset.

To carry through with our example date, `SYSDATETIMEOFFSET()` returns `2021-08-05 14:42:40.1043180 -04:00`.

The server's offset is `-04:00`. To be clear, this is an offset and does not represent a timezone. 

The current offset is `-04:00`, though at other parts of the year, the server will report its offset as `-05:00`, depending on Daylight Saving Time. Records reported today will be `-04:00`. Records at the end of the year or at the beginning of the year will be recorded at `-05:00`. The server itself may not change physically, but its offset may change for Daylight Saving Time.

Suppose we physically move the server from U.S. Eastern Time to U.S. Pacific Time. However, we may have forgotten to update our system to the new timezone. Physically, the server is in Pacific Time. However, operating system-wise and SQL Server-wise, it is reporting in Eastern Time. There is no magical way of getting your date to pick up the current physical timezone.

`datetimeoffset` data is not timezone aware. However, if you need to calculate time differences based on the offset, then capture the offset by using the `datetimeoffset` data type. 

## SQL Functions with Dates

When it comes to working with dates in SQL Server, many functions make it easier for date handling. Let's look at `FORMAT()`, working with parts of dates, and doing calculations with dates.

### `FORMAT()`

`FORMAT()` is used for converting date values from one format to another. You can format dates using format strings. You can also format dates taking culture into account.

For these examples, we will work with the GETDATE() value of `2021-08-05 15:11:51.777`.

#### Formatting Dates with Format Strings

Format strings are common ways of formatting in programming languages. SQL's date formatting works with the following abbreviations:

  * `MM` - a two-digit month from 01-12
  * `MMM` - abbreviated month (Jan, Feb, Mar, etc.)
  * `MMMM` - month spelled out (January, February, March, etc.)
  * `dd` - a two-digit day from 01-31
  * `dddd` - the day of the week spelled out (Monday, Tuesday, Wednesday, etc.)
  * `yy` - two-digit year
  * `yyyy` - four-digit year
  * `hh` - a two-digit hour from 01-12
  * `mm` - two-digit minutes from 00-59
  * `ss` - two-digit seconds from 00-59

Suppose we want to get the hours, minutes, and seconds from `GETDATE()`. We can use `FORMAT()` and pass in two values:

  * the date - for this example, we are using `GETDATE()`
  * the date format string - for this example, we are using `hh:mm:ss`

This is the code for getting the hours, minutes, and seconds from `GETDATE()` using `FORMAT()`:

```sql
SELECT FORMAT(GETDATE(),'hh:mm:ss')
```

Here is the result:

```
03:11:51
```

Suppose we wanted to get the date in the format of `Month-Day-Year`. Consider the following code:

```sql
SELECT FORMAT(GETDATE(),'MM-dd-yyyy')
```

Here is the result:

```
08-05-2021
```

Suppose we prefer slashes instead of dashes. We also may prefer two-digit years instead of four-digit years. Consider the following code to get the date from `GETDATE()` in `Month/day/two-digit year` format:

```sql
SELECT FORMAT(GETDATE(),'MM/dd/yy')
```

Here is the result:

```
08/05/21
```

Refer to [Standard date and time format strings documentation from Microsoft](https://docs.microsoft.com/en-us/dotnet/standard/base-types/standard-date-and-time-format-strings) for common date and time format strings.

#### Formatting Dates with Culture

Another approach to formatting dates is passing in the **culture code**, which includes a two-letter language code and a two-letter country or region code. In this approach, the `FORMAT()` function takes in three parameters:

  * the date - `GETDATE()` in our example
  * the date format string - `d` in our example is a short date pattern
  * culture code - `cs-CZ` is the culture code for Czech Republic

Suppose we need to display our `GETDATE()` date in the short date pattern - only including the numeric representations of the month, day, and year, not including the day of the week or the month spelled out. We want to display our date to a Czech audience. Their dates are in `Day.Month.Year` form. Consider the following code:

```sql
SELECT FORMAT(GETDATE(),'d','cs-CZ')
```

Here is the result:

```
05.08.2021
```

To find a comprehensive list of culture codes used in SQL Server, search the Internet for ".NET culture codes."

### Working with Parts of Dates

It is common to work with parts of dates. Consider the following applications:

* Looking at a company's growth by seeing the number of hires by year and month
* Calculating quarterly sales
* Checking if sales are more popular on a certain day of a week

All of these tasks can be accomplished in SQL through the help of built-in functions.

#### Working with Individual Part Functions

In the example of looking at the number of hires by year and month, the `YEAR()` and `MONTH()` functions would be used.

`YEAR()` and `MONTH()` each take in one parameter - a date value. These functions work with `date`, `datetime`, `datetime2`, `datetimeoffset`, and date strings.

Consider the following code:

```sql
SELECT YEAR('2020-10-12 10:00:00'), MONTH('2020-10-12 10:00:00')
```

The results are:

```
2020     10
```

Suppose we look at invoices for April 2016 in the Wide World Importers dataset. Specifically, let's look at the number of invoices, chiller items, and dry items grouped by day. We can use `DAY()` to access the day portion of a date value. Like `YEAR()` and `MONTH()`, `DAY()` takes in one parameter of a date type value. Here is the SQL to get our invoices for April 2016 and looking at the number of invoices, number of chiller items, and number of dry items by day:

```sql
SELECT DAY(InvoiceDate), COUNT(InvoiceID),
    SUM(TotalChillerItems), SUM(TotalDryItems)
FROM Sales.Invoices
WHERE YEAR(InvoiceDate) = 2016 
   AND MONTH(InvoiceDate) = 4
GROUP BY DAY(InvoiceDate)
ORDER BY DAY(InvoiceDate)
```

#### Working with Character Representations

`DATENAME()` and `DATEPART()` are used for working with parts of dates.  `DATENAME()` and `DATEPART()` take in two parameters - a datepart and a date type value. A **datepart** is shorthand for the part of the date. If you need to get names spelled out, use `DATENAME()`. If you need to get date parts in numeric values, use `DATEPART()`. Refer to [DATENAME() documentation on Arguments](https://docs.microsoft.com/en-us/sql/t-sql/functions/datename-transact-sql?view=sql-server-ver15#arguments) and [DATEPART() documentation on Arguments](https://docs.microsoft.com/en-us/sql/t-sql/functions/datepart-transact-sql?view=sql-server-ver15#arguments) for supported dateparts.

Suppose we calculate the number of chiller and dry items invoiced by quarter for 2014 and 2015. Looking at the `DATEPART()` documentation, we can use `DATEPART()` with the datepart value of `q` to get the quarterly breakdown.

Here is the query to get the number of chiller items and  dry items invoiced by year and then by quarter:

```sql
SELECT YEAR(InvoiceDate), DATEPART(q, InvoiceDate),
    SUM(TotalChillerItems), SUM(TotalDryItems)
FROM Sales.Invoices
WHERE YEAR(InvoiceDate) IN (2014,2015)
GROUP BY YEAR(InvoiceDate), DATEPART(q, InvoiceDate)
ORDER BY YEAR(InvoiceDate), DATEPART(q, InvoiceDate)
```

Here is the result:

| (No column name) | (No column name) | (No column name) | (No column name) |
|-------|-------|-------|-------|
| 2014 |	1	| 0 | 15448 |
| 2014 |	2	| 0 | 17171 |
| 2014 |	3	| 0 | 16345 |
| 2014 |	4	| 0 | 16977 |
| 2015 |	1	| 0 | 16934 |
| 2015 |	2	| 0 | 18633 |
| 2015 |	3	| 0 | 18573 |
| 2015 |	4	| 0 | 17758 |

We may want to see if we send more invoices on a particular day of the week - Monday, Tuesday, Wednesday, etc. We can use `DATENAME()` to get us the names of the dates and `DATEPART()` to get us the value to order the dates properly.

Here is the sql:

```sql  
SELECT DATENAME(WEEKDAY, InvoiceDate), COUNT(InvoiceDate) 
FROM Sales.Invoices
GROUP BY DATENAME(WEEKDAY, InvoiceDate), DATEPART(dw, InvoiceDate)
ORDER BY DATEPART(dw, InvoiceDate) 
```

Here are the invoice counts by day of the week:

| (No column name) | (No column name) |
|------|-----------------|
| Monday |	13000 |
| Tuesday |	13117 |
| Wednesday |	12955 |
| Thursday |	12853 |
| Friday	| 12700 |
| Saturday |	5885 |

Only a few invoicing happens on Saturday, and no invoicing happens on Sunday.

> A Note on Internationalization and Dates
> 
> Different cultures start their weeks on different days.  A setting in the system determines the first day of the week. This can be set on the server using the `SET DATEFIRST` command. It can be queried with `SELECT @@DATEFIRST`. For our course, our `@@DATEFIRST` is set to 7, which is Sunday. Refer to [Microsoft's documentation on `DATEFIRST`](https://docs.microsoft.com/en-us/sql/t-sql/functions/datefirst-transact-sql) for specifics on how `DATEFIRST` works.

We can also build dates from parts using `DATEFROMPARTS()`. Perhaps we want to calculate how far we are from the beginning of the year. We can pass in the year, month, and day to `DATEFROMPARTS()` to build the first day.

Consider this SQL:

```sql
DECLARE @firstOfYear date
SET @firstOfYear = DATEFROMPARTS(YEAR(GETDATE()), 1, 1)
SELECT @firstOfYear
```

Our result is:

```
2021-01-01
```      

Note that `DATEFROMPARTS()` returns a `date` type. If you need to include the time, you can create `datetime`, `datetime2` and `datetimeoffset` values using `CAST()`.

Consider the following SQL:

```sql
SELECT CAST('2021-01-01 00:00:00.000000 -04:00' AS datetime2)
SELECT CAST('2021-01-01 00:00:00.000000 -04:00' AS datetimeoffset)
```

These queries return:

```
2021-01-01 00:00:00.0000000
2021-01-01 00:00:00.0000000 -04:00
```

`datetime` does not work with the offset. Consider the following SQL:

```sql
SELECT CAST('2021-01-01 00:00:00.000000 -04:00' AS datetime)
```

We get the following error:

```
Conversion failed when converting date and/or time from character string.
```

`datetime` requires year, month, day, hours, minutes, seconds, milliseconds, microseconds, and nanoseconds. The following SQL statement shows the most characters for a `datetime` with `CAST()`.

```sql
SELECT CAST('2021-01-01 00:00:00.000' AS datetime)
```

The result is:

```
2021-01-01 00:00:00.000
```

### Calculating with Dates

Dates can work with some aggregate functions in SQL - specifically `MIN()` and `MAX()`. `MIN()` will return the earliest date. `MAX()` will return the latest date.

Differences between dates can be calculated with `DATEDIFF()`. `DATEDIFF()` takes in three arguments:

  * a datepart
  * start date
  * end date

We want to look at the purchase orders to see the difference between the order date and the expected delivery date. We want to see how many purchase orders have the same gap between the order date and the delivery date. Consider the following SQL query:

```sql
SELECT DATEDIFF(d,OrderDate,ExpectedDeliveryDate), COUNT(PurchaseOrderID)
FROM Purchasing.PurchaseOrders
GROUP BY DATEDIFF(d, OrderDate, ExpectedDeliveryDate)
ORDER BY DATEDIFF(d, OrderDate, ExpectedDeliveryDate)
```

Here are the results:

| (No column name) | (No column name) |
|------------------|---------------|
| 3	| 1 |
| 7	| 74 |
| 12 | 6 |
| 14 | 109 |
| 20 | 1884 |

For the most part, the difference between the order date and the expected delivery date is twenty days. We could explore our data further if we wanted to dive deeper to see if these varied from suppliers. `DATEDIFF()` also helps with identifying how long a part is at a station or looking at invoice aging.

## Conclusion

From yearly financial reviews to quarterly or monthly commission calculations to production planning, dates and times are relevant across business units. In this lesson, we looked at data types for storing dates and times. We also looked at how to format dates and times for our needs, including working with parts of dates using numeric and string representations.

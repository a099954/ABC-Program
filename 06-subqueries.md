# Lesson: Using Subqueries

## Introduction

Up until this point, we have been querying tables. However, we can also run queries against another query's results. We can use query results as part of our fields returned from a different query and even use the results of another query as a comparison for a query in `WHERE` clauses. Queries nested within other queries are known as subqueries. In this lesson, we will show how to work with subqueries.

## Learning Outcomes

By the end of this lesson, you will be able to:

1. Define the term subquery.
1. Check for existence using a subquery.
1. Use subqueries for comparison in `WHERE` clauses.

## What is a subquery?  How is it used?

As the name suggests, a **subquery** is a query within a query. The results of a subquery may be a scalar value (single value) or a table of values. Subqueries have many uses:

* Checking records based on existence (or not existing)
* Acting as a range or a value for comparison in a `WHERE` clause
* As a field in a `SELECT` clause

Let's take a look at how these subqueries work.

## Using Subqueries with Existence - `EXISTS` and `NOT EXISTS`

One of the things subqueries can be used for is to check if a relationship exists or not exists. In Wide World Importers, consider the relationship between `Application.Countries` and `Application.StateProvinces`. All states or provinces have a country, but not all countries have a state or province. Knowing what we know so far from the lessons in this module, we could use `LEFT JOIN` to see the countries without states or provinces.  The `LEFT JOIN` query for counting the countries without states or provinces is:

```sql
SELECT COUNT(DISTINCT CountryName) 
FROM Application.Countries 
LEFT JOIN Application.StateProvinces
    ON Application.Countries.CountryID = Application.StateProvinces.CountryID
WHERE Application.StateProvinces.CountryID IS NULL
```

There are 189 country names without states.

We can use a subquery to check existence as well. We want a count of all unique country names that do not have states or provinces. We can use the `NOT EXISTS` operator in a `WHERE` clause to check the non-existence of things. The approach we will take with this is:

1. Select the count of unique country names in the `SELECT` clause.
1. Put `Application.Countries` in the `FROM` clause.
1. Add a `WHERE` clause for filtering our results using `NOT EXISTS`, followed by parentheses.
1. Within those parentheses, write the query to select the country ID from state provinces where state provinces' country ID is equal to the countries' country ID field.

The query for getting the count of the countries that do not have states or provinces is as follows:

```sql
SELECT COUNT(DISTINCT CountryName) 
FROM Application.Countries
WHERE NOT EXISTS 
    (SELECT CountryID 
    FROM Application.StateProvinces
    WHERE Application.StateProvinces.CountryID = Application.Countries.CountryID)
```

If we wanted to get the count of countries with states or provinces, we could use the `EXISTS` keyword. The previous query changes by removing the `NOT`. The query to get the count of countries that do have states or provinces using the `EXISTS` keyword is:

```sql
SELECT COUNT(DISTINCT CountryName) 
FROM Application.Countries 
WHERE EXISTS 
    (SELECT CountryID 
    FROM Application.StateProvinces 
    WHERE Application.StateProvinces.CountryID = Application.Countries.CountryID)
```

There is one country with states.

## Using Subqueries in `WHERE` Clauses

Another use for subqueries is for comparison in the `WHERE` clause. This is common when trying to find values compared to table-wide aggregated values instead of group-wide. We call out table-wide specifically because subqueries, in this case, need to return a single value or a set of values for a single column.

Suppose we want to find the city with the largest recorded population. We can use a subquery for that. Here is the approach to the query:

1. Select the city name in the `SELECT` clause.
1. Put `Application.Cities` in the `FROM` clause.
1. Add a `WHERE` clause for filtering, as we want to filter for the largest recorded population. We will use a subquery to get a scalar value. However, with the `IN` keyword, the subquery could return a set of values for a single column and still work. So this `WHERE` clause uses the `IN` keyword to check the latest recorded population. Follow the `IN` clause with a set of parentheses `()`. The `WHERE` clause at this point should look like this:

    ```sql
    WHERE LatestRecordedPopulation IN ()
    ```
1. Within those parentheses, write the query to select the maximum latest recorded population table-wide.

The query to find the city with the largest recorded population is:

```sql
SELECT CityName 
FROM Application.Cities 
WHERE LatestRecordedPopulation IN 
    (SELECT MAX(LatestRecordedPopulation) 
    FROM Application.Cities)
```

The result is New York.

In addition to using the `IN` keyword, you can also use the mathematical operators for comparison in a `WHERE` clause when using a subquery for a value. Suppose we want to get cities and populations greater than the average recorded population. This is the approach we will take:

1. Select the city name and latest recorded population in the `SELECT` clause.
1. Put `Application.Cities` in the `FROM` clause.
1. Add a `WHERE` clause for filtering, as we want to filter for the latest recorded populations greater than average. We will use a subquery to get a scalar value. So this `WHERE` clause uses the greater than operator `>` to check the latest recorded population against the average population. Follow the `>` with a set of parentheses `()`. The `WHERE` clause at this point should look like this:

    ```sql
    WHERE LatestRecordedPopulation > ()
    ```

4. Within those parentheses, write the query to select the table-wide average latest recorded population.

The query to find all cities with populations greater than the average population is:

```sql
SELECT CityName, LatestRecordedPopulation
FROM Application.Cities
WHERE LatestRecordedPopulation > 
    (SELECT AVG(LatestRecordedPopulation)
     FROM Application.Cities)
```

There are 4104 rows in this result set.

## Using Subqueries in `SELECT` Clauses

Another place where subqueries can be used is in the `SELECT` clause.  Table-wide aggregates are a common subquery in a `SELECT` clause.

Suppose we want a count of cities by the state as well as the count of unique states. The approach would be:

1. Select the province ID, the distinct cities by state, and a subquery with the county for the unique province ids in `Application.Cities`.
1. Add `Application.Cities` to the `FROM` clause.
1. Group by state province ID.

The query to get the count of cities by state, as well as the count of unique states, is as follows:

```sql
SELECT StateProvinceID, COUNT(DISTINCT CityID), 
    (SELECT COUNT(DISTINCT StateProvinceID) FROM Application.Cities)
FROM Application.Cities
GROUP BY StateProvinceID
```

There are 53 rows returned in these results.

As we have mentioned with subqueries, they return a single value or a set of values for a single column. However, you may want to try using multiple aggregates to see what SQL Server thinks. Try running the following code in a query window for Wide World Importers:

```sql
SELECT CityName, LatestRecordedPopulation, 
    (SELECT AVG(LatestRecordedPopulation), 
            MAX(LatestRecordedPopulation) 
    FROM Application.Cities) 
FROM Application.Cities
```

The error message comes back as:

```
Started executing query at Line 1
Msg 116, Level 16, State 1, Line 1
Only one expression can be specified in the select list when the subquery is not introduced with EXISTS.
Total execution time: 00:00:00.008
```

A subquery can have multiple columns in an `EXISTS` clause, but that's the only place where multiple columns may exist within a subquery.

## Conclusion

In this lesson, we ran queries against another query's results. We used another query's results as part of our fields. We compared against table-wide aggregates for a query in `WHERE` clauses. Queries nested within other queries are known as subqueries. In this lesson, we showed common places to work with subqueries. In the following exercise, you will write some SQL statements with subqueries to answer questions.

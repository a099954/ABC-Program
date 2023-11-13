# Exercise: Aggregates

## Introduction

In the Aggregates SQL lesson, we introduced aggregates to better understand our data for descriptive analysis. For this exercise:

1. Create a new SQL file.
1. Set the connection in SQL Server Management Studio (SSMS) to look at Wide World Importers.
1. Write these `SELECT` queries.

## Exercise

1. What is the average typical weight per unit for warehouse stock items?
1. What are the heaviest and lightest stock items - based on typical weight per unit?
    * Hints: 
    * Use SQL variables to store the minimum and maximum values.
    * Then build a query off of those results.
1. Create a list of brands and their total stock items in the warehouse. Sort it by the most to least items, then alphabetically by brand.
1. How many temperature sensor recordings are there for the vehicle temperatures? What are their recordings? Include:
    * Count of temperature readings
    * Earliest date of recording
    * Latest date of recording
1. Get the VehicleRegistration, ChillerSensorNumber, Min temperature, Max temperature, Average temperature, number of readings, and number of unique vehicle registrations for March 2016. Order by vehicle registration and chiller sensor number.
    * Hints:
    * The date range makes a difference for the `BETWEEN` and `<=` and `>=` ranges.
    * You can get those specific values from `MIN` and `MAX` RecordedWhen values.
1. Let's start by looking at the order lines for Order 1163.
1. Now, let's get the total for these order lines for Order 1163.
1. Are there any orders where Quantity and PickedQuantity don't match? Let's count the order lines.
1. Let's see what orders have outstanding quantities and how many are still outstanding for each order.
1. What is the query for getting individual orders' totals?
1. Suppose we want orders less than $1000. What is the query for orders less than $1000?

# Exercise: Aggregates - STUDENT KEY

## Introduction

In the Aggregates SQL lesson, we introduced aggregates to better understand our data for descriptive analysis. For this exercise:

1. Create a new SQL file.
1. Set the connection in SQL Server Management Studio (SSMS) to look at Wide World Importers.
1. Write these `SELECT` queries.

The student key contains general guidance to assure you that you are on the right track.

## Exercise

1. What is the average typical weight per unit for warehouse stock items?

    ```
    1.833920
    ```

2. What are the heaviest and lightest stock items - based on typical weight per unit?

    | StockItemName | TypicalWeightPerUnit |
    | -------------------- | -------------------- |
    | USB food flash drive - sushi roll | 0.050 |
    | USB food flash drive - hamburger | 0.050 |
    | USB food flash drive - hot dog | 0.050 |
    | USB food flash drive - pizza slice | 0.050 |
    | USB food flash drive - banana | 0.050 |
    | USB food flash drive - chocolate bar | 0.050 |
    | USB food flash drive - cookie | 0.050 |
    | USB food flash drive - donut | 0.050 |
    | USB food flash drive - shrimp cocktail | 0.050 |
    | USB food flash drive - fortune cookie | 0.050 |
    | Ride on big wheel monster truck (Black) 1/12 scale | 21.000 |

3. Create a list of brands and their total stock items in the warehouse. Sort it by the most to least items, then alphabetically by brand.

    | Brand | (No column name) |
    | --------- | -------------- |
    | NULL | 209 |
    | Northwind | 18 |

4. How many temperature sensor recordings are there for the vehicle temperatures? What are their recordings? Include:
   * Count of temperature readings
   * Earliest date of recording
   * Latest date of recording

    | (No column name) | (No column name) | (No column name) |
    | ---------------- | --------------- | ---------------- |
    | 65998 | 2016-01-01 07:00:00.0000000 | 2016-05-31 15:57:19.0000000 |

5. Get the VehicleRegistration, ChillerSensorNumber, Min temperature, Max temperature, Average temperature, number of readings, and number of unique vehicle registrations for March 2016. Order by vehicle registration and chiller sensor number.

    | VehicleRegistration | ChillerSensorNumber | (No column name) | (No column name) | (No column name) | (No column name) | (No column name) |
    | ------------------- | ------------------- | -------------- | -------------- | ------------------ | ---------------- | ---------------- |
    | WWI-321-A | 1 | 3.00 | 5.00 | 4.001882 | 6757 | 1 |
    | WWI-321-A | 2 | 3.00 | 5.00 | 4.008250 | 6757 | 1 |

6. Let's start by looking at the order lines for Order 1163.

    | OrderLineID | OrderID | StockItemID | Description | PackageTypeID | Quantity | UnitPrice | TaxRate | PickedQuantity | PickingCompletedWhen | LastEditedBy | LastEditedWhen |
    | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
    | 3577 | 1163 | 138 | Furry animal socks (Pink) S | 10 | 36 | 5.00 | 15.000 | 36 | 2013-01-23 11:00:00.0000000 | 20 | 2013-01-23 11:00:00.0000000 |
    | 3578 | 1163 | 141 | Furry animal socks (Pink) XL | 10 | 72 | 5.00 | 15.000 | 72 | 2013-01-23 11:00:00.0000000 | 20 | 2013-01-23 11:00:00.0000000 |

7. Now, let's get the total for these order lines for Order 1163.

    | OrderID | (No column name) |
    | ------- | ------ |
    | 1163 | 621.000000 |

8. Are there any orders where Quantity and PickedQuantity don't match? Let's count the order lines.

    ```
    3147
    ```

9. Let's see what orders have outstanding quantities and how many are still outstanding for each order.

    ```
    3085 rows, including:
    ```
    | OrderID | (No column name) |
    | ------- | ------ |
    | 7770 | 120 |
    | 20013 | 120 |
    | 23107 | 120 |
    | 24731 | 120 |
    | 32372 | 120 |

10. What is the query for getting individual orders' totals?

    ```
    73595 rows, including:
    ```
    | OrderID | (No column name) |
    | ------- | ------ |
    | 1163 | 621.000000 |
    | 9094 | 4330.900000 |
    | 9443 | 1601.950000 |
    | 11698 | 17024.025000 |
    | 11993 | 1311.000000 |

11. Suppose we want orders less than $1000. What is the query for orders less than $1000?

    ```
    22414 rows, including:
    ```
    | OrderID | (No column name) |
    | ------- | ------ |
    | 1163 | 621.000000 |
    | 15819 | 259.900000 |
    | 24396 | 179.400000 |
    | 34852 | 302.450000 |

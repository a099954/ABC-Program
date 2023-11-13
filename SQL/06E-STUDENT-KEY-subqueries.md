# Exercise: SQL Subqueries - STUDENT KEY

## Introduction

In the Subqueries SQL lesson, we introduced the many cases for a SQL subquery. For this exercise:

1. Create a new SQL file.
1. Set the connection in SQL Server Management Studio (SSMS) to look at Wide World Importers.
1. Write these queries.

The student key contains general guidance to assure you that you are on the right track.

## Exercise

1. Get all stock items that have Blue colors. We only need the stock item's name and don't need the color name in our results.

    23 rows, including:

    | StockItemName                                          |
    | ------------------------------------------------------ |
    | RC toy sedan car with remote control (Blue) 1/50 scale |
    | Ride on toy sedan car (Blue) 1/12 scale                |
    | Superhero action jacket (Blue) 3XS                     |
    | Superhero action jacket (Blue) XXS                     |

2. Get all stock items and their color IDs for those that don't have Blue colors. Include stock items that do not have colors.

    204 rows, including:

    | StockItemName                 | ColorID |
    | ----------------------------- | ------- |
    | USB missile launcher (Green)  | NULL    |
    | USB rocket launcher (Gray)    | 12      |
    | Office cube periscope (Black) | 3       |

3. Get all stock items without colors using the simplest query.

    No JOINs.

    99 rows, including:

    | StockItemName                     |
    | --------------------------------- |
    | USB missile launcher (Green)      |
    | USB food flash drive - sushi roll |
    | USB food flash drive - hamburger  |
    | USB food flash drive - hot dog    |

4. What are stock items and their suppliers for packaging suppliers? Use a subquery in an `IN` clause.

    67 rows, including:

    | StockItemName                      | (No column name) |
    | ---------------------------------- | ------------- |
    | Small sized bubblewrap roll 10m    | Litware, Inc. |
    | Medium sized bubblewrap roll 20m   | Litware, Inc. |
    | Large sized bubblewrap roll 50m    | Litware, Inc. |
    | 10 mm Double sided bubble wrap 10m | Litware, Inc. |

5. What stock items and suppliers from packaging suppliers had transactions in 2014?

    67 rows, including:

    | StockItemName | (No column name) |
    | --------------------------------------------------- | ------------- |
    | 10 mm Double sided bubble wrap 50m                  | Litware, Inc. |
    | Packing knife with metal insert blade (Yellow) 9mm  | Litware, Inc. |
    | Packing knife with metal insert blade (Yellow) 18mm | Litware, Inc. |

6. What suppliers from toy suppliers had transactions in 2013? How many individual stock items did those suppliers have in 2013?

    | SupplierID | (No column name) | (No column name) |
    | ------ | ------ | ------ |
    | 10 | Northwind Electric Cars | 18 |

7. Get a list of supplier category IDs, supplier count for the category, and total supplier count.

    8 rows, including:

    | SupplierCategoryID | (No column name) | (No column name) |
    | ------------------ | ----------------------- | ------------------ |
    | 2 | 6 | 13 |
    | 3 | 1 | 13 |
    | 4 | 1 | 13 |

8. Get a list of supplier category names, supplier count for the category, and total supplier count, including the category name rather than the category ID.

    8 rows, including:

    | (No column name) | (No column name) | (No column name) |
    | --------- | ---------- | ---------- |
    | Novelty Goods Supplier | 6 | 13 |
    | Toy Supplier | 1 | 13 |
    | Clothing Supplier | 1 | 13 |

9. Get transactions by supplier overall for "A Datum Corporation."

    | SupplierID | TransactionAmount |
    |--------------|-------------------|
    | 1 | 2194.50 |
    | 1 | 3762.00 |
    | 1 | -5956.50 |
    | 1 | 7524.00 |
    | 1 | 4639.80 |
    | 1 | 9405.00 |
    | 1 | -21568.80 |

10. Get the transactions by supplier for "A Datum Corporation," but only those whose transaction amounts are greater than the average transaction amount.

    | SupplierID | TransactionAmount |
    |--------------|-------------------|
    | 1 | 2194.50 |
    | 1 | 3762.00 |
    | 1 | 4639.80 |
    | 1 | 7524.00 |
    | 1 | 9405.00 |

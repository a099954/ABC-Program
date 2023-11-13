# Exercise: Filtering SQL - STUDENT KEY

## Introduction

In the Filtering SQL lesson, we introduced the `WHERE` clause and multiple ways to filter our results. For this exercise:

1. Create a new SQL file.
1. Set the connection in SQL Server Management Studio (SSMS) to look at Wide World Importers.
1. Write these queries.

The student key contains general guidance to assure you that you are on the right track.

## Exercise

1. Write a `SELECT` query that gets the color IDs and names for all colors that start with `Dark`.

```
8       Dark Brown
9       Dark Green
```

2. Write a `SELECT` query that gets all color names that are 5-characters long.

```
Azure
Beige
Black
Ivory
Khaki
Mauve
Olive
Wheat
White
```

3. Write a `SELECT` query that gets the color names for colors with the following IDs: 1, 11, 15, and 36. Use the `OR` keyword.

```
Azure       1
Gold        11
Ivory       15
Yellow      36
```

4. Write a `SELECT` query that gets the color names for colors with the following IDs: 1, 11, 15, and 36. Use the `IN` keyword.

```
Azure       1
Gold        11
Ivory       15
Yellow      36
```

5. Write a `SELECT` query that gets the customer names for all customers with a postal city ID of 242.

```
Wingtip Toys (Akhiok, AK)
Caterina Pinto
```

6. Write a `SELECT` query that gets customer names where the delivery postal code is 90210.

```
(0 rows)
```

7. Write a `SELECT` query that gets the customer names that start with `An` using `LIKE`.

```
Anca Gogean
Ana Florea
Andris Saulitis
Anil Sarkar
Annette Hetu
Anna Mazzanti
Anna Gyarmathi
Anand Mudaliyar
Anindya Gkatak
```

8. Write a `SELECT` query that gets the customer names that start with `An` using `BETWEEN`.

```
Anca Gogean
Ana Florea
Andris Saulitis
Anil Sarkar
Annette Hetu
Anna Mazzanti
Anna Gyarmathi
Anand Mudaliyar
Anindya Gkatak
```

9. Write a `SELECT` query that gets a list of customer names and phone numbers where the phone number contains `555-`.

```
Tailspin Toys (Head Office)         (308) 555-0100
Tailspin Toys (Sylvanite, MT)       (406) 555-0100
Tailspin Toys (Peeples.Valle...     (480) 555-0100
Tailspin Toys (Medicine Lodg...     (316) 555-0100
Tailspin Toys (Gasport, NY)         (212) 555-0100
Tailspin Toys (Jessie, ND)          (701) 555-0100
Tailspin Toys (Frankewing, T...     (423) 555-0100
Tailspin Toys (Bow Mar, CO)         (303) 555-0100
Tailspin Toys (Netcong, NJ)         (201) 555-0100
Tailspin Toys (Wimbledon, ND)       (701) 555-0100
Tailspin Toys (Devault, PA)         (215) 555-0100
Tailspin Toys (Biscay, MN)          (218) 555-0100
```

10. Write a `SELECT` query that gets customers that have deliveries to `Shop 2` and a PO Box in `Emilyville`.

```
Matteo Cattaneo     Shop 2      Emilyville
```

11. Write a `SELECT` query that gets unique delivery methods from the customers table.

```
3
```

12. Write a `SELECT` query that gets the last 5 customers ordered alphabetically.

```
Yves Belisle
Wingtip Toys (Yaak, MT)
Wingtip Toys (Willow Valley,...
Wingtip Toys (White Church, ...
Wingtip Toys (West Hempstead...
```

1.  Write a `SELECT` query that gets the customer name and account opened date for all accounts opened between July 1, 2015, and December 31, 2015. Order it by the newest opened account and then by the customer name. Use the `>=` and `<=` operators for your filter.

```
Kalyani Benjaree        2015-12-20
Adriana Pena            2015-11-30
Emma Salpa              2015-11-29
Luis Saucedo            2015-11-27
Ian Olofsson            2015-09-26
Sylvia Laramee          2015-09-24
Amrita Ganguly          2015-09-23
Amet Shergill           2015-08-13
Abhra Ganguly           2015-08-09
Ivana Hadrabova         2015-07-28
```

14. Write a `SELECT` query that gets the customer name and account opened date for all accounts opened between July 1, 2015, and December 31, 2015. Order it by the newest opened account and then by the customer name. Use the `BETWEEN` clause.

```
Kalyani Benjaree        2015-12-20
Adriana Pena            2015-11-30
Emma Salpa              2015-11-29
Luis Saucedo            2015-11-27
Ian Olofsson            2015-09-26
Sylvia Laramee          2015-09-24
Amrita Ganguly          2015-09-23
Amet Shergill           2015-08-13
Abhra Ganguly           2015-08-09
Ivana Hadrabova         2015-07-28
```

15. Write a `SELECT` query that gets the credit limits for Dipti Shah, Ivana Hadrabova, Emma Salpa, and Ian Olofsson. Order them from lowest to highest limits.

```
Emma Salpa          1600.00
Ivana Hadrabova     1600.00
Ian Olofsson        3300.00
Dipti Shah          3700.00
```

16. Write a `SELECT` query that gets the first 5 accounts that do not have buying groups assigned to them.

```
Eric Torres             NULL
Cosmina Vlad            NULL
Bala Dixit              NULL
Aleksandrs Riekstins    NULL
Ratan Poddar            NULL
```

17. Write a `SELECT` query that gets the first 5 accounts with buying groups assigned to them.

```
Tailspin Toys (Head Office)                  1
Tailspin Toys (Sylvanite, MT)                1
Tailspin Toys (Peeples Valley, A...          1
Tailspin Toys (Medicine Lodge, K...          1
Tailspin Toys (Gasport, NY)                  1
```

18. Write a `SELECT` query that meets the following criteria:
    * At least 2 customers must not have a buying group assigned - call these customers out with the `IN` clause
    * At least 2 customers must have a buying group assigned - call these customers out with a `LIKE` clause
    * When the buying group is `NULL`, show 'No Buyer'

```
Bala Dixit                            No Buyer
Cosmina Vlad                          No Buyer
Eric Torres                           No Buyer
Tailspin Toys (Fishtail, MT)          1
Tailspin Toys (Sun River, MT)         1
```

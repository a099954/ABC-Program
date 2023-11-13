# Exercise: Date Handling - STUDENT KEY

## Introduction

You have been presented with a data set called AdventureWorks2019. We want to learn more about the company, its employees, orders, invoices, and purchase orders.

The student key contains general guidance to assure you that you are on the right track.

## Instructions

1. Create a SQL file with queries to answer the questions.
1. Check your answers with the student key to see if you are on the right track.

Bring questions to class.

## Questions

1. How many employees were hired by year?

    | (No column name) | (No column name) |
    |----------|---------------|
    | 2013 | 3 |
    | 2012 | 4 |
    | 2011 | 16 |
    | 2010 | 38 |
    | 2009 | 148 |
    | 2008 | 74 |
    | 2007 | 6 |
    | 2006 | 1 |

2. What are the minimum and maximum differences between the order date and the ship date on sales orders?

    ```
    7   8
    ```

3. How many months of data are available for each year? Keep in mind that we need a count of unique months.

    | (No column name) | (No column name) |
    |-----------|----------------|
    | 2011 | 8 |
    | 2012 | 12 |
    | 2013 | 12 |
    | 2014 | 6 |

4. When was the first order placed? When was the last order placed?

    ```
    2011-05-31 00:00:00.000	    2014-06-30 00:00:00.000
    ```

5. What do the number of sales and average sales look like for each day of the week? Spell out the day of the week.

    | (No column name) | (No column name) | (No column name) |
    |-------|-------|-------|
    | Sunday | 639 | 12778.4838 |
    | Monday | 589 | 8269.7243 |
    | Tuesday | 618 | 10904.9919 |
    | Wednesday | 489 | 9555.8119 |
    | Thursday | 458 | 6579.9649 |
    | Friday | 577 | 8884.1314 |
    | Saturday | 545 | 9334.9295 |

6. What products are taking longer than scheduled?

    ```
    29,465 items

    This query should show scheduled time in days and actual time in days.
    ```

7. What products are more than two weeks over schedule?

    ```
    7,396 items
    ```

8. What's the difference between actual and planned costs on work order routing?

    ```
    No results
    ```

9. What's the most popular day of the week for putting in purchase orders?

    | (No column name) | (No column name) |
    |-----------|----------|
    | Sunday | 233 |
    | Monday | 726 |
    | Tuesday | 580 |
    | Wednesday | 841 |
    | Thursday | 772 |
    | Friday | 692 |
    | Saturday | 168 |
    

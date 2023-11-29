# Exercise: Cleaning Data - INSTRUCTOR KEY

## Introduction

In this exercise, you will work with a "dirty" dataset. Using what you have learned in the Cleaning Data lesson, clean the data.

## Exercise

Download the following workbook: <a href="./assets/files/airports-by-continent-dirty.xlsx">Airports by Continent Dirty Dataset</a>.

- Remove blank lines
- Remove duplicates
- Identify outliers - determine whether relevant or erroneous
- Make data consistent
- Rename the workbook airports-by-continent-lastname-firstinitial.xlsx
- Submit your updated workbook

## KEY

* The NA and OC worksheets contain duplicate records.
  * Various records
* AF worksheet contains misspellings, punctuation errors, or incorrect data.
  * 10810 - Jaimba should be Jamba
  * 13670 - Uses Africa instead of AF
  * 15238 - Uses CFG instead of CF
  * 18324 - arly should be Arly
  * 12534 - 8675309 is an impossible elevation
* AN is missing airport type in a few records
* EU contains breaks in escaping, combining type with name in the following records:
  * 11580
  * 12388
  * 17825
* AS contains various blank rows

​	
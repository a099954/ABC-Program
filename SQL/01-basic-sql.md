# Lesson: Basic SQL

## Introduction

We can use Structured Query Language (SQL) to query a relational database for relevant data.  

In this lesson, we will explore working with math and strings in SQL. We will also explore how to get data from a single SQL table.

## Learning Outcomes

By the end of this lesson, you will be able to:

1. Define SQL, statement, and query.
1. Use `SELECT` to work with values directly.
1. Identify common string expressions in SQL.
1. Understand how to write math expressions in SQL.
1. Use `SELECT` to query fields from a table.

## What is SQL?

SQL - short for Structured Query Language - is used for querying relational databases such as SQL Server, Oracle, MySQL, and PostgreSQL. While each database system may have its own system-specific commands, they share an underlying base implementation of SQL.  

The SQL standard - documentation that guides the SQL implementations - is documented following International Organization for Standardization (ISO) guidelines. The earliest version of the SQL standard is known as SQL-92. The latest stable version is SQL:2016.  

> SQL is pronounced a couple of ways - including "sequel" and "ess-cue-el."

### Explaining T-SQL and ANSI SQL

While working with SQL, you may see T-SQL. T-SQL is short for Transact-SQL, an extension of the SQL language used by Microsoft SQL Server and Sybase. T-SQL adds features to the SQL statements, including working with subqueries and additional tables in `UPDATE` and `DELETE` statements, using code blocks for conditional execution, and working with local variables. The lessons in this module are T-SQL-compliant.

The American National Standards Institute - more commonly known as ANSI (pronounced ann-see) - was the first to handle the SQL standard in 1986. ANSI SQL is SQL compliant with the ISO SQL standards. The standards were added to ISO in 1987. The ISO/IEC Joint Technical Committee (JTC1) for Information Technology currently maintains the SQL standard. IEC is the International Electrotechnical Commission.

## Writing SQL

SQL is written in **statements** - strings of characters that conform to formatting and syntax rules specified in the international standard. A **query** is a type of statement that returns a result set - possibly even an empty set of results.  

> All queries are statements, but not all statements are queries.

Statements and queries include **commands** - keywords that tell the database engine to do something. Standard commands include `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `CREATE`, `ALTER`, and `DROP`.

> We may capitalize the SQL commands and keywords to call attention to them. However, unless otherwise specified in the server documentation or configuration, SQL statements are not case-sensitive.

Statements and queries are built with **clauses** - code fragments starting with a command and followed by additional code. Common clauses include the `SELECT` clause, `FROM` clause, and `WHERE` clause. Additional code may include **expressions** - a combination of values, operators, and SQL functions. **Functions** are saved blocks of SQL code to do things and possibly return values. We will explain these clauses, expressions, functions, and other additional code as we introduce them in these lessons.

A **batch** is a series of SQL statements when multiple statements are needed to get a job done. For example, you might need to create a table, then populate it with starting data. This can be accomplished in a series of SQL statements, which would run as a batch of SQL statements.

## Working with Values in SQL

The `SELECT` keyword is used to specify which field(s) to get from a table. It can also be used to select values. Let's look into using `SELECT` to select values.

## SELECT with Strings

When working with strings in SQL, we surround our strings with a single quote `'` on either side of the string. Consider the following query:

```sql
SELECT 'This is a string'
```

The result is:

| (No column name)     |
| ----------- | 
| This is a string    | 


The output in the results pane should show 'This is a string' in a column with no column name.

### Getting the Lengths of Strings

If you need to get a length of a string, you can use `LEN()`. Consider the following SQL statement:

```sql
SELECT LEN('This is a string')
```

The length of 'This is a string' is: 16.


### Concatenating Strings

We can use the `+` operator to combine strings. Consider the following SQL statement:

```sql
SELECT 'This is ' + 'a string'
```

The result is:

| (No column name)     |
| ----------- | 
| This is a string    | 


You can use multiple `+` statements to combine multiple strings into a single string. The following SQL statements would also return 'This is a string'

```sql
SELECT 'This ' + 'is a ' + 'string'
SELECT 'This ' + 'is ' + 'a ' + 'string'
```

The result for both of these queries is:

| (No column name)     |
| ----------- | 
| This is a string    | 

The above string could also be formed using the `CONCAT()` function. Consider the following SQL statements:

```sql
SELECT CONCAT('This is ', 'a string')
SELECT CONCAT('This ', 'is a', ' string')
```

Both of these also result in 'This is a string'. There are multiple ways of concatenating strings in SQL. You can choose what to use based on your situation.

### Splitting Strings

We have seen concatenating strings. We can also use SQL to split strings using the `STRING_SPLIT()` function. We have to pass in two parameters to `STRING_SPLIT()` - the string to split and the delimiting character.

In the following SQL statement, we will split 'This is a string', breaking it apart by spaces:

```sql
SELECT * FROM STRING_SPLIT('This is a string',' ')
```

This is the output:

| value     |
| ----------- | 
| This | 
| is | 
| a | 
| string | 


We have to use a `FROM` clause here because `STRING_SPLIT()` returns rows of data rather than a scalar - singular - value. Later in this lesson, we will explain the `FROM` clause when discussing selecting data from tables.

`STRING_SPLIT()` is great for breaking apart delimited strings. Consider the following SQL, where we have a comma-delimited fruit list and want to split each fruit into its own row:

```sql
SELECT * FROM STRING_SPLIT('Apples,oranges,peaches,bananas',',')
```

The result is:

| value     |
| ----------- | 
| Apples | 
| oranges | 
| peaches | 
| bananas | 

## SELECT with Numbers and Math

SQL can also be used to do math. Consider the following SQL statements:

```sql
SELECT 1 + 1

SELECT 3/2

SELECT 3.0/2.0
```

The results come back as:

* 1 + 1 = 2
* 3/2 = 1
* 3.0/2.0 = 1.500000

The type we use makes a difference when working with numbers, as seen in the results above. 3/2 returned a whole number and no remainder. However, if we change those inputs from integers to decimals, notice that the result changes to match the type of the operands.  

What would happen if we mixed our types and tried 3/2.0 or 3.0/2?  `SELECT` statements select data and will not change data. Try running the following code:

```sql
SELECT 3/2.0

SELECT 3.0/2
```

The results both come back as `1.500000`.  SQL converts to the `numeric` data type when dealing with a mix of integers and numeric values. We can use the `SQL_VARIANT_PROPERTY` function to get a value's `BaseType` to see what data types we are working with. This is useful to know if you are presented with values and are uncertain of their data types. Let's try this out to see what SQL is telling us type-wise:

```sql
SELECT SQL_VARIANT_PROPERTY(3/2.0,'BaseType')

SELECT SQL_VARIANT_PROPERTY(3/2,'BaseType')
```

Notice that the results come back as `numeric` when there are mixed types and `int` when working with two integers.

## Comments

Sometimes, the code isn't clear enough on its own. We can add comments to our SQL statements to denote what happens when executing this code. Consider the following code block:

```sql
/*

This is a multi-line comment. 
In this line of code below, we see the result of dividing an int by a numeric.

*/
SELECT SQL_VARIANT_PROPERTY(3/2.0,'BaseType')

-- This is a single-line comment. In this line of code below, we see the result of dividing an int by an int.
SELECT SQL_VARIANT_PROPERTY(3/2,'BaseType')
```

Single-line comments can be prefaced with double hyphens `--`. Multi-line comments can be made by sandwiching text between `/*` and `*/`.

## SELECT with Fields

Now that you have seen what `SELECT` does by itself, let's use it to select data from a table in a database. When we select data from the table, we select its column names or fields. We need to tell SQL where we select the data using the FROM keyword.

This SQL query comprises a `SELECT` clause and a `FROM` clause. The syntax is as follows:  

```
SELECT fieldname1, fieldname2, fieldname3 
FROM tableName
```

Suppose we want to see what colors the warehouse deals with - we can query the `Warehouse.Colors` table. Since it is a small table, we can use the wildcard for the fields with minimal impact on the server.

```sql
SELECT * 
FROM Warehouse.Colors
```
 The query reads as:

* `SELECT` - select all the fields
* `FROM` Warehouse.Colors - from the table we are concerned with

The results include the number of rows affected - 36 - and the execution time.

> This table, in particular, is a special type of table called a **system-versioned table**, which tracks who last edited the value and how long the value is valid. The database system tracks this information and can use this for point-in-time analysis. This is a newer feature of SQL Server 2016. If you see LastEditedBy, ValidFrom, and ValidTo, these are fields associated with the system-versioned tables.

In the previous example, you have seen the wildcard character - the asterisk `*` - used in the field list position. The asterisk represents "all fields." While you can use the `*` for "all fields" in a query, you may get data back that you don't necessarily need. Only select the data you need - this will increase the performance of your queries.

> Don't bog down the server with calls for unnecessary data. This impacts all who are accessing the SQL Server.

Since the columns we are concerned with are `ColorID` and `ColorName`, we can call those fields out specifically in the field list following the `SELECT` keyword. So our updated query to see the colors from the warehouse is:

```sql
SELECT ColorID, ColorName 
FROM Warehouse.Colors
```

This query returns the `ColorID` and `ColorName` for all 36 colors. A sample of the results appears below:

| ColorID     | ColorName |
| ----------- | ----------- |
| 1    | Azure      |
| 2   | Beige       |
| 3   | Black       |
| 4   | Blue       |

## Selecting the First Records

If we want to take a quick look at the data on the table without being overwhelmed, we can use the `TOP` keyword along with the number of records to limit how many records come back.

The query for the first five records of the `Warehouse.Colors` table is:

```sql
SELECT TOP 5 ColorID, ColorName 
FROM Warehouse.Colors
```

The results are:

| ColorID     | ColorName |
| ----------- | ----------- |
| 1    | Azure      |
| 2   | Beige       |
| 3   | Black       |
| 4   | Blue       |
| 5   | Charcoal       |

## Finding a Character in a String

We want to work with the `Application.People` table for the next few examples. Let's look at the top 5 `FullName` values from the `Application.People` table. Here is the query:

```sql
SELECT TOP 5 FullName
FROM Application.People
```

These are the results:

```
Aahlada Thota
Aakarsha Nookala
Aakriti Bhamidipati
Aakriti Byrraju
Aamdaal Kamasamudram
```

We want to get the first initial and last name for the first 5 names.  We can use `LEFT()` to get the first number of characters from the left of a string. The `LEFT()` function takes in two parameters - the string and the number of characters to grab from the left of the string.

To get all first initials, consider the following SQL query:

```sql
SELECT TOP 5 LEFT(FullName, 1)
FROM Application.People
```

The results are:

```
A
A
A
A
A
```

In this particular set of names, we can use the space `' '` as our delimiter to help us find the last name. Earlier, we mentioned `STRING_SPLIT()`. Keep in mind that `STRING_SPLIT()` returns rows of values. Rather than working with rows, we want to get a substring, a part of a string, using the delimiter location as the starting point.

So for 'Aahlada Thota', we want to find the space character. The character after the space will be where the last name starts. We can use `CHARINDEX()` to find the first index of a character in a string. `CHARINDEX()` takes two parameters - the character to find and the string to search.

Where is the space in these first 5 names?  Consider the following SQL:

```sql
SELECT TOP 5 FullName, CHARINDEX(' ', FullName)
FROM Application.People
```

This is the output:

```
Aahlada Thota, 8
Aakarsha Nookala, 9
Aakriti Bhamidipati, 8
Aakriti Byrraju, 8
Aamdaal Kamasamudram, 8
```

What if we pass in a character that doesn't exist? Try this query:

```sql
SELECT TOP 5 FullName, CHARINDEX(',', FullName)
FROM Application.People
```

This is the output:

```
Aahlada Thota, 0
Aakarsha Nookala, 0
Aakriti Bhamidipati, 0
Aakriti Byrraju, 0
Aamdaal Kamasamudram, 0
```

We can use `SUBSTRING()` to get the last names. `SUBSTRING()` takes in three parameters:

* String to parse
* Starting position of the substring
* Number of characters to gather

To get the last name, we will use the following parameter values:

* String to parse - `FullName`
* Starting position of the substring - In this case, the character after the space, so `CHARINDEX(' ',FullName)+1`
* Number of characters to gather - We can send the full length of the string for simplicity's sake. `LEN(FullName)`

This is our full query for getting the first initial and last names for the first 5 `FullName` values on `Application.People`.

```sql
SELECT TOP 5 LEFT(FullName, 1), 
    SUBSTRING(FullName, CHARINDEX(' ', FullName)+1, LEN(FullName))
FROM Application.People
```

These are our results:

```
A	            Thota
A           	Nookala
A           	Bhamidipati
A           	Byrraju
A           	Kamasamudram
```

## Pattern Matching in Strings

Similar to how we use `CHARINDEX()` to find characters in a string, we can use `PATINDEX()` to find patterns in a string. `PATINDEX()` takes two parameters - the pattern to match and the string to search.

Suppose we wanted to find names that contain an 'aa' and end in 'a'. We can pass in a pattern using `%` as a wildcard to match zero or any instance of a character. We can use the pattern expression `'%aa%a'` to match strings that contain 'aa' and end in 'a'. 

Consider the following SQL:

```sql
SELECT TOP 5 FullName, PATINDEX('%aa%a',FullName)
FROM Application.People 
```

The results are:

```
FullName                (No column name)
Aahlada Thota       	1
Aakarsha Nookala	    1
Aakriti Bhamidipati	    0
Aakriti Byrraju	        0
Aamdaal Kamasamudram	0
```

Suppose we wanted to find if any of these names match the pattern of containing 'aa' and ending in a vowel. We can match a set of letters by surrounding the possible letters to match with square brackets `[]`. We can match the pattern of containing 'aa' and ending in a vowel with the following expression: `'%aa%[aeiou]'`. Consider the following SQL:

```sql
SELECT TOP 5 FullName, PATINDEX('%aa%[aeiou]', FullName)
FROM Application.People
```

The results are:

```
FullName                (No column name)
Aahlada Thota       	1
Aakarsha Nookala	    1
Aakriti Bhamidipati	    1
Aakriti Byrraju	        1
Aamdaal Kamasamudram	0
```

Suppose we want names with 'aa' that do not end in a vowel.  We can use the `^` as part of the expression to indicate 'not'. Consider the following SQL:

```sql
SELECT TOP 5 FullName, PATINDEX('%aa%[^aeiou]', FullName)
FROM Application.People
```

The results are:

```
FullName                (No column name)
Aahlada Thota       	0
Aakarsha Nookala	    0
Aakriti Bhamidipati	    0
Aakriti Byrraju	        0
Aamdaal Kamasamudram	1
```

`PATINDEX()` is best used similar to `CHARINDEX()`, when creating substrings. We will use `PATINDEX()` a little later and wanted to point it out now since its usage is similar to `CHARINDEX()`.

## Conclusion

In this lesson, we learned how to work with math and strings in SQL, select all table fields, and then took our query skills one step further by only selecting the fields we needed.

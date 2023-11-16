# Lesson: Data Types

## Introduction

When it comes to gathering and storing relational data, we can store many types of data. Suppose you are running a housewares store and have received this inventory report. What types of data are included?

<table>
  <caption style="font-weight:bold;">Table 1 - Housewares 'n' More Inventory Report for 3/14/2030</caption>
  <thead>
    <tr>
      <th>Product</th>
      <th>Qty In Stock</th>
      <th>Qty Ordered</th>
      <th>Date Due</th>
      <th>Current Price</th>
      <th>Is Backordered</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Electric Tea Kettle</td>
      <td>2</td>
      <td>4</td>
      <td>3/15/2030</td>
      <td>$39.99</td>
      <td>FALSE</td>
    </tr>
    <tr>
      <td>Rice Cooker</td>
      <td>1</td>
      <td>4</td>
      <td>3/31/2030</td>
      <td>$19.99</td>
      <td>FALSE</td>
    </tr>
    <tr>
      <td>Vacuum Sealer</td>
      <td>3</td>
      <td>0</td>
      <td></td>
      <td>$109.99</td>
			<td>FALSE</td>
    </tr>
    <tr>
      <td>Food Dehydrator</td>
      <td>2</td>
      <td>5</td>
      <td>5/1/2030</td>
      <td>$49.99</td>
      <td>TRUE</td>
    </tr>
  </tbody>
</table>

In this lesson, we will cover the data types supported in most systems and explain why these data types matter.

## Learning Outcomes

By the end of this lesson, you will be able to:

1. Define data types. 
2. Explain the importance of data types.
3. List the most common data types. 
4. Identify column data types in a table. 

## What is a Data Type?

The values of a column in a table share the same data type. The **data type** indicates what types of values are stored in a column or field. The data type is consistent across a relational data column. It is consistent across fields in formats such as XML and JSON.

<!--- provide examples of data types -->


## Why are Data Types Important?

Data types help give the values more context. In a programming world, everything is an object. But consider the following value:

311

What does this represent? If we say that 311 is an object - the most generic data type in programming, does that help you understand it? Not really. If we told you that 311 was a string because its a band's name, that might help with some context. If we told you that 311 was a number because it is a racing bib number, that might also help with some context. The data type helps to give the data more context, which is part of the transformation from data to information.

Data types are also important to those processing the data, converting it from data to visualizations. When importing data, if we specify a type for our column, we can get errors when unexpected or missing data occurs, which can help us to identify that:
1. There is unexpected or missing data.
2. We need to clean our dataset.
3. Once clean, we can assign the correct data type to our column.

When we convert our data into specific data types, it becomes easier for data analysts to work with that data.  From date and mathematical calculations to numerical comparisons, if the specific data type is on the column, the data in that column fits that data type. Work with that column happens because we're working on specific terms and functions that are built for that data type, rather than trying to work under the generic premise of "everything is an object."

## Types of Data

There are various types of data, including:

- Temporal
- Numeric & Boolean
- String
- Others
    - Binary
    - Unique Identifiers
    - Spatial Data

### Temporal Data

**Temporal data** refers to data in the form of times. Temporal data is an example of qualitative data. 

Examples of temporal data include:

<table>
  <thead>
    <tr>
      <th>Data Type</th>
      <th>Examples</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Date (relies on locale settings)</td>
      <td>
        <ul>
          <li>3/14/2030</li>
          <li>2030/03/14</li>
          <li>2030-03-14</li>
          <li>3-14-2030</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>Time (hours:minutes:seconds.fractional)</td>
      <td>23:00:00.0000
</td>
    </tr>
    <tr>
      <td>DateTime</td>
      <td></td>
    </tr>
    <tr>
      <td>DateTime with an offset (also known as DateTimeOffset)
</td>
      <td>
        <ul>
          <li>3/14/2030 23:00:00.0000 -06:00</li>
          <li>3/14/2030 23:00:00.0000 +12:45</li>
          <li>2030-03-14 23:00:30.12345Z</li>
        </ul>
      </td>
    </tr>
  </tbody>
</table>

Date relies on locale settings. Locale may refer to the locale settings on your machine, the server where the database lives, or the locale configured on the database server itself. When in doubt, use the ISO standard formats to add date data to a database.


Offsets may look like timezones, though **offsets are not timezones**. There is no timezone awareness with offsets. If you use any built-in functions to handle date differences, they calculate with basic math and do not necessarily account for daylight saving time differences.


The Z format in DateTimeOffset is part of the UTC format in [ISO 8601 Date and Time format](https://en.wikipedia.org/wiki/ISO_8601). Z stands for the zero UTC offset, though some may also say that Z stands for Zulu time.

12:45 UTC can be written as 12:45Z or T1245Z. Pay close to spacing to identify time versus offset identification.

### Numeric & Boolean Data

**Numeric data** refers to data represented by numeric values. These values are also known as quantitative data. Examples of numeric data include:

* Integers
* Numbers that use a decimal point

**Boolean data** involves `true` and `false` values. These are grouped with numeric data because most database systems do not store these values as words. These values are typically stored as integer types behind the scenes. `true` maps to 1 and `false` maps to 0. In some systems, `true` maps to any number that isn't 0.

Examples of numeric data include:

<table>
  <thead>
    <tr>
      <th>Data Type</th>
      <th>Examples</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Integers – tinyint, smallint, mediumint (int), bigint </td>
      <td>0, -1, 123456789</td>
    </tr>
    <tr>
      <td>Bit</td>
      <td>0, 1</td>
    </tr>
    <tr>
      <td>Boolean</td>
      <td>True (1), False (0)</td>
    </tr>
    <tr>
      <td>Float, Decimal, Double</td>
      <td>3.14, 25.00, -0.05368752</td>
    </tr>
  </tbody>
</table>

When it comes to storing integers, choose the integer type that makes the most sense. Most relational database systems support integers going from a smaller int range to a larger int range. However, if you find that you've allocated too big of a range, the database systems may not scale back down to a smaller integer type.

Floats, decimals, and doubles deal with partial values rather than whole numbers. They differ in varying ways. Double and decimal are precision-based types, whereas float is an approximation. So, if you need accurate math without rounding, use double or decimal. If you can accept a margin of error when the system chooses to round a value, then a float will work for you. The difference between double and decimal is their precision lengths - double is precise up to 15 digits, whereas decimal is precise up to 38 digits. Due to the accuracy, decimal is used in financial applications. If performance is more important than accuracy, float is better performing than the precision-based numeric values.

### String Data

**String data** refers to data represented by characters - such as alphabetical characters, Unicode characters, and literal constants. Examples of string data include:

Why are they called strings? A string data type represents a sequence of characters, characters in a line like a string, similar to a string of pearls, for example.

Examples of strings include:

<table>
  <thead>
    <tr>
      <th>Data Type</th>
      <th>Examples</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>char</td>
      <td>
        <ul>
          <li>!</li>
          <li>A</li>
          <li>test</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>nchar</td>
      <td>
        <ul>
          <li>🦞</li>
          <li>爱</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>varchar</td>
      <td>
        <ul>
          <li>test</li>
          <li>Explore. Dream. Discover.</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>nvarchar</td>
      <td>🌮🌮🌮 on Tuesday!</td>
    </tr>
  </tbody>
</table>

#### Char and nchar vs. varchar and nvarchar

Let's talk about char and nchar and how they differ between varchar and nvarchar.

 The `n` in `nchar` and `nvarchar` is short for national. Data is stored in groups known as **byte pairs**. These types are used when working with Unicode characters - including emoji and international characters.

 > 爱 is the Chinese symbol for love.

 The difference between char and varchar is more than just three letters. char - and its Unicode equivalent of nchar - is a fixed-sized string. When you use a char, the relational database system allocates the specified number of spaces, even if the spaces won't be used. varchar - and its Unicode equivalent of nvarchar - is a variable-sized string. It will allocate up to the amount that is specified, but it only allocates what is needed.

 Let's look at the following example. Suppose we want to store the word `test` as a value. We can say that it is a `char(4)` - telling the database server to allocate four characters for this field. So in storage, this looks like this:

 <table class="breakdown">
  <tr>
    <td>t</td>
    <td>e</td>
    <td>s</td>
    <td>t</td>
  </tr>
 </table>

 Now suppose that this column is keeping track of words that begin with 't'. And now we add `toe` to the list.

<table class="breakdown">
  <tr>
    <td>t</td>
    <td>e</td>
    <td>s</td>
    <td>t</td>
  </tr>
  <tr>
    <td>t</td>
    <td>o</td>
    <td>e</td>
    <td class="end"></td>
  </tr>
 </table>

Notice that there is a space in toe. With types like `char` and `nchar`, the space is allocated even if it isn't used.

Now suppose we change this to a `varchar(4)`. While the space can hold up to four characters, it can handle less than four characters. The database system will only allocate space that is used, not storing empty data.

<table class="breakdown">
  <tr>
    <td>t</td>
    <td>e</td>
    <td>s</td>
    <td>t</td>
  </tr>
  <tr>
    <td>t</td>
    <td>o</td>
    <td>e</td>
    <td class="end2"></td>
  </tr>
 </table>

When you know that your data is a consistent length, then `char` and `nchar` make sense. When you know that your data can vary in length, then `varchar` and `nvarchar` are your choices. If you know you aren't dealing with Unicode values, stick with `char` and `varchar`. However, if you need to deal with Unicode values, consider working with `nchar` and `char`.

### Other Data Types

Temporal, spatial, numeric, string and Boolean data represent the bulk of the data out there. However, there are a few other data types to know as well.

#### Binary Data

Binary data is used for storing binary values - such as images and files. Binary data is stored in a collection of bytes, also known as a **byte array**. When viewing binary data in a table, the binary values may not make sense. Most binary values are read in by another application that can translate the bytes into something more meaningful.

#### Unique Identifier

A unique identifier is a 16-bit value, typically used as a **record identifier** - to identify a particular observation or row or record. Another term you may see with unique identifiers is a **globally unique identifier (GUID)** or a **universally unique identifier (UUID)**. These are sometimes used as record identifiers, though most modern database development tends to lean towards integer types - specifically `int` and `bigint`.


#### Spatial Data

**Spatial data** is a form of qualitative data that refers to data stored in the form of coordinates. Examples of spatial data include:

* Geography - tracking latitude and longitude coordinates
* Geometry - tracking points along a path

There are also various data types for geometry to build shapes.

## Identifying the Data Types

Now that we have covered our data types, what data types can be associated with our original table? We have added a row to our data table to indicate the data types used here:

<table>
  <caption style="font-weight:bold; text-align:center;">Table 1 - Housewares 'n' More Inventory Report for 3/14/2030</caption>
  <thead>
    <tr>
      <th></th>
      <th>Product</th>
      <th>Qty In Stock</th>
      <th>Qty Ordered</th>
      <th>Date Due</th>
      <th>Current Price</th>
      <th>Is Backordered</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="font-weight: bold; background-color: #45c6e9; color:white;">Data Type</td>
      <td style="font-weight: bold; background-color: #45c6e9; color:white;">String</td>
      <td style="font-weight: bold; background-color: #45c6e9; color:white;">Numeric</td>
      <td style="font-weight: bold; background-color: #45c6e9; color:white;">Numeric</td>
      <td style="font-weight: bold; background-color: #45c6e9; color:white;">Temporal</td>
      <td style="font-weight: bold; background-color: #45c6e9; color:white;">Numeric</td>
      <td style="font-weight: bold; background-color: #45c6e9; color:white;">Boolean</td>
    </tr>
    <tr>
      <td></td>
      <td>Electric Tea Kettle</td>
      <td>2</td>
      <td>4</td>
      <td>3/15/2030</td>
      <td>$39.99</td>
      <td>FALSE</td>
    </tr>
    <tr>
			<td></td>
      <td>Rice Cooker</td>
      <td>1</td>
      <td>4</td>
      <td>3/31/2030</td>
      <td>$19.99</td>
      <td>FALSE</td>
    </tr>
    <tr>
      <td></td>
      <td>Vacuum Sealer</td>
      <td>3</td>
      <td>0</td>
      <td></td>
      <td>$109.99</td>
			<td>FALSE</td>
    </tr>
    <tr>
      <td></td>
      <td>Food Dehydrator</td>
      <td>2</td>
      <td>5</td>
      <td>5/1/2030</td>
      <td>$49.99</td>
      <td>TRUE</td>
    </tr>
  </tbody>
</table>

## Conclusion

In this lesson, we covered many terms related to data. In the following exercise, we will identify data types for columns in tables.

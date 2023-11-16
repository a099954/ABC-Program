# Lesson: Tabular Data Vocabulary

## Introduction

When presented with data, it is helpful to understand which words to use when talking with your colleagues. Relational data is often presented in tables. 

<table>
  <caption style="font-weight:bold; text-align:center;">Table 1 - Housewares 'n' More Inventory Report for 3/14/2030</caption>
  <thead>
    <tr>
      <th>Product</th>
      <th>Qty In Stock</th>
      <th>Qty Ordered</th>
      <th>Date Due</th>
      <th>Current Price</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Electric Tea Kettle</td>
      <td>2</td>
      <td>4</td>
      <td>3/15/2030</td>
      <td>$39.99</td>
    </tr>
    <tr>
      <td>Rice Cooker</td>
      <td>1</td>
      <td>4</td>
      <td>3/31/2030</td>
      <td>$19.99</td>
    </tr>
    <tr>
      <td>Vacuum Sealer</td>
      <td>3</td>
      <td>0</td>
      <td></td>
      <td>$109.99</td>
    </tr>
    <tr>
      <td>Food Dehydrator</td>
      <td>2</td>
      <td>5</td>
      <td>5/1/2030</td>
      <td>$49.99</td>
    </tr>
  </tbody>
</table>

Suppose you are running a housewares store and have received this inventory report. How would you talk with your colleagues about this report?

This lesson reviews the components of a table, explains the construction of tabular data, and demonstrates how to compare data across columns and fields.  

## Learning Outcomes

By the end of this lesson, you will be able to:

1. Identify the components of a table. 
2. Read tabular data. 
3. Compare and contrast columns and fields. 

## Tabular Data with Data and Metadata

The set of data above is in a layout called a **table**. Tables may also be called **datasets** or **recordsets**. Tables are a way to present data - especially numerical data - in an organized manner. They are made up of a few components:

* Title
* Header
* Rows
* Columns
* Footer

Our table includes:

* Title: Table 1 - Housewares 'n' More Inventory Report for 3/14/2030
* Header: Product, Qty In Stock, Qty Ordered, Date Due, and Current Price
* Rows: the values below the header, presented in a horizontal manner
* Columns: the values below the header, presented in a vertical manner

This table does not have a footer. Titles and footers are used to give the table data more context, helping to convert the observations from data to information. The title for the table may also include a table number to be referenced elsewhere. Footers may be used for things such as citations.

### Table Headers

<table>
  <thead>
    <tr class="table-highlight">
      <th>Product</th>
      <th>Qty In Stock</th>
      <th>Qty Ordered</th>
      <th>Date Due</th>
      <th>Current Price</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Electric Tea Kettle</td>
      <td>2</td>
      <td>4</td>
      <td>3/15/2030</td>
      <td>$39.99</td>
    </tr>
    <tr>
      <td>Rice Cooker</td>
      <td>1</td>
      <td>4</td>
      <td>3/31/2030</td>
      <td>$19.99</td>
    </tr>
    <tr>
      <td>Vacuum Sealer</td>
      <td>3</td>
      <td>0</td>
      <td></td>
      <td>$109.99</td>
    </tr>
    <tr>
      <td>Food Dehydrator</td>
      <td>2</td>
      <td>5</td>
      <td>5/1/2030</td>
      <td>$49.99</td>
    </tr>
  </tbody>
</table>

Table headers are helpful for understanding the values below them. As we mentioned in a previous lesson, table headers are considered metadata, and the values below those headers are considered data. Table headers are used to display the metadata.

The collection of data - the collection of **values** - below the headers is also known as the **observations**, as described in the Observe step of the scientific method.

## Reading Rows and Columns

A common way to look at **tabular data** - data presented in a table - is to look at its rows and columns.

### Rows

When reading a table, it is important to know that data may be grouped in horizontal presentation, known as **rows**, **records**, or **observations**. These words are used interchangeably and come up in different contexts.

<table>
  <thead>
    <tr>
      <th>Product</th>
      <th>Qty In Stock</th>
      <th>Qty Ordered</th>
      <th>Date Due</th>
      <th>Current Price</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Electric Tea Kettle</td>
      <td>2</td>
      <td>4</td>
      <td>3/15/2030</td>
      <td>$39.99</td>
    </tr>
    <tr class="table-highlight">
      <td>Rice Cooker</td>
      <td>1</td>
      <td>4</td>
      <td>3/31/2030</td>
      <td>$19.99</td>
    </tr>
    <tr>
      <td>Vacuum Sealer</td>
      <td>3</td>
      <td>0</td>
      <td></td>
      <td>$109.99</td>
    </tr>
    <tr>
      <td>Food Dehydrator</td>
      <td>2</td>
      <td>5</td>
      <td>5/1/2030</td>
      <td>$49.99</td>
    </tr>
  </tbody>
</table>

Sometimes, depending on the **data source** - the source from where the data is gathered, observations may be spread across multiple rows or records. For this example, we are presenting clean data, but data isn't always clean. An **observation** may be represented by many rows (records). However, when data is organized nicely, when data is tidy, an observation is represented by a single row.

### Columns

Data may be grouped in their vertical presentation, known as **columns**, **variables**, or **attributes**. These terms are used interchangeably and come up in different contexts.

<table>
  <thead>
    <tr>
      <th>Product</th>
      <th class="table-highlight">Qty In Stock</th>
      <th>Qty Ordered</th>
      <th>Date Due</th>
      <th>Current Price</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Electric Tea Kettle</td>
      <td class="table-highlight">2</td>
      <td>4</td>
      <td>3/15/2030</td>
      <td>$39.99</td>
    </tr>
    <tr>
      <td>Rice Cooker</td>
      <td class="table-highlight">1</td>
      <td>4</td>
      <td>3/31/2030</td>
      <td>$19.99</td>
    </tr>
    <tr>
      <td>Vacuum Sealer</td>
      <td class="table-highlight">3</td>
      <td>0</td>
      <td></td>
      <td>$109.99</td>
    </tr>
    <tr>
      <td>Food Dehydrator</td>
      <td class="table-highlight">2</td>
      <td>5</td>
      <td>5/1/2030</td>
      <td>$49.99</td>
    </tr>
  </tbody>
</table>

Data in a column are related to the **column heading** - the first cell in a column when table headers are present. The values of a column typically have the same data type.

## The Problem of "Fields"

When looking at documents online, you may see the term **field** used interchangeably with **column**. This is especially common when talking of tabular data and in consumer applications such as Access, Excel, and ArcGIS. Columns can represent fields, but columns and fields are separate concepts. To break it down further:

- A column is the vertical collection of data in a table.
- A field is an element where one piece of information is stored.

Consider this tabular representation:

<table>
  <caption>2016 Summer Olympics Windsurfing Results - Women</caption>
  <thead>
    <tr>
      <th>Rank</th>
      <th>Country</th>
      <th>Name</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Gold</td>
      <td>France</td>
      <td>Charline Picon</td>
    </tr>
    <tr>
      <td>Silver</td>
      <td>China</td>
      <td>Peina Chen</td>
    </tr>
    <tr>
      <td>Bronze</td>
      <td>Russia</td>
      <td>Stefaniya Elfutina</td>
    </tr>
  </tbody>
</table>

In a table, fields are stored in columns. Now consider the same representation in this XML snippet:

```xml
<Contestants>
  <Contestant>
    <Rank>Gold</Rank>
    <Country>France</Country>
    <Name>Charline Picon</Name>
  </Contestant>
  <Contestant>
    <Rank>Silver</Rank>
    <Country>China</Country>
    <Name>Peina Chen</Name>
  </Contestant>
  <Contestant>
    <Rank>Bronze</Rank>
    <Country>Russia</Country>
    <Name>Stefaniya Elfutina</Name>
  </Contestant>
</Contestants>
```

We no longer have columns, though each Contestant record has a Rank, Country, and Name field.

We will use attribute, column, or variable in our data courses when talking about tabular data and vertically grouped data. 


## Conclusion

When explaining tabular data to others, you should now talk with them about the representation - from the title to the headers to the rows and columns. In our next lesson, we will explore the different data types that appear in columns.

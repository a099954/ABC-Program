# Lesson: File Sources

## Introduction
Where do we get data? We couldn't access data or build reports if it wasn't stored somewhere. So, how is data stored? In this lesson, we consider data structure and how it is presented in text, XML, and JSON files. 

## Learning Outcomes

By the end of this lesson, you will be able to:

1. Discern between structured, unstructured, and semi-structured data. 
2. Explain how data is presented in text files. 
3. Recognize the structure of an XML file. 
4. Pick out the parts of a JSON file. 

## Structured,  Semi-structured, and Unstructured Data
Data is available in many forms and may be organized, somewhat organized, or unorganized. Based on its organizability, we can identify data as structured, semi-structured, and unstructured.

<img src="assets/images/unstructured-structured-data.jpg" alt="Infographic Showing Unstructured vs. Structured Data"/>

### Structured Data

Structured data is easy to organize and analyze and is typically presented as tabular data. Common examples of structured data include audio track listings, movie cast listings, card collections, and recipes.

Structured data typically has relationships that are easy to recognize and are stored in organized files such as relational databases, Excel files, and CSVs.  

### Semi-structured Data

Semi-structured data is somewhat structured but does not necessarily present well as tabular data. An example of semi-structured data is email.  We can structure and easily search To, Cc, Bcc, and Subject lines.  However, the contents of the email are more complex and typically unstructured.  

Semi-structured data is typically stored in non-relational databases, JSON, or XML.  This data is somewhat easier to parse than unstructured data, but it still has more complexity than structured data.

### Unstructured Data

Unstructured data is not organized in an easy-to-search manner and is often displayed as binary data. An example of unstructured data is music information such as artists, albums, and song titles.

Unstructured data is typically seen in text files, PDF documents, other binary files, and non-relational databases.

## Text Files

Text files are a common way of getting values from a system.  Data in text files can be structured, unstructured, or semi-structured. Many enterprise resource planning (ERP), customer relationship management (CRM), product information management (PIM), and payroll systems have ways of exporting data into text files for further analysis and processing.  

Text files can also be used for survey responses, Internet of Things responses from sensors, transcripts of customer satisfaction phone calls, and service reviews. Common text formats include ACH files (from payroll systems), CSV files, and other delimited files, but may also be in JSON, XML, or YAML. 

### CSV Files and Delimited Text Files

Comma-separated values (CSVs) are text files that store values separated by commas.  Each line in the file represents a record.  CSV files may include the header row with the column names as the first line of the file, but you can omit the header row. 

This is a sample of a CSV file:

```
Class_Number,Number_Of_Animal_Species_In_Class,Class_Type
1,41,Mammal
2,20,Bird
3,5,Reptile
4,13,Fish
5,4,Amphibian
6,8,Bug
7,10,Invertebrate
```

#### Delimiters

In a CSV file, the comma is used to separate values.  The character known for separating values is called a **delimiter**.  The comma is the specific delimiter for CSV files.

Data can be stored with other delimiters and saved as text files, usually with a .txt extension.  Other delimiters include semi-colons, tabs, spaces, and pipes.  The following example is a pipe-delimited text file:

```
Game Name|Times Played
Sorry|50
Trouble|48
Candyland|46
Chutes and Ladders|25
Checkers|29
Chess|43
```
The abbreviation CSV may also stand for **character-separated values**, as a delimiter is a single character.  In some European countries - including Italy, France, and Spain, semi-colons are used more often than commas for CSV files.

#### Header Row

The row of column names - the metadata - is the first row in a text file and should be delimited with the same delimiter as the data.

#### Text qualifier

What if your data has the delimiter as part of its value?  How does this get handled?

There are a few different scenarios:
- Some people include them without doing anything, making the data hard to import later.
- Some people will use their knowledge of data and try an **escape sequence** - to tell a program that a string is to be treated as written and try to handle the special characters.  For example, if you want to include a double quote in a value in an Excel formula, you would have to escape it with additional quotes.
- Some will use encoded values.  This is common in data used in websites.  Encoded values allow you to use representations of a character that are identifiable by other programs.  A common encoding is using ASCII representation or Unicode encoding.

If you have data in a spreadsheet that you want to export to a CSV, use the spreadsheet program's export feature.  Those typically will handle escaping and encoding as part of their code.  They also make use of **text qualifiers**, characters that identify values are strings or text.  Using a text qualifier makes it easier for importing, as it is clear that the data is a string, and the program importing the data doesn't have to guess at the data type.

Consider the example of the pipe-delimited game from before. If we wanted to convert it to a CSV with text qualifiers, it would look like this:

```
"Game Name","Times Played"
"Sorry",50
"Trouble",48
"Candyland",46
"Chutes and Ladders",25
"Checkers",29
"Chess",43
```

## XML

Extensible Markup Language is more commonly referred to as XML. This abbreviation is not pronounced but is identified by its letters individually.

XML allows us to store semi-structured and structured data in a human-readable and machine-readable format.  There is a standard format for XML, and some industries have gone further to document XML as it applies to them.  For example, the finance industry has documented XML as part of [ISO 20022](https://www.iso20022.org/).

XML is an older format, initially released in February 1998.  It is based on a markup language that was created in the 1970s.  It is still available for some data sources, though it is being used less as JSON takes over.

```xml
<?xml version="1.0" encoding="ISO-8859-1" ?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"></xs:schema>
<Menu>
    <MenuItem>
        <Name>Stuffed Peppers</Name>
        <Description>Peppers stuffed with Italian sausage</Description>
        <Price>7.99</Price>
    </MenuItem>
    <MenuItem>
        <Name>Chicken Paprikash</Name>
        <Description>Chicken in a creamy paprika sauce, served over spaetzle</Description>
        <Price>8.99</Price>
    </MenuItem>
</Menu>
```
XML is used for object representation.  It uses the concept of **tags** to identify metadata and stores the data within the tags. An XML representation of an attribute follows this type of layout:

```xml
<ColumnName>value</ColumnName>
```

## JSON

JavaScript Object Notation - more commonly known by its abbreviation of JSON (pronounced Jay-Sahn or Jason) - is another form for storing semi-structured and structured data.  It was officially released in 2002 and became part of an international standard in 2013.

As data formats go, JSON has gained popularity over the years.  While there are ways to parse XML, it is significantly easier to read through JSON.

```json
{
	"menu": {
        "items" : [
            {
                "Name":"Stuffed Peppers",
                "Description":"Peppers stuffed with Italian sausage",
                "Price":7.99
            },
            {
                "Name":"Chicken Paprikash",
                "Description":"Chicken in a creamy paprika sauce, served over spaetzle",
                "Price":8.99
            }
        ]
    }
}
```
JSON is known for its key-value pairing or dictionary layout.  It is also used for object representation, similar to XML.  However, instead of tags, JSON uses properties and values.  Its structure follows this layout:

```json
columnName: value
```

## Fixed Format

Another way to store data is in a fixed format file.  Fixed format files specify that particular data must appear in a certain order and in a certain position in a row.  For fixed format files, documentation is provided as to what fields are expected and the length of the fields.

This is common with mainframe applications and especially in finance systems.  An example of this is [an ACH file](https://engineering.gusto.com/how-ach-works-a-developer-perspective-part-4/), used in banking.

## Conclusion

In this lesson, we explored common data formats and provided examples of unstructured, semi-structured, and structured data.

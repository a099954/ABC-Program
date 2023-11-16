# Lesson: Databases

## Introduction
Another common way of storing data are in collective stores called databases.  Databases hold tables of data.  Examples of data that could be stored in databases include recipes with ingredients, books with authors, menu items with prices, and movies with casts and crew. Many business systems work with databases, including enterprise resource planning (ERP), Customer relationship management (CRM), and HR and payroll systems.

This lesson introduces databases and explores the differences between relational and non-relational databases.

## Learning Outcomes

By the end of this lesson, you will be able to:

1. Define database. 
2. Explain how tabular data comes together in relational databases. 

## Databases

Databases are collections of data.  They may be stored locally, on a server in a local server room, on a virtual machine, or in the cloud.  They are typically managed by database administrators.  Data analysts, reports specialists, and database developers are common roles working with database systems. Data can be stored in relational datasets or in non-relational datasets.  Let's take a look at the different database systems available.

## Relational Databases

Relational databases are used for storing related data in tabular form - in rows and columns.  Structured data lives in relational databases.  For example, storing movies and cast and the relationship between movies and their cast and crew members could make sense to be in a relational database.  When presented as a table, column headers are known as metadata.  Values that aren't considered metadata on the table are data.

Sample relational data may look like this:

<table>
    <caption>Movies</caption>
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td>Miss Congeniality</td>
        </tr>
        <tr>
            <td>2</td>
            <td>Speed</td>
        </tr>
        <tr>
            <td>3</td>
            <td>The Matrix</td>
        </tr>
    </tbody>
</table>

<table>
    <caption>Members</caption>
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td>Sandra Bullock</td>
        </tr>
        <tr>
            <td>2</td>
            <td>Keanu Reeves</td>
        </tr>
        <tr>
            <td>3</td>
            <td>Lana Wachowski</td>
        </tr>
    </tbody>
</table>

<table>
    <caption>MovieMembers</caption>
    <thead>
        <tr>
            <th>MovieID</th>
            <th>MemberID</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td>1</td>
        </tr>
        <tr>
            <td>2</td>
            <td>1</td>
        </tr>
        <tr>
            <td>2</td>
            <td>2</td>
        </tr>
        <tr>
            <td>2</td>
            <td>3</td>
        </tr>
        <tr>
            <td>3</td>
            <td>3</td>
        </tr>
    </tbody>
</table>

These three tables show a relationship between movies and cast and crew members.

Relational databases are queried using variants of Structured Query Language (SQL, pronounced Ess-cue-el or Sequel).

Common relational databases include Microsoft SQL Server, Oracle database, MySQL, and PostgreSQL.

## Non-Relational Databases

Non-relational databases are for storing data that doesn't conform to a table naturally.  These are used to store unstructured and semi-structured data.

As mentioned in the Database Types introduction, the common non-relational databases include:

* Graph databases - such as Neo4j and Gremlin
* Document databases - such as MongoDB, CouchDB, CosmosDB, DocumentDB, and Elasticsearch
* Column stores - such as Apache Cassandra, MariaDB AX
* Key-value stores - such as Redis, Couchbase, Dynamo, MemcacheDB, Riak, Azure CosmosDB Table API

## Conclusion

There are various ways to store data, only one of which is databases.  In this lesson, we focused on relational databases and presented a quick refresher on the most common non-relational databases.

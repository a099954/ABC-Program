# Exercise: Data Normalization

## Introduction
In the lesson, we explored the process of data normalization. We explained the benefits of normalizing our data. In this exercise, you will explore normalizing a dataset.

## Goals

- Show an understanding of breaking up data into smaller chunks.
- Demonstrate how to break things down and the reason why they need to be broken in a certain way.

## Data

Some techs have approached you about creating a database for their library. This is a sample of their data:

| Title      | Authors |
| ----------- | ----------- |
| Microsoft Windows Server 2008 R2 Administration Instant Reference   | Matthew Hester, Chris Henley      |
| Automating Microsoft Windows Server 2008 R2 with Windows PowerShell 2.0   | Matthew Hester, Sarah Dutkiewicz        |
| Microsoft Windows Server 2012 Administration Instant Reference     | Matthew Hester, Chris Henley       |
| The Phoenix Project   | Gene Kim, Kevin Behr, George Spafford        |
| The Unicorn Project      | Gene Kim      |
| The DevOps Handbook   | Gene Kim, Jez Humble, Patrick Debois, John Willis, John Allspaw       |
| The Visible Ops Handbook    | Gene Kim, George Spafford, Kevin Behr      |


## Step 1: Normalize the Data to 1NF.

This initial table is not in 1NF. Explain what needs to be changed to get this data into 1NF.

The key is break values out into **atomic** units.

| Title      | Author |
| ----------- | ----------- |
| Microsoft Windows Server 2008 R2 Administration Instant Reference   | Matthew Hester|
| Microsoft Windows Server 2008 R2 Administration Instant Reference   | Chris Henley      |
| Automating Microsoft Windows Server 2008 R2 with Windows PowerShell 2.0   | Matthew Hester|
| Automating Microsoft Windows Server 2008 R2 with Windows PowerShell 2.0   |Sarah Dutkiewicz        |
| Microsoft Windows Server 2012 Administration Instant Reference     | Matthew Hester|
| Microsoft Windows Server 2012 Administration Instant Reference     | Chris Henley       |
| The Phoenix Project   | Gene Kim|
| The Phoenix Project   | Kevin Behr |
| The Phoenix Project   | George Spafford        |
| The Unicorn Project      | Gene Kim      |
| The DevOps Handbook   | Gene Kim       |
| The DevOps Handbook   | Jez Humble |
| The DevOps Handbook   | Patrick Debois |
| The DevOps Handbook   | John Willis  |
| The DevOps Handbook   | John Allspaw       |
| The Visible Ops Handbook    | Gene Kim |
| The Visible Ops Handbook    | George Spafford |
| The Visible Ops Handbook    | Kevin Behr      |


## Step 2: Normalizing Further to 2NF.

After 1NF, this data can possibly be simplified to 2NF. Explain what steps need to change.

Break these into 3 pieces - Books, Authors, BooksAuthors.

Books

| BookID    | Title |
| ----------- | ----------- |
| 1| Microsoft Windows Server 2008 R2 Administration Instant Reference  |
|2 | Automating Microsoft Windows Server 2008 R2 with Windows PowerShell 2.0  |
|3 | Microsoft Windows Server 2012 Administration Instant Reference  |
|4 | The Phoenix Project   | 
|5 | The Unicorn Project      | 
|6 | The DevOps Handbook   | 
|7 | The Visible Ops Handbook    | 

*****************

Authors

| AuthorID    | Name |
| ----------- | ----------- |
| 1| Matthew Hester|
|2 | Chris Henley|
|3 | Sarah Dutkiewicz|
|4 | Gene Kim| 
|5 | Kevin Behr| 
|6 | George Spafford| 
|7 | Jez Humble|
|8 | Patrick Debois| 
|9 | John Willis| 
|10 | John Allspaw| 


*****************

BooksAuthors

| BookID    | AurthorID |
| ----------- | ----------- |
| 1| 1|
|1 |2 |
|2 | 1|
|2 | 3| 
|3 | 1| 
|3 | 2| 
|4 | 4|
|4 | 5| 
|4 | 6| 
|5 | 4| 
|6 | 4| 
|6 | 7| 
|6 | 8| 
|6 | 9| 
|6 | 10| 
|7 | 4| 
|7 | 5| 
|7 | 6| 


## Step 3: Tidy Data at 3NF

Is this data normalized enough to meet 3NF? If not, what steps need to be taken to get there? What is required for 3NF to be met?

```
This data is fine at 2NF.  It also meets 3NF.

3NF requires:

- Meet 2NF
- There are no functional dependencies.
```

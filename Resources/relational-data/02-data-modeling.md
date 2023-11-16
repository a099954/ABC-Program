# Lesson: Data Modeling

## Introduction

Data modeling assists in visualizing and understanding what the data represents. It is a purposeful discipline to involve stakeholders in interpreting data.  

This lesson explains data modeling and a process to conduct a data modeling exercise. This lesson also describes the importance of data modeling to save time, avoid confusion, and fuel dialogue among stakeholders.  

## Learning Outcomes

By the end of this lesson, you will be able to:

1. Define data modeling. 
2. Describe the data modeling process. 
3. Explain the importance of data modeling. 

## What is Data Modeling?

Before we get too carried away, let's talk about the term **data model** and set the context properly.  In data, there are data models and then there are machine learning models used with machine learning algorithms.  We are not talking about machine learning models here.  We are talking about data models - models that represent the objects represented in a data file.  Data models have two key parts: entities and attributes.

### What is a Data Model?

A data model is a diagram of the object represented by data.  It identifies the name of the object itself and any of its attributes that may be in data.

### Entities and Attributes

**Entities** are the objects that are being represented in the data.  These could be physical things or concepts, concrete or abstract.  **Attributes** are properties of the entities.

Attributes are also known as columns in tabular data.  When working with JSON data, attributes are known as keys.  If it is XML data that you are working with, the fields of each object are also known as attributes.  Attribute names are best described as metadata.

> If you are starting a data model from tabular data, the table headers are a common starting spot for identifying attributes of your data model.

### Drawing a Data Model

We want to start with a simple example.  You have a collection of music that you want to catalog.  What makes up your catalog?

- A collection of music albums

We have a collection of music albums. Let's create a data model using a music album as our entity. From a high level, what attributes might make up a music album?

- Performer
- Album Name
- Release Year

So we have our entity - music album - and our attributes - performer, album name, and released year.  How do we turn this into a data model diagram?

A data model follows the following recipe:

```
EntityName
-----------
Attribute1
Attribute2
Attribute3
```

Entity names are typically written without spaces, as spaces in names can make it more complex to access in a database.  Some folks may replace spaces with underscores `_` or dashes `-`.  Most common though, is to eliminate the spaces and run the words together with title casing - where the first letter of each word is capitalized.

Our music album data model could look like this:

```
MusicAlbum
---------
Performer
AlbumName
ReleaseYear
```
However, a music album is not the only thing we typically care about in our catalog.  Do you know that song that means the world to you, but you can't remember which album it was on?  How do we get that?

Tracks are part of our albums.  Since the tracklist is a collection of its songs, that brings up another entity - the Track.  What properties does a song track have?

- Track Number
- Track Name
- Track Length

Our data model for a track could look like this:

```
Track
-----
TrackNumber
TrackName
TrackLength
```

How do we tie our tracks to our albums?  We need to update our music album data model to account for the tracks.  This could look like this:

```
MusicAlbum
---------
Performer
AlbumName
ReleaseYear
Tracks
```

Tracks on the music album could point to the Track on the track data model, from a super high-level guess.  However, the relationships between models get trickier.

## The Data Modeling Process

Data modeling is an activity that is typically performed across business units.  It involves:
- Business analysts
- QA
- Developers
- Project Managers
- Other stakeholders

In a data modeling meeting, all stakeholders get together to identify key entities and their attributes.  They share their domain knowledge and identify known relationships between entities.  

In a data modeling activity, as the team talks, documentation - such as a data dictionary or a set of entity relationship diagrams - can be created to document the terminology so that all teams can communicate about this data with a common vocabulary.  **Data dictionaries** are used to describe columns on a table or attributes of an entity with the entity name, attribute name, and a description of the attribute.

Sample Data Dictionary

| Entity      | Attribute | Description |
| ----------- | ----------- |----------- |
| Customer    | Cust#      | Customer identification number       |
| Customer      | CustomerName      | Name of customer       |
| Contact      | ContactID       | Contact identification number      |
| Contact     | ContactName      | Name of customer       |
| Contact      | PhoneNumber       | Contact's phone number       |
| CustomerContact      | CustomerID       | Customer identification number       |
| CustomerContact      | ContactID     | Customer identification number       |


Example data dictionaries include:

- [Planetary Data System Data Dictionary](https://pds.nasa.gov/tools/dd-search/) - includes attribute name and description
- [US Geological Survey Open-File Report 03-001 Data Dictionary](https://pubs.usgs.gov/of/2003/of03-001/htmldocs/datadict.htm) - short field name with full-length name and description
- [Landsat Data Dictionary](https://lta.cr.usgs.gov/DD/landsat_dictionary.html) - includes field definition, formats, possible values

An **entity relationship diagram (ERD)** shows how entities are related, linked by attributes.  We will explore entity relationship diagrams when we talk about relationships later in this lesson.

## Why is Data Modeling Crucial?

Data modeling is a way for us to show **what** our data represents.  We find this concept to be so important that we teach this to our developers to tackle this step before writing any lines of code.  This is crucial for many reasons.

### Stop and Think

You see a problem, and you immediately want to jump in and fix it.  This is a common problem we see when in the field.  The thing is, our initial understanding of a problem or situation may not necessarily be enough for us to go on.  When starting a new data project or being tossed into a highly undocumented data process, the data modeling exercise gives you a moment to stop and think whether your initial gut reaction would work.  It allows you to talk through the problem or situation and wholly understand it.  This is a conversation for all stakeholders.

### Understanding the Data

When you create a data model, you create a visualization of the **object** represented  by the data.  Whether it is a stock quote, customer order, or an invoice, data modeling helps to show what the thing is that you are analyzing.  

By building a data model, you have a better idea of what you are working with.

### Better Documentation and Communication

Data modeling is documentation that should be shared across the business.  This allows the business to explain their domain to their developers with consistent jargon across the departments.  This also allows for new folks to come in and review these documents to understand how things work.

### Clearer Scope

Rushing into a situation, you go in with a narrow glimpse of the scope.  By talking through the data model, you will get a clearer understanding of the scope of the domain.

## Conclusion

To better understand what the data represents, a data modeling exercise will assist in visualizing the object or concept.  When done early in a process, it can save development time and confusion. A data model can be a conversation for all stakeholders - from business to technical and everything in between.  We can practice data modeling with other objects to get used to drawing out entities and their attributes.

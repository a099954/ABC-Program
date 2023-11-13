# Lesson: Online Datasets

## Introduction

While data can be stored locally in files and databases, there is a vast world of data out there that can't, including online datasets that house open data and Web APIs. Now, you may be tempted to use that data once you've found it, but you also need to follow licensing laws. In this lesson, we'll identify common data sources online and explore the licensing concerns you need to address when working with acquired data. 

## Learning Outcomes

By the end of this lesson, you will be able to:

1. Identify online data sets. 
2. Define open data. 
3. Explain web APIs. 
4. Discuss licensing data. 
5. Discuss questions to consider when using online data. 

## Online Datasets

There are numerous sites out there that offer data for the taking - from Open Data sites to data repositories and more. With data being more widely available and accessible, let's look at open data and other sources for online data.

## Open Data
**Open data** is data that is freely available for use and redistribution without copyright restrictions.  

> "Open data and content can be freely used, modified, and shared by anyone for any purpose" - Source: [The Open Definition](http://opendefinition.org/)

The [Open Data Initiative (ODI)](https://opendatainitiative.github.io/) is a group that helps to encourage governmental data transparency. They have broken down the US state data sources on their [Transparency page](https://opendatainitiative.github.io/transparency). Some data may be available in CSVs or Excel formats. Some organizations have chosen to release their data best suited for non-relational representation in PDFs. Others have portals to expose their data but make it harder to download.

Government agencies are not the only groups releasing data due to an Open Data push. The push for open data has grown over the years. If you search for "Open Data initiative," you will find that influential companies such as Adobe, Amazon, Microsoft, and SAP are also getting into the open data space.

Some open data sources include:
- [Data.gov](https://www.data.gov/) - the US government's open data
- [Data.gov.au](https://data.gov.au/) - Australian government's open data
- [Open.canada.ca](https://open.canada.ca/en/search/inventory) - Canada's open data
- [Registry of Open Data on AWS](https://registry.opendata.aws/) - open data available that is stored in AWS
- [Microsoft Research Open Data](https://msropendata.com/) - open data from Microsoft Research
- [Open Corporates](https://opencorporates.com/) - open data from corporations

If you want to get into Open Data and start your own Open Data initiative in your company, consider this guidance from [the World Bank](http://opendatatoolkit.worldbank.org/en/starting.html).

Open data promotes transparency, allows us to hold data gatherers accountable for responsible gathering processes, and encourages others to share their data and collaborate in a data-sharing world.

## Web APIs

Application Programming Interfaces (APIs) are a way for companies to expose their data for developers to consume. This allows a developer to write an application to contact an API and retrieve data that can be used in an application - such as a website or a mobile application or a desktop application.  

Web APIs are specifically accessed using HTTPS and other web protocols to retrieve data via the Internet. They operate on the principle of request (calling to the API) and response (getting a response from the API). Data from an API is included as part of the response from a web API. Many APIs out there return data in the JSON format. Some may return data in the XML format. Some APIs will have options to return JSON or XML, depending on an HTTP Accept header that is included in the request.

APIs are typically used by data analysts and data engineers, so we will not get into working with them until our Data Analysis and Data Engineering courses.  However, it is helpful to know that there are online sources out there where sites make their data available.

Examples of APIs include:
- [World Time API](http://worldtimeapi.org/) - used for getting local times for a given time zone
- [Facebook's Marketing APIs](https://developers.facebook.com/docs/marketing-apis) - used for advertising on Facebook
- [NewsAPI](https://newsapi.org/) - used for getting news headlines from throughout the world
- [Spoonacular Food API](https://spoonacular.com/food-api) - used for finding recipes, nutrition information, and allergen information

## Licensing and Data

When using data from sources, you need to understand the licensing and usage rights of the data. Not all data is free to use.  Not all data is open. While there are licenses that make data available and shareable - such as Creative Commons and MIT licenses- there are also licenses that restrict the use of data, especially when it comes to commercial usage.

There are sites known for an abundance of data, including Kaggle and DataHub.io. These sites include a field for licensing the data. Unless the person or group posting the data owns the data, you need to question the licensing:

- Who ultimately is responsible for creating this data?
- Is the creator the one who released the data?
- Are they releasing the data with the original license?
- Are they within the original source's terms of use?

If you are not sure about using the data within its terms of use, consult your legal team to ensure that you are using data within your rights.

## Questioning Online Data Sources

When using others' data, you will want to consider questions about their data.  

- Who gathered the data?
- How was the data gathered?
- Why was the data gathered?
- When was the data gathered?
- What data was gathered?

These are some of the situations you will want to keep in mind when working with others' data.

### Biases
According to [Dictionary.com](https://www.dictionary.com/browse/bias), **bias** can be defined as:

> a particular tendency, trend, inclination, feeling, or opinion, especially one that is preconceived or unreasoned

Biases are something common in data. Biases can sway and skew data for various viewpoints. You need to understand who is gathering data and how it can be skewed.

### Missing Data

**Missing data** is data that is omitted or not recorded in a dataset. Data professionals know that handling missing data is like walking a highwire - there has to be a careful analysis of the data there to understand how to handle the missing data. Before missing data could be fixed, a data analyst would need to understand why that data is missing.

Missing data can be handled in many ways, including removing columns where data is missing more than being present or inferring values based on statistical calculations.

### Untidy Data

**Untidy data** is data that is not organized in a manner that is easy to use in reporting. This is very common in online datasets. For data to be tidy, there are 3 things that need to be met:

```
1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.
```
Source: [Tidy Data by Hadley Wickham, p. 4, section 2.3 Tidy data](https://vita.had.co.nz/papers/tidy-data.pdf)

Data analysts and data engineers have the skills necessary to clean up the data and make it in a form where it is easier to use to create reports.  


## Conclusion

With the internet's advancements, sharing data is a lot easier. In addition to having data on your servers, you can search for data from other sources. Understanding what data is available and questioning that data opens up the world to collaborating with others and ensuring that the data presented is accurate and honest.  In the next exercise, we will test your understanding of these concepts. 

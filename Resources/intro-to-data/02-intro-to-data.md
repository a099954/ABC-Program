# Lesson: Introduction to Data-Driven Decision Making

## Introduction

In life and business, we use data to make decisions every day. Some questions that data may help us answer include: 

* Considering their short and long-term forecasts, what funds should I invest in? 
* Our product is taking a long time to go from engineering to delivery, but where do we see an opportunity for more efficiency in our production process?
* What seasonal products have specific sale and discount times? 
* Are we getting the right engagement in these marketing channels, or should we change our strategy?

It helps us make informed decisions.  But is data the same as information?  If they are not the same, why do we hear these terms together so often?

This lesson explains what data is and how to apply the Scientific Method when working with data. This lesson also distinguishes different types of data and identifies the importance of transforming data into meaningful information. 

## Learning Outcomes

By the end of this lesson, you will be able to:

1. Define data.
2. Explain the scientific method.
3. Contrast structured data, unstructured data, and semi-structured data.
4. Differentiate between qualitative data and quantitative data.
5. Distinguish between data and metadata.
6. Define information.

## What is Data?

**Data** is numbers, text, images, and other unprocessed values.  Data does not have meaning on its own and needs to be analyzed and visualized to make informed decisions.  Consider the following data:

* 3/14
* "The greatest thing you'll ever learn..."
* 6.62607015 × 10<sup>−34</sup>
* onomatopoeia

What do these represent?  What do they mean?  Without any context, we don't know if 3/14 represents a fraction or if it is being used to describe Pi Day.  3/14 is a raw value - there is no context, no processing. Data is unprocessed and leaves a lot to be questioned.

We typically gather and process data by following the scientific method.

## The Scientific Method

The **scientific method** is a process for questioning, gathering, and analyzing data.

<figure><img src="assets/images/scientific-method.jpg" alt="Scientific Method" ><figcaption>Steps in the Scientific Method</figcaption></figure>

### Applying the Scientific Method

Consider the following scenario:

When your company website was initially developed, it didn't consider mobile users. So, you're redesigning it. 

#### Step 1: Question

Are we getting significant traffic from mobile users? If so, what browsers do we need to support?

#### Step 2: Research

If your site already has an analytics tool set up and running, you can use existing data to understand your website's visitors.  If not, it might be beneficial to look into competitors' sites for inspiration.  While researching, you found that 75% of your traffic is from mobile users.  Additional research shows that you have Android and iOS users making up 90% of your mobile traffic.

#### Step 3: Hypothesize

If we redesign our site with a responsive design, our engagement with our audience should increase.

#### Step 4: Experiment

Convert a high-traffic page from the old design into a more responsive design.

#### Step 5. Observe

Gather data from visitors to the high-traffic page using the analytics platform.  This is the stage where we gather data.

Sample responses may look like this:

```
Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36
Mozilla/5.0 (iPhone; CPU iPhone OS 13_5_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1.1 Mobile/15E148 Safari/604.1
Googlebot/2.1 (+http://www.google.com/bot.html)
Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.74 Safari/537.36 Edg/79.0.309.43
Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19
Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_5) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/85 Version/11.1.1 Safari/605.1.15
```
#### Step 6: Analyze

Review the observations.  Determine whether to accept or reject the hypothesis or if further exploration is needed, repeat the cycle.

#### Step 7: Report

Present the findings from the analysis for others to understand.  If there are more questions based on the presentation, you can repeat the steps of the scientific method.

## Structured, Unstructured, and Semi-Structured Data

<figure><img src="assets/images/unstructured-structured-data.jpg" alt="Unstructured vs Structured Data Infographic" ><figcaption> Unstructured vs Structured Data</figcaption></figure>

Raw data comes in many forms.  While tables are common ways of displaying data, they are not the only ways of organizing data.  The three main ways of organizing data are:

* structured data
* unstructured data
* semi-structured data

**Structured data** is presented in tables with rows and columns, which are easily organized and searchable.  Structured data is commonly stored in **relational database management systems (RDBMS)**.  A student grade book is an example of data that can be easily organized and searched.

**Unstructured data** is data without a format. When there is no format, it is harder to search unstructured data.  It is harder to process unstructured data.  However, there are non-relational databases that can store unstructured data.  An example of unstructured data could be a collection of scanned documents that need storing.

<figure><img src="assets/images/image-attributes.png" alt="Image attributes from Windows explorer" longdesc="Picture taken by Sadukie"><figcaption>Image attributes from Windows explorer</figcaption></figure>

**Semi-structured data** is a combination of structured data and unstructured data.  It takes the best of both worlds - using unstructured when needed and structured when possible.  Consider a digital photo album.  Image file names, file size, timestamp, tags, author, F-stop, ISO speed, and focal length are **metadata** - attributes - that could be categorized in a structured form. In contrast, the image's pixels are binary and unstructured.  Together this is a semi-structured record.

## Qualitative Data vs. Quantitative Data

When running the experiments and gathering data, a couple of types of data will come back - qualitative and quantitative.

Qualitative data is used to represent qualities, traits, and characteristics. It is loosely organized, somewhat unstructured. Qualitative data includes things such as thoughts, opinions, feedback, and other freeform responses. These types of responses answer questions such as "Why?" and "What?".

In a customer satisfaction survey. Qualitative responses come from questions such as:

- Would you recommend our store to others? Why or why not? (The "Why or why not?" is what brings in the qualitative response.)
- What brought you into our store initially?
- What can we do to improve your experience in our store?

Quantitative data is used to represent quantifiable responses, including numeric data and data that can be counted. Quantitative data answers questions such as "How much...?", "How many...?", and "How frequent...?".

If you consider the customer satisfaction survey, quantitative responses come from questions such as:

- Rate your experience on a scale of 1 (the worst) and 5 (the best).
- Would you recommend our store to others? (Yes or No)
- What is your age range? (buckets of demographic breakdowns)

Using both qualitative and quantitative questions will help get a better understanding of the whole story. With our customer survey, the quantitative data allows us to see the "How much...?", "How many...", and "How frequent...?", and the qualitative data gets us insight into our customer's feelings in regards to our service. We get a better understanding of the customer's story by including both qualitative and quantitative responses.


## Data vs. Metadata

Data can be described with other data.  Data that describes data is called **metadata**.

Consider the sample responses from our website redesign example.

* The operating systems include Linux, iPhone, Windows NT 10.0, and Macintosh.  "operating system" is the metadata, whereas the values Linux, iPhone, Windows NT 10.0, and Macintosh are considered data.
* The browsers include Chrome, Edge (Chromium), Mobile Safari, and Safari.  "browser" is the metadata, whereas the values Chrome, Edge with Chromium, Mobile Safari, and Safari are considered data.

Here is another example of data versus metadata.  Consider the following table:

<table>
    <thead>
    	<tr>
            <th>Park Name</th>
            <th>State</th>
            <th>Acreage</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Wrangell–St. Elias</td>
            <td>Alaska</td>
            <td>8,323,146.48</td>
        </tr>
        <tr>
            <td>Gates of the Arctic</td>
            <td>Alaska</td>
            <td>7,523,897.4</td>
        </tr>
        <tr>
            <td>Denali</td>
            <td>Alaska</td>
            <td>4,740,911.16</td>
        </tr>
        <tr>
            <td>Katmai</td>
            <td>Alaska</td>
            <td>3,674,529.33</td>
        </tr>
        <tr>
            <td>Death Valley</td>
            <td>California, Nevada</td>
            <td>3,373,063.14</td>
        </tr>        
    </tbody>
    <tfoot>
        <tr>
            <td colspan="3">Source: <a href="https://nationalparkobsessed.com/national-parks-by-size/#1-us-national-parks-ranked-by-size">NationalParkObsessed.com</a></td>
        </tr>
    </tfoot>
</table>

The table headings - Park Name, State, and Acreage - are metadata.  They describe the values below each heading.

The values in those columns are data.

## What is Information?

Data is the raw collection of values.  It is numbers, images, and text.  Without context, without understanding, it is called data.

Once we get through the analysis, data changes into information.  **Information** is processed data, made more useful during the analysis stage of the scientific method.  Data is the input, and information is the output.

![data is the input.  Analysis is the process.  Information is the output.](assets/images/data-in-info-out.png)

## Conclusion

In this lesson, we differentiated between data and metadata, evaluated qualitative and quantitative data, and analyzed data to turn it into information and make informed decisions. You will get practice with applying all of these concepts in the upcoming exercises.

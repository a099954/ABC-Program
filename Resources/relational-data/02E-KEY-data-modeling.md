# Exercise: Data Modeling

## Introduction
Entities and their attributes are a part of data modeling. Data can come in a variety of formats. We are going to work with different formats and create data models based on those formats.

Each of the objects below is considered a separate case. Create a data model using what you know, making note of entities and attributes as you draw them.

```
This has been delivered in multiple ways, and whiteboarding works really well.  This key has a whiteboard image as well as notes of what to watch for.
```


## Goals
- Demonstrate an understanding of data modeling.
- Understand the difference between entities and attributes.

## Sample Data 1

```json
{
    "cacaoReviews": [
        {
            "Company" : "A. Morin",
            "SpecificBeanOrigin" : "Agua Grande",
            "REF" : 1876,
            "ReviewDate" :  2016,
            "CocoaPercent" : "63%",
            "CompanyLocation": "France",
            "Rating": 3.75,            
            "BroadBeanOrigin": "Sao Tome"
        },
        {
            "Company" : "Holy Cacao",
            "SpecificBeanOrigin" : "Camino Verde P., Balao, Guayas",
            "REF" : 1466,
            "ReviewDate" :  2015,
            "CocoaPercent" : "70%",
            "CompanyLocation": "Israel",
            "Rating": 3.5,            
            "BroadBeanOrigin": "Ecuador"
        },
        {
            "Company" : "Hummingbird",
            "SpecificBeanOrigin" : "Amazonas",
            "REF" : 1097,
            "ReviewDate" :  2013,
            "CocoaPercent" : "70%",
            "CompanyLocation": "Canada",
            "Rating": 3.75,
            "BeanType": "Forastero",            
            "BroadBeanOrigin": "Venezuela"
        },
        {
            "Company" : "Matale",
            "SpecificBeanOrigin" : "Kuilili P., 2013",
            "REF" : 1177,
            "ReviewDate" :  2013,
            "CocoaPercent" : "74%",
            "CompanyLocation": "Australia",
            "Rating": 4,            
            "BeanType": "Trinitario",
            "BroadBeanOrigin": "Papua New Guinea"
        },
        {
            "Company" : "Raaka",
            "SpecificBeanOrigin" : "Amazon Basin Blend",
            "REF" : 1788,
            "ReviewDate" :  2016,
            "CocoaPercent" : "70%",
            "CompanyLocation": "U.S.A",
            "Rating": 3,            
            "BroadBeanOrigin": "Peru(SMartin,Pangoa,nacional)"
        },
    ]
}
```
### Prompts

- What is the entity?
- What are the attributes?
- Draw a data model.

```
- The Entity should be the CacaoReview.
- The attributes should be each of the properties.  They may also include a data type for each attribute.
```
This is a sample drawing of the data model:
<img src="assets/images/08E-data-modeling-sample1.png" />

```
In the drawing:

- We listed CacaoReview at the top, as it is the entity.
- We listed the fields with possible suggestions of data types, including:
    - Company - string
    - SpecificBeanOrigin - string
    - REF - numeric
    - ReviewDate - numeric/int
    - CocoaPercent - string
    - CompanyLocation - string
    - Rating - numeric/decimal
    - BroadBeanOrigin - string

They may have other suggestions as well.  Encourage them to share their choices and their reasoning. This will help gauge their understanding of the materials.
```


Now that you have drawn the model on this sample look at [the full table on Kaggle](https://www.kaggle.com/rtatman/chocolate-bar-ratings?select=flavors_of_cacao.csv).  

- Would you change anything about your model?  If so, what would you change and why?

```
This is a discussion point and relies on the learner's understanding of the full data vs the partial data.
```

## Sample Data 2

```xml
<Airports>
    <Airport>
        <id>2429</id>
        <ident>EGKK</ident>
        <type>large_airport</type>
        <name>London Gatwick Airport</name>
        <latitude_deg>51.148102</latitude_deg>
        <longitude_deg>-0.190278</longitude_deg>
        <elevation_ft>202</elevation_ft>
        <iso_country>GB</iso_country>
        <iso_region>GB-ENG</iso_region>
        <municipality>London</municipality>
        <gps_code>EGKK</gps_code>
        <iata_code>LGW</iata_code>
    </Airport>
    <Airport>
        <id>20361</id>
        <ident>KLNN</ident>
        <type>small_airport</type>
        <name>Lake County Executive Airport</name>
        <latitude_deg>41.683998</latitude_deg>
        <longitude_deg>-81.389702</longitude_deg>
        <elevation_ft>626</elevation_ft>
        <iso_country>US</iso_country>
        <iso_region>US-OH</iso_region>
        <municipality>Willoughby</municipality>
        <gps_code>KLNN</gps_code>
        <iata_code>LNN</iata_code>
    </Airport>
    <Airport>
        <id>44829</id>
        <ident>NZRL</ident>
        <type>seaplane_base</type>
        <name>Rotorua Lakes Water Aerodrome</name>
        <latitude_deg>-38.08330154</latitude_deg>
        <longitude_deg>176.2669983</longitude_deg>
        <iso_country>NZ</iso_country>
        <iso_region>NZ-BOP</iso_region>
        <municipality>Lake Rotorua</municipality>
        <gps_code>NZRL</gps_code>        
    </Airport>
    <Airport>
        <id>323838</id>
        <ident>DE-0351</ident>
        <type>balloonport</type>
        <name>Balloonport Bitterfeld</name>
        <latitude_deg>51.62455</latitude_deg>
        <longitude_deg>12.29391</longitude_deg>
        <iso_country>DE</iso_country>
        <iso_region>DE-ST</iso_region>
        <municipality>Bitterfeld</municipality>
    </Airport>
    <Airport>
        <id>41544</id>
        <ident>ZA-0021</ident>
        <type>heliport</type>
        <name>Pretoria Central Heliport</name>
        <latitude_deg>-25.65570068</latitude_deg>
        <longitude_deg>28.22060013</longitude_deg>
        <elevation_ft>4087</elevation_ft>
        <iso_country>ZA</iso_country>
        <iso_region>ZA-GT</iso_region>
        <municipality>Pretoria</municipality>
        <iata_code>HPR</iata_code>
    </Airport>
</Airports>
```

### Prompts

- What is the entity?
- What are the attributes?

```
The entity is Airport.
The attributes include:
    - id
    - ident
    - type
    - name
    - latitude_deg
    - longitude_deg
    - elevation_ft
    - iso_country
    - iso_region
    - municipality
    - iata_code
```

- Draw a data model.

Now that you have drawn the model on this sample look at [airports.csv on OurAirports](https://ourairports.com/data/).

- Would you change anything about your model?  If so, what would you change and why?

```
This is a discussion point and relies on the learner's understanding of the full data vs the partial data.
```

## Sample Data 3

```csv
Date,SP500,Dividend,Earnings,Consumer Price Index,Long Interest Rate,Real Price,Real Dividend,Real Earnings,PE10
1871-01-01,4.44,0.26,0.4,12.46,5.32,89.0,5.21,8.02,
1871-02-01,4.5,0.26,0.4,12.84,5.32,87.53,5.06,7.78,
1871-03-01,4.61,0.26,0.4,13.03,5.33,88.36,4.98,7.67,
1871-04-01,4.74,0.26,0.4,12.56,5.33,94.29,5.17,7.96,
1871-05-01,4.86,0.26,0.4,12.27,5.33,98.93,5.29,8.14,
```

### Prompts

- What is the entity?
- What are the attributes?

```
The entity is ?  These are entries from the S&P 500 index.  Seek how the learner names the entity and question how they came up with the name.

The attributes are:
- Date
- SP500
- Dividend
- Earnings
- Consumer Price Index
- Long Interest Rate
- Real Price
- Real Dividend
- Real Earnings
- PE10
```

- Draw a data model.

Now that you have drawn the model on this sample look at [the data on DataHub](https://datahub.io/core/s-and-p-500).

- Would you change anything about your model?  If so, what would you change and why?

```
This is a discussion point and relies on the learner's understanding of the full data vs the partial data.
```

## Sample Data 4

<table>
    <thead>
        <tr>
            <th>incident_id</th>
            <th>agency</th>
            <th>incident_address</th>
            <th>zip_code</th>
            <th>priority</th>
            <th>callcode</th>
            <th>calldescription</th>
            <th>category</th>
            <th>call_timestamp</th>
            <th>precinct_sca</th>
            <th>respondingunit</th>
            <th>officerinitiated</th>
            <th>intaketime</th>
            <th>dispatchtime</th>
            <th>traveltime</th>
            <th>totalresponsetime</th>
            <th>time_on_scene</th>
            <th>totaltime</th>
            <th>neighborhood</th>
            <th>block_id</th>
            <th>council_district</th>
            <th>longitude</th>
            <th>latitude</th>            
        </tr>
    </thead>
    <tbody>    
        <tr>
            <td>202025003789</td>
            <td>DPD </td>
            <td>Woodward Ave & W Forest Ave</td>
            <td>48201</td>
            <td>2</td>
            <td>831020</td>
            <td>ASSIST OTHER</td>
            <td>AO      </td>
            <td>9/6/2020 21:06</td>
            <td>39A </td>
            <td></td>
            <td>Yes</td>
            <td>0</td>
            <td>0</td>
            <td>0</td>
            <td>0</td>
            <td>9</td>
            <td>9</td>
            <td>Midtown</td>
            <td>2.61635E+14</td>
            <td>6</td>
            <td>-83.06299872</td>
            <td>42.35475148</td>
        </tr>
        <tr>
            <td>202025003790</td>
            <td>DPD </td>
            <td>Iowa St & Sherwood St</td>
            <td>48212</td>
            <td>3</td>
            <td>935030</td>
            <td>REMARKS</td>
            <td>REMARKS </td>
            <td>9/6/2020 21:06</td>
            <td>119C</td>
            <td> </td>
            <td>Yes</td>
            <td>0</td>
            <td>0</td>
            <td>0</td>
            <td>0</td>
            <td>0.1</td>
            <td>0.1</td>
            <td>Grant</td>
            <td>2.61635E+14</td>
            <td>3</td>
            <td>-83.03367347</td>
            <td>42.42496575</td>
        </tr>
        <tr>
            <td>202025003791</td>
            <td>DPD </td>
            <td>Scotten St & W Warren Ave</td>
            <td>48210</td>
            <td>2</td>
            <td>345020</td>
            <td>PERSON WITH WEAPON</td>
            <td>WEAPON  </td>
            <td>9/6/2020 21:06</td>
            <td>1009</td>
            <td></td>
            <td>No</td>
            <td>2</td>
            <td>24.6</td>
            <td>21.7</td>
            <td>48.5</td>
            <td>40.2</td>
            <td>88.8</td>
            <td>Chadsey Condon</td>
            <td>2.61635E+14</td>
            <td>6</td>
            <td>-83.11106417</td>
            <td>42.34474521</td>
        </tr>
        <tr>
            <td>202025003792</td>
            <td>DPD </td>
            <td>W Warren Ave & S M 10 Service Drive</td>
            <td>48208</td>
            <td>2</td>
            <td>347020</td>
            <td>ASSAULT AND BATTERY IP-JH</td>
            <td>AB IP/JH</td>
            <td>9/6/2020 21:06</td>
            <td>38B </td>
            <td></td>
            <td>No</td>
            <td>1</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td>Wayne State</td>
            <td>2.61635E+14</td>
            <td>6</td>
            <td>-83.07392129</td>
            <td>42.35360839</td>
        </tr>
        <tr>
            <td>202025003793</td>
            <td>DPD </td>
            <td>Grand River Ave & W McNichols Rd</td>
            <td>     </td>
            <td>3</td>
            <td>818030</td>
            <td>AID MOTORIST MISC</td>
            <td>AIDMOTR </td>
            <td>9/6/2020 21:06</td>
            <td>86C </td>
            <td>DRK821</td>
            <td>Yes</td>
            <td>0</td>
            <td>0</td>
            <td>0</td>
            <td>0</td>
            <td>30.9</td>
            <td>30.9</td>
            <td>Oak Grove</td>
            <td>2.61635E+14</td>
            <td>1</td>
            <td>-83.2533696</td>
            <td>42.41482124
            </td>
        </tr>
    </tbody>
</table>


### Prompts


- What is the entity?
- What are the attributes?

```
The entity is Incident.
The attributes include:
        - incident_id
        - agency
        - incident_address
        - zip_code
        - priority
        - callcode
        - calldescription
        - category
        - call_timestamp
        - precinct_sca
        - respondingunit
        - officerinitiated
        - intaketime
        - dispatchtime
        - traveltime
        - totalresponsetime
        - time_on_scene
        - totaltime
        - neighborhood
        - block_id
        - council_district
        - longitude
        - latitude</th>
```


- Draw a data model.

Now that you have drawn the model on this sample look at [the 911 service calls data from Detroit](https://data.detroitmi.gov/datasets/911-calls-for-service-last-30-days).

- Would you change anything about your model?  If so, what would you change and why?

```
This is a discussion point and relies on the learner's understanding of the full data vs the partial data.
```
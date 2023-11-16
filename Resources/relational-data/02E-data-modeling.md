# Exercise: Data Modeling

## Introduction
Entities and their attributes are a part of data modeling. Data can come in a variety of formats. We are going to create data models based on JSON and XML formats.

Each of the objects below is considered a separate case. Create a data model using what you know, making note of entities and attributes as you draw them.

You will complete this exercise individually and then share with the class.

## Part 1: Data Modeling with JSON

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
### Questions
- What is the entity?
- What are the attributes?

### Task
- Draw a data model.


## Part 2: Data Modeling with XML

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

### Questions
- What is the entity?
- What are the attributes?

### Task
- Draw a data model.

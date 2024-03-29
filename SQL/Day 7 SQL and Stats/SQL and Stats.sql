/* exampe of case statement*/

-- our broken case statement
SELECT
    ProductID,
    Name AS ProductName,
    Size,
    CASE
        WHEN Size <= 45 THEN 'S'
        WHEN Size > 45 AND Size <= 60 THEN 'M'
        WHEN Size > 60 THEN 'L'
        ELSE 'Unknown'
    END AS ProductCategory
FROM
    Production.Product;
-- it will produce an error about a value not being numeric


-- SOLUTION

--Step 1: take a look at all the values that are not numeric in the size column
SELECT
    Distinct(Size)
FROM
    Production.Product
WHERE 
	ISNUMERIC(size) = 0;  -- notice that we have NULL values and String Values


--Step 2: add conditions to the CASE statement for all string values
SELECT
    ProductID,
    Name AS ProductName,
    Size,
    CASE
		WHEN Size = 'L' THEN 'L'
		WHEN Size = 'M' THEN 'M'
		WHEN Size = 'S' THEN 'S'
		WHEN Size = 'XL' THEN 'XL'
        WHEN Size <= 45 THEN 'S'
        WHEN Size > 45 AND Size <= 60 THEN 'M'
        WHEN Size > 60 THEN 'L'
        ELSE 'Unknown'
    END AS ProductCategory
FROM
    Production.Product;

-- Step 3: save as temp table
SELECT
    ProductID,
    Name AS ProductName,
    Size,
    CASE
		WHEN Size = 'L' THEN 'L'
		WHEN Size = 'M' THEN 'M'
		WHEN Size = 'S' THEN 'S'
		WHEN Size = 'XL' THEN 'XL'
        WHEN Size <= 45 THEN 'S'
        WHEN Size > 45 AND Size <= 60 THEN 'M'
        WHEN Size > 60 THEN 'L'
        ELSE 'Unknown'
    END AS ProductCategory
into #df  -- temp table
FROM
    Production.Product;

--Step 4: review the df temp table
select * from #df






/* exampe of weighted average
    we will use our df table to continue the analysis*/


-- Step 1: Remove Values from size that are NOT Numeric
select *
--into #cleanedaggtable
from #df
WHERE ISNUMERIC(size) = 1;  -- filtered out Nulls and Strings;


-- Step 2: Convert (cast) size to numeric (INT) values
select ProductID, ProductName, cast(size as INT) as int_size, ProductCategory
--into #cleanedaggtable
from #df
WHERE ISNUMERIC(size) = 1;  -- filtered out Nulls and Strings;


-- Step 3: Save cleaned and preped data as temp table
select ProductID, ProductName, cast(size as INT) as int_size, ProductCategory
into #cleandf
from #df
WHERE ISNUMERIC(size) = 1; -- filtered out Nulls and Strings;


-- Step 4: View Temp table
select * from #cleandf;


-- Step 5:  Create Aggregate table
select ProductCategory, AVG(int_size) AS avg_size
from #cleandf
group by ProductCategory;


-- Step 6: Save aggregates as temp table
select ProductCategory, AVG(int_size) AS avg_size
into #agg_table
from #cleandf
group by ProductCategory;


-- Step 7: View Temp table
select * from #agg_table;


-- Step 8:  Create weight by using Case Clause
select 
	ProductCategory, 
	avg_size,
	case 
		when ProductCategory = 'L' then avg_size * .3 -- weight for large
		when ProductCategory = 'M' then avg_size * .6 -- weight for medium
		when ProductCategory = 'S' then avg_size * .1 -- weight for small
	end AS weightedAverages
--into #final_weighted_average
from #agg_table;


-- Step 9:  Save weight aggregates as temp table
select 
	ProductCategory, 
	avg_size,
	case 
		when ProductCategory = 'L' then avg_size * .3 -- weight for large
		when ProductCategory = 'M' then avg_size * .6 -- weight for medium
		when ProductCategory = 'S' then avg_size * .1 -- weight for small
	end AS weightedAverages
into #final_weighted_average
from #agg_table;


-- Step 10:  View temp table
select * from #final_weighted_average;


-- Step 11:  Calculate final Weighted Average
select avg(weightedAverages) as final_weighted_average, avg(avg_size) as base_average
from #final_weighted_average;








/* example of outlier detection
	Using Standard Deviations*/

-- Step 1:  Veiw data from our cleaned temp table
select * from #cleandf;


-- Step 2:  Calculate the Standard Deviation
select AVG(int_size) as avg_size, STDEV(int_size) as std_dev_size 
from #cleandf;


-- Step 3:  Calculate the low and high size distribution based on 1 Standard Deviation
select 
	AVG(int_size) as avg_size,
	STDEV(int_size) AS std_dev_size, 

	STDEV(int_size) + AVG(int_size) as High_dev,
	AVG(int_size) - STDEV(int_size) as Low_dev
from #cleandf;


-- Step 4:  Calculate the low and high size distribution based on 3 Standard Deviation

select 

	AVG(int_size) as avg_size,
	STDEV(int_size) AS std_dev_size, 

	STDEV(int_size) + AVG(int_size) as High_dev,
	AVG(int_size) - STDEV(int_size) as Low_dev,

	(STDEV(int_size)*3) + AVG(int_size) as High_dev3,
	AVG(int_size) - (STDEV(int_size*3)) as Low_dev3

from #cleandf;


-- Step 5:  Save as temp table
select 
	AVG(int_size) as avg_size,
	STDEV(int_size) AS std_dev_size, 


	STDEV(int_size) + AVG(int_size) as High_dev,
	AVG(int_size) - STDEV(int_size) as Low_dev,

	(STDEV(int_size)*3) + AVG(int_size) as High_dev3,
	AVG(int_size) - (STDEV(int_size*3)) as Low_dev3

into #stdev  -- save as temp table
from #cleandf;


-- Step 6:  View temp table
select * from #stdev;


-- Step 7:  Join the deviation table to the cleaned data table via Cross Join
SELECT *
FROM #cleandf
CROSS JOIN #stdev;


-- Step 8:  Save final joined table and get ready to do your analysis
SELECT *
into #stdev_df
FROM #cleandf
CROSS JOIN #stdev;


-- Step 9:  View temp table
select * from #stdev_df;


-- Step 10:  filter rows by deviations to find outliers
select 
	ProductID, 
	ProductName, 
	ProductCategory,
	int_size as size,
	High_dev3,
	Low_dev3
	from #stdev_df
where (int_size >= High_dev3) or (int_size <= Low_dev3); -- we found our outlier







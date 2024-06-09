<h1 align="center">Cyclistic Analytics 2023</h1>

<br> 

<p align="center" width="100%">
    <img width="40%" src="https://github.com/anzarshaikh9/Cyclistic_analytics_2023--EXCEL-SQL-TABLEAU/assets/169331791/425f9a1c-83d9-4dbc-946b-2b18d67eb250">
</p>

<br>

## Introduction

Welcome to my Cyclistic bike-share analysis project! In this project, I am analyzing data for Cyclistic, a fictional bike-share company based in Chicago. Cyclistic offers a diverse range of bicycles, including traditional bikes, reclining bikes, hand tricycles, and cargo bikes, through a network of over 5,800 bicycles and 600 docking stations. Most users ride for leisure, although a significant portion about 30% use the bikes for their daily commute. Cyclistic's marketing strategy has focused on building general awareness and appealing to broad consumer segments. They offer flexible pricing plans including single-ride passes, full-day passes, and annual memberships. Casual riders buy single-ride or full-day passes, while annual memberships are for Cyclistic members.

The goal of the company is to maximize the number of annual memberships, which is crucial for its future growth. To achieve this, I need to understand the behavior of casual riders and annual members. By analyzing historical bike trip data, I aim to uncover insights into how these two groups use Cyclistic bikes differently.
<br>
<br>

***
## Problem Statement

I need to understand how annual members and casual riders use Cyclistic bikes differently. By analyzing the differences in usage patterns, trip durations, and popular routes, I aim to identify key differences between these two groups. These insights will help the company design targeted marketing strategies to encourage casual riders to become annual members, ultimately supporting Cyclistic's growth objectives.
<br>
<br>

***
## Data

I'm utilizing Cyclistic's historical trip data for trend analysis and identification. The dataset comprises 12 CSV files, each representing a month from the year 2023. The initial raw data contains 13 columns, but after data manipulation, it expands to 14 columns. In total, there are 5,719,877 rows combining all 12 CSV files.

>[!Note]
>*This is public data and it has been made available by Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement).*
<br>

***
## Tools

- Excel - Data Manipulation
- MySQL - Data Analysis
- Tableau - Data Visualization
<br>

***
## Data Manipulation

In this dataset, minimal cleaning was required, primarily involving some data formatting. In Excel, I created a column called 'ride_length' to calculate the duration of each ride by subtracting the 'started_at' column from the 'ended_at' column (e.g., =D2-C2). This new column was formatted as HH:MM:SS. Following this, I proceeded to the analysis step.
<br>
<br>

***
## Data Analysis & Visualization

Before beginning the analysis, I set up a schema in MySQL named 'cyclistic' to organize the database effectively. Within this schema, I created a table called 'tripdata_2023' to store the relevant data. After setting up the table, I imported all the necessary data into 'tripdata_2023', ensuring that the data was properly structured and ready for analysis. This setup allowed for efficient data management and streamlined the subsequent analytical processes.

***
1. Conducting a comprehensive data exploration and generating detailed summary statistics for bike trips in the year 2023. This includes calculating the total number of bike trips and determining the proportion of trips taken by members versus casual users. Additionally, ride length metrics such as the maximum, minimum, and average ride lengths will be analyzed. These statistics will be computed separately for both member and casual users to provide a clear comparison.
<br>

```sql
SELECT
    COUNT(*) AS total_trips,
    COUNT(IF(member_casual = 'member', 1, NULL)) AS member_trips,
    COUNT(IF(member_casual = 'casual', 1, NULL)) AS casual_trips,
    ROUND((COUNT(IF(member_casual = 'member', 1, NULL)) / COUNT(*)) * 100, 2) AS member_percent,
    ROUND((COUNT(IF(member_casual = 'casual', 1, NULL)) / COUNT(*)) * 100, 2) AS casual_percent
FROM
	cyclistic.tripdata_2023;
```
<div align="center">

| total_trips | member_trips | casual_trips | member_percent | casual_percent |
|-------------|--------------|--------------|----------------|----------------|
| 5719877     | 3660698      | 2059179      | 64.00          | 36.00          |

</div>

<br>

```sql
SELECT
    DISTINCT member_casual,
    MAX(ride_length) AS max_ride_length,
    MIN(ride_length) AS min_ride_length,
    SEC_TO_TIME(AVG(TIME_TO_SEC(ride_length))) AS avg_ride_length
FROM
	cyclistic.tripdata_2023
GROUP BY
	member_casual;
```
<div align="center">
	
| member_casual | max_ride_length | min_ride_length | avg_ride_length |
| ------------- | --------------- | --------------- | --------------- |
| member        | 23:59:55        | 00:00:00        | 00:12:04.2609   |
| casual        | 23:59:55        | 00:00:00        | 00:21:10.7038   |

</div>

<br>

<p align="center" width="100%">
    <img width="50%" src="https://github.com/anzarshaikh9/Cyclistic_analytics_2023--EXCEL-SQL-TABLEAU/assets/169331791/3265abab-acef-4628-80f5-98d85c372819">
</p>

<br>

***
2. 

```sql
SELECT
    time_format(time(started_at), "%h %p") AS hour_of_day,
    count(*) AS member_trips
FROM
	cyclistic.tripdata_2023
WHERE
	member_casual = 'member'
GROUP BY
	hour_of_day
ORDER BY
	member_trips DESC;

/* For casual riders replace all the text from 'member' to 'casual' */
```

<div align="center">
<table>
<td>

| hour_of_day | member_trips |
|-------------|--------------|
| 05 PM       | 387973       |
| 04 PM       | 331643       |
| 06 PM       | 307787       |
| 03 PM       | 246741       |
| 08 AM       | 244218       |
| 07 PM       | 217972       |
| 02 PM       | 201905       |
| 12 PM       | 199941       |
| 01 PM       | 198738       |
| 07 AM       | 194611       |
| 11 AM       | 176379       |
| 09 AM       | 164912       |
| 08 PM       | 151659       |
| 10 AM       | 148848       |
| 09 PM       | 117765       |
| 06 AM       | 105310       |
| 10 PM       | 88006        |
| 11 PM       | 56438        |
| 12 AM       | 35534        |
| 05 AM       | 34144        |
| 01 AM       | 21185        |
| 02 AM       | 12275        |
| 04 AM       | 8778         |
| 03 AM       | 7936         |

</td><td>

| hour_of_day | casual_trips |
|-------------|--------------|
| 05 PM       | 199282       |
| 04 PM       | 182502       |
| 06 PM       | 172201       |
| 03 PM       | 159268       |
| 02 PM       | 142731       |
| 01 PM       | 136656       |
| 12 PM       | 130779       |
| 07 PM       | 127271       |
| 11 AM       | 110524       |
| 08 PM       | 91921        |
| 10 AM       | 86606        |
| 09 PM       | 77308        |
| 08 AM       | 70700        |
| 09 AM       | 70005        |
| 10 PM       | 68359        |
| 07 AM       | 53000        |
| 11 PM       | 49292        |
| 12 AM       | 36896        |
| 06 AM       | 30151        |
| 01 AM       | 23929        |
| 02 AM       | 14456        |
| 05 AM       | 11429        |
| 03 AM       | 7944         |
| 04 AM       | 5969         |

</td>
</table>
</div>

<p align="center" width="100%">
    <img width="85%" src="https://github.com/anzarshaikh9/Cyclistic_analytics_2023--EXCEL-SQL-TABLEAU/assets/169331791/7b428d4b-5f10-40a2-89e2-c81013669609">
</p>


***
3.


```sql
SELECT
	DAYNAME(started_at) AS day_of_week,
	COUNT(*) AS member_trips,
	SEC_TO_TIME(ROUND(AVG(TIME_TO_SEC(ride_length)), 0)) AS member_avg_ride_length
FROM
	cyclistic.tripdata_2023
WHERE
	member_casual = 'member'
GROUP BY
	day_of_week
ORDER BY
	member_trips DESC;

/* For casual riders replace all the text from 'member' to 'casual' */
```

<div align="center">
<table>
<td>

| day_of_week | member_trips | member_avg_ride_length |
|-------------|--------------|------------------------|
| Thursday    | 589590       | 00:11:35               |
| Wednesday   | 586459       | 00:11:31               |
| Tuesday     | 576754       | 00:11:30               |
| Friday      | 531599       | 00:12:00               |
| Monday      | 493156       | 00:11:28               |
| Saturday    | 472860       | 00:13:27               |
| Sunday      | 408860       | 00:13:27               |

</td><td>

| day_of_week | casual_trips | casual_avg_ride_length |
|-------------|--------------|------------------------|
| Saturday    | 410706       | 00:24:01               |
| Sunday      | 335718       | 00:24:43               |
| Friday      | 311925       | 00:20:32               |
| Thursday    | 270612       | 00:18:29               |
| Wednesday   | 249166       | 00:18:03               |
| Tuesday     | 246224       | 00:18:57               |
| Monday      | 234828       | 00:20:48               |

</td>
</table>
</div>

<p align="center" width="100%">
    <img width="95%" src="https://github.com/anzarshaikh9/Cyclistic_analytics_2023--EXCEL-SQL-TABLEAU/assets/169331791/d16ae077-d9fb-46ce-a238-304bc3987e1e">
</p>


***
4.

```sql
SELECT
	MONTHNAME(started_at) AS month,
	COUNT(*) AS member_trips,
    	SEC_TO_TIME(ROUND(AVG(TIME_TO_SEC(ride_length)), 0)) AS member_avg_ride_length
FROM
	cyclistic.tripdata_2023
WHERE
	member_casual = 'member'
GROUP BY
	month
ORDER BY
	member_trips DESC;

/* For casual riders replace all the text from 'member' to 'casual' */
```

<div align="center">
<table>
<td>

| month    | member_trips | member_avg_ride_length |
|----------|--------------|------------------------|
| August   | 460563       | 00:13:11               |
| July     | 436292       | 00:13:13               |
| June     | 418388       | 00:12:52               |
| September| 404736       | 00:12:38               |
| May      | 370646       | 00:12:35               |
| October  | 360042       | 00:11:34               |
| April    | 279305       | 00:11:28               |
| November | 264126       | 00:11:01               |
| March    | 196477       | 00:10:12               |
| December | 172401       | 00:10:47               |
| January  | 150293       | 00:10:04               |
| February | 147429       | 00:10:28               |

</td><td>

| month     | casual_rides | casual_avg_ride_length |
|-----------|--------------|------------------------|
| July      | 331358       | 00:23:35               |
| August    | 311130       | 00:22:40               |
| June      | 301230       | 00:22:19               |
| September | 261635       | 00:21:15               |
| May       | 234181       | 00:22:39               |
| October   | 177071       | 00:19:04               |
| April     | 147285       | 00:21:20               |
| November  | 98392        | 00:16:10               |
| March     | 62201        | 00:16:01               |
| December  | 51672        | 00:14:49               |
| February  | 43016        | 00:16:38               |
| January   | 40008        | 00:14:17               |

</td>
</table>
</div>

![Dashboard 2 (3)](https://github.com/anzarshaikh9/Cyclistic_analytics_2023--EXCEL-SQL-TABLEAU/assets/169331791/cb1c6ef6-89f9-4760-afee-7764fa19795e)

***
5.

```sql
SELECT
	start_station_name,
	COUNT(*) AS total,
	COUNT(IF(member_casual = 'member', 1, NULL)) AS member,
    	COUNT(IF(member_casual = 'casual', 1, NULL)) AS casual
FROM
	cyclistic.tripdata_2023
WHERE
	start_station_name != ''
GROUP BY
	start_station_name
ORDER BY
	member DESC -- for casual rider replace from 'member' to 'casual'
LIMIT
	10;
```

<div align="center">
<table>
<td>

| start_station_name          | total | member | casual |
|-----------------------------|-------|--------|--------|
| Clinton St & Washington Blvd| 32715 | 26216  | 6499   |
| Kingsbury St & Kinzie St    | 34966 | 26172  | 8794   |
| Clark St & Elm St           | 35805 | 25001  | 10804  |
| Wells St & Concord Ln       | 33590 | 21419  | 12171  |
| Clinton St & Madison St     | 26840 | 20596  | 6244   |
| Wells St & Elm St           | 30407 | 20400  | 10007  |
| University Ave & 57th St    | 26647 | 20038  | 6609   |
| Broadway & Barry Ave        | 28485 | 18959  | 9526   |
| Loomis St & Lexington St    | 21794 | 18901  | 2893   |
| State St & Chicago Ave      | 25789 | 18485  | 7304   |

</td><td>

| start_station_name                | total | member | casual |
|-----------------------------------|-------|--------|--------|
| Streeter Dr & Grand Ave           | 63249 | 17219  | 46030  |
| DuSable Lake Shore Dr & Monroe St | 40288 | 9801   | 30487  |
| Michigan Ave & Oak St             | 37383 | 14719  | 22664  |
| DuSable Lake Shore Dr & North Blvd| 35966 | 15628  | 20338  |
| Millennium Park                   | 30156 | 9928   | 20228  |
| Shedd Aquarium                    | 22805 | 5022   | 17783  |
| Theater on the Lake               | 30068 | 13709  | 16359  |
| Dusable Harbor                    | 21459 | 5968   | 15491  |
| Wells St & Concord Ln             | 33590 | 21419  | 12171  |
| Montrose Harbor                   | 20126 | 8139   | 11987  |

</td>
</table>
</div>

<p align="center" width="100%">
    <img width="45%" src="https://github.com/anzarshaikh9/Cyclistic_analytics_2023--EXCEL-SQL-TABLEAU/assets/169331791/7c4bc344-7341-4d7f-8a1d-39a775b606a7">
	<img width="45%" src="https://github.com/anzarshaikh9/Cyclistic_analytics_2023--EXCEL-SQL-TABLEAU/assets/169331791/8225f34c-1f06-4b95-9a58-c0c9e11cef27">
</p>

***
6.

```sql
SELECT
	DISTINCT rideable_type,
	COUNT(*) AS total_bike_trip,
    	COUNT(IF(member_casual = 'member', 1, NULL)) AS member_bike_trip,
    	COUNT(IF(member_casual = 'casual', 1, NULL)) AS casual_bike_trip,
	ROUND((COUNT(IF(member_casual = 'member', 1, NULL)) / COUNT(*)) * 100, 2) AS member_percent,
    	ROUND((COUNT(IF(member_casual = 'casual', 1, NULL)) / COUNT(*)) * 100, 2) AS casual_percent
FROM
	cyclistic.tripdata_2023
GROUP BY
	rideable_type;
```
<div align="center">

| rideable_type | total_bike_trip  | member_bike_trip  | casual_bike_trip  | member_percent | casual_percent |
|---------------|------------------|-------------------|-------------------|----------------|----------------|
| electric_bike | 2945579          | 1841568           | 1104011           | 62.52          | 37.48          |
| classic_bike  | 2696011          | 1819130           | 876881            | 67.47          | 32.53          |
| docked_bike   | 78287            | 0                 | 78287             | 0.00           | 100.00         |

</div>

<p align="center" width="100%">
    <img width="50%" src="https://github.com/anzarshaikh9/Cyclistic_analytics_2023--EXCEL-SQL-TABLEAU/assets/169331791/252e7dbd-f109-4569-abc6-aaebdc0b5821">
</p>

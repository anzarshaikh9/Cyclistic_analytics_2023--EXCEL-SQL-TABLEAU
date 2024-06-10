-- Total bike-trips and the share of trips between member and casual in year 2023

SELECT
    COUNT(*) AS total_trips,
    COUNT(IF(member_casual = 'member', 1, NULL)) AS member_trips,
    COUNT(IF(member_casual = 'casual', 1, NULL)) AS casual_trips,
    ROUND((COUNT(IF(member_casual = 'member', 1, NULL)) / COUNT(*)) * 100, 2) AS member_percent,
    ROUND((COUNT(IF(member_casual = 'casual', 1, NULL)) / COUNT(*)) * 100, 2) AS casual_percent
FROM
	cyclistic.tripdata_2023;


-- Maximum, minimum and average ride length between member and casual

SELECT
	DISTINCT member_casual,
    MAX(ride_length) AS max_ride_length,
    MIN(ride_length) AS min_ride_length,
    SEC_TO_TIME(AVG(TIME_TO_SEC(ride_length))) AS avg_ride_length
FROM
	cyclistic.tripdata_2023
GROUP BY
	member_casual;


-- Member bike-trips in the hour of the day

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


-- Casual bike-trips in the hour of the day

SELECT
	time_format(time(started_at), "%h %p") AS hour_of_day,
    count(*) AS casual_trips
FROM
	cyclistic.tripdata_2023
WHERE
	member_casual = 'casual'
GROUP BY
	hour_of_day
ORDER BY
	casual_trips DESC;


-- Member bike-trips and average ride length in the day of week totals over a year

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


-- Casual bike-trips and average ride length in the day of week totals over a year

SELECT
	DAYNAME(started_at) AS day_of_week,
	COUNT(*) AS casual_trips,
    SEC_TO_TIME(ROUND(AVG(TIME_TO_SEC(ride_length)), 0)) AS casual_avg_ride_length
FROM
	cyclistic.tripdata_2023
WHERE
	member_casual = 'casual'
GROUP BY
	day_of_week
ORDER BY
	casual_trips DESC;


-- Monthly member bike-trips and average ride length in year 2023

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


-- Monthly casual bike-trips and average ride length in year 2023

SELECT
	MONTHNAME(started_at) AS month,
	COUNT(*) AS casual_trips,
    SEC_TO_TIME(ROUND(AVG(TIME_TO_SEC(ride_length)), 0)) AS casual_avg_ride_length
FROM
	cyclistic.tripdata_2023
WHERE
	member_casual = 'casual'
GROUP BY
	month
ORDER BY
	casual_trips DESC;
    
    
-- Top 10 stations used by member

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
	member DESC
LIMIT
	10;


-- Top 10 stations used by casual

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
	casual DESC
LIMIT
	10;


-- Distinct rideable type used by member and casual

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
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

## Problem Statement

I need to understand how annual members and casual riders use Cyclistic bikes differently. By analyzing the differences in usage patterns, trip durations, and popular routes, I aim to identify key differences between these two groups. These insights will help the company design targeted marketing strategies to encourage casual riders to become annual members, ultimately supporting Cyclistic's growth objectives.
<br>
<br>

## Data

I'm utilizing Cyclistic's historical trip data for trend analysis and identification. The dataset comprises 12 CSV files, each representing a month from the year 2023. The initial raw data contains 13 columns, but after data manipulation, it expands to 14 columns. In total, there are 5,719,877 rows combining all 12 CSV files.

*Note: This is public data and it has been made available by Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement).*
<br>
<br>

## Tools

- Excel - Data Manipulation
- MySQL - Data Analysis
- Tableau - Data Visualization
<br>

## Data Manipulation

In this dataset, minimal cleaning was required, primarily involving some data formatting. In Excel, I created a column called 'ride_length' to calculate the duration of each ride by subtracting the 'started_at' column from the 'ended_at' column (e.g., =D2-C2). This new column was formatted as HH:MM:SS. Following this, I proceeded to the analysis step.
<br>
<br>

## Data Analysis & Visualization


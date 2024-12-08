# Introduction
As a stock enthusiast and trader, I conducted this analysis to evaluate Safaricom's stock performance from 2012 to 2019. The project focuses on price movements, trading volumes, returns, and volatility, uncovering trends and correlations. Using daily stock data.

-SQL queries. Check them out here: [Analysis folder](/Analysis/)

# Background
Wanting to start an investment portfolio I was driven to do analysis and know what affects my stock of choice.

The questions I wanted answer were
##### 1. Price Analysis
##### 2. Volatility and Risk
##### 3. Volume and Trading Activity
##### 4. Price Change Analysis
##### 5. Comparing Yearly Performance
##### 8. Risk and Return Analysis

# Tools used
I used a couple of tools to see my insights and conclude my findings
1.	**SQL:** Help to query my database for analysis
2.	**PostgreSQL:** Choice for my database
3.	**Visual Studio Code:** Database management and executing queries
4.	**Git and Github:** For version control and sharing my SQL scripts and Analysis
5.	**Tableau**: For visualizing trends.

# The Analysis
### 1. Price Analysis
  This was to see how prices have changed over the seven year period (2012-2019). The analysis showed that prices closed higher at the end of every year creating new highs. 
```
SELECT 
    EXTRACT(YEAR FROM date) AS year, 
    ROUND(AVG(close), 2) AS average_close_price
FROM safaricom
GROUP BY EXTRACT(YEAR FROM date)
ORDER BY year;
```
### 2. Volatility and Risk
  The average daily volatility was at 0.0151 or 1.51%. 
  ```
WITH daily_returns AS (
    SELECT 
        date, 
        ("close" - LAG("close") OVER (ORDER BY date)) / LAG("close") OVER (ORDER BY date) AS return
    FROM safaricom
)
SELECT 
    ROUND(STDDEV(return), 4) AS daily_volatility,
    ROUND(STDDEV(return) * 100, 2) AS percentage_daily_volatility
FROM daily_returns
```
  2014 had the lowest volatility of 19.49% and 2018 had the highest with 26.25%
  ```
   WITH daily_returns AS (
    SELECT 
        date, 
        EXTRACT(YEAR FROM date) AS year,
        ("close" - LAG("close") OVER (PARTITION BY EXTRACT(YEAR FROM date) ORDER BY date)) / LAG("close") OVER (PARTITION BY EXTRACT(YEAR FROM date) ORDER BY date) AS return
    FROM safaricom
),
annual_volatility AS (
    SELECT 
        year,
        ROUND(CAST(STDDEV(return) * SQRT(252) AS NUMERIC), 4) AS annual_volatility,
        ROUND(CAST(STDDEV(return) * SQRT(252) * 100 AS NUMERIC), 2) AS percentage_annual_volatility
    FROM daily_returns
    WHERE 
        return IS NOT NULL
    GROUP BY year
)
SELECT 
    year, 
    annual_volatility,
    percentage_annual_volatility
FROM annual_volatility
ORDER BY year;
```
### 3. Volume and Trading activity
  2016 had the lowest average volume per year of 9.39M while 2013 had the highest with 15.85M
```
WITH yearly_data AS (
    SELECT 
        EXTRACT(YEAR FROM date) AS year,
        SUM(volume_million) AS total_volume,
        COUNT(volume_million) AS trading_days
    FROM safaricom
    GROUP BY 
        EXTRACT(YEAR FROM date)
)
SELECT 
    year,
    ROUND(total_volume::NUMERIC / trading_days, 2) AS average_daily_volume
FROM yearly_data
ORDER BY average_daily_volume ASC;
```
I went further to check the correlation between volume and price movement. The correlation had a value of 0.03. This showed that the correlation that exists between these two metrics was very small.
Practical Implication:
The stock's price movement is likely influenced by other factors (e.g., news, market conditions, or other technical indicators) rather than trading volume alone

```
SELECT 
    ROUND(CORR(volume_million, change_percentage)::NUMERIC, 2) AS correlation_between_volume_and_change_percentage
FROM safaricom;
```
![Day Vs Volume](https://github.com/user-attachments/assets/8baae145-d4fd-442a-84f9-e80eae9bdacc)
Wenesday had the highest volume and Monday had the lowest. As seen Monday and Fridays experienced low volumes while Tuesday, Wenesday and Thursday had the highest volumes
```
SELECT 
    TO_CHAR(date, 'Day') AS day_of_week,
    ROUND(AVG(volume_million), 2) AS avg_volume
FROM safaricom
GROUP BY TO_CHAR(date, 'Day')
ORDER BY avg_volume DESC;
```
### 4. Price Change
   Out of the 1753 days 669 of them experienced a positive or negative change in value over 1%. This represented 38.16% of the total days
   ```
   SELECT 
    COUNT(*) AS total_days,
    SUM(CASE WHEN ABS(change_percentage) > 1 THEN 1 ELSE 0 END) AS days_over_1_percent,
    ROUND(SUM(CASE WHEN ABS(change_percentage) > 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS percentage_days_over_1_percent
    FROM safaricom;
   ```
### 5. Comparing Yearly Perfomance
      2018 was the lowest perfoming year with a value of -17.01% while 2013 was the best performing year wuith a value of 117%
### 6. Risk and Returns
      Annually the stock would have returns of 34.59%. And a total return of 700% in the period between 2012 and 2019
      ```
      SELECT 
    ROUND(((MAX(CASE WHEN date = '2019-06-14' THEN "close" END) /
            MAX(CASE WHEN date = '2012-06-11' THEN "close" END) - 1) * 100), 2) AS total_return_percentage
    FROM safaricom;
       ```
# What I Learned
The stock has perfommed well over the years. Even in depressions when the stock market is hit hard this particular stock recovered and continued to grow in size. For the long term investor it would have been a good one to hold on buying. For the short term investor i dont know, Why?, I expected volume to have a significant change to the stock price but on analysis this was proven wrong.
# Conclusions
On concluding the analysis the Overal trend was an uptrend for the 7 years. 

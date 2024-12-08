--3. **Volume and Trading Activity**
   --What is the average trading volume per year?**
     --(Calculate the average of 'Vol.' for each year.)
   --What is the relationship between volume and price movement?**  
     --(For example, does the stock tend to have high volume on up days or down days?)
   --Were there any periods of unusually high or low volume?**
   --What days of the week tend to have higher trading volumes?**

SELECT *
FROM safaricom

 --What is the average trading volume per year?
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
ORDER BY year;

 --What is the relationship between volume and price movement?
SELECT 
    ROUND(CORR(volume_million, change_percentage)::NUMERIC, 2) AS correlation_between_volume_and_change_percentage
FROM safaricom;
--0.03
--Value close to 0:
--A correlation of 0.03 suggests a very weak or negligible linear relationship between trading volume and percentage price change.
--This means that changes in trading volume do not significantly affect the price changes (or vice versa).
--Practical Implication:
--The stock's price movement is likely influenced by other factors (e.g., news, market conditions, or other technical indicators) rather than trading volume alone

--What days of the week tend to have higher trading volumes?**
SELECT 
    TO_CHAR(date, 'Day') AS day_of_week,
    ROUND(AVG(volume_million), 2) AS avg_volume
FROM safaricom
GROUP BY TO_CHAR(date, 'Day')
ORDER BY avg_volume DESC;
--monday friday low wenesday highest



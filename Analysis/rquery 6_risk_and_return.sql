--### 8. **Risk and Return Analysis**
   -- **What is the annualized return over the 7 years (2012-2019)?**  
     --(You can calculate this by comparing the first and last closing prices of 2012 and 2019.)
   -- **How did the stock perform during market downturns or crises?**
     --(You can check specific periods like during 2018 or other market corrections.)

SELECT *
FROM safaricom

-- **What is the annualized return over the 7 years (2012-2019)?
SELECT 
    ROUND((POWER((ending_value / beginning_value), (1.0 / 7)) - 1), 4) AS annual_returns,
    ROUND((POWER((ending_value / beginning_value), (1.0 / 7)) - 1) * 100, 2) AS "%_annual_return"
FROM 
    (SELECT 
        (SELECT "close" 
         FROM safaricom 
         WHERE EXTRACT(YEAR FROM date) = 2012 
         ORDER BY date 
         LIMIT 1) AS beginning_value,
         
        (SELECT "close" 
         FROM safaricom 
         WHERE EXTRACT(YEAR FROM date) = 2019 
         ORDER BY date DESC 
         LIMIT 1) AS ending_value) AS values;
--34.59

WITH daily_returns AS (
    SELECT 
        EXTRACT(YEAR FROM date) AS year,
        ("close" - LAG("close") OVER (PARTITION BY EXTRACT(YEAR FROM date) ORDER BY date)) / LAG("close") OVER (PARTITION BY EXTRACT(YEAR FROM date) ORDER BY date) AS return_per_day
    FROM safaricom
    WHERE EXTRACT(YEAR FROM date) BETWEEN 2012 AND 2019
),
yearly_volatility AS (
    SELECT 
        year,
        STDDEV(return_per_day) AS daily_volatility
    FROM daily_returns
    WHERE return_per_day IS NOT NULL
    GROUP BY year
)
SELECT 
    year,
    ROUND(daily_volatility::numeric, 6) AS daily_volatility,
    ROUND(daily_volatility * SQRT(252)::numeric, 6) AS annualized_volatility
FROM yearly_volatility
ORDER BY annualized_volatility DESC;



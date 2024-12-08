--2. **Volatility and Risk**
  -- **What is the daily volatility of the stock?**  
     --(You can calculate daily volatility as the difference between the high and low prices.)
 -- **What is the standard deviation of the daily percentage change in stock price?**  
     --(This will give you an idea of how much the price fluctuated daily.)
  -- **What were the largest single-day price changes?**  
     --(Look for the highest daily changes in the stock price from the "Change %" column.)

SELECT *
FROM safaricom 

--What is the daily volatility of the stock?
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
WHERE 
    return IS NOT NULL;
    --1.51%

--What is the annual volatility of the stock
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

--This measures the largest price fluctuation within a single day.
WITH daily_price_changes AS (
    SELECT 
        date, 
        ABS("high" - "low") AS price_change
    FROM 
        safaricom
)
SELECT 
    date, 
    ROUND(price_change, 2) AS largest_price_change
FROM 
    daily_price_changes
ORDER BY 
    price_change DESC
LIMIT 5;

--This measures the largest price change between the Open and Close for each day, capturing the day's price movement.
WITH daily_price_changes AS (
    SELECT 
        date, 
        ABS("open" - "close") AS price_change
    FROM 
        safaricom
)
SELECT 
    date, 
    ROUND(price_change, 2) AS largest_price_change
FROM 
    daily_price_changes
ORDER BY 
    price_change DESC
LIMIT 5;

SELECT 
    date, 
    "change_percentage"
FROM safaricom
ORDER BY 
    ABS("change_percentage") DESC
LIMIT 5;


--1. **Price Analysis**
   --What is the overall trend of the stock from 2012 to 2019?**  
     --(Is the stock price increasing, decreasing, or fluctuating?)
   --What is the average closing price per year?**  
     --(You can calculate the annual average of the 'Close' prices.)
   --What were the highest and lowest closing prices during the entire period?**
   --What was the highest opening price and lowest opening price during the period?**

SELECT *
FROM safaricom

--What is the average closing price per year?** 
SELECT 
    EXTRACT(YEAR FROM date) AS year, 
    ROUND(AVG(close), 2) AS average_close_price
FROM safaricom
GROUP BY EXTRACT(YEAR FROM date)
ORDER BY year;

--What were the highest and lowest closing prices during the entire period?
SELECT 
    MAX("close") AS highest_close, 
    MIN("close") AS lowest_close
FROM safaricom;
   -- 32.75 and 3.4  

--What was the highest opening price and lowest opening price during the period?
SELECT 
    MAX("open") AS highest_close, 
    MIN("open") AS lowest_close
FROM safaricom;
    -- 0 and 32.75

SELECT *
FROM safaricom
WHERE open = '0'


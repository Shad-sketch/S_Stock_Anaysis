--### 5. **Comparing Yearly Performance**
   -- **How did the stock perform in each year (2012-2019)?**  
     --(Look at the change in closing price from the beginning to the end of each year.)
   -- **Which year had the best performance in terms of overall growth or decline?**
   -- **Were there any specific years where the stock experienced major fluctuations or losses?**

SELECT *
FROM safaricom

 -- **How did the stock perform in each year (2012-2019)?** 
WITH yearly_prices AS (
    SELECT 
        EXTRACT(YEAR FROM date) AS year,
        FIRST_VALUE("open") OVER (PARTITION BY EXTRACT(YEAR FROM date) ORDER BY date ASC) AS start_price,
        LAST_VALUE("close") OVER (PARTITION BY EXTRACT(YEAR FROM date) ORDER BY date ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS end_price
    FROM 
        safaricom
)
SELECT 
    year,
    ROUND((end_price - start_price) / start_price * 100, 2) AS annual_percentage_change
FROM 
    yearly_prices
WHERE 
    year BETWEEN 2012 AND 2019
GROUP BY 
    year, start_price, end_price
ORDER BY 
    year;

c:\Users\shades\Downloads\annual_percentage_change_chart.png

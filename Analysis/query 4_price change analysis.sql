--4. **Price Change Analysis**
   -- **What is the average percentage change per year?**
     --(Look at the average of the 'Change %' column for each year.)
   -- **What was the biggest positive and negative change in percentage on any single day?**
   -- **How often does the stock experience a positive or negative change in value over 1% in a single day?**

SELECT change_percentage
FROM safaricom

-- **What is the average percentage change per year?**
SELECT 
    EXTRACT(YEAR FROM date) AS year,
    ROUND(AVG(change_percentage), 2) AS avg_percentage_change
FROM 
    safaricom
GROUP BY 
    EXTRACT(YEAR FROM date)
ORDER BY 
    avg_percentage_change DESC;
    
-- **How often does the stock experience a positive or negative change in value over 1% in a single day?**
SELECT 
    COUNT(*) AS total_days,
    SUM(CASE WHEN ABS(change_percentage) > 1 THEN 1 ELSE 0 END) AS days_over_1_percent,
    ROUND(SUM(CASE WHEN ABS(change_percentage) > 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS percentage_days_over_1_percent
FROM safaricom;

-- **What was the biggest positive and negative change in percentage on any single day?
SELECT 
    date AS change_date,
    change_percentage AS percentage_change
FROM safaricom
WHERE 
    change_percentage = (SELECT MAX(change_percentage) FROM safaricom)
OR 
    change_percentage = (SELECT MIN(change_percentage) FROM safaricom);
--7.87 2012/11/09 and -7.77 2016/09/05



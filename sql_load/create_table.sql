--Create table safaricom and copy the data

CREATE TABLE safaricom
(
    Date TEXT,
    Open NUMERIC,
    High NUMERIC,
    Low NUMERIC,
    Close NUMERIC,
    Volume_Million TEXT,
    Change_Percentage TEXT 
)

/* ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️
Database Load Issues (follow if receiving permission denied when running SQL code below)

NOTE: If you are having issues with permissions. And you get error: 

'could not open file "[your file path]\job_postings_fact.csv" for reading: Permission denied.'

1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `stock_projects` database
3. Right-click `stock_projects` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv files
    1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy Safaricom FROM 'C:\Program Files\PostgreSQL\17\data\Datasets\stock_projects\NSE_SCOM_Safaricom.csv' WITH (FORMAT csv, HEADER true,DELIMITER ',', ENCODING 'UTF8');
*\

\copy safaricom FROM 'C:\Users\shades\Safaricom_Stock_Analysis\csv_file\NSE_SCOM_Safaricom.csv' WITH (FORMAT csv, HEADER true,DELIMITER ',', ENCODING 'UTF8');
*\

Alternatively you can use 


COPY company_dim
FROM 'C:\Program Files\PostgreSQL\17\data\Datasets\stock_projects\NSE_SCOM_Safaricom.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
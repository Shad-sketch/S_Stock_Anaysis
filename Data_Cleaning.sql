--Standardize Data Formats
--Text Cleaning

SELECT *
FROM safaricom

SELECT volume_Million
FROM safaricom
WHERE volume_Million LIKE '%K';

UPDATE safaricom
SET volume_Million = TRIM(TRAILING 'K' FROM volume_Million)
WHERE volume_Million LIKE '%K';

UPDATE safaricom
SET volume_Million = CONCAT(ROUND(CAST(volume_Million AS numeric) / 1000, 4), 'M')
WHERE volume_Million NOT LIKE '%M' AND volume_Million !~ '[^0-9.]';

SELECT volume_Million
FROM safaricom
ORDER BY volume_Million ASC;


UPDATE safaricom
SET volume_Million = TRIM(TRAILING 'M' FROM volume_Million)
WHERE volume_Million LIKE '%M';

ALTER TABLE safaricom
ALTER COLUMN volume_Million TYPE numeric USING volume_Million::numeric;

UPDATE safaricom
SET change_percentage = REPLACE(change_percentage, '%', '')::numeric;

ALTER TABLE safaricom
ALTER COLUMN change_percentage TYPE numeric USING change_percentage::numeric;

UPDATE Safaricom
SET Date = TO_CHAR(TO_DATE(Date, 'DD-MM-YYYY'), 'YYYY-MM-DD')
WHERE Date IS NOT NULL;

ALTER TABLE Safaricom
    ALTER COLUMN Date TYPE DATE USING TO_DATE(Date, 'YYYY-MM-DD');






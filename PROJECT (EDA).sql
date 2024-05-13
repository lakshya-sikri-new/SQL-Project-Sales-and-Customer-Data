- --EDA ( Exploratory Data Analysis )

SELECT top 100*
FROM Customer_Data;

select top 100 *
FROM Sales_Data

SELECT invoice_no,
       COUNT(*) AS count
FROM Sales_Data
GROUP BY invoice_no
HAVING COUNT(*) > 0;

--- Cleaing of Data 

SELECT 
  s.customer_id,
  s.category,
  s.quantity,
  s.price,
  s.quantity * s.price AS total_price,
  s.invoice_date,
  s.shopping_mall,
  c.gender,
  c.age,
  c.payment_method
INTO [SALES AND CUSTOMER DATA]
FROM Sales_Data AS s
INNER JOIN Customer_Data AS c
ON c.customer_id = s.customer_id;


SELECT *
FROM [SALES AND CUSTOMER DATA]
WHERE total_price IS NULL;

SELECT *
FROM [SALES AND CUSTOMER DATA]


--What is the total revenue generated in the year 2022?

SELECT SUM(total_price) AS total_revenue
FROM [SALES AND CUSTOMER DATA]
WHERE YEAR(invoice_date) = 2022;

--Most popular product category in terms of sales

SELECT
  SUM(quantity) AS total_quantity,
  category
FROM [SALES AND CUSTOMER DATA]
GROUP BY category
ORDER BY total_quantity DESC;




-- TOUGHER QUERIES------------------------------------------------------------------------------------------------------------------------------------

--Top Three shopping malls in terms of sales revenue?
SELECT top 5
  shopping_mall
  , ROUND(SUM(total_price),2) AS total_price
  FROM [SALES AND CUSTOMER DATA]
  GROUP BY shopping_mall
  ORDER BY total_price DESC


  SELECT top 10
  shopping_mall
  , ROUND(SUM(total_price),2) AS total_price
  FROM [SALES AND CUSTOMER DATA]
  GROUP BY shopping_mall
  ORDER BY total_price DESC


--The gender distribution across different product categories?

  SELECT
  category
  gender
  ,COUNT(*) AS count
  FROM [SALES AND CUSTOMER DATA]
GROUP BY gender, category
 ORDER BY count DESC;

--Age distribution of customers who prefer each payment method?

 SELECT
  CASE WHEN age BETWEEN 0 AND 25 THEN '0-25'
       WHEN age BETWEEN 26 AND 50 THEN '26-50'
       WHEN age BETWEEN 51 AND 75 THEN '51-75'
       WHEN age BETWEEN 76 AND 100 THEN '76-100'
       ELSE 'other' 
  END AS age_range,
  payment_method,
  COUNT(*) AS count
FROM [SALES AND CUSTOMER DATA]
GROUP BY CASE WHEN age BETWEEN 0 AND 25 THEN '0-25'
             WHEN age BETWEEN 26 AND 50 THEN '26-50'
             WHEN age BETWEEN 51 AND 75 THEN '51-75'
             WHEN age BETWEEN 76 AND 100 THEN '76-100'
             ELSE 'other' 
        END, payment_method
ORDER BY COUNT(*) DESC;

--Rolling Total of prices Per Month

SELECT SUBSTRING(CONVERT(varchar, invoice_date, 120), 1, 7) AS dates, SUM(total_price) AS total_price_off
FROM [SALES AND CUSTOMER DATA]
GROUP BY SUBSTRING(CONVERT(varchar, invoice_date, 120), 1, 7)
ORDER BY dates ASC;

--What is the average monthly sales amount over the entire dataset period?
SELECT AVG(total_price_off) AS average_monthly_sales
FROM (
    SELECT SUBSTRING(CONVERT(varchar, invoice_date, 120), 1, 7) AS dates, SUM(total_price) AS total_price_off
    FROM [SALES AND CUSTOMER DATA]
    GROUP BY SUBSTRING(CONVERT(varchar, invoice_date, 120), 1, 7)
) AS monthly_sales;

-- Which month had the highest total sales?
SELECT TOP 1 dates AS month_with_highest_sales, total_price_off AS highest_sales_amount
FROM (
    SELECT SUBSTRING(CONVERT(varchar, invoice_date, 120), 1, 7) AS dates, SUM(total_price) AS total_price_off
    FROM [SALES AND CUSTOMER DATA]
    GROUP BY SUBSTRING(CONVERT(varchar, invoice_date, 120), 1, 7)
    ORDER BY total_price_off DESC
) AS monthly_sales;

-- How does the sales distribution look over the months? (Optional: Visualize the distribution)
SELECT dates AS month, total_price_off AS total_sales
FROM (
    SELECT SUBSTRING(CONVERT(varchar, invoice_date, 120), 1, 7) AS dates, SUM(total_price) AS total_price_off
    FROM [SALES AND CUSTOMER DATA]
    GROUP BY SUBSTRING(CONVERT(varchar, invoice_date, 120), 1, 7)
) AS monthly_sales
ORDER BY month ASC;
 




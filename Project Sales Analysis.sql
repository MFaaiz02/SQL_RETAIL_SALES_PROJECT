-- SQL Retail Sales Analysis
create database Sales_Project;
use sales_project;
-- Creating Table
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

select * from retail_sales;
select count(*) from retail_sales;

-- Data Cleaning
SELECT * FROM retail_sales
WHERE transaction_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
--
delete from retail_sales
where 
 transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- Data Exploration

-- How many Sale Records we have.?
select count(*) total_sale_Values From retail_sales;

-- How many Customers we have..?
select count(distinct customer_id) as Unique_Customers from retail_sales;

-- How many Categories we have..?
select distinct category as Unique_Categories from retail_sales;

-- Data Analysis/Business Key Problems & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than equal to 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * 
from retail_sales
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the 
-- quantity sold is more than equal to 4 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity >= 4
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
  
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select 
category,
sum(total_sale) as Total_Sales,
count(*) as Total_Orders
from retail_sales  
group by category;  


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
ROUND(AVG(age),1) average_age
FROM retail_sales
WHERE category = 'Beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM RETAIL_SALES
WHERE TOTAL_SALE > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT
		CATEGORY,
		GENDER AS GENDER,
		COUNT(*) AS TOTAL_TRANSACTIONS
	FROM RETAIL_SALES
	GROUP 
		BY CATEGORY,GENDER
	ORDER BY 1;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
	YEAR,
	MONTH,
	AVERAGE_SALES
FROM (
    SELECT 
        YEAR(sale_date) AS YEAR,
        MONTH(sale_date) AS MONTH,
        ROUND(AVG(total_sale), 2) AS AVERAGE_SALES,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS RNK
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t1
WHERE rnk = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    Category,    
    COUNT(DISTINCT customer_id) as TOTAL_UNIQUE_CUSTOMERS
FROM retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders    
FROM hourly_sale
GROUP BY shift;

-- End of project
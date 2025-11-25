# 🛍️ Retail Sales Analysis — SQL Project

## 📘 Project Overview
This SQL project focuses on analyzing retail sales data to identify trends, customer behavior, and category performance.  
It is designed for **beginners** who want to learn SQL through a real-world style dataset.

### 🎯 Key Objectives:
- 🗄️ **Database Setup:** Create and structure a retail sales database.  
- 🧹 **Data Cleaning:** Detect and remove invalid or missing data.  
- 🔍 **Exploratory Data Analysis:** Understand customer patterns and product category behavior.  
- 📊 **Business Insights:** Answer practical business questions using SQL queries.  
- 💡 **Decision Support:** Provide insights to improve retail operations and marketing.

The dataset contains transaction information such as date, time, customer demographics, product categories, quantities, pricing, and sales amounts—ideal for hands-on analytics practice.

------------------------------------------------------------

## 🗄️ 1. Database Setup

-- Create Database  
CREATE DATABASE Sales_Project;

-- Use the database  
USE Sales_Project;

-- Create Table  
CREATE TABLE retail_sales
(
    transaction_id INT PRIMARY KEY,	
    sale_date DATE,	 
    sale_time TIME,	
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(20),	
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

------------------------------------------------------------

## 🧹 2. Data Cleaning & Validation

-- View all data  
SELECT * FROM retail_sales;

-- Count total records  
SELECT COUNT(*) AS total_records FROM retail_sales;

-- Find NULL values  
SELECT *
FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

-- Delete NULL records  
DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

------------------------------------------------------------

## 🔍 3. Data Exploration

-- Total sales records  
SELECT COUNT(*) AS total_sale_records FROM retail_sales;

-- Unique customers  
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM retail_sales;

-- Unique categories  
SELECT DISTINCT category AS unique_categories FROM retail_sales;

------------------------------------------------------------

## 📊 4. Business Problems & SQL Solutions

-- Q1: Retrieve all sales made on '2022-11-05'  
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q2: Clothing transactions with quantity >= 4 in Nov-2022  
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity >= 4
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

-- Q3: Total sales for each category  
SELECT 
    category,
    SUM(total_sale) AS total_sales,
    COUNT(*) AS total_orders
FROM retail_sales  
GROUP BY category;

-- Q4: Average age of customers who purchased Beauty products  
SELECT
    ROUND(AVG(age), 1) AS average_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q5: Find transactions where total_sale > 1000  
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Q6: Total transactions by gender in each category  
SELECT
    category,
    gender,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category;

-- Q7: Best-selling month each year  
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
        ) AS rnk
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t1
WHERE rnk = 1;

-- Q8: Top 5 customers based on total sales  
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q9: Unique customers per category  
SELECT 
    category,    
    COUNT(DISTINCT customer_id) AS total_unique_customers
FROM retail_sales
GROUP BY category;

-- Q10: Order distribution by shift  
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

------------------------------------------------------------

## 📈 Findings & Insights

### 👥 Customer Demographics  
- Majority of customers fall between **25–45 years**, strongest buying group.  
- Gender distribution is balanced, indicating equal market engagement.

### 🛒 Category Performance  
- **Clothing** is the top-performing category across all metrics.  
- **Beauty** shows strong sales among customers aged 30+.  
- Other categories like Electronics & Food maintain steady monthly sales.

### 💰 Revenue & Transaction Behavior  
- Several premium transactions exceed **$1000**, showing high-value customers.  
- Average order values are higher during seasonal months like **November & December**.  
- Categories with higher revenue are also the most frequently purchased.

### ⭐ Customer Loyalty Insights  
- Top 5 customers contribute a noticeable portion of total sales, indicating repeat purchases.  
- Clothing and Beauty categories have the highest repeat customer counts.

### ⏰ Time-Based Activity  
- **Afternoon (12 PM – 5 PM)** is the peak shopping window.  
- Morning orders show steady traffic; evenings are comparatively lower.

------------------------------------------------------------

## 📄 Reports
- Total Sales Summary  
- Monthly Trend Analysis  
- Customer Demographics Report  
- Category Performance Overview  
- Shift-Based Order Traffic Report  

------------------------------------------------------------

## 🏁 Conclusion
This project delivers a complete end-to-end SQL analysis workflow suitable for beginners and data enthusiasts.  
It includes database creation, data cleaning, EDA, and practical business-focused SQL queries.

### 🔑 Key Takeaways:
- 📊 **SQL is a powerful tool** for extracting actionable insights from raw business data.  
- 🛍️ Retail datasets help understand **customer behavior, category trends, and revenue patterns**.  
- ⏱️ Time-based and seasonal analysis helps businesses optimize **staffing, inventory, and promotions**.  
- 👥 Customer-level insights reveal opportunities for **loyalty programs and targeted marketing**.  

Overall, this project showcases how SQL can turn transactional data into valuable insights that support data-driven decision-making in retail environments.

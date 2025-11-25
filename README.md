# 🛍️ Retail Sales Analysis — SQL Project

## 📘 Project Overview
This SQL project analyzes retail sales data to uncover customer behavior, category performance, seasonal trends, and revenue insights.  
It is ideal for **beginners** who want real-world SQL practice.

### 🎯 Key Objectives
- 🗄️ **Database Setup** – Build a structured retail sales database  
- 🧹 **Data Cleaning** – Identify and remove invalid records  
- 🔍 **EDA** – Explore customers, categories, and sales  
- 📊 **Business Queries** – Solve real retail problems using SQL  
- 💡 **Insights** – Provide actionable findings for decision-making  

The dataset contains transaction details such as date, time, customer demographics, category, pricing, and sales amount.

---

## 🗄️ 1. Database Setup

```sql
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
```

---

## 🧹 2. Data Cleaning & Validation

```sql
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
```

---

## 🔎 3. Data Exploration (EDA)

```sql
-- Total sale records
SELECT COUNT(*) AS total_sale_records FROM retail_sales;

-- Unique customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM retail_sales;

-- Unique categories
SELECT DISTINCT category AS unique_categories FROM retail_sales;
```

---

## 📊 4. Business Problems & SQL Solutions

### 📌 Q1 — Retrieve all sales made on 2022-11-05
```sql
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

### 📌 Q2 — Clothing transactions (quantity ≥ 4) in Nov-2022
```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity >= 4
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
```

### 📌 Q3 — Total sales for each category
```sql
SELECT 
    category,
    SUM(total_sale) AS total_sales,
    COUNT(*) AS total_orders
FROM retail_sales  
GROUP BY category;
```

### 📌 Q4 — Average age of customers purchasing Beauty items
```sql
SELECT ROUND(AVG(age), 1) AS average_age
FROM retail_sales
WHERE category = 'Beauty';
```

### 📌 Q5 — Transactions with total sale > 1000
```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

### 📌 Q6 — Total transactions by gender & category
```sql
SELECT
    category,
    gender,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

### 📌 Q7 — Best-selling month in each year
```sql
SELECT YEAR, MONTH, AVERAGE_SALES
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
```

### 📌 Q8 — Top 5 customers by total sales
```sql
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

### 📌 Q9 — Unique customers per category
```sql
SELECT 
    category,
    COUNT(DISTINCT customer_id) AS total_unique_customers
FROM retail_sales
GROUP BY category;
```

### 📌 Q10 — Order distribution by shift
```sql
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
```

---

## 📈 Findings & Insights

### 👥 Customer Demographics
- Customers aged **25–45** generate most sales  
- Balanced gender participation  

### 🛍️ Category Performance
- **Clothing** leads in both revenue and number of orders  
- **Beauty** attracts older customers (30+)  
- Electronics & Food are steady performers  

### 💰 Revenue Trends
- Multiple premium transactions above **$1000**  
- Strong seasonal spikes in **November & December**  

### ⭐ Customer Loyalty
- Top 5 customers contribute significantly to total revenue  
- Clothing has the highest repeat purchase rate  

### ⏰ Time-Based Patterns
- Sales peak between **12 PM to 4 PM**  
- Evening traffic is comparatively low  

---

## 📄 Reports Generated
- Monthly Sales Trend  
- Category Performance Report  
- Customer Demographics Summary  
- High-Value Transaction Report  
- Shift-Based Sales Analysis  

---

## 🏁 Conclusion

This project provides a complete SQL workflow suitable for beginners and analysts.  
It demonstrates how SQL can transform raw retail data into **meaningful business insights**.

### 🔑 Key Takeaways
- SQL helps uncover hidden trends in customer behavior  
- Retail datasets reveal strong **seasonal and category-based patterns**  
- Insights support better decisions in **marketing, inventory, and staffing**  
- Customer-level analysis helps identify **loyal and high-value buyers**

---

## 📬 Stay Updated & Connect With Me

For more content on SQL, data analysis, and other data-related topics, feel free to connect or reach out:

🔗 **LinkedIn:**  
https://www.linkedin.com/in/mohd-faaiz-669730388/

📧 **Email:**  
mohdfaaizbly@outlook.com


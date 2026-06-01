-- ================================================
-- Project  : Retail Sales Analysis
-- Author   : Piyush Kumar
-- File     : analysis_queries.sql
-- Description: Business insight queries
-- ================================================

USE retail_sales_db;

-- ------------------------------------------------
-- 1. Total Revenue Generated
-- ------------------------------------------------
SELECT SUM(total_amount) AS total_revenue
FROM retail_sales;

-- ------------------------------------------------
-- 2. Total Number of Transactions
-- ------------------------------------------------
SELECT COUNT(transaction_id) AS total_transactions
FROM retail_sales;

-- ------------------------------------------------
-- 3. Total Unique Customers
-- ------------------------------------------------
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales;

-- ------------------------------------------------
-- 4. Revenue by Product Category
-- ------------------------------------------------
SELECT 
    product_category,
    SUM(total_amount) AS total_revenue,
    COUNT(transaction_id) AS total_orders
FROM retail_sales
GROUP BY product_category
ORDER BY total_revenue DESC;

-- ------------------------------------------------
-- 5. Monthly Revenue Trend
-- ------------------------------------------------
SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    SUM(total_amount) AS monthly_revenue
FROM retail_sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY year, month;

-- ------------------------------------------------
-- 6. Revenue by Gender
-- ------------------------------------------------
SELECT 
    gender,
    SUM(total_amount) AS total_revenue,
    COUNT(transaction_id) AS total_orders
FROM retail_sales
GROUP BY gender
ORDER BY total_revenue DESC;

-- ------------------------------------------------
-- 7. Top 5 Customers by Spending
-- ------------------------------------------------
SELECT 
    customer_id,
    SUM(total_amount) AS total_spending
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spending DESC
LIMIT 5;

-- ------------------------------------------------
-- 8. Average Order Value by Category
-- ------------------------------------------------
SELECT 
    product_category,
    ROUND(AVG(total_amount), 2) AS avg_order_value
FROM retail_sales
GROUP BY product_category
ORDER BY avg_order_value DESC;

-- ------------------------------------------------
-- 9. Age Group Analysis
-- ------------------------------------------------
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    COUNT(transaction_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY age_group
ORDER BY total_revenue DESC;

-- ------------------------------------------------
-- 10. Best Selling Month
-- ------------------------------------------------
SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    SUM(total_amount) AS monthly_revenue
FROM retail_sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY monthly_revenue DESC
LIMIT 1;

-- ------------------------------------------------
-- 11. Category Performance by Gender
-- ------------------------------------------------
SELECT 
    gender,
    product_category,
    SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY gender, product_category
ORDER BY gender, total_revenue DESC;

-- ------------------------------------------------
-- 12. High Value Transactions (Above Average)
-- ------------------------------------------------
SELECT *
FROM retail_sales
WHERE total_amount > (SELECT AVG(total_amount) FROM retail_sales)
ORDER BY total_amount DESC;

-- ================================================
-- Project  : Retail Sales Analysis
-- Author   : Piyush Kumar
-- File     : data_cleaning.sql
-- Description: Data cleaning queries
-- ================================================

USE retail_sales_db;

-- 1. Check total records
SELECT COUNT(*) AS total_records FROM retail_sales;

-- 2. Check for NULL values in all columns
SELECT
    SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END)   AS null_transaction_id,
    SUM(CASE WHEN sale_date IS NULL THEN 1 ELSE 0 END)         AS null_sale_date,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END)       AS null_customer_id,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END)            AS null_gender,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END)               AS null_age,
    SUM(CASE WHEN product_category IS NULL THEN 1 ELSE 0 END)  AS null_product_category,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END)          AS null_quantity,
    SUM(CASE WHEN price_per_unit IS NULL THEN 1 ELSE 0 END)    AS null_price_per_unit,
    SUM(CASE WHEN total_amount IS NULL THEN 1 ELSE 0 END)      AS null_total_amount
FROM retail_sales;

-- 3. Check for duplicate transaction IDs
SELECT transaction_id, COUNT(*) AS duplicate_count
FROM retail_sales
GROUP BY transaction_id
HAVING COUNT(*) > 1;

-- 4. Remove duplicate records
DELETE FROM retail_sales
WHERE transaction_id IN (
    SELECT transaction_id FROM (
        SELECT transaction_id, ROW_NUMBER() OVER (PARTITION BY transaction_id ORDER BY transaction_id) AS rn
        FROM retail_sales
    ) t WHERE rn > 1
);

-- 5. Check for invalid age values (age should be between 18 and 100)
SELECT * FROM retail_sales
WHERE age < 18 OR age > 100;

-- 6. Check for negative quantity or price
SELECT * FROM retail_sales
WHERE quantity <= 0 OR price_per_unit <= 0 OR total_amount <= 0;

-- 7. Verify total_amount calculation (quantity * price_per_unit)
SELECT * FROM retail_sales
WHERE total_amount != (quantity * price_per_unit);

-- 8. Standardize gender values
UPDATE retail_sales
SET gender = UPPER(SUBSTRING(gender, 1, 1)) + LOWER(SUBSTRING(gender, 2, LEN(gender)));

-- 9. Check distinct product categories
SELECT DISTINCT product_category FROM retail_sales;

-- 10. Final clean record count
SELECT COUNT(*) AS clean_records FROM retail_sales;

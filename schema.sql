-- ================================================
-- Project  : Retail Sales Analysis
-- Author   : Piyush Kumar
-- File     : schema.sql
-- Description: Database schema for retail sales
-- ================================================

CREATE DATABASE retail_sales_db;

USE retail_sales_db;

CREATE TABLE retail_sales (
    transaction_id    INT PRIMARY KEY,
    sale_date         DATE,
    customer_id       VARCHAR(10),
    gender            VARCHAR(10),
    age               INT,
    product_category  VARCHAR(50),
    quantity          INT,
    price_per_unit    DECIMAL(10,2),
    total_amount      DECIMAL(10,2)
);

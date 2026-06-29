-- ============================================================
-- PROJECT 1: RETAIL SALES ANALYSIS
-- Author: Aman Yadav
-- Tool: PostgreSQL 18 + pgAdmin
-- Date: 2024
-- Description: Analysis of retail store sales data to find
--              revenue trends, top customers, and product performance
-- ============================================================


-- ============================================================
-- SECTION 1: DATABASE SETUP
-- ============================================================

CREATE TABLE retail_customers (
    customer_id   INT PRIMARY KEY,
    name          VARCHAR(100),
    city          VARCHAR(50),
    age           INT,
    gender        VARCHAR(10)
);

CREATE TABLE retail_products (
    product_id    INT PRIMARY KEY,
    product_name  VARCHAR(100),
    category      VARCHAR(50),
    price         INT
);

CREATE TABLE retail_sales (
    sale_id       INT PRIMARY KEY,
    customer_id   INT,
    product_id    INT,
    quantity      INT,
    sale_date     DATE,
    total_amount  INT
);


-- ============================================================
-- SECTION 2: BUSINESS KPI QUERIES
-- ============================================================

-- Q1: Overall Business Summary
-- Purpose: Get a high-level snapshot of business performance
SELECT
    COUNT(DISTINCT customer_id)    AS "Total Customers",
    COUNT(sale_id)                 AS "Total Orders",
    SUM(total_amount)              AS "Total Revenue",
    ROUND(AVG(total_amount))       AS "Avg Order Value",
    MIN(total_amount)              AS "Min Sale",
    MAX(total_amount)              AS "Max Sale"
FROM retail_sales;


-- Q2: Revenue by Category
-- Purpose: Identify which product categories drive most revenue
SELECT
    p.category                                              AS "Category",
    COUNT(s.sale_id)                                        AS "Orders",
    SUM(s.total_amount)                                     AS "Revenue",
    ROUND(SUM(s.total_amount) * 100.0 /
        SUM(SUM(s.total_amount)) OVER(), 1)                AS "Revenue %"
FROM retail_sales s
JOIN retail_products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY "Revenue" DESC;


-- Q3: Top Products by Revenue with Ranking
-- Purpose: Find best and worst performing products
SELECT
    p.product_name                                          AS "Product",
    p.category                                              AS "Category",
    COUNT(s.sale_id)                                        AS "Times Sold",
    SUM(s.quantity)                                         AS "Units Sold",
    SUM(s.total_amount)                                     AS "Revenue",
    ROUND(SUM(s.total_amount) * 100.0 /
        SUM(SUM(s.total_amount)) OVER(), 1)                AS "Revenue %",
    RANK() OVER (ORDER BY SUM(s.total_amount) DESC)        AS "Rank"
FROM retail_sales s
JOIN retail_products p ON s.product_id = p.product_id
GROUP BY p.product_name, p.category, p.product_id
ORDER BY "Revenue" DESC;


-- ============================================================
-- SECTION 3: CUSTOMER ANALYSIS
-- ============================================================

-- Q4: Top Customers by Total Spend
-- Purpose: Identify VIP customers for loyalty programs
SELECT
    c.name                                                  AS "Customer",
    c.city                                                  AS "City",
    c.gender                                                AS "Gender",
    COUNT(s.sale_id)                                        AS "Orders",
    SUM(s.total_amount)                                     AS "Total Spent",
    ROUND(AVG(s.total_amount))                              AS "Avg Order",
    RANK() OVER (ORDER BY SUM(s.total_amount) DESC)        AS "Rank"
FROM retail_customers c
JOIN retail_sales s ON c.customer_id = s.customer_id
GROUP BY c.name, c.city, c.gender, c.customer_id
ORDER BY "Total Spent" DESC;


-- Q5: Gender-wise Sales Analysis
-- Purpose: Understand buying patterns by gender
SELECT
    c.gender                                                AS "Gender",
    COUNT(DISTINCT c.customer_id)                          AS "Customers",
    COUNT(s.sale_id)                                        AS "Orders",
    SUM(s.total_amount)                                     AS "Revenue",
    ROUND(AVG(s.total_amount))                              AS "Avg Spend"
FROM retail_customers c
JOIN retail_sales s ON c.customer_id = s.customer_id
GROUP BY c.gender
ORDER BY "Revenue" DESC;


-- Q6: City-wise Performance
-- Purpose: Identify top performing cities for regional strategy
SELECT
    c.city                                                  AS "City",
    COUNT(DISTINCT c.customer_id)                          AS "Customers",
    COUNT(s.sale_id)                                        AS "Orders",
    SUM(s.total_amount)                                     AS "Revenue",
    ROUND(AVG(s.total_amount))                              AS "Avg Order"
FROM retail_customers c
JOIN retail_sales s ON c.customer_id = s.customer_id
GROUP BY c.city
ORDER BY "Revenue" DESC;


-- Q7: Customers Who Purchased Laptops (High Value Segment)
-- Purpose: Identify premium customers for upsell opportunities
SELECT
    c.name                                                  AS "Customer",
    c.city                                                  AS "City",
    s.sale_date                                             AS "Purchase Date",
    s.total_amount                                          AS "Amount"
FROM retail_customers c
JOIN retail_sales s    ON c.customer_id = s.customer_id
JOIN retail_products p ON s.product_id  = p.product_id
WHERE p.product_name = 'Laptop'
ORDER BY s.sale_date;


-- ============================================================
-- SECTION 4: TIME-SERIES ANALYSIS
-- ============================================================

-- Q8: Monthly Revenue Trend
-- Purpose: Track revenue performance over time
SELECT
    TO_CHAR(sale_date, 'YYYY-MM')                          AS "Month",
    COUNT(sale_id)                                          AS "Orders",
    SUM(total_amount)                                       AS "Revenue",
    ROUND(AVG(total_amount))                               AS "Avg Sale"
FROM retail_sales
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY "Month";


-- Q9: Month-over-Month Revenue Growth
-- Purpose: Calculate revenue growth percentage each month
WITH monthly_revenue AS (
    SELECT
        TO_CHAR(sale_date, 'YYYY-MM')                      AS month,
        SUM(total_amount)                                   AS revenue
    FROM retail_sales
    GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
)
SELECT
    month                                                   AS "Month",
    revenue                                                 AS "Revenue",
    LAG(revenue) OVER (ORDER BY month)                     AS "Prev Month Revenue",
    revenue - LAG(revenue) OVER (ORDER BY month)           AS "Growth (Absolute)",
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY month))
        * 100.0
        / LAG(revenue) OVER (ORDER BY month), 1
    )                                                       AS "Growth %"
FROM monthly_revenue
ORDER BY month;


-- Q10: Best Day of Week for Sales
-- Purpose: Optimize marketing campaigns by day
SELECT
    TO_CHAR(sale_date, 'Day')                              AS "Day",
    COUNT(sale_id)                                          AS "Orders",
    SUM(total_amount)                                       AS "Revenue"
FROM retail_sales
GROUP BY TO_CHAR(sale_date, 'Day')
ORDER BY "Revenue" DESC;


-- ============================================================
-- SECTION 5: ADVANCED ANALYSIS
-- ============================================================

-- Q11: Customer Purchase Frequency (Returning vs One-time)
-- Purpose: Measure customer loyalty and retention
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time Buyer'
        WHEN order_count = 2 THEN 'Returning Buyer'
        ELSE 'Loyal Customer'
    END                                                     AS "Customer Type",
    COUNT(*)                                                AS "Count"
FROM (
    SELECT customer_id, COUNT(sale_id) AS order_count
    FROM retail_sales
    GROUP BY customer_id
) AS customer_orders
GROUP BY
    CASE
        WHEN order_count = 1 THEN 'One-time Buyer'
        WHEN order_count = 2 THEN 'Returning Buyer'
        ELSE 'Loyal Customer'
    END;


-- Q12: Product Performance by City (Window Function)
-- Purpose: Find top product in each city
WITH city_product AS (
    SELECT
        c.city                                              AS city,
        p.product_name                                      AS product,
        SUM(s.total_amount)                                AS revenue,
        RANK() OVER (
            PARTITION BY c.city
            ORDER BY SUM(s.total_amount) DESC
        )                                                   AS city_rank
    FROM retail_sales s
    JOIN retail_customers c ON s.customer_id = c.customer_id
    JOIN retail_products p  ON s.product_id  = p.product_id
    GROUP BY c.city, p.product_name
)
SELECT city AS "City", product AS "Top Product", revenue AS "Revenue"
FROM city_product
WHERE city_rank = 1
ORDER BY revenue DESC;


-- ============================================================
-- END OF QUERIES
-- ============================================================

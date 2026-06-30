-- ============================================================
-- PROJECT 2: E-COMMERCE CUSTOMER ANALYTICS
-- Author: Aman Yadav
-- Tool: PostgreSQL 18 + pgAdmin
-- Description: Customer Lifetime Value, Churn Detection, and
--              RFM Segmentation for an e-commerce business
-- ============================================================


-- ============================================================
-- SECTION 1: DATABASE SETUP
-- ============================================================

CREATE TABLE ecom2_customers (
    customer_id   INT PRIMARY KEY,
    name          VARCHAR(100),
    city          VARCHAR(50),
    signup_date   DATE
);

CREATE TABLE ecom2_orders (
    order_id      INT PRIMARY KEY,
    customer_id   INT,
    order_date    DATE,
    amount        INT,
    status        VARCHAR(20)
);


-- ============================================================
-- SECTION 2: CUSTOMER LIFETIME VALUE (CLV)
-- ============================================================

-- Q1: Customer Lifetime Value Ranking
-- Purpose: Identify highest-value customers for the business
SELECT
    c.name                                        AS "Customer",
    c.city                                         AS "City",
    COUNT(o.order_id)                             AS "Total Orders",
    SUM(o.amount)                                  AS "CLV (Total Spent)",
    ROUND(AVG(o.amount))                          AS "Avg Order Value",
    RANK() OVER (ORDER BY SUM(o.amount) DESC)    AS "Rank"
FROM ecom2_customers c
JOIN ecom2_orders o ON c.customer_id = o.customer_id
GROUP BY c.name, c.city, c.customer_id
ORDER BY "CLV (Total Spent)" DESC;


-- Q2: Customer Purchase Journey (First to Last Order)
-- Purpose: Understand how long customers stay engaged
SELECT
    c.name                                         AS "Customer",
    MIN(o.order_date)                             AS "First Purchase",
    MAX(o.order_date)                             AS "Last Purchase",
    MAX(o.order_date) - MIN(o.order_date)         AS "Customer Lifespan (days)",
    COUNT(o.order_id)                             AS "Total Orders"
FROM ecom2_customers c
JOIN ecom2_orders o ON c.customer_id = o.customer_id
GROUP BY c.name, c.customer_id
ORDER BY "Customer Lifespan (days)" DESC;


-- ============================================================
-- SECTION 3: CHURN DETECTION
-- ============================================================

-- Q3: Customer Churn Status
-- Purpose: Identify Active, At Risk, and Churned customers
-- NOTE: Using DATE '2024-07-01' as reference point since dataset
--       spans Nov 2023 - Jun 2024. Using CURRENT_DATE would be
--       incorrect for historical/snapshot datasets.
SELECT
    c.name                                                       AS "Customer",
    MAX(o.order_date)                                           AS "Last Order Date",
    DATE '2024-07-01' - MAX(o.order_date)                       AS "Days Since Last Order",
    CASE
        WHEN DATE '2024-07-01' - MAX(o.order_date) <= 30  THEN 'Active'
        WHEN DATE '2024-07-01' - MAX(o.order_date) <= 90  THEN 'At Risk'
        ELSE 'Churned'
    END                                                          AS "Status"
FROM ecom2_customers c
JOIN ecom2_orders o ON c.customer_id = o.customer_id
GROUP BY c.name, c.customer_id
ORDER BY "Days Since Last Order" DESC;


-- ============================================================
-- SECTION 4: RFM CUSTOMER SEGMENTATION
-- ============================================================

-- Q4: RFM Segmentation (Recency, Frequency, Monetary)
-- Purpose: Industry-standard customer segmentation for targeted marketing
SELECT
    c.name                                                       AS "Customer",
    DATE '2024-07-01' - MAX(o.order_date)                       AS "Recency (days)",
    COUNT(o.order_id)                                            AS "Frequency",
    SUM(o.amount)                                                AS "Monetary",
    CASE
        WHEN COUNT(o.order_id) >= 4 AND SUM(o.amount) >= 20000 THEN 'Champion'
        WHEN COUNT(o.order_id) >= 2 AND SUM(o.amount) >= 5000  THEN 'Loyal'
        WHEN DATE '2024-07-01' - MAX(o.order_date) > 90        THEN 'Lost'
        ELSE 'New/Occasional'
    END                                                          AS "Segment"
FROM ecom2_customers c
JOIN ecom2_orders o ON c.customer_id = o.customer_id
GROUP BY c.name, c.customer_id
ORDER BY "Monetary" DESC;


-- Q5: Segment Summary (Count & Revenue per Segment)
-- Purpose: High-level view for marketing budget allocation
WITH rfm AS (
    SELECT
        c.customer_id,
        c.name,
        DATE '2024-07-01' - MAX(o.order_date) AS recency,
        COUNT(o.order_id)                      AS frequency,
        SUM(o.amount)                          AS monetary
    FROM ecom2_customers c
    JOIN ecom2_orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name
),
segmented AS (
    SELECT
        *,
        CASE
            WHEN frequency >= 4 AND monetary >= 20000 THEN 'Champion'
            WHEN frequency >= 2 AND monetary >= 5000  THEN 'Loyal'
            WHEN recency > 90                          THEN 'Lost'
            ELSE 'New/Occasional'
        END AS segment
    FROM rfm
)
SELECT
    segment                              AS "Segment",
    COUNT(*)                             AS "Customer Count",
    SUM(monetary)                        AS "Total Revenue",
    ROUND(AVG(monetary))                 AS "Avg CLV"
FROM segmented
GROUP BY segment
ORDER BY "Total Revenue" DESC;


-- ============================================================
-- END OF QUERIES
-- ============================================================

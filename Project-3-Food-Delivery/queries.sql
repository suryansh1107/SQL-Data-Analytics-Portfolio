-- ============================================================
-- PROJECT 3: FOOD DELIVERY BUSINESS ANALYSIS
-- Author: Aman Yadav
-- Tool: PostgreSQL 18 + pgAdmin
-- Description: Order funnel, delivery time, and peak hour
--              analysis for a food delivery platform
-- ============================================================


-- ============================================================
-- SECTION 1: DATABASE SETUP
-- ============================================================

CREATE TABLE fd_restaurants (
    restaurant_id   INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    cuisine_type    VARCHAR(50),
    city            VARCHAR(50)
);

CREATE TABLE fd_orders (
    order_id        INT PRIMARY KEY,
    restaurant_id   INT,
    customer_name   VARCHAR(100),
    order_time      TIMESTAMP,
    delivery_time   TIMESTAMP,
    status          VARCHAR(20),
    amount          INT
);


-- ============================================================
-- SECTION 2: ORDER FUNNEL ANALYSIS
-- ============================================================

-- Q1: Order Status Breakdown (Funnel Overview)
-- Purpose: Understand conversion at each stage of the order funnel
SELECT
    status                                              AS "Status",
    COUNT(*)                                            AS "Orders",
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1)  AS "Percentage"
FROM fd_orders
GROUP BY status
ORDER BY "Orders" DESC;


-- Q2: Cancellation Rate by Restaurant
-- Purpose: Identify restaurants with operational issues
-- NOTE: Watch for small sample size bias - see Q7 for filtered version
SELECT
    r.restaurant_name                                                    AS "Restaurant",
    COUNT(o.order_id)                                                    AS "Total Orders",
    COUNT(CASE WHEN o.status = 'Cancelled' THEN 1 END)                  AS "Cancelled",
    ROUND(
        COUNT(CASE WHEN o.status = 'Cancelled' THEN 1 END) * 100.0
        / COUNT(o.order_id), 1
    )                                                                     AS "Cancellation Rate %"
FROM fd_restaurants r
JOIN fd_orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_name
ORDER BY "Cancellation Rate %" DESC;


-- ============================================================
-- SECTION 3: DELIVERY TIME ANALYSIS
-- ============================================================

-- Q3: Overall Average Delivery Time
-- Purpose: Baseline operational metric
SELECT
    ROUND(AVG(
        EXTRACT(EPOCH FROM (delivery_time - order_time)) / 60
    ))                                                                    AS "Avg Delivery Time (mins)"
FROM fd_orders
WHERE status = 'Delivered';


-- Q4: Delivery Time per Restaurant (Speed Ranking)
-- Purpose: Identify fastest and slowest restaurants for operational benchmarking
SELECT
    r.restaurant_name                                                    AS "Restaurant",
    COUNT(o.order_id)                                                    AS "Delivered Orders",
    ROUND(AVG(
        EXTRACT(EPOCH FROM (o.delivery_time - o.order_time)) / 60
    ))                                                                    AS "Avg Delivery Time (mins)"
FROM fd_restaurants r
JOIN fd_orders o ON r.restaurant_id = o.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY r.restaurant_name
ORDER BY "Avg Delivery Time (mins)" ASC;


-- ============================================================
-- SECTION 4: PEAK HOURS ANALYSIS
-- ============================================================

-- Q5: Peak Order Hours
-- Purpose: Identify busiest hours for staffing decisions
SELECT
    EXTRACT(HOUR FROM order_time)        AS "Hour",
    COUNT(*)                             AS "Orders",
    SUM(amount)                          AS "Revenue"
FROM fd_orders
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY "Orders" DESC;


-- Q6: Lunch vs Dinner Revenue Comparison
-- Purpose: Compare meal-time performance for marketing/staffing
SELECT
    CASE
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 11 AND 15 THEN 'Lunch'
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 18 AND 22 THEN 'Dinner'
        ELSE 'Other'
    END                                   AS "Meal Time",
    COUNT(*)                              AS "Orders",
    SUM(amount)                           AS "Revenue",
    ROUND(AVG(amount))                    AS "Avg Order Value"
FROM fd_orders
GROUP BY
    CASE
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 11 AND 15 THEN 'Lunch'
        WHEN EXTRACT(HOUR FROM order_time) BETWEEN 18 AND 22 THEN 'Dinner'
        ELSE 'Other'
    END
ORDER BY "Revenue" DESC;


-- ============================================================
-- SECTION 5: STATISTICALLY RELIABLE COMPARISONS
-- ============================================================

-- Q7: Restaurant Reliability Comparison (Minimum Sample Size Filter)
-- Purpose: Avoid drawing conclusions from restaurants with too few orders
-- LESSON: A restaurant with 1 order and 1 cancellation shows 100%
--         cancellation rate, but this is NOT a reliable signal.
--         Filtering for 2+ orders gives more trustworthy insights.
SELECT
    r.restaurant_name                                                    AS "Restaurant",
    COUNT(o.order_id)                                                    AS "Total Orders",
    COUNT(CASE WHEN o.status = 'Cancelled' THEN 1 END)                  AS "Cancelled",
    ROUND(
        COUNT(CASE WHEN o.status = 'Cancelled' THEN 1 END) * 100.0
        / COUNT(o.order_id), 1
    )                                                                     AS "Cancel Rate %"
FROM fd_restaurants r
JOIN fd_orders o ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_name
HAVING COUNT(o.order_id) >= 2
ORDER BY "Cancel Rate %" DESC;


-- ============================================================
-- END OF QUERIES
-- ============================================================

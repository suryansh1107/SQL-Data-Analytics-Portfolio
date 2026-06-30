-- ============================================================
-- PROJECT 4: NETFLIX DATA ANALYSIS
-- Author: Aman Yadav
-- Tool: PostgreSQL 18 + pgAdmin
-- Description: Content catalog analysis - genre trends, country
--              distribution, and release year patterns
-- ============================================================


-- ============================================================
-- SECTION 1: DATABASE SETUP
-- ============================================================

CREATE TABLE netflix_content (
    show_id        INT PRIMARY KEY,
    title          VARCHAR(150),
    type           VARCHAR(20),
    genre          VARCHAR(100),
    country        VARCHAR(50),
    release_year   INT,
    rating         VARCHAR(10),
    duration       VARCHAR(20)
);


-- ============================================================
-- SECTION 2: CONTENT TYPE ANALYSIS
-- ============================================================

-- Q1: Movies vs TV Shows Ratio
-- Purpose: Understand the platform's content format split
SELECT
    type                                                AS "Content Type",
    COUNT(*)                                             AS "Count",
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1)   AS "Percentage"
FROM netflix_content
GROUP BY type
ORDER BY "Count" DESC;


-- Q2: Top Genres
-- Purpose: Identify dominant content categories
SELECT
    genre                                                AS "Genre",
    COUNT(*)                                             AS "Count",
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1)   AS "Percentage"
FROM netflix_content
GROUP BY genre
ORDER BY "Count" DESC;


-- Q3: Content Count by Country (with Movie/TV breakdown)
-- Purpose: Assess geographic content sourcing
SELECT
    country                                              AS "Country",
    COUNT(*)                                             AS "Total Content",
    COUNT(CASE WHEN type = 'Movie' THEN 1 END)           AS "Movies",
    COUNT(CASE WHEN type = 'TV Show' THEN 1 END)         AS "TV Shows"
FROM netflix_content
GROUP BY country
ORDER BY "Total Content" DESC;


-- ============================================================
-- SECTION 3: TIME TREND ANALYSIS
-- ============================================================

-- Q4: Content Count by Decade
-- Purpose: Understand catalog age distribution
SELECT
    CASE
        WHEN release_year < 2000 THEN '1990s'
        WHEN release_year < 2010 THEN '2000s'
        WHEN release_year < 2020 THEN '2010s'
        ELSE '2020s'
    END                                                   AS "Decade",
    COUNT(*)                                              AS "Content Count"
FROM netflix_content
GROUP BY
    CASE
        WHEN release_year < 2000 THEN '1990s'
        WHEN release_year < 2010 THEN '2000s'
        WHEN release_year < 2020 THEN '2010s'
        ELSE '2020s'
    END
ORDER BY "Decade";


-- Q5: Rating Distribution
-- Purpose: Understand audience targeting (mature vs family content)
SELECT
    rating                                                AS "Rating",
    COUNT(*)                                              AS "Count"
FROM netflix_content
GROUP BY rating
ORDER BY "Count" DESC;


-- ============================================================
-- SECTION 4: ADVANCED TEXT AGGREGATION
-- ============================================================

-- Q6: Crime Titles Grouped by Country (STRING_AGG)
-- Purpose: Demonstrate combining multiple rows into a single readable string
SELECT
    country                                               AS "Country",
    STRING_AGG(title, ', ')                              AS "Crime Titles"
FROM netflix_content
WHERE genre = 'Crime'
GROUP BY country
ORDER BY country;


-- Q7: Genre Summary with Full Title List (filtered for reliability)
-- Purpose: Report-style summary showing genre dominance with example titles
-- NOTE: HAVING COUNT(*) >= 2 filters out single-title genres to avoid
--       drawing conclusions from one-off content (similar to Project 3's
--       sample-size lesson)
SELECT
    genre                                                 AS "Genre",
    COUNT(*)                                              AS "Total Titles",
    STRING_AGG(title, ', ' ORDER BY title)               AS "All Titles"
FROM netflix_content
GROUP BY genre
HAVING COUNT(*) >= 2
ORDER BY "Total Titles" DESC;


-- ============================================================
-- END OF QUERIES
-- ============================================================

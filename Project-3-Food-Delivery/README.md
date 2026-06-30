# 🍕 Project 3: Food Delivery Business Analysis

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-blue)
![Status](https://img.shields.io/badge/Status-Completed-green)
![Tool](https://img.shields.io/badge/Tool-pgAdmin%204-orange)

## 📌 Business Problem

A food delivery platform (similar to Zomato/Swiggy) needs operational insights:

- What percentage of orders get cancelled?
- What is the average delivery time, and which restaurants are fastest/slowest?
- When are peak ordering hours — lunch or dinner?
- Which restaurants have a genuine cancellation problem (vs. a small-sample fluke)?

## 🗄️ Dataset Overview

| Table | Rows | Description |
|-------|------|-------------|
| `fd_restaurants` | 8 | Restaurant info (name, cuisine, city) |
| `fd_orders` | 25 | Orders with timestamps and status |

**Order Statuses:** Delivered, Cancelled, Placed  
**Time Period:** June 1–6, 2024

## 🛠️ Tools Used

- **PostgreSQL 18** + **pgAdmin 4**
- **SQL Concepts:** CASE WHEN counting, `EXTRACT(EPOCH FROM ...)` for time math, `EXTRACT(HOUR FROM ...)` for hour grouping, conditional aggregation, HAVING for sample-size filtering

## 📊 Key Findings

### 🔄 Order Funnel
| Status | Orders | % |
|--------|--------|---|
| Delivered | 19 | 76% |
| Cancelled | 4 | 16% |
| Placed (in progress) | 2 | 8% |

A 16% cancellation rate is within typical industry range (10–20%) but worth monitoring.

### ⚡ Delivery Speed
- **Overall average delivery time:** 42 minutes
- **Fastest restaurant:** Pizza Paradise (~42 min avg, 5 orders — reliable sample)

### 📅 Lunch vs Dinner
| Meal Time | Orders | Revenue | Avg Order |
|-----------|--------|---------|-----------|
| Dinner | — | ₹6,350 | — |
| Lunch | — | ₹6,330 | — |

**Insight:** Lunch and dinner revenue are nearly identical (₹20 difference) — both time slots deserve equal staffing and marketing focus.

### ⚠️ Restaurant Reliability Check (Min. 2 Orders)
| Restaurant | Orders | Cancelled | Cancel Rate |
|------------|--------|-----------|--------------|
| Spice Junction | 5 | 2 | **40%** |
| Burger Barn | 3 | 1 | 33% |
| Curry Corner | 2 | 0 | 0% |

## 🔍 Critical Data Analyst Lesson — Sample Size Bias

**Pasta Palace** showed a 100% cancellation rate in raw analysis (1 order, 1 cancellation). However, with only 1 total order, this is **statistically unreliable** — a single data point cannot establish a trend.

After filtering for restaurants with **2+ orders** (Q7), **Spice Junction** emerges as the genuine concern with a 40% cancellation rate across 5 orders — a much more trustworthy signal.

> **Takeaway:** Always check sample size before drawing conclusions from percentage-based metrics. This is a common interview topic in data analytics.

## 💡 Recommendations

1. **Investigate Spice Junction** — 40% cancellation rate (5 orders) needs root-cause analysis (stock issues? wrong orders? slow confirmation?)
2. **Benchmark Against Pizza Paradise** — Use their delivery process as the operational standard for other restaurants.
3. **Equal Investment in Lunch & Dinner** — Since revenue is nearly equal, don't over-allocate marketing budget to one slot.
4. **Set Minimum Sample Thresholds** — Any restaurant performance metric should require a minimum order count (e.g., 5+) before action is taken.

## 📁 Project Structure

```
Project-3-Food-Delivery/
├── README.md
└── queries.sql
```

## 👤 Author

**Suryansh Diswar** | Data Analytics Learner | SQL | PostgreSQL

---
*Part of my SQL Data Analytics Portfolio*

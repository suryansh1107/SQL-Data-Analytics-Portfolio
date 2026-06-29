# 🛒 Project 1: Retail Sales Analysis

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-blue)
![Status](https://img.shields.io/badge/Status-Completed-green)
![Tool](https://img.shields.io/badge/Tool-pgAdmin%204-orange)

## 📌 Business Problem

A retail store wants to understand its sales performance across 7 months (January–July 2024). The management needs answers to:

- What is the total revenue and average order value?
- Which products and categories generate the most revenue?
- Who are the top customers (VIP segment)?
- How has revenue trended month over month?
- Which days and months perform best?

## 🗄️ Dataset Overview

| Table | Rows | Description |
|-------|------|-------------|
| `retail_customers` | 10 | Customer demographics (name, city, age, gender) |
| `retail_products` | 12 | Product catalog (name, category, price) |
| `retail_sales` | 30 | Transaction records (date, quantity, amount) |

**Categories:** Electronics, Clothing, Food, Sports, Books  
**Time Period:** January 2024 – July 2024  
**Cities:** Agra, Delhi, Mumbai, Pune, Jaipur, Chennai, Bangalore, Hyderabad

## 🛠️ Tools Used

- **PostgreSQL 18** — Database & Query Engine
- **pgAdmin 4** — Query Tool
- **SQL Concepts Used:** JOINs, GROUP BY, Window Functions (RANK, LAG), CTEs, Subqueries, CASE WHEN, Aggregations

## 📊 Key Findings

### 💰 Revenue Summary
| Metric | Value |
|--------|-------|
| Total Revenue | ₹5,29,400 |
| Total Orders | 30 |
| Avg Order Value | ₹17,647 |
| Best Month | May 2024 — ₹91,000 |
| Worst Month | March 2024 — ₹34,400 |

### 🏆 Top 3 Products
| Rank | Product | Revenue | Revenue % |
|------|---------|---------|-----------|
| 1 | Laptop | ₹3,30,000 | 62.3% |
| 2 | Smartphone | ₹1,25,000 | 23.6% |
| 3 | Headphones | ₹21,000 | 4.0% |

### 👥 Top 3 Customers (VIP Segment)
| Rank | Customer | City | Total Spent |
|------|----------|------|-------------|
| 1 | Aman Yadav | Agra | ₹88,000 |
| 2 | Anjali Singh | Hyderabad | ₹80,900 |
| 3 | Sneha Gupta | Pune | ₹68,500 |

### 📅 Best Day for Sales
| Day | Orders | Revenue |
|-----|--------|---------|
| **Friday** | 11 | ₹2,84,400 |
| Saturday | 8 | ₹1,03,200 |
| Thursday | 6 | ₹23,800 |

## 🔍 Business Insights & Recommendations

1. **Electronics Dominates** — Electronics category contributes ~90% of total revenue. Focus inventory and marketing on Electronics.

2. **Laptop = Cash Cow** — Laptop alone contributes 62.3% of revenue. Ensure stock availability and consider EMI options to boost sales.

3. **VIP Customer Program** — Top 3 customers (Aman, Anjali, Sneha) contribute 44% of revenue. Create a loyalty/VIP program for them.

4. **March Crash Investigation** — March saw a -61.2% revenue drop. Needs investigation — was there a stock issue or low marketing spend?

5. **Friday Marketing** — 37% of all orders happen on Friday. Run special Friday offers or flash sales to maximize revenue.

6. **Books & Food Underperform** — These categories generate less than 2% of revenue combined. Consider discontinuing or reducing SKUs.

## 📁 Project Structure

```
Project-1-Retail-Sales/
│
├── README.md          ← You are here
├── queries.sql        ← All 12 SQL queries with comments
└── insights.md        ← Detailed business recommendations
```

## 🚀 How to Run

1. Open **pgAdmin 4**
2. Connect to your PostgreSQL server
3. Create a new database: `retail_analysis`
4. Open `queries.sql` in Query Tool
5. Run **Section 1** first (Database Setup)
6. Then run each query section

## 👤 Author

**Aman Yadav**  
Data Analytics Learner | SQL | PostgreSQL  
📍 Agra, India

---
*This project is part of my SQL Data Analytics Portfolio*

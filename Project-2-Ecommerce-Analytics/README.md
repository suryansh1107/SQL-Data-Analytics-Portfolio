# 🛍️ Project 2: E-commerce Customer Analytics

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-blue)
![Status](https://img.shields.io/badge/Status-Completed-green)
![Tool](https://img.shields.io/badge/Tool-pgAdmin%204-orange)

## 📌 Business Problem

An e-commerce company wants to understand customer behavior and reduce churn. Management needs answers to:

- What is each customer's Lifetime Value (CLV)?
- Which customers are at risk of churning?
- How can we segment customers for targeted marketing?
- Who are our most valuable but currently inactive customers?

## 🗄️ Dataset Overview

| Table | Rows | Description |
|-------|------|-------------|
| `ecom2_customers` | 12 | Customer info (name, city, signup date) |
| `ecom2_orders` | 35 | Order history (date, amount, status) |

**Time Period:** November 2023 – June 2024

## 🛠️ Tools Used

- **PostgreSQL 18** + **pgAdmin 4**
- **SQL Concepts:** Window Functions (RANK), CTEs, Date Arithmetic, CASE WHEN Segmentation, Aggregations

## 📊 Key Findings

### 💎 Top 3 Customers by CLV
| Rank | Customer | Orders | CLV |
|------|----------|--------|-----|
| 1 | Rahul Verma | 6 | ₹39,300 |
| 2 | Aman Yadav | 6 | ₹31,200 |
| 3 | Anjali Singh | 4 | ₹22,000 |

### 🚦 Churn Status Breakdown
| Status | Count | Customers |
|--------|-------|-----------|
| 🟢 Active (≤30 days) | 3 | Aman, Ravi, Anjali |
| 🟡 At Risk (31-90 days) | 4 | Rahul, Vikram, Arjun, Divya |
| 🔴 Churned (90+ days) | 5 | Priya, Neha, Sneha, Pooja, Karan |

### 🏆 RFM Customer Segments
| Segment | Count | Total Revenue | Avg CLV |
|---------|-------|----------------|---------|
| Champion | 4 | ₹1,13,900 | ₹28,475 |
| Loyal | 3 | ₹32,500 | ₹10,833 |
| Lost | 4 | ₹17,600 | ₹4,400 |
| New/Occasional | 1 | ₹4,100 | ₹4,100 |

## 🔍 Critical Business Insight

**⚠️ Rahul Verma — our highest CLV customer (₹39,300) — is now classified as "At Risk" (32 days inactive).**

This is a high-priority retention case: losing our top spender would have the largest revenue impact of any single customer churn event.

## 💡 Recommendations

1. **Urgent Win-Back for Rahul** — Personal outreach with exclusive offer; he's our #1 customer going quiet.
2. **Champion Retention** — VIP program for the 4 Champions (₹1,13,900 combined revenue = 67% of total).
3. **Lost Customer Campaign** — 5 churned customers represent ₹17,600 in dormant value; targeted discount email could reactivate.
4. **Reference Date Methodology** — Used `2024-07-01` as analysis reference point instead of `CURRENT_DATE` since this is historical/snapshot data — an important practice for accurate time-based analysis.

## 📁 Project Structure

```
Project-2-Ecommerce-Analytics/
├── README.md
└── queries.sql
```

## 👤 Author

**Aman Yadav** | Data Analytics Learner | SQL | PostgreSQL

---
*Part of my SQL Data Analytics Portfolio*

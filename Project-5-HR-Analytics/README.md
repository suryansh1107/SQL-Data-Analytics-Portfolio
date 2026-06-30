# 👥 Project 5: HR Analytics Dashboard

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-blue)
![Status](https://img.shields.io/badge/Status-Completed-green)
![Tool](https://img.shields.io/badge/Tool-pgAdmin%204-orange)

## 📌 Business Problem

An organization wants to understand workforce trends, monitor employee attrition, and evaluate compensation across departments. HR management needs insights to improve employee retention and support workforce planning.

Key business questions:

- What is the overall employee attrition rate?
- Which departments experience the highest attrition?
- How do salaries compare across departments?
- How are employees distributed by tenure?
- Does employee tenure influence attrition?

---

## 🗄️ Dataset Overview

| Table | Description |
|-------|-------------|
| `hr_employees` | Employee details including department, salary, joining date, exit date, and employment status |

### Main Columns

- Employee ID
- Employee Name
- Department
- Salary
- Join Date
- Exit Date
- Employment Status

---

## 🛠️ Tools Used

- PostgreSQL 18
- pgAdmin 4

---

## 📊 SQL Concepts Used

- Aggregate Functions
- CASE WHEN
- Window Functions (`NTILE`)
- GROUP BY
- ORDER BY
- Date Arithmetic
- COALESCE
- Percentage Calculations

---

## 📈 Analysis Performed

### 1️⃣ Attrition Analysis

- Overall Attrition Rate
- Department-wise Attrition Rate

### 2️⃣ Salary Analysis

- Average Salary by Department
- Minimum & Maximum Salary
- Salary Quartile Segmentation using `NTILE()`

### 3️⃣ Tenure Analysis

- Employee Tenure Buckets
- Average Tenure Comparison (Active vs Left Employees)

---

## 💡 Business Insights

- Identified departments with the highest employee turnover.
- Compared salary distribution across departments.
- Segmented employees into salary quartiles for compensation review.
- Analyzed workforce experience using tenure buckets.
- Compared average tenure between active and former employees to identify retention trends.

---

## 🎯 Business Recommendations

- Investigate departments with high attrition and implement retention strategies.
- Review compensation in departments with below-average salaries.
- Create targeted engagement programs for employees within their first few years.
- Monitor salary quartiles to ensure fair and competitive compensation.
- Use tenure insights to improve employee retention planning.

---

## 📁 Project Structure

```
Project-5-HR-Analytics/
├── README.md
└── queries.sql
```

---

## 👤 Author

**Suryansh Diswar**

Data Analytics Learner | SQL | PostgreSQL

---

⭐ If you found this project useful, feel free to star the repository!

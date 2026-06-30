# 🎬 Project 4: Netflix Data Analysis

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-blue)
![Status](https://img.shields.io/badge/Status-Completed-green)
![Tool](https://img.shields.io/badge/Tool-pgAdmin%204-orange)

## 📌 Business Problem

Netflix's content strategy team wants to understand their catalog composition:

- What is the Movies vs TV Shows ratio?
- Which genres dominate the platform?
- Which countries contribute the most content?
- How has content release trended across decades?
- What is the audience rating distribution?

## 🗄️ Dataset Overview

| Table | Rows | Description |
|-------|------|-------------|
| `netflix_content` | 25 | Title catalog (type, genre, country, year, rating) |

**Content Types:** Movie, TV Show  
**Genres:** Crime, Drama, Sci-Fi, Action, Horror, Comedy, Animation, Fantasy  
**Countries:** United States, India, South Korea, UK, Spain, Germany, France

## 🛠️ Tools Used

- **PostgreSQL 18** + **pgAdmin 4**
- **SQL Concepts:** `STRING_AGG()` for text aggregation, CASE-based decade grouping, conditional counting, HAVING for reliability filtering

## 📊 Key Findings

### 🎭 Content Type Split
| Type | Count | % |
|------|-------|---|
| TV Shows | 13 | 52% |
| Movies | 12 | 48% |

A near-even split shows balanced investment in both formats.

### 🏆 Top Genres
| Genre | Titles | % |
|-------|--------|---|
| Crime | 8 | 32% |
| Drama | 4 | 16% |
| Sci-Fi | 3 | 12% |
| Action | 3 | 12% |
| Horror | 2 | 8% |

**Crime is the dominant genre**, contributing nearly 1 in 3 titles.

### 🌍 Country Distribution
| Country | Total | Movies | TV Shows |
|---------|-------|--------|----------|
| United States | 16 | 11 | 5 |
| India | 2 | 0 | 2 |
| South Korea | 2 | 1 | 1 |
| United Kingdom | 2 | 0 | 2 |
| Spain, Germany, France | 1 each | — | — |

**64% of content originates from the United States** — a heavy domestic concentration.

### ⭐ Rating Distribution
TV-MA is the most common rating (11 titles), reflecting a catalog skewed toward mature audiences.

## 🔍 Business Insight

Crime genre content brings the most international diversity — titles from India (Sacred Games, Mirzapur), Spain (Money Heist), and France (Lupin) are all in this category. This suggests **Crime is Netflix's most effective genre for global content strategy**, balancing US dominance with international appeal.

## 💡 Recommendations

1. **Expand Crime Genre Investment** — Highest title count AND best country diversity; proven format for both engagement and global reach.
2. **Reduce US Over-Reliance** — 64% concentration is a risk; competitors with more diverse libraries may capture international subscribers.
3. **Leverage TV-MA Success** — Mature content dominates the catalog; consider whether family-friendly content is underrepresented for broader audience reach.
4. **Use Crime as Template for Other Genres** — Study what makes Crime titles (Money Heist, Squid Game-adjacent dramas) successful internationally and replicate for Sci-Fi/Action.

## 📁 Project Structure

```
Project-4-Netflix/
├── README.md
└── queries.sql
```

## 👤 Author

**Suryansh Diswar** | Data Analytics Learner | SQL | PostgreSQL

---
*Part of my SQL Data Analytics Portfolio*

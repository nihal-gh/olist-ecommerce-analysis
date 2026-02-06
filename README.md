# 📦 E-commerce Operational Analytics (Olist Dataset)

## 📌 Project Overview

This project analyzes operational performance in an e-commerce marketplace using the Brazilian **Olist** dataset.
The primary objective is to understand how **seller behavior**, **delivery performance**, **product categories**, and **time trends** impact **revenue** and **customer satisfaction**.

The analysis combines **SQL**, **Python**, and **Power BI** to build an end-to-end analytics workflow, moving from raw transactional data to actionable business insights.

---

## 🛠️ Tech Stack

* **SQL (MySQL)** – data extraction, joins, aggregations
* **Python** – data cleaning, feature engineering, exploratory analysis

  * Pandas, NumPy, Matplotlib
* **Power BI** – data modeling, interactive dashboards
* **Jupyter Notebook** – analysis, machine leaning and experimentation

---

## 📂 Dataset

* Source: Olist Brazilian E-commerce Dataset https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

The dataset represents real marketplace transactions, making it suitable for operational and performance analysis.

---

## 🧱 Data Modeling & Structure

The project uses a **multi-level analytical structure** to avoid mixing different business questions:

* **Fact Table**
  Transactional order-item level data with timestamps

* **Order-Level Table**
  One row per order containing:

  * total price
  * delivery time
  * review score

* **Seller-Level Table**
  Aggregated seller metrics:

  * average delivery time
  * average review score
  * number of orders
  * total revenue

* **Category-Level Table**
  Aggregated metrics by product category:

  * revenue
  * delivery time
  * reviews
  * order volume

This separation allows clear analysis of **who** (sellers), **when** (time trends), and **where** (product categories).

---

## 📊 Dashboard Pages & Analysis

### 🔹 Page 1 — Seller Performance

**Goal:** Identify high-impact sellers and operational risks.

Key points:

* Sellers with very low order volumes were excluded to reduce noise and unstable averages.
* Delivery time and customer reviews were analyzed together to assess seller quality.
* Separate tables highlight **best-performing** and **worst-performing** sellers.

**Insights:**

* High-revenue sellers tend to have slower delivery times.
* Slower delivery is associated with lower review scores.
* A small number of sellers have disproportionate impact on customer experience.

---

### 🔹 Page 2 — Platform & Time Trends

**Goal:** Understand how the platform evolves over time.

Key points:

* Revenue and order volume trends over months.
* Delivery time and review score trends to assess operational health.
* Analysis uses **unfiltered order-level data** to reflect true platform performance.

**Insights:**

* Revenue and orders show seasonal fluctuations.
* Periods of growth coincide with slight declines in customer satisfaction.
* Delivery performance remains relatively stable but directly influences reviews.

---

### 🔹 Page 3 — Category Analysis

**Goal:** Identify product categories that drive revenue and operational challenges.

Key points:

* Revenue concentration across product categories.
* Average delivery time and reviews by category.
* Relationship between delivery difficulty and customer satisfaction.

**Insights:**

* Certain high-revenue categories are also the most difficult to deliver.
* Categories with longer delivery times tend to receive lower reviews.
* Operational issues are category-dependent, not only seller-dependent.

---

## 🔑 Key Business Insights

* **Delivery speed is a major driver of customer satisfaction.**
* **High scale (revenue/orders) often comes with operational trade-offs.**
* **Category characteristics significantly influence delivery performance.**
* **Filtering low-volume entities improves analytical reliability.**

---

## 📌 Modeling & Analysis Decisions

* Sellers with very few orders were excluded from seller-level analysis to avoid noisy averages.
* Seller performance, platform trends, and category analysis were separated into different pages to prevent mixing analytical scopes.
* Time-based trends use unfiltered order data to reflect true platform behavior.
* Aggregated tables were linked via relationships instead of duplicating date fields.

---

## Machine Learning Extension – Delivery Delay Prediction

The goal of this model is to predict whether an order is at risk of late delivery at the time of purchase, using only information available before shipment.
### Target Variable

A binary target `is_late` was created based on delivery time:
- `1` → orders delivered after 15 days (75th percentile)
- `0` → orders delivered within 15 days

This threshold reflects operationally meaningful delays while maintaining class balance.

### Feature Selection

Only features available at order creation time were used to avoid data leakage.

Baseline features:
- Product price
- Delivery cost
- Product category (Top-N grouped)

Additional features tested:
- Seller average delivery time (historical)
- Product weight and volume

Post-delivery attributes such as review scores and actual delivery dates were explicitly excluded.
### Modeling Approach

A Logistic Regression model was used as a baseline due to its interpretability and suitability for tabular data.

Model evaluation focused on recall for late deliveries and ROC-AUC, as missing delayed orders is costlier than false alerts.

### Experimental Results

1. Baseline (order attributes only)
   - ROC-AUC: ~0.65
   - Late delivery recall: ~6%

2. Seller average delivery time
   - ROC-AUC: ~0.71
   - Late delivery recall: ~14%
   - Threshold tuning increased recall to ~24%

3. Product weight and volume
   - No improvement in recall or ROC-AUC
   - Model became more conservative due to redundant signals

### Decision Threshold Tuning

The default classification threshold (0.5) was adjusted to improve recall for late deliveries.
Lowering the threshold increased late-order detection at the cost of additional false positives, highlighting the operational trade-off between alert volume and customer experience risk.

### Key Insights

- Seller historical delivery performance is the strongest predictor of late deliveries.
- Product physical attributes did not add independent predictive power once category and shipping cost were included.
- Threshold selection significantly impacts operational outcomes and must align with business tolerance for false alerts.

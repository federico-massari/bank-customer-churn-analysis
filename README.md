# Bank Customer Churn Analysis

An exploratory SQL analysis of 10,000 bank customer records, identifying the strongest patterns associated with customer churn and testing common banking assumptions against the data.

## Overview

This project investigates which customer characteristics are associated with churn in a retail banking context. Rather than building a predictive model, the analysis follows a hypothesis-driven approach: each query tests a specific business question, and follow-up queries are used to explain unexpected results.

## Dataset

* **Source:** Bank Customer Churn dataset (Kaggle, radheshyamkollipara)
* **Size:** 10,000 rows, 18 columns
* **Target variable:** `Exited` (1 = churned, 0 = retained)
* **Overall churn rate:** 20.4%

## Tools

* SQL (SQLite / DBeaver) for data exploration and analysis
* Tableau Public for visualization

## Dashboard

[View the interactive dashboard on Tableau Public](https://public.tableau.com/views/BankCustomerChurnAnalysis_17885378448070/BankCustomerChurnKeyDrivers?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

## Approach

* Categorical ranges (balance, age) were defined before reviewing results, based on standard business logic, to avoid fitting categories to observed patterns.
* Each hypothesis is stated before the corresponding query.
* Follow-up queries were added only when an initial result raised a further question (e.g. product count and geography).
* The analysis is descriptive and observational. It does not establish causality and does not build a predictive model.

## Key Insights

**1. Number of products shows the strongest churn pattern**

Customers with exactly 2 products have the lowest churn rate observed (7.6%). Churn rises to 82.71% for customers with 3 products and 100% for customers with 4 products. The relationship is non-linear and does not support the common assumption that holding more products is associated with lower churn.

**2. Germany's churn rate is partly associated with a higher concentration of high-product customers**

Germany's churn rate (32.44%) is roughly double that of France and Spain (~16%). Germany also has a higher proportion of customers holding 3+ products (4.78% of its base, vs. 2.65% in France and 2.95% in Spain), which may account for part of the observed difference between countries.

**3. Balance shows a non-linear relationship with churn**

Customers with low balances (€0-50K) have the highest observed churn rate (34.67%), while zero-balance customers show a lower rate (13.82%). High-balance customers (23.12%) fall between these two groups.

**4. Active members show a lower churn rate than inactive members**

14.27% for active members vs. 26.87% for inactive members, indicating an association between activity status and churn.

**5. Churn varies substantially by age group, peaking at 50-59**

Churn reaches 56.04% among customers aged 50-59, the highest observed rate across age groups, then drops to 27.95% for customers 60+. The relationship is non-linear.

**6. Complaint status shows an exceptionally strong association with churn**

99.51% of customers who filed a complaint churned, compared to 0.05% of those who didn't. This is an association, not evidence that complaints cause or predict churn. The near-total overlap between the two variables is itself notable and would be worth investigating further — for example, whether `Complain` and `Exited` are recorded through related or overlapping operational processes.

## Business Recommendations

* Monitor customers with 3+ products, given their substantially higher observed churn rates.
* Prioritize further investigation of customers aged 50-59, the group with the highest observed churn rate.
* Review Germany's customer portfolio, particularly its higher concentration of customers with 3+ products.
* Use complaint status as a strong descriptive signal, while avoiding causal or predictive interpretation until the relationship between `Complain` and `Exited` is better understood.

## Repository Structure

```text
bank-customer-churn-analysis/
│
├── README.md
├── LICENSE
├── .gitignore
├── sql/
│   └── churn_analysis.sql
├── dashboard/
│   ├── screenshots/
│   │   └── bank-customer-churn-dashboard.png
│   └── README.md
└── data/
    └── README.md
```

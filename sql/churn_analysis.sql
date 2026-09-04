-- ============================================================
-- BANK CUSTOMER CHURN ANALYSIS
-- SQL ANALYSIS
-- ============================================================

-- Purpose:
-- Explore customer characteristics associated with churn
-- and investigate hypotheses generated during the analysis.

-- Dataset:
-- Customer_Churn_Records

-- Target variable:
-- Exited (1 = customer exited, 0 = customer remained)

-- Tools:
-- SQLite / DBeaver
-- ============================================================

-- ============================================================
-- 1. DATASET OVERVIEW
-- ============================================================

-- Business question:
-- How many customer records are available for analysis?

SELECT
COUNT(*) AS total_customers
FROM Customer_Churn_Records;

-- ============================================================
-- 2. OVERALL CHURN
-- ============================================================

-- Business question:
-- What is the overall distribution of customer churn?

SELECT
Exited,
COUNT(*) AS total_customers,
ROUND(
COUNT(*) * 100.0 /
SUM(COUNT(*)) OVER (),
2
) AS percentage
FROM Customer_Churn_Records
GROUP BY Exited
ORDER BY Exited;

-- ============================================================
-- 3. CHURN BY COMPLAINT STATUS
-- ============================================================

-- Business question:
-- Is customer complaint status associated with churn?

-- Hypothesis:
-- Customers who filed a complaint may have a higher churn rate
-- because complaints can indicate customer dissatisfaction.

SELECT
Complain,
COUNT(*) AS total_customers,
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0
/ COUNT(*),
2
) AS churn_rate
FROM Customer_Churn_Records
GROUP BY Complain
ORDER BY churn_rate DESC;

-- ============================================================
-- 4. CHURN BY GEOGRAPHY
-- ============================================================

-- Business question:
-- Which country has the highest customer churn rate?

-- Hypothesis:
-- Churn rates may differ substantially across countries
-- because customer populations and market conditions can vary.

SELECT
Geography,
COUNT(*) AS total_customers,
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0
/ COUNT(*),
2
) AS churn_rate
FROM Customer_Churn_Records
GROUP BY Geography
ORDER BY churn_rate DESC;

-- ============================================================
-- 5. CUSTOMER PROFILE BY GEOGRAPHY
-- ============================================================

-- Business question:
-- How do customer characteristics differ across countries?

-- Purpose:
-- This analysis provides context for geographic differences
-- in churn and helps identify differences in customer profiles.

SELECT
Geography,
COUNT(*) AS total_customers,
ROUND(AVG(CreditScore), 0) AS avg_credit_score,
ROUND(AVG(Age), 1) AS avg_age,
ROUND(AVG(Balance), 2) AS avg_balance,
ROUND(AVG("Satisfaction Score"), 2) AS avg_satisfaction
FROM Customer_Churn_Records
GROUP BY Geography
ORDER BY Geography;

-- ============================================================
-- 6. CHURN BY BALANCE RANGE
-- ============================================================

-- Business question:
-- How does churn vary across different customer balance ranges?

-- Hypothesis:
-- Customers with higher account balances may show different
-- churn patterns from customers with lower balances.

-- Balance ranges are defined before evaluating the results
-- to avoid adjusting categories to fit observed patterns.

SELECT
CASE
WHEN Balance = 0 THEN 'Zero Balance'
WHEN Balance < 50000 THEN 'Low (0-50K)'
WHEN Balance < 100000 THEN 'Medium (50K-100K)'
WHEN Balance < 150000 THEN 'High (100K-150K)'
ELSE 'Very High (150K+)'
END AS balance_range,
COUNT(*) AS total_customers,
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0
/ COUNT(*),
2
) AS churn_rate
FROM Customer_Churn_Records
GROUP BY balance_range
ORDER BY
CASE balance_range
WHEN 'Zero Balance' THEN 1
WHEN 'Low (0-50K)' THEN 2
WHEN 'Medium (50K-100K)' THEN 3
WHEN 'High (100K-150K)' THEN 4
WHEN 'Very High (150K+)' THEN 5
END;

-- ============================================================
-- 7. CHURN BY NUMBER OF PRODUCTS
-- ============================================================

-- Business question:
-- Is the number of banking products associated with churn?

-- Hypothesis:
-- Customers with more banking products may have lower churn
-- because greater product adoption could indicate stronger
-- customer engagement and loyalty.

SELECT
NumOfProducts,
COUNT(*) AS total_customers,
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0
/ COUNT(*),
2
) AS churn_rate
FROM Customer_Churn_Records
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

-- ============================================================
-- 8. FOLLOW-UP ANALYSIS: HIGH PRODUCT COUNT BY GEOGRAPHY
-- ============================================================

-- Follow-up question:
-- Does the concentration of customers with 3+ products differ
-- across countries?

-- Purpose:
-- The overall product analysis revealed unusually high churn
-- among customers with 3+ products. This follow-up investigates
-- whether some countries have a higher concentration of these
-- customers.

SELECT
Geography,
COUNT(*) AS total_customers,
SUM(
CASE WHEN NumOfProducts >= 3 THEN 1 ELSE 0 END
) AS high_product_customers,
ROUND(
SUM(
CASE WHEN NumOfProducts >= 3 THEN 1 ELSE 0 END
) * 100.0 / COUNT(*),
2
) AS high_product_percentage
FROM Customer_Churn_Records
GROUP BY Geography
ORDER BY high_product_percentage DESC;

-- ============================================================
-- 9. HIGH PRODUCT COUNT BY COUNTRY AND CHURN
-- ============================================================

-- Follow-up question:
-- How does churn vary by number of products within each country?

-- Purpose:
-- This analysis investigates whether the relationship between
-- product count and churn is consistent across countries.

SELECT
Geography,
NumOfProducts,
COUNT(*) AS total_customers,
ROUND(AVG(Balance), 0) AS avg_balance,
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0
/ COUNT(*),
2
) AS churn_rate
FROM Customer_Churn_Records
WHERE NumOfProducts >= 3
GROUP BY Geography, NumOfProducts
ORDER BY Geography, NumOfProducts;

-- ============================================================
-- 10. CHURN BY ACTIVE MEMBER STATUS
-- ============================================================

-- Business question:
-- Are inactive members more likely to churn than active members?

-- Hypothesis:
-- Active customers may have lower churn because greater
-- engagement with the bank may be associated with retention.

SELECT
IsActiveMember,
COUNT(*) AS total_customers,
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0
/ COUNT(*),
2
) AS churn_rate
FROM Customer_Churn_Records
GROUP BY IsActiveMember
ORDER BY churn_rate DESC;

-- ============================================================
-- 11. CHURN BY AGE GROUP
-- ============================================================

-- Business question:
-- How does churn vary across customer age groups?

-- Hypothesis:
-- Churn may differ across age groups because customer needs
-- and financial behaviour can change throughout the customer
-- lifecycle.

-- Age groups are predefined before evaluating the results.

SELECT
CASE
WHEN Age < 30 THEN 'Under 30'
WHEN Age < 40 THEN '30-39'
WHEN Age < 50 THEN '40-49'
WHEN Age < 60 THEN '50-59'
ELSE '60+'
END AS age_group,
COUNT(*) AS total_customers,
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0
/ COUNT(*),
2
) AS churn_rate
FROM Customer_Churn_Records
GROUP BY age_group
ORDER BY
CASE age_group
WHEN 'Under 30' THEN 1
WHEN '30-39' THEN 2
WHEN '40-49' THEN 3
WHEN '50-59' THEN 4
WHEN '60+' THEN 5
END;

-- ============================================================
-- 12. ANALYTICAL NOTES
-- ============================================================

-- The queries above are designed to follow an analytical
-- sequence rather than simply demonstrate SQL syntax:

-- 1. Establish the overall churn level.
-- 2. Test individual customer-level hypotheses.
-- 3. Identify unusually strong associations.
-- 4. Perform follow-up analysis when an initial result raises
--    an additional business question.

-- The analysis is descriptive and observational.
-- It does not establish causality or build a predictive model.
-- ============================================================

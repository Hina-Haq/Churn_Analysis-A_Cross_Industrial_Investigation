-- Project: Cancel Culture — Customer Churn Analysis
-- Table: bank_churn_cleaned (load your bank CSV into MySQL)
-- QUERY 1 — OVERALL CHURN RATE
-- Business question: How big is the churn problem in banking?
-- ============================================================
 
SELECT
    Churn,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS churn_rate_pct
FROM bank_churn_cleaned
GROUP BY Churn
ORDER BY Churn DESC;

-- QUERY 2 — CHURN BY AGE GROUP
-- Business question: Which age group is most at risk?
-- ============================================================
 
SELECT
    CASE
        WHEN Age BETWEEN 18 AND 30 THEN '18-30'
        WHEN Age BETWEEN 31 AND 40 THEN '31-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        WHEN Age BETWEEN 51 AND 60 THEN '51-60'
        WHEN Age > 60 THEN '60+'
    END AS Age_Group,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(AVG(Churn_Binary) * 100, 1) AS churn_rate_pct,
    ROUND(AVG(Balance), 0) AS avg_balance,
    ROUND(AVG(Age), 1) AS avg_age
FROM bank_churn_cleaned
GROUP BY Age_Group
ORDER BY churn_rate_pct DESC;
 
-- QUERY 3 — CHURN BY GEOGRAPHY
-- Business question: Why is Germany losing twice as many customers?
-- ============================================================
 
SELECT
    Geography,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(AVG(Churn_Binary) * 100, 1) AS churn_rate_pct,
    ROUND(AVG(Age), 1) AS avg_age,
    ROUND(AVG(Balance), 0) AS avg_balance,
    ROUND(AVG(CreditScore), 1) AS avg_credit_score,
    ROUND(AVG(IsActiveMember) * 100, 1) AS pct_active_members
FROM bank_churn_cleaned
GROUP BY Geography
ORDER BY churn_rate_pct DESC;


-- QUERY 4 — THE PRODUCT PARADOX
-- Business question: Why do customers with more products leave more?
-- ============================================================
 
SELECT
    NumOfProducts,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(AVG(Churn_Binary) * 100, 1) AS churn_rate_pct,
    ROUND(AVG(Balance), 0) AS avg_balance,
    ROUND(AVG(Age), 1) AS avg_age,
    ROUND(AVG(IsActiveMember) * 100, 1) AS pct_active
FROM bank_churn_cleaned
GROUP BY NumOfProducts
ORDER BY NumOfProducts;
 

-- QUERY 5 — ACTIVE MEMBER PROTECTION
-- Business question: How much does engagement protect retention?
-- ============================================================
 
SELECT
    CASE WHEN IsActiveMember = 1 THEN 'Active' ELSE 'Inactive' END AS Member_Status,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(AVG(Churn_Binary) * 100, 1) AS churn_rate_pct,
    ROUND(AVG(Balance), 0) AS avg_balance,
    ROUND(AVG(Age), 1) AS avg_age,
    ROUND(AVG(NumOfProducts), 2) AS avg_products
FROM bank_churn_cleaned
GROUP BY Member_Status
ORDER BY churn_rate_pct DESC;
 
-- QUERY 6 — GENDER AND CHURN
-- Business question: Why are female customers leaving more?
-- ============================================================
 
SELECT
    Gender,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(AVG(Churn_Binary) * 100, 1) AS churn_rate_pct,
    ROUND(AVG(Age), 1) AS avg_age,
    ROUND(AVG(Balance), 0) AS avg_balance,
    ROUND(AVG(IsActiveMember) * 100, 1) AS pct_active
FROM bank_churn_cleaned
GROUP BY Gender
ORDER BY churn_rate_pct DESC;
 
-- QUERY 7 — HIGH RISK SEGMENT
-- Combines age + geography + inactive status
-- Business question: Who has ALL the high risk factors combined?
-- ============================================================
 
SELECT
    Gender,
    Geography,
    CASE WHEN IsActiveMember = 1 THEN 'Active' ELSE 'Inactive' END AS Member_Status,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(AVG(Churn_Binary) * 100, 1) AS churn_rate_pct,
    ROUND(AVG(Age), 1) AS avg_age,
    ROUND(AVG(Balance), 0) AS avg_balance
FROM bank_churn_cleaned
WHERE Age BETWEEN 41 AND 60
AND Geography = 'Germany'
AND IsActiveMember = 0
GROUP BY Gender, Geography, Member_Status
ORDER BY churn_rate_pct DESC;
 
-- QUERY 8 — BALANCE SEGMENTS AND CHURN
-- Business question: Are we losing our most valuable customers?
-- ============================================================
 
SELECT
    CASE
        WHEN Balance = 0 THEN 'Zero Balance'
        WHEN Balance BETWEEN 1 AND 50000 THEN 'Low (1-50k)'
        WHEN Balance BETWEEN 50001 AND 100000 THEN 'Medium (50k-100k)'
        WHEN Balance BETWEEN 100001 AND 150000 THEN 'High (100k-150k)'
        WHEN Balance > 150000 THEN 'Very High (150k+)'
    END AS Balance_Segment,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(AVG(Churn_Binary) * 100, 1) AS churn_rate_pct,
    ROUND(AVG(Age), 1) AS avg_age
FROM bank_churn_cleaned
GROUP BY Balance_Segment
ORDER BY churn_rate_pct DESC;
 
 -- QUERY 9 — TENURE AND CHURN
 -- Business question: Does loyalty matter in banking like it does in Telco?
-- ============================================================
 
SELECT
    CASE
        WHEN Tenure BETWEEN 0 AND 2 THEN '0-2 years'
        WHEN Tenure BETWEEN 3 AND 5 THEN '3-5 years'
        WHEN Tenure BETWEEN 6 AND 8 THEN '6-8 years'
        WHEN Tenure BETWEEN 9 AND 10 THEN '9-10 years'
    END AS Tenure_Group,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(AVG(Churn_Binary) * 100, 1) AS churn_rate_pct,
    ROUND(AVG(Balance), 0) AS avg_balance
FROM bank_churn_cleaned
GROUP BY Tenure_Group
ORDER BY churn_rate_pct DESC;
 
-- QUERY 10 — TYPICAL CHURNER VS STAYER FULL PROFILE
-- Business question: If we had to describe our at-risk bank customer, what would they look like?
-- ============================================================
 
SELECT
    Churn,
    COUNT(*) AS customer_count,
    ROUND(AVG(Age), 1) AS avg_age,
    ROUND(AVG(Tenure), 1) AS avg_tenure_years,
    ROUND(AVG(Balance), 0) AS avg_balance,
    ROUND(AVG(CreditScore), 1) AS avg_credit_score,
    ROUND(AVG(EstimatedSalary), 0) AS avg_salary,
    ROUND(AVG(NumOfProducts), 2) AS avg_products,
    ROUND(AVG(IsActiveMember) * 100, 1) AS pct_active,
    ROUND(SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_female,
    ROUND(SUM(CASE WHEN Geography = 'Germany' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_germany,
    ROUND(SUM(CASE WHEN Geography = 'France' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_france,
    ROUND(SUM(CASE WHEN Geography = 'Spain' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_spain
FROM bank_churn_cleaned
GROUP BY Churn
ORDER BY Churn DESC;
 




















































































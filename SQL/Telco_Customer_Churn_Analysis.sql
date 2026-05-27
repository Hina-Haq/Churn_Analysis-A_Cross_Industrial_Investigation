-- Check table exists and see first 5 rows
SELECT * 
FROM telco_customer_churn_cleaned 
LIMIT 5;

-- Confirm row count matches Python (should be 7,032)
SELECT COUNT(*) AS total_rows
FROM telco_customer_churn_cleaned;

-- See all column names and data types
DESCRIBE telco_customer_churn_cleaned;

-- QUERY 1 — OVERALL CHURN RATE
-- Confirms EDA Finding 1: baseline churn numbers
-- Business question: What is our overall churn problem?
-- ============================================================
SELECT 
    Churn,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS churn_rate_pct
FROM telco_customer_churn_cleaned
GROUP BY Churn
ORDER BY Churn DESC;

-- QUERY 2 — CHURN BY CONTRACT TYPE + REVENUE IMPACT
-- Confirms EDA Finding 2: contract type is biggest churn driver
-- Business question: Which contract loses most customers AND revenue?
-- ============================================================
  Select 
    Contract,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(AVG(Churn_Binary) * 100, 1) AS churn_rate_pct,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 0) AS monthly_revenue_lost,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM telco_customer_churn_cleaned
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

-- QUERY 3 — THE DANGER ZONE — CHURN BY TENURE GROUP
-- Confirms EDA Finding 3: new customers churn most
-- Business question: Exactly when do customers leave?
-- ============================================================
SELECT 
    CASE 
        WHEN tenure BETWEEN 0 AND 12 THEN '0-12 months'
        WHEN tenure BETWEEN 13 AND 24 THEN '13-24 months'
        WHEN tenure BETWEEN 25 AND 48 THEN '25-48 months'
        WHEN tenure BETWEEN 49 AND 72 THEN '49-72 months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(AVG(Churn_Binary) * 100, 1) AS churn_rate_pct,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM telco_customer_churn_cleaned
GROUP BY tenure_group
ORDER BY churn_rate_pct DESC;
 
 -- QUERY 4 — THE FIBRE OPTIC PARADOX
-- Confirms EDA Finding 5: premium customers churn more
-- Business question: Why are our best-paying customers leaving?
-- ============================================================


SELECT 
    InternetService,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(AVG(Churn_Binary) * 100, 1) AS churn_rate_pct,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 0) AS monthly_revenue_lost
FROM telco_customer_churn_cleaned
GROUP BY InternetService
ORDER BY churn_rate_pct DESC;

 -- QUERY 5 — PAYMENT METHOD RISK
-- Confirms EDA Finding 8: electronic check = high churn risk
-- Business question: Which payment method signals a customer at risk?
-- ============================================================
 SELECT 
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(AVG(Churn_Binary) * 100, 1) AS churn_rate_pct,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM telco_customer_churn_cleaned
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;
 
-- QUERY 6 — SUPPORT SERVICES PROTECTION
-- Confirms EDA Findings 6 and 7: support cuts churn significantly
-- Business question: Does investing in support services pay off?
-- ============================================================
 SELECT 
    TechSupport,
    OnlineSecurity,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(AVG(Churn_Binary) * 100, 1) AS churn_rate_pct,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM telco_customer_churn_cleaned
WHERE TechSupport != 'No internet service'
AND OnlineSecurity != 'No internet service'
GROUP BY TechSupport, OnlineSecurity
ORDER BY churn_rate_pct DESC;

-- QUERY 7 — HIGH RISK CUSTOMER SEGMENT
-- Combines EDA Findings 2, 5, 8: the perfect storm customer
-- Business question: How many customers have ALL high risk factors?
-- Month-to-month + Fibre optic + Electronic check = highest risk
-- ============================================================
SELECT 
    Contract,
    InternetService,
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(AVG(Churn_Binary) * 100, 1) AS churn_rate_pct,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 0) AS monthly_revenue_lost
FROM telco_customer_churn_cleaned
WHERE Contract = 'Month-to-month'
AND InternetService = 'Fiber optic'
AND PaymentMethod = 'Electronic check'
GROUP BY Contract, InternetService, PaymentMethod;
 
-- QUERY 8 — DEMOGRAPHICS AND CHURN
-- Confirms EDA Finding 9: seniors and singles churn more
-- Business question: Which demographic is most vulnerable?
-- ============================================================
  
SELECT 
    SeniorCitizen,
    Partner,
    Dependents,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(AVG(Churn_Binary) * 100, 1) AS churn_rate_pct
FROM telco_customer_churn_cleaned
GROUP BY SeniorCitizen, Partner, Dependents
ORDER BY churn_rate_pct DESC
LIMIT 10;

-- QUERY 9 — REVENUE LOST BY CONTRACT TYPE
-- Confirms EDA Finding 10: revenue impact broken down by contract
-- Business question: Where is the biggest financial loss coming from?
-- ============================================================

SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(Churn_Binary) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 0) AS monthly_revenue_lost,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) * 12, 0) AS annual_revenue_lost,
    ROUND(AVG(CASE WHEN Churn = 'Yes' THEN MonthlyCharges END), 2) AS avg_churner_charges
FROM telco_customer_churn_cleaned
GROUP BY Contract
ORDER BY monthly_revenue_lost DESC;
 
-- QUERY 10 — TYPICAL CHURNER VS STAYER FULL PROFILE
-- Confirms EDA Finding: complete picture of who is leaving
-- Business question: If we had to describe our at-risk customer, what would they look like?
-- ============================================================
 SELECT 
    Churn,
    COUNT(*) AS customer_count,
    ROUND(AVG(tenure), 1) AS avg_tenure_months,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(TotalCharges), 2) AS avg_total_charges,
    ROUND(AVG(SeniorCitizen) * 100, 1) AS pct_senior_citizen,
    ROUND(SUM(CASE WHEN Partner = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_with_partner,
    ROUND(SUM(CASE WHEN Dependents = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_with_dependents,
    ROUND(SUM(CASE WHEN Contract = 'Month-to-month' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_month_to_month,
    ROUND(SUM(CASE WHEN InternetService = 'Fiber optic' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_fiber_optic,
    ROUND(SUM(CASE WHEN PaymentMethod = 'Electronic check' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct_electronic_check
FROM telco_customer_churn_cleaned
GROUP BY Churn
ORDER BY Churn DESC;
 
















 
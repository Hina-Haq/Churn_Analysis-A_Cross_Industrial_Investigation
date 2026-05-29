<p align="center">
  <img src="clearchurn_logo.svg" width="350"/>
</p>
<div align="center">

# Customer Churn Analysis  
### Cross-Industry Churn Patterns in Telco and Banking

**Tools used:** Python · SQL · Tableau · Jupyter Notebook  
**Data sources:** Kaggle datasets for Telco Customer Churn and Bank Customer Churn

</div>

---

## Index

- [Project Overview](#project-overview)
- [Business Problem](#business-problem)
- [Project Scope](#project-scope)
- [Datasets](#datasets)
- [Project Structure](#project-structure)
- [Workflow](#workflow)
- [Key Analysis Areas](#key-analysis-areas)
- [Cross-Industry Focus](#cross-industry-focus)
- [Tools and Technologies](#tools-and-technologies)
- [Deliverables](#deliverables)
- [How to Use](#how-to-use)
- [Links](#links)

---

## Project Overview

This project explores **customer churn** in two industries: **telecommunications** and **banking**.

The main goal was to understand why customers leave, identify the strongest churn drivers, and compare which churn patterns appear in both industries versus which ones are industry-specific.

The **Telco dataset** was used as the main base analysis, while the **Bank dataset** was used for cross-industry comparison.

---

## Business Problem

Customer churn means a company is losing existing customers. This matters because keeping a customer is usually cheaper than acquiring a new one.

In this project, we studied churn from a business perspective:
- Which customers are most likely to leave?
- Which behaviours or attributes are linked to churn?
- Which churn patterns appear in both industries?
- Which churn signals are unique to only one industry?

---

## Project Scope

This project combines:
- Data cleaning in Python
- Exploratory data analysis (EDA) in Jupyter Notebook
- SQL analysis for business questions
- Statistical analysis
- Tableau visualisation and presentation building

The analysis is designed as a **cross-industry churn study**, not just two separate case studies.

---

## Datasets

The data used in this project comes from **Kaggle**.

### 1. Telco Customer Churn
This dataset is the main analytical base of the project. After cleaning, it contains **7,032 rows** and an overall churn rate of **26.6%**. It includes variables such as tenure, contract type, internet service, payment method, monthly charges, support services, and customer demographics.  

### 2. Bank Customer Churn
This dataset is used for comparison across industries. It contains **10,000 rows** and an overall churn rate of **20.4%**. It includes variables such as age, geography, balance, tenure, number of products, activity status, estimated salary, and credit score.

---

## Project Structure

```text
Customer-Churn-Analysis/
│
├── Telco_Bank_cleaning.ipynb
├── EDA_Telco.ipynb
├── Bank_EDA.ipynb
├── Statistical_analysis.ipynb
├── Telco_Customer_Churn_Analysis.sql
├── Bank_Customer_Churn.sql
├── presentation/
├── tableau/
└── README.md
```

### Main files

- `Telco_Bank_cleaning.ipynb`  
  Loads, cleans, and prepares the churn datasets for analysis.

- `EDA_Telco.ipynb`  
  Exploratory analysis for the telco dataset.

- `Bank_EDA.ipynb`  
  Exploratory analysis for the bank dataset.

- `Statistical_analysis.ipynb`  
  Statistical testing and validation of churn-related findings.

- `Telco_Customer_Churn_Analysis.sql`  
  SQL business queries for telco churn analysis.

- `Bank_Customer_Churn.sql`  
  SQL business queries for bank churn analysis.

---

## Workflow

This project followed a simple analytics pipeline:

1. **Data collection**  
   Downloaded churn datasets from Kaggle.

2. **Data cleaning**  
   Cleaned missing values, fixed data types, removed non-analytical fields, and created binary churn columns.

3. **Exploratory data analysis**  
   Investigated churn patterns, segment behaviour, and major customer risk factors.

4. **SQL analysis**  
   Wrote business-focused SQL queries to confirm findings and answer practical retention questions.

5. **Cross-industry comparison**  
   Compared telco and banking churn to identify shared and industry-specific churn patterns.

6. **Visual storytelling**  
   Built visualisations in Tableau and prepared presentation materials.

---

## Key Analysis Areas

### Telco analysis
The telco analysis focused on customer tenure, contract type, internet service, payment method, support services, demographic traits, and revenue impact from churn.

Some of the major telco churn themes included:
- High churn among **month-to-month** customers
- Higher churn in early customer tenure
- Increased churn among **fiber optic** customers
- Higher risk linked to **electronic check** payment method
- Lower churn for customers with support-related services such as tech support and online security

### Bank analysis
The bank analysis focused on age, geography, balance, activity level, number of products, gender, and tenure.

Some major bank churn themes included:
- Higher churn in specific **age groups** and **Gender**
- Strong differences by **geography**
- Lower churn among **active members**
- Important churn patterns linked to **number of products**
- Segment-level risk differences across customer profiles

---

## Cross-Industry Focus

A central aim of this project is to compare churn across industries.

### Shared churn patterns
The project looks for churn patterns that appear in both telco and banking, such as:
- Lower engagement being linked to higher churn
- Certain customer segments showing much higher churn than others
- Clear differences between retained and churned customers
- Strong business value in identifying high-risk groups early

### Industry-specific churn patterns
The project also highlights churn drivers that are more exclusive to one industry:

- **Telco-specific patterns:** contract type, internet service type, support service adoption, payment method, and monthly charge pressure
- **Bank-specific patterns:** geography, number of products, balance patterns, and active membership status

This makes the project stronger than a standard churn dashboard because it moves from single-industry analysis to **cross-industry insight generation**.

---

## Tools and Technologies

- **Python** for cleaning, transformation, and exploratory analysis
- **Pandas, NumPy, Matplotlib, Seaborn** for notebook analysis
- **SQL** for business-question-based querying
- **Jupyter Notebook** for analysis workflow
- **Tableau** for dashboards and visual storytelling
- **PowerPoint / presentation materials** for communicating insights

---

## Deliverables

This project includes:
- Cleaned datasets
- Python notebooks for cleaning and EDA
- SQL scripts for business analysis
- Statistical analysis notebook
- Tableau visualisations
- Presentation slides summarising the findings

---

## How to Use

1. Download the churn datasets from Kaggle.
2. Open the notebooks in Jupyter Notebook or VS Code.
3. Run the cleaning notebook first.
4. Run the EDA notebooks for telco and bank analysis.
5. Use the SQL scripts in MySQL or another SQL environment after loading the cleaned tables.
6. Build or open the Tableau dashboard for the final visual analysis.
7. Use the presentation to communicate the business findings.

---

## Links

Add your project links here when ready:

- **Kaggle Telco dataset:**
- https://www.kaggle.com/datasets/blastchar/telco-customer-churn<img width="468" height="50" alt="image" src="https://github.com/user-attachments/assets/c6435895-4e6d-46f7-bea6-9e98ac13a4fd" />
- **Kaggle Bank dataset:**
- https://www.kaggle.com/datasets/shrutimechlearn/churn-modelling<img width="468" height="25" alt="image" src="https://github.com/user-attachments/assets/6de4544a-818c-41a2-91b3-2b7e0069ab01" />
- **Tableau dashboard:** https://public.tableau.com/authoring/Churn_Analysis_A_Cross_Industrial_Investigation/Telco_Dashbord#1<img width="468" height="40" alt="image" src="https://github.com/user-attachments/assets/8f8ca39f-0073-400d-a711-19aaf446ba48" />
- **Presentation Pdf:**
-  https://github.com/Hina-Haq/Churn_Analysis A_Cross_Industrial_Study/blob/main/ClearChurn_Final_Presentation.pdf

---


## Final Note

This project is not only about finding who churns. It is about understanding how churn behaves across two different industries, where the patterns overlap, and where each industry has its own unique retention risks.

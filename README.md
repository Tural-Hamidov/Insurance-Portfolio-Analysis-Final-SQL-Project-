# Insurance-Portfolio-Analysis-Final-SQL-Project
SQL-based insurance portfolio analysis focusing on profitability, risk drivers, and data-driven pricing and underwriting recommendations.
# 📊 Insurance Portfolio Analysis (SQL & Data Analytics)

## 📌 Project Overview
This project analyzes an insurance company’s portfolio to evaluate financial performance, identify loss drivers, and provide data-driven recommendations for pricing and underwriting.
The analysis is conducted using SQL queries on structured datasets.

## 🎯 Project Objectives
- Analyze total premium vs total claims
- Evaluate profitability trends across years
- Identify high-risk agents, regions, and products
- Analyze claim reasons and customer risk behavior
- Support pricing and underwriting decisions

## 🗂️ Database Schema

### CUSTOMERS
- customer_id
- full_name
- gender
- age
- city
- vehicle_type

### AGENTS
- agent_id
- agent_name
- branch
- hire_date
- region

### POLICIES
- policy_id
- customer_id
- agent_id
- policy_type
- start_date
- end_date
- premium_amount
- coverage_amount

### CLAIMS
- claim_id
- policy_id
- claim_date
- claim_amount
- claim_reason
- status

### PAYMENTS
- payment_id
- policy_id
- payment_date
- amount
- payment_method

## 🔍 Key Findings
- Total claims significantly exceed total premiums, making the portfolio loss-making.
- For every 100 AZN of premium collected, approximately 136 AZN is paid as claims.
- All analyzed years show negative profitability.
- Casco is the highest-risk insurance product.
- Losses are mainly driven by Vandalism and Theft claims.
- A small group of customers generates a large share of total losses.
- Late payment rate is critically high at 49%.

## 🎯 Final Recommendations
1. Reprice Casco insurance using risk-based pricing.
2. Evaluate agent performance based on profitability, not sales volume.
3. Apply sales limits to agents with negative profitability.
4. Strengthen underwriting rules in high-loss regions.
5. Introduce controls for high claim-ratio customers.
6. Encourage card and online payments to reduce late payments.

## 🛠️ Tools Used
- SQL
- CSV datasets
- Excel / Dashboard

## 🔚 Conclusion
This project demonstrates that increasing sales without proper risk assessment and pricing leads to structural losses in insurance portfolios.

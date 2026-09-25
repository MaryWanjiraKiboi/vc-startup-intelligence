# vc-startup-intelligence
SQL analysis of startup revenue, funding, traction, platforms and investment signals from a VC perspective.
# VC Startup Intelligence Analytics

## Project Overview

This project analyzes a startup dataset from a venture capital perspective.

The objective is to use SQL to understand startup revenue performance,
funding patterns, traction, platform adoption, AI participation and
capital-efficiency signals.

Rather than focusing only on SQL syntax, the analysis asks business
questions that could support investment and strategic decision-making.

## Business Questions

The analysis explores:

- Which startups generate the highest monthly revenue?
- Which startups demonstrate strong revenue with little or no funding?
- Which startups show the strongest traction?
- How concentrated is startup revenue?
- How is revenue distributed across startups?
- How does funding relate to revenue?
- Are AI startups more likely to be self-funded?
- Which platforms are most commonly used?
- Which platform combinations generate higher revenue?
- Which revenue models appear among high-revenue startups?

## Key Findings

- Revenue is highly concentrated, with one startup accounting for a large
  share of total monthly revenue.
- Most startups fall into the low-revenue category.
- A small number of self-funded startups demonstrate meaningful monthly revenue.
- Web is the dominant platform in the dataset.
- AI startups represent a large proportion of the dataset but account for a
  smaller share of total revenue.
- Funding alone does not appear to explain commercial traction.

## Tools

- MySQL
- MySQL Workbench
- SQL

## Analysis Areas

1. Data Exploration
2. Data Quality
3. Revenue Analysis
4. Platform Analysis
5. AI Startup Analysis
6. Funding Analysis
7. Traction Analysis
8. Revenue Concentration
9. Revenue Segmentation
10. Capital Efficiency

## Data Limitations

The dataset contains a monthly revenue measure but does not provide
historical revenue data. Therefore, this project does not calculate
actual month-over-month or year-over-year revenue growth.

The `verticals` field also contains multiple industry tags in a single field,
which limits detailed industry-level comparisons.

The dataset does not provide the actual amount of capital raised, so true
return on investment or whether a startup is overfunded cannot be calculated.

## Project Purpose

This project demonstrates how SQL can be used to move from raw startup data
to business insights and investment-related analysis.

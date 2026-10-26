Hospital Operations \& Billing Intelligence (Power BI)



An interactive Power BI dashboard that shows hospital admissions, billing, length of stay and test results for 50,000 patient admissions (8 May 2019 to 7 May 2024). Built as a Power BI intern final project using Power Query, a star schema and DAX.



Objective



Business problem: Hospital managers need one clear view of how many patients are admitted, how much is billed, how long patients stay, and how test results and admission types are spread. Without it, it is hard to plan beds, check billing quality and decide where to improve.



Objective: Explore and clean the data, build a star schema model with DAX measures, create a three-page dashboard, validate the numbers, and give evidence-based insights and recommendations.



Intended users: Hospital operations managers, billing and finance teams, and senior decision-makers.



Dataset

Source: Kaggle healthcare\_dataset (CC0 public domain licence), accessed October 2026

Size: 55,500 raw rows, 15 columns. After cleaning: 50,000 rows, 18 columns

Grain: one row = one patient admission

Reporting period: 8 May 2019 to 7 May 2024 (2019 and 2024 are partial years)

Key fields: Date of Admission, Discharge Date, Medical Condition, Insurance Provider, Admission Type, Billing Amount, Test Results, Age, Medication

Data-sharing limitations: The dataset is public (CC0). Patient names were removed during cleaning. The data appears synthetic, and the currency is not stated.

Repository Structure

Hospital-Operations-Billing-PowerBI/

├── BRD/                  Business Requirements Document (BRD\_Submitted.pdf)

├── FRD/                  Functional Requirements Document (FRD\_Submitted.pdf)

├── Data/

│   ├── raw/              Original Kaggle file, unchanged (healthcare\_dataset.csv)

│   ├── cleaned/          Cleaned dataset (healthcare\_cleaned.csv)

│   └── assessment/       Column\_Assessment.xlsx and Validation\_Checks.xlsx

├── Visuals/              Dashboard mockup (editable file and export) and draft data model

├── PowerBI/

│   ├── pbix/             Hospital\_Operations\_Billing\_Intelligence.pbix

│   └── exports/          dashboard\_export.pdf

├── Reports/              Analysis\_Report.pdf

├── Scripts/              PowerQuery\_Steps.m (documented Power Query steps)

└── README.md

Tools Used

Power BI Desktop: data model, DAX measures, dashboard

Power Query: cleaning and transformation

DAX: measures, what-if parameter, dynamic titles

Excel: column assessment and validation checks

Git and GitHub: version control

Data Preparation



All steps were done in Power Query and are saved in Scripts/PowerQuery\_Steps.m. The raw file in Data/raw is unchanged.



Removed 534 exact duplicate rows and about 4,966 near-duplicates that differed only in Age (first copy kept), giving 50,000 rows

Removed the patient Name column for privacy

Flagged 96 rows with negative billing (total -47,650.40) in a Billing Status column, and kept them

Added Admission ID, Length of Stay (Day) (discharge date minus admission date) and Age Group (18-34, 35-49, 50-64, 65+)

Set correct data types

Data Model and Measures



Star schema: one fact table, Admissions\_Clean (one row per admission), connected to seven dimension tables: DimCondition, DimInsurance, DimAdmissionType, DimMedication, DimTestResult, DimAgeGroup and DimDate.



Relationships are one-to-many from each dimension to the fact table

DimDate connects to Date of Admission (active). The Discharge Date relationship is inactive

All measures are stored in a \_Measures table



Key measures: Total Admissions, Total Billing, Avg Billing per Admission, Avg Length of Stay, Emergency Admission %, Abnormal Test Result %, Negative Billing Count, Billing Equivalent and Bed Days Freed (what-if on stay reduction).



Dashboard pages: Overview, Billing and Operations, plus hidden Definitions, Tooltip and Condition Details (drill-through) pages. Features include slicers, a metric switch, Reset, Info and Hide filters buttons, and a what-if slider.



Steps to Reproduce

Download the source dataset from Kaggle (healthcare\_dataset, CC0), or use Data/raw/healthcare\_dataset.csv.

Review Data/assessment/Column\_Assessment.xlsx and Scripts/PowerQuery\_Steps.m to see the cleaning decisions and transformations.

Open PowerBI/pbix/Hospital\_Operations\_Billing\_Intelligence.pbix in Power BI Desktop.

If the file path has changed, go to Home, Transform data, Data source settings and update the path to the CSV on your computer.

Click Refresh and check the key measures: 50,000 admissions, total billing 1,277.8M, average stay 15.5 days.

Review PowerBI/exports/dashboard\_export.pdf and Reports/Analysis\_Report.pdf.

Key Insights and Recommendations



Key insights



50,000 admissions, total billing 1,277.8M, average billing 25,555.69 per admission

Billing is almost the same across insurers (25,413 to 25,651, a gap of about 0.9%)

Admission types are evenly split: Elective 33.65%, Urgent 33.57%, Emergency 32.78%

Average length of stay is about 15.5 days in every age group and condition

33.5% of tests are abnormal

A 1-day shorter stay would free 50,000 bed days (a scenario, not a forecast)

96 admissions have negative billing (-47,650.40), likely refunds or adjustments



Recommendations



Treat length of stay as the main lever and study discharge delays first

Review the 96 negative billing records with the billing team

Plan emergency capacity at about one-third of admissions

Set up a follow-up process for abnormal test results

Do not target actions by insurer, condition or age group yet, because differences are very small

Collect better data (stated currency, full years, real cost data) before real decisions



Full details are in Reports/Analysis\_Report.pdf.



Limitations

Currency is not stated, so billing values have no unit

2019 and 2024 are partial years, so yearly totals cannot be compared directly

The data appears synthetic (values are almost evenly spread), so findings may not match a real hospital

About 5,500 duplicates were removed, so a few real repeat visits may have been lost

Billing is not profit or cost

The what-if assumes billing is proportional to stay days

Patient names were removed, so repeat patients cannot be tracked

Author



Sreelakshmi, Data Analyst Intern, Bridgeon (Kerala, India)




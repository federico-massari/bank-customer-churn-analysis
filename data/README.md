# Data

## Source

Bank Customer Churn dataset, published on Kaggle by radheshyamkollipara.

[Dataset on Kaggle](https://www.kaggle.com/datasets/radheshyamkollipara/bank-customer-churn)

## License

Listed on Kaggle as "Other" (no specific terms are stated in the dataset description). The raw data is not redistributed in this repository — download it directly from the source link above if you want to reproduce the analysis.

## Size

10,000 rows, 18 columns.

## Column Dictionary

| Column | Description |
|---|---|
| RowNumber | Sequential row index. Not used in analysis. |
| CustomerId | Unique customer identifier. Not used in analysis. |
| Surname | Customer surname. Not used in analysis. |
| CreditScore | Customer's credit score. |
| Geography | Customer's country (France, Germany, Spain). |
| Gender | Customer's gender. |
| Age | Customer's age in years. |
| Tenure | Number of years as a bank customer. |
| Balance | Account balance. |
| NumOfProducts | Number of bank products held by the customer. |
| HasCrCard | Whether the customer holds a credit card (1/0). |
| IsActiveMember | Whether the customer is an active member (1/0). |
| EstimatedSalary | Customer's estimated annual salary. |
| Exited | Target variable. Whether the customer churned (1/0). |
| Complain | Whether the customer filed a complaint (1/0). |
| Satisfaction Score | Customer-provided score for complaint resolution. |
| Card Type | Type of card held by the customer. |
| Points Earned | Loyalty points earned through card usage. |

## Processing

The dataset was loaded as-is into SQLite (DBeaver), with no cleaning, transformation, or column renaming applied prior to analysis.

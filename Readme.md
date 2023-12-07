# Nashville Housing Data Transformation

This repository contains SQL queries used for data preprocessing and transformation on the Nashville Housing dataset. These queries aim to standardize data formats, populate missing values, break down address columns, handle categorical data, and remove duplicates.

## Queries Overview

### Standardize Date Format
- Changes the format of the 'SaleDate' column to standardize the date data.

### Populate Property Address Data
- Populates missing 'PropertyAddress' values by updating them from non-null entries that share the same 'ParcelID'.

### Breaking Property Address into Individual Columns
- Splits the 'PropertyAddress' column into separate 'Address' and 'PropertyCity' columns.

### Breaking Owner Address into Individual Columns
- Divides the 'OwnerAddress' column into 'OwnerAddress', 'OwnerCity', and 'OwnerState' columns.

### Change Y and N to Yes and No in "SoldAsVacant" Field
- Modifies 'SoldAsVacant' column values from 'Y' and 'N' to 'Yes' and 'No' respectively.

### Removing Duplicates using CTE (Common Table Expression)
- Uses a Common Table Expression to identify and remove duplicate entries based on specific columns.

### Deleted Unused Columns
- Drops the 'TaxDistrict' column from the dataset.

## How to Use:

[Dataset](https://github.com/ManojGowda27/Data-Analyst-Portfolio-Projects/blob/main/Nashville%20Housing%20Data%20-%20Data%20Cleaning%20using%20SQL/NashvilleHousing.xlsx)

1. Ensure you have access to a SQL database containing the Nashville Housing dataset.
2. Copy the SQL queries into your SQL environment or editor.
3. Run the queries in sequence to preprocess and transform the data according to the outlined steps.

## Notes:

- The code assumes the existence of a table named "NashvilleHousing" containing columns such as 'SaleDate', 'PropertyAddress', 'OwnerAddress', 'SoldAsVacant', etc.
- Modify the queries as needed to suit your specific database schema and structure.
- Ensure to have appropriate permissions and backups before performing any data modifications.

Please adapt the queries as per your dataset's structure and requirements.

For any questions or improvements, feel free to open an issue or submit a pull request.

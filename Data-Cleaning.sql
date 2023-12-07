

select * 
from dbo.NashvilleHousing

---------------------------------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format

select SaleDate
from PersonalPortfolio.dbo.NashvilleHousing

alter table NashvilleHousing
alter column SaleDate Date


-----------------------------------------------------------------------------------------------------------------------

-- Populate Property Address Data
select *
from PersonalPortfolio.dbo.NashvilleHousing
where PropertyAddress is null
order by ParcelID


UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from PersonalPortfolio.dbo.NashvilleHousing a
JOIN PersonalPortfolio.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

---------------------------------------------------------------------------------------------------------

-- Breaking Property Address into Individual Columns(Address, City)
select PropertyAddress
FROM PersonalPortfolio.dbo.NashvilleHousing

SELECT
SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
FROM PersonalPortfolio.dbo.NashvilleHousing

UPDATE NashvilleHousing
SET PropertyCity = SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

ALTER TABLE NashvilleHousing
ADD PropertyCity Nvarchar(255)

UPDATE NashvilleHousing
SET PropertyAddress = SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

select PropertyAddress, PropertyCity
from PersonalPortfolio.dbo.NashvilleHousing

---------------------------------------------------------------------------------------------------------------

-- Breaking Owner Address into Individual Columns(Address, City, State)
SELECT OwnerAddress
from PersonalPortfolio.dbo.NashvilleHousing

SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
from PersonalPortfolio.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
ADD OwnerState Nvarchar(255)

UPDATE NashvilleHousing
SET OwnerState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

ALTER TABLE NashvilleHousing
ADD OwnerCity Nvarchar(255)

UPDATE NashvilleHousing
SET OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

UPDATE NashvilleHousing
SET OwnerAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

Select OwnerAddress, OwnerCity, OwnerState
from PersonalPortfolio.dbo.NashvilleHousing

---------------------------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "SoldAsVacant" Field

SELECT Distinct(SoldAsVacant), COUNT(SoldAsVacant)
from PersonalPortfolio.dbo.NashvilleHousing
group by SoldAsVacant
order by 2

SELECT SoldAsVacant,
CASE When SoldAsVacant = 'Y' then 'Yes'
	 When SoldAsVacant = 'N' then 'No'
	 ELSE SoldAsVacant
	 END
from PersonalPortfolio.dbo.NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' then 'Yes'
						When SoldAsVacant = 'N' then 'No'
						ELSE SoldAsVacant
						END


-----------------------------------------------------------------------------------------------------------------------

-- Removing Duplicates using CTE

WITH RowNumCTE AS (
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
				) row_num
FROM PersonalPortfolio.dbo.NashvilleHousing
)
SELECT *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress

-------------------------------------------------------------------------------------------------

-- Deleted Unused Columns

SELECT *
FROM PersonalPortfolio.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
DROP COLUMN TaxDistrict

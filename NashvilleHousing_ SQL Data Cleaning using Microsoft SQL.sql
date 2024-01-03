/*

Cleaning Data in SQL Queries...

*/

SELECT * FROM 
Portfolio_Project.dbo.NashvilleHousing


-- Standardize the Date Format
SELECT CAST(SaleDate as date) FROM Portfolio_Project.dbo.NashvilleHousing

-- Add a new column to the given table...
ALTER TABLE NashvilleHousing
add SaleDateConverted Date

UPDATE NashvilleHousing
SET SaleDateConverted = CAST(SaleDate as date)


-- Populate Property Address Data Where There are Null Values...
SELECT * FROM NashvilleHousing
WHERE PropertyAddress IS NULL


SELECT a.UniqueID, a.ParcelID, a.PropertyAddress, b.UniqueID, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress) 
FROM 
NashvilleHousing as a JOIN NashvilleHousing as b
ON a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing as a JOIN NashvilleHousing as b
ON a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress is NULL


SELECT PropertyAddress FROM 
NashvilleHousing
WHERE PropertyAddress IS NULL

-- Break Out Address into Individual Columns(Address, City, State)
SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) as Address
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress nvarchar(225)

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE NashvilleHousing
ADD PropertySplitCity nvarchar(225)

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))

SELECT * FROM NashvilleHousing

-- Better Approach...
SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress nvarchar(255)

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',', '.'), 3)

ALTER TABLE NashvilleHousing
ADD OwnerSplitCity nvarchar(255)

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',', '.'),2)

ALTER TABLE NashvilleHousing
ADD OwnerSplitState nvarchar(255)

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',', '.'), 1)

-- Learn to drop a column...
ALTER TABLE NashvilleHousing
DROP COLUMN OwnerSplitStae

-- Change Y and N to Yes and No in 'Sold as Vacant' Field...
UPDATE NashvilleHousing
SET SoldAsVacant = CASE 
WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END

SELECT DISTINCT(SoldAsVacant) FROM NashvilleHousing

-- Remove Duplicates...

WITH RowNumCTE AS 
(
SELECT *, ROW_NUMBER() OVER 
(PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
ORDER BY UniqueID) row_num
FROM NashvilleHousing
-- ORDER BY PropertyAddress
)
--SELECT * FROM RowNumCTE 
--WHERE row_num > 1
--ORDER BY PropertyAddress

DELETE FROM RowNumCTE 
WHERE row_num > 1
-- ORDER BY PropertyAddress

-- Delete Unused Columns -- 

ALTER TABLE NashvilleHousing
DROP COLUMN SaleDate

SELECT * FROM NashvilleHousing
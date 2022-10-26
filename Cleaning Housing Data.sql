-- Adding a new Column for only DATE

Alter Table  NashvilHousing
ADD DateofSale DAte

update NashvilHousing set DateofSale= CONVERT(DAte,SaleDate) from NashvilHousing

SELECT * FROM  NashvilHousing 

-- Populate Addresses that are null
Select a.parcelid,
a.propertyaddress,b.parcelid,b.propertyaddress from nashvilhousing a inner join
nashvilhousing b on a.parcelid = b.parcelid and a.uniqueid != b.uniqueid

update a set a.propertyaddress = b.propertyaddress from  nashvilhousing a inner join
nashvilhousing b on a.parcelid = b.parcelid and a.uniqueid != b.uniqueid
where a.propertyaddress is null

-- Breaking out the Property Address

Select Address = SUBSTRING(propertyaddress,1,(CHARINDEX(',',propertyaddress)-1)),
SUBSTRING(propertyaddress,
(CHARINDEX(',',propertyaddress)+1),len(propertyaddress)) as city
from Nashvilhousing

alter table nashvilhousing add Address VARCHAR(MAX)
alter table nashvilhousing add City VARCHAR(MAX)

update nashvilhousing set City =   SUBSTRING(propertyaddress,
(CHARINDEX(',',propertyaddress)+1),len(propertyaddress)) from Nashvilhousing

-- To get state from the Owner address
alter table nashvilhousing add State VARCHAR(MAX)

update nashvilhousing set State =
'TN' from NashvilHousing 

-- To print Y or N based on Sold as Vacant Field
alter table nashvilhousing add SoldasVac VARCHAR(MAX)

UPDATE nashvilhousing SET SoldasVac = 

CASE
WHEN SoldasVacant = 'N' THEN 'No'
WHEN SoldasVacant = 'Y' THEN 'Yes'
ELSE SoldasVacant
END
from NashvilHousing

-- Dropping Duplicate Rows
WITH CT AS
(
SELECT *,Rank = ROW_NUMBER() OVER(PARTITION BY
ParcelID,PropertyAddress,SalePrice,SaleDate,LegalReference ORDER BY SalePrice Desc ) from NashvilHousing
)
SELECT * FROM CT 

-- Dropping Unnecassary Columns

SELECT * FROM NASHVILHOUSING
ALTER TABLE  NASHVILHOUSING DROP COLUMN PropertyAddress,SaleDate

SELECT * FROM  NASHVILHOUSING order by SalePrice Desc
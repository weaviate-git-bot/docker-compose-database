SELECT AddressID, AddressLine1, City
FROM [AdventureWorks].[Person].[Address]
WHERE AddressID = '1'

UPDATE [AdventureWorks].[Person].[Address]
SET CITY = 'Atlanta'
WHERE AddressID = '1'

UPDATE [AdventureWorks].[Person].[Address]
SET CITY = 'Bothell'
WHERE AddressID = '1'

SELECT AddressID, AddressLine1, City
FROM [AdventureWorks].[Person].[Address]
WHERE AddressID = '1'
USE [master]
GO
RESTORE DATABASE [AdventureWorks] FROM DISK = 
'C:\SQLBackup\AdventureWorks2014.BAK' WITH NORECOVERY, REPLACE;
GO
RESTORE DATABASE [AdventureWorks] WITH RECOVERY;
GO

--Create a new table
USE AdventureWorks
GO
SELECT * INTO SALES FROM Sales.SalesOrderDetail

--Show the top 10 orders by SalesOrderID DESC
--This will allow us to see when we insert new records
SELECT TOP 10 * 
	FROM Sales
	ORDER BY SalesOrderID DESC;
GO

--Check Recovery model of AdventureWorks
--It should be in full recovery model
USE [master]
GO
ALTER DATABASE [AdventureWorks] SET RECOVERY FULL 
GO

--Backup the database and log 
BACKUP DATABASE [AdventureWorks] 
	TO DISK = 'C:\BACKUPS\AdventureWorks.BAK';
GO
BACKUP LOG [AdventureWorks] 
	TO DISK = 'C:\BACKUPS\AdventureWorks_LOG1.BAK';
GO

--Change database context back to AdventureWorks
USE AdventureWorks
GO

--INSERT a single record into the sales table.
INSERT  INTO Sales 
        ( [SalesOrderID] ,
          [CarrierTrackingNumber] ,
          [OrderQty] ,
          [ProductID] ,
          [SpecialOfferID] ,
          [UnitPrice] ,
          [UnitPriceDiscount] ,
          [LineTotal] ,
          [rowguid] ,
          [ModifiedDate]
        )
VALUES  ( '75150' ,
          NULL ,
          '2' ,
          '879' ,
          '1' ,
          '159.00' ,
          '0.00' ,
          '380.00' ,
          NEWID() ,
          GETDATE()
        );
GO

--Backup the log 
BACKUP LOG [AdventureWorks] 
	TO DISK = 'C:\BACKUPS\AdventureWorks_LOG2.BAK';
GO

--INSERT another record into the sales table.
INSERT INTO [sales]
           ([SalesOrderID]
           ,[CarrierTrackingNumber]
           ,[OrderQty]
           ,[ProductID]
           ,[SpecialOfferID]
           ,[UnitPrice]
           ,[UnitPriceDiscount]
           ,[LineTotal]
           ,[rowguid]
           ,[ModifiedDate])
     VALUES
           ('75200'
           ,NULL
           ,'2'
           ,'879'
           ,'1'
           ,'159.00'
           ,'0.00'
           ,'318.00'
           ,NEWID()
           ,getdate());
GO

--Take another log backup.
BACKUP LOG [AdventureWorks] 
	TO DISK = 'C:\BACKUPS\AdventureWorks_LOG3.BAK';
GO

--Lets insert another record for good measure into the sales table.
INSERT INTO [sales]
           ([SalesOrderID]
           ,[CarrierTrackingNumber]
           ,[OrderQty]
           ,[ProductID]
           ,[SpecialOfferID]
           ,[UnitPrice]
           ,[UnitPriceDiscount]
           ,[LineTotal]
           ,[rowguid]
           ,[ModifiedDate])
     VALUES
           ('75250'
           ,NULL
           ,'2'
           ,'879'
           ,'1'
           ,'159.00'
           ,'0.00'
           ,'318.00'
           ,NEWID()
           ,getdate());
GO

--A final log backup.
BACKUP LOG [AdventureWorks] 
	TO DISK = 'C:\BACKUPS\AdventureWorks_LOG4.BAK';
GO

--Now lets see if we see our 3 records we inserted.
--Should have SalesOrderID 75150, 75200 and 75250
USE [AdventureWorks];
GO

SELECT TOP 10 *
	FROM AdventureWorks.dbo.SALES ORDER BY SalesOrderID DESC;
GO





--Restore Process
RESTORE DATABASE AdventureWorks FROM DISK = 
'C:\BACKUPS\AdventureWorks.BAK' WITH NORECOVERY, REPLACE
RESTORE LOG AdventureWorks FROM DISK = 
'C:\BACKUPS\AdventureWorks_LOG1.BAK' WITH NORECOVERY
RESTORE LOG AdventureWorks FROM DISK = 
'C:\BACKUPS\AdventureWorks_LOG2.BAK' WITH NORECOVERY
RESTORE LOG AdventureWorks FROM DISK = 
'C:\BACKUPS\AdventureWorks_LOG3.BAK' WITH NORECOVERY
RESTORE LOG AdventureWorks FROM DISK = 
'C:\BACKUPS\AdventureWorks_LOG4.BAK' WITH NORECOVERY
RESTORE DATABASE AdventureWorks WITH RECOVERY
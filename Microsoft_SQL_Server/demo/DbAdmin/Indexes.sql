USE [AdventureWorks]
GO

CREATE TABLE [dbo].[Fragment](
	[c1] [uniqueidentifier] NULL
) ON [PRIMARY]
GO

CREATE UNIQUE CLUSTERED INDEX [CS_C1] ON [dbo].[Fragment]
(
	[c1] ASC
) ON [PRIMARY]
GO

insert into Fragment values (newid())
go 100000


--view fragmentation

ALTER INDEX [CS_C1] ON [dbo].[Fragment] REBUILD 

DROP TABLE Fragment

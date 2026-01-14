
--step 1 create a partition function 
create partition function partitionbyyear(date)
as range left for values('2023-12-31','2024-12-31','2025-12-31')

--query lists all existing partition function 
select 
name,
function_id,
type_desc,
boundary_value_on_right
from sys.partition_functions

--create file group
alter database SalesDB add filegroup FG_2023;
alter database SalesDB add filegroup FG_2024;
alter database SalesDB add filegroup FG_2025;
alter database SalesDB add filegroup FG_2026;

--to remove a filegroup
alter database SalesDB REMOVE filegroup FG_2023;

--query lists all existing filegroup
SELECT *
FROM sys.filegroups
WHERE TYPE = 'FG'

--STEP 3 ADD .NDF FILES TO EACH FILEGROUP
ALTER DATABASE SalesDB ADD FILE 
(
NAME =P_2023,--LOGICAL NAME
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2023.ndf'

)TO FILEGROUP FG_2023;

ALTER DATABASE SalesDB ADD FILE 
(
NAME =P_2024,--LOGICAL NAME
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2024.ndf'

)TO FILEGROUP FG_2024;

ALTER DATABASE SalesDB ADD FILE 
(
NAME =P_2025,--LOGICAL NAME
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2025.ndf'

)TO FILEGROUP FG_2025;

ALTER DATABASE SalesDB ADD FILE 
(
NAME =P_2026,--LOGICAL NAME
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\P_2026.ndf'

)TO FILEGROUP FG_2026;

--LIST ALL FILE INSIDE DATABASE
SELECT
    fg.name AS FilegroupName,
    mf.name AS LogicalFileName,
    mf.physical_name AS PhysicalFilePath,
    mf.size /128 AS SizeInMB
from sys.filegroups fg
join sys.master_files mf 
on fg.data_space_id = mf.data_space_id
where mf.database_id = DB_ID('SalesDB');

--STEP 4 CREATE PARTITION SCHEME
CREATE PARTITION SCHEME SchemePartitionByYear
AS PARTITION  partitionbyyear
TO (FG_2023,FG_2024,FG_2025,FG_2026)

--QUERY LIST ALL PARTITION SCHEME
SELECT
    ps.name as ParrtitionSchemeName,
    pf.name as PartitionFunctionName,
    ds.destination_id as PartitionNumber,
    fg.name as FilegroupName
FROM SYS.partition_schemes ps
JOIN sys.partition_functions pf
on ps.function_id = pf.function_id
JOIN sys.destination_data_spaces ds 
on ps.data_space_id = ds.partition_scheme_id
JOIN sys.filegroups fg ON ds.data_space_id =  fg.data_space_id



--step 5 create the partitioned table

CREATE TABLE Sales.Orders_Partitioned
(
OrderID INT,
OrderDate DATE,
Sales INT
) ON SchemePartitionByYear (OrderDate)

-- INSERT INTO THE TABLE
INSERT INTO Sales.Orders_Partitioned VALUES (1,'2023-05-15',100)
INSERT INTO Sales.Orders_Partitioned VALUES (2,'2024-07-20',50)
INSERT INTO Sales.Orders_Partitioned VALUES (3,'2025-12-31',20)
INSERT INTO Sales.Orders_Partitioned VALUES (4,'2026-01-01',100)

--QUERY THE DATA
SELECT * 
FROM Sales.Orders_Partitioned

--check if partition is workig fine
SELECT 
    p.partition_id as PartitionNumber,
    f.name as PartitionFilegroup,
    p.rows as NumberOfRows
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = F.data_space_id
WHERE OBJECT_NAME(p.object_id) = 'Orders_Partitioned';

--CREATE ANOTHER TABLE WITHOUT PARTITION 
SELECT * 
INTO Sales.Orders_NoPartitioned
FROM Sales.Orders_Partitioned


--check if partition is working
SELECT * 
FROM Sales.Orders_NoPartitioned
WHERE OrderDate IN ('2026-01-01','2025-12-31');
SELECT * 
FROM Sales.Orders_Partitioned
WHERE OrderDate IN ('2026-01-01','2025-12-31');
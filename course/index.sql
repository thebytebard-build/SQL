/*
use SalesDB+
--create a table
select*
into Sales.dbcustomers
from Sales.Customers

-- create a clustered index 
create clustered index idx_dbcustomers_customerid on Sales.dbcustomers (CustomerID)

-- drop clustered index idx_dbcustomers_customerid
drop index idx_dbcustomers_customerid on Sales.dbcustomers

--create a non clustered index based on lastname
create nonclustered index idx_dbcustomers_lastname
on Sales.dbcustomers (LastName)

--create a non clustered index based on firstname
create index idx_dbcustomers_Firstname
on Sales.dbcustomers (FirstName)

--create a composite index based on country and score
create index idx_dbcustomers_countryscore
on Sales.dbcustomers (Country,Score)


--drop the previous row clustered index to build new columnstore index
drop index [idx_dbcustomers_customerid] on Sales.dbcustomers

--create new cluster columnstore index
create clustered columnstore index idx_dbcustomers_cs_clustered
on Sales.dbcustomers



--create new non cluster columnstore index
create nonclustered columnstore index idx_dbcustomers_csnonclustered_firstname
on Sales.dbcustomers (FirstName)
*/

/*
use AdventureWorksDW2022
--heap
select *
into FactInternetSales_HP
from FactInternetSales

--RowStore
select *
into FactInternetSales_RS
from FactInternetSales

create clustered index idx_FactInternetSales_RS_PK
on FactInternetSales_RS(SalesOrderNumber, SalesOrderLineNumber)

--ColumnStore
select *
into FactInternetSales_CS
from FactInternetSales

create clustered columnstore index idx_FactInternetSales_CS_PK
on FactInternetSales_CS

use SalesDB

--unique index
select
*
from Sales.Products
create unique nonclustered index idx_products_product
on Sales.products (Product)

--try to insert duplicate value in unique index column
insert into Sales.products (ProductID,Product) 
values (106,'Caps')

--creating filtered index for country usa
select *
from Sales.Customers
where Country ='USA'

create nonclustered index idx_customers_country
on Sales.Customers(Country)
where Country ='USA'

--Monitoring and Managing Index

--list all indexes on a specific table
sp_helpindex 'Sales.DBCustomers84rrr'



--**Index Information for All Tables
--Displays index names, types, and key properties for each table in the database.*
--check the usage of indexex
select
tbl.name as TableName,
idx.name as IndexName,
idx.type_desc as IndexType,
idx.is_primary_key as IsPrimaryKey,
idx.is_unique as IsUnique,
idx.is_disabled as IsDisabled,
s.user_seeks as UserSeeks,
s.user_scans UserScans,
s.user_lookups UserLookups,
s.user_updates UserUpdates,
coalesce (s.last_user_seek,s.last_user_scan) as LastUpdate
from sys.indexes idx
join sys.tables tbl
on idx.object_id =tbl.object_id
left join sys.dm_db_index_usage_stats s --dynamic management view (DMV)
on s.object_id = idx.object_id
and s.index_id = idx.index_id
order by tbl.name,idx.name

--step 1 do a query
--step 2 take suggestion from database about missing index
use AdventureWorksDW2022
select
fs.SalesOrderNumber
from FactInternetSales fs
inner join DimProduct dp
on fs.ProductKey = dp.ProductKey
where dp.Color ='Black'
and fs.OrderDateKey between 20101229 and 20101231

select * from sys.dm_db_missing_index_details

--check duplicate indexes using table name and index column
use SalesDB
select
    tbl.name as TableName,
    col.name as IndexColumn,
    idx.name as IndexName,
    idx.type_desc as IndexType,
    count(*) over (partition by tbl.name,col.name) ColumnCount
from sys.indexes idx
join sys.tables tbl on idx.object_id = tbl.object_id
join sys.index_columns ic on idx.object_id =ic.object_id and idx.index_id = ic.index_id
join sys.columns col on ic.object_id = col.object_id and ic.column_id = col.column_id
--order by tbl.name, col.name
order by ColumnCount desc

   -- check statistics of a database
    select
        SCHEMA_NAME(t.schema_id) as SchemaName,
        t.name as TableName,
        s.name as StatisticName,
        sp.last_updated as LastUpdate,
        DATEDIFF(Day,sp.last_updated,GETDATE()) as LastUpdateDay,
        sp.rows as 'Rows',
        sp.modification_counter as ModificationsLastUpdate
    from sys.stats s
    join sys.tables t
    on s.object_id = t.object_id
    cross apply sys.dm_db_stats_properties(s.object_id,s.stats_id) as sp
    order by ModificationsLastUpdate desc

--update statistics
update STATISTICS Sales.DBCustomers _WA_Sys_00000003_2739D489
-- update whole databse
exec sp_updatestats

-- monitor fragmentation

-- do we have any fragmentation in our databse or check health of index
select
    tbl.name as TableName,
    idx.name as IndexName,
    s.avg_fragmentation_in_percent,
    s.page_count
from sys.dm_db_index_physical_stats(DB_ID(),null,null,null,'limited') s --(DMF) 
JOIN sys.tables tbl
ON s.object_id = tbl.object_id
JOIN sys.indexes idx
ON s.object_id = idx.object_id
AND s.index_id = idx.index_id
order by s.avg_fragmentation_in_percent desc

--reorganize fragmentation
alter index idx_customers_country on Sales.Customers reorganize

--rebuild fragmentation
alter index idx_dbcustomers_countryscore on Sales.dbcustomers rebuild
*/


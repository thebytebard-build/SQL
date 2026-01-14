/*
--clustered index
select *
from FactResellerSales
where CarrierTrackingNumber = '4911-403C-98'

--clustered index key lookup nested join
select 
CarrierTrackingNumber 
from FactResellerSales
where CarrierTrackingNumber = '4911-403C-98'

--clustered index hash match sort clustered oindex on another table merge join sort stream aggregation  
select 
p.EnglishProductName as ProductName,
sum(s.SalesAmount) as TotalSales
from FactResellerSales s
join DimProduct p
on p.ProductKey = s.ProductKey
group by p.EnglishProductName

--the above query is taing too much time since it have aggregation but we know for aggregation columnstore store index is good lets create one

--create index
create clustered columnstore index isx_FactResellerSalesHP
on FactResellerSales_HP

select 
p.EnglishProductName as ProductName,
sum(s.SalesAmount) as TotalSales
from FactResellerSales_HP s
join DimProduct p
on p.ProductKey = s.ProductKey
group by p.EnglishProductName
--now taking less time
*/


--sql hints
use SalesDB
select*
from Sales.Orders o
left join Sales.Customers c --with (index(index name)) --with (forceseek) 
on o.CustomerID = c.CustomerID
option (hash join)
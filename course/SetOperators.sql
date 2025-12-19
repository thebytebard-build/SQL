
--combine all data without duplicates
select
FirstName,
LastName
from Sales.Employees

union 

select 
FirstName,
LastName
from Sales.Customers


--combine all data with duplicates
select
FirstName,
LastName
from Sales.Employees

union all

select 
FirstName,
LastName
from Sales.Customers

--find the employee who are not customer at the same time
select 
FirstName,
LastName
from Sales.Customers

except

select 
FirstName,
LastName
from Sales.Employees

--find the employees who are also customers
select 
FirstName,
LastName
from Sales.Employees   

intersect

select 
FirstName,
LastName
from Sales.Customers


--orders are stored in separate tables(orders and ordersarchive) . combine all orders into one report without duplicates
select
'orders' as sourcetable,
[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
from Sales.Orders

union

select
'orders archive ' as sourcetable,
[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
from Sales.OrdersArchive
order by OrderID
/*
--total number of order for each month by creating cta
select
    datename(month,OrderDate) OrderMonth,
    count(OrderID) as totalorders
into Sales.MonthlyOrders
from Sales.Orders
group by datename(month,OrderDate)

--drop the cta
drop table Sales.MonthlyOrders

--update cta
if OBJECT_ID('Sales.MonthlyOrders',' U') is not null
   drop table Sales.MonthlyOrders;
Go
select
    datename(month,OrderDate) OrderMonth,
    count(OrderID) as totalorders
into Sales.MonthlyOrders
from Sales.Orders
group by datename(month,OrderDate)
*/






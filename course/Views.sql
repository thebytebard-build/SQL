/*
create view Sales.v_MonthlySummary as
(
    select
    datetrunc(month,OrderDate) as ordermonth,
    sum (Sales) as totalsales,
    count(OrderID) totalorder,
    sum(Quantity) totalquantity
    from Sales.Orders
    group by datetrunc(month,OrderDate) 
)

--rename the table or update the table
if OBJECT_ID ('Sales.v_MonthlySummary','V') is not null
    drop view Sales.v_MonthlySummary
Go
create view Sales.V_MonthlySummary as
(
    select
    datetrunc(month,OrderDate) as ordermonth,
    sum (Sales) as totalsales,
    count(OrderID) totalorder,
    sum(Quantity) totalquantity
    from Sales.Orders
    group by datetrunc(month,OrderDate) 
)

--provide view that combines details from orders, products, customers, and employees
create view Sales.v_OrderDetails as
(
select
o.OrderID,
o.OrderDate,
p.Product,
p.Category,
coalesce(c.FirstName,'')+' '+coalesce(c.LastName,'') as CustomerName,
c.Country as CustomerCountry,
coalesce(e.FirstName,'')+' '+coalesce(e.LastName,'') as SalesName,
e.Department,
o.Sales,
o.Quantity
from Sales.Orders as o
left join Sales.Products as p
on o.ProductID = p.ProductID
left join Sales.Customers as c
on o.CustomerID = c.CustomerID
left join Sales.Employees as e
on o.SalesPersonID = e.EmployeeID


--provide a view for eu sales team 
--that combine details from tables
--and excludes data related to the usa
--provide view that combines details from orders, products, customers, and employees
create view Sales.v_OrderDetails_EU as
(
select
o.OrderID,
o.OrderDate,
p.Product,
p.Category,
coalesce(c.FirstName,'')+' '+coalesce(c.LastName,'') as CustomerName,
c.Country as CustomerCountry,
coalesce(e.FirstName,'')+' '+coalesce(e.LastName,'') as SalesName,
e.Department,
o.Sales,
o.Quantity
from Sales.Orders as o
left join Sales.Products as p
on o.ProductID = p.ProductID
left join Sales.Customers as c
on o.CustomerID = c.CustomerID
left join Sales.Employees as e
on o.SalesPersonID = e.EmployeeID
where c.Country != 'USA'
)
)
*/


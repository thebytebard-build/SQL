/*
--find the products that have a price higher than the average price of all products
select *
from (
select 
ProductID,
Price,
avg(Price) over () as avgprice
from Sales.Products
) as t
where Price > avgprice


--rank customers based on their total amount of sales
select*,
rank() over (order by total desc) as customerrank
from
(
select 
CustomerID,
sum(Sales)  as total
from Sales.Orders
group by CustomerID
) as t

--show the product IDs, product names ,price, and the total number of orders
select
ProductID,
Product,
Price,
(select 
count(*)
from Sales.Orders
) as c
from Sales.Products

--show all customer details and find the total orders of each customer
select
c.*,
t.totalorder
from Sales.Customers as c
left join (select 
CustomerID,
count(*) as totalorder
from Sales.Orders
group by CustomerID)as t
on c.CustomerID = t.CustomerID


--find the products that have a price higher than the the average price of alll products
select*
from Sales.Products
where Price > (select avg(Price) from Sales.Products)

--show the details of orders made by customer in germany
select*
from Sales.Orders
where CustomerID in (select CustomerID from Sales.Customers where Country = 'Germany')

-- ***** important 
--find female emploees whose salaries are greater than the salaries of aany male employees
select*
from Sales.Employees
where Gender = 'F'
and Salary > any(select Salary from sales.Employees where Gender = 'M')

-- ***** important 
--find female emploees whose salaries are greater than the salaries of all male employees
select*
from Sales.Employees
where Gender = 'F'
and Salary > all(select Salary from sales.Employees where Gender = 'M')

--show all customer details and find the total orders of each customer
select*,
(select count(*) from Sales.Orders as o where o.CustomerID = c.CustomerID) as totalsales
from Sales.Customers as c


--show the details of orders made by customers in germany
select *
from Sales.Customers as c
where not exists (
                 select 1
                 from Sales.Orders as o
                 where Country ='Germany'
                 and o.CustomerID = c.CustomerID
             )
*/




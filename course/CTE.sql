/*
--find the total sales per customer
with total_sale as
(
select
CustomerID,
sum(Sales) as TotalSales
from Sales.Orders
group by CustomerID
),
--find the lats order per customer
last_order as 
(
select CustomerID,
max(OrderDate) as lastorder
from Sales.Orders
group by CustomerID
),
--rank customers based on total sales per customer
rank_customer as
(
select 
CustomerID,
TotalSales,
rank() over (order by TotalSales desc) as sales_rank
from total_sale
),
--segment customers based on their total sales
customer_segment as
(
select
CustomerID,
case when TotalSales >100 then 'High'
     when TotalSales >50 then 'Medium'
     else 'Low'
end customersegment
from  total_sale
)
--main query
select
c.CustomerID,
c.FirstName,
c.LastName,
cts.TotalSales,
clo.lastorder,
ccr.sales_rank,
ccg.customersegment
from Sales.Customers as c
left join total_sale as cts
on c.CustomerID = cts.CustomerID
left join last_order as clo
on clo.CustomerID =c.CustomerID
left join rank_customer as ccr
on c.CustomerID = ccr.CustomerID
left join customer_segment as ccg
on c.CustomerID = ccg.CustomerID

--generate a sequence of numbers from 1 to 20
--anchor query
with series as
(
select 
1 as MyNumber
union all
--recursive query
select 
MyNumber+1
from series
where MyNumber<20
)
select*
from series
option (MAXRECURSION 10)

*/
-- show the employee hierarchy by displaying each employee's level within the organization
--anchor query 

with cte_hierarchy as 
(
select
EmployeeID,
FirstName,
ManagerID,
1 as level 
from Sales.Employees
where ManagerID is null
union all
select 
e.EmployeeID,
e.FirstName,
e.ManagerID,
level+1
from Sales.Employees as e
inner join cte_hierarchy as ceh
on e.ManagerID = ceh.EmployeeID

)

select*
from cte_hierarchy
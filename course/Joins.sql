--here im using Mydatabase 
--get all customers along with their orders, but only for customers who have placed an order
select *
from customers 
[inner join] join orders
on id = customer_id

--get all customers along with their orders, but only for customers who have placed an order and the column must be only id, first_name,sales
select 
c.id,
first_name,
o.customer_id,
sales
from customers as c
inner join orders as o
on id = customer_id

--get all customers along with their orders,  who have placed an order and including those who have not placed an order
select 
c.id,
first_name,
o.order_id,
sales
from customers as c
left join orders as o
on id = customer_id

--get all customer along with their order, including order without matching customer
select 
c.id,
first_name,
o.order_id,
sales
from customers as c
right join orders as o
on id = customer_id

--get all customer ans all orders, even if there's no match
select 
c.id,
first_name,
o.order_id,
sales
from customers as c
full join orders as o
on id = customer_id

--get all the custoers who haven't place any order 
select *
from customers as c
left join orders as o
on id =customer_id
where o.customer_id is null

--get all order without matchng order
select *
from customers as c
right join orders as o
on id = customer_id
where c.id is null

--get all order without matchng order using left join
select *
from orders as o
left join customers as c
on id =customer_id
where c.id is null

--find customer without order and order wihout customer
select *
from customers as c
full join orders as o
on id = customer_id
where 
   c.id is null or o.customer_id is null

--get all customers along with their orders,but only for customers who have placed and order (with using full join)
select *
from customers as c
full join orders as o
on id = customer_id
where 
c.id is not null and o.customer_id is not null


--get all customers along with their orders,but only for customers who have placed and order (with using left join)
select *
from customers as c
left join orders as o
on id = customer_id
where 
--c.id = o.customer_id
o.customer_id is not null

--generate all possible combination from customer and order
select *
from customers
cross join orders

--from here i will be using SalesDB
--using salesdb ,retrieve a list of all orders,along with the related customers,products and employee details for each order display :
--order id , customer's name ,product name, sales,price ,sales person name

select
o.OrderID,
o.Sales,
c.FirstName as CustomerFirstName,
c.LastName as CustomerLastName,
p.Product as ProductName,
P.Price,
e.FirstName as EmployeeFirstName,
e.LastName as EmployeeLastName
from Sales.Orders as o
left join Sales.Customers as c
on o.CustomerID =c.CustomerID
left join Sales.Products as p
on o.ProductID = p.ProductID
left join Sales.Employees as e
on o.SalesPersonID =e.EmployeeID


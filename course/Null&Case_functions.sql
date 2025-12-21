
--find average scores of the customers
select
CustomerID,
Score,
avg(score) over () as avgscore,
avg(coalesce(score,0)) over () as avgscore2
from Sales.Customers

--display the full name of customers in a single field by merging their first and last names, and add 10 bonus points to each customer's score
select
coalesce(FirstName,'')+' '+coalesce(LastName,'') as[full name],
10+coalesce(Score,0) as Score
from Sales.Customers

--joining two table when coumn have null bu we need to include to null place as well
select 
*
from Sales.Customers as c
join Sales.Employees as e
on e.EmployeeID = c.CustomerID
and isnull(e.LastName,' ') =isnull(c.LastName ,' ')


--sort the customer from lowest to highest scores with null appearng at last
select
CustomerID,
score,
coalesce(score,9999999),
case when score is null then 1 else 0 end flag
from Sales.Customers
order by flag

--find the sales price for each ordder by dividing sales by quantity
select 
OrderID,
Sales,
Quantity,
Sales/nullif(Quantity,0)
from Sales.Orders

--identify the customer who have no score
select*
from Sales.Customers
where Score is  null

--identify the customer who have  score
select*
from Sales.Customers
where Score is not null

--create policy using null
with orders as(
select 1 as Id,'A' Category union
select 2, NULL union
select 3,'' union
select 4, ' '
)

select *,
DATALENGTH(category) categorylen,
DATALENGTH(trim(category)) as onlynullEmptystring,
DATALENGTH(nullif(trim(category),'')) as onlynull,
coalesce(nullif(trim(category),''),'unknown')
from orders


--create report showing total sales for each of the following categories
--high if over 50,medium over 20 ,and for rest is 'low'
--sort the categories from highest to lowest

select 
Category,
sum(Sales) as totalSales
from(
select
OrderID,
Sales,
case
    when Sales >50 then 'High'
    when Sales >20 then 'Medium'
    else 'low'
    end Category
from Sales.Orders
)t
group by Category
order by totalSales desc

--retrieve employee detail with gender displayed as full text
select
EmployeeID,
case
    when Gender = 'M' then 'Male'
    when Gender = 'F' then 'Female'
    else 'Not Available'
end Gender 
from Sales.Employees


--retrive customers detail with abbreviated country code
select*,
case
    when Country ='Germany' then 'De'
    when Country ='USA' then 'Us'
    else 'n/a'
end country_abbreviation
from Sales.Customers


--retrive customers detail with abbreviated country code with quick form of case
select*,
case country
    when 'Germany' then 'De'
    when 'USA' then 'Us'
    else 'n/a'
end country_abbreviation
from Sales.Customers

--find the average score of customer and treat null as a customer
--and add additional provide details such as customer id and last name
select
CustomerID,
LastName,
Score,
avg(case when Score is null then 0 else score end) over () as avgcustomer
from Sales.Customers

--count how many times each customer has made an order with sales greater than 30
select
CustomerID,
sum(
case 
when Sales >30 then 1
else 0
end ) totalorder
from Sales.Orders
group by CustomerID























































































































































































































































































































































































































































































































































































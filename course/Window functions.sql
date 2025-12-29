/*
--all the aggregate functions
select
count(*),
sum(Sales),
max(Sales),
AVG(Sales),
min(Sales)
from Sales.Orders
group by CustomerID

--find the total sale for each product
select 
sum( Sales) as totalsales
from Sales.Orders
group by ProductID

--find the total sale for each product
--and additionL provide detail orderid ,order date
select 
OrderID,
OrderDate,
sum(Sales) over (partition by ProductID) as totalsalesproduct
from Sales.Orders

--find the total sales across all orders
--find the total sales for each product , additionally provide details such order id & order date
--find the total sales for each combination of product and order status
select
OrderID,
OrderDate,
Sales,
sum(Sales) over (partition by ProductID,OrderStatus) as [productt&ordstatus],
sum(Sales) over (partition by ProductID) totalsales_product,
sum(Sales) over ()  totalsales
from Sales.Orders


--rank each order based on their sales from highest to lowest, additionally provide details such order id & order date
select
OrderID,
OrderDate,
Sales,
rank() over (order by Sales desc) as RankSales
from Sales.Orders

--show aggregate sales using current row and 2 following
select
OrderID,
OrderDate,
OrderStatus,
Sales,
sum (Sales) over (partition by OrderStatus order by OrderDate rows between current row AND 2 following) Total
from Sales.Orders

--find the total sales for each order status only for two pproduct 101 and 102
select 
OrderID,
OrderDate,
OrderStatus, 
ProductID,
Sales,
sum(Sales) over (partition by OrderStatus) as totalSales
from Sales.Orders
where ProductID in (101,102)

--aggreggate functions 

--here we find null
--find the total numbers of orders
--find total number of orders for each customers
--provide additional details such order id ,order date
select
OrderID,
CustomerID,
OrderDate,
count(*) over () TotalOrders,
count(*) over (partition by CustomerID) OrderByCustomer
from Sales.Orders

--find total numbers of customers ,additionally provide all customer's details
--find the total number of scores for the cstomers
select*,
count(1) over () TotalCustomers,
count(Score) over () TotalScore
from Sales.Customers

--here we find duplicate
--check whther the table 'orders' contains any duplicate rows
select
OrderID,
count(*) over (partition by OrderID) as Checkk
from Sales.Orders


--check whether the table 'ordersArchives1' contains any duplicate rows
select
OrderID,
count(*) over (partition by OrderID) as Checkk
from Sales.OrdersArchive
--another way
select *
from (
select
OrderID,
count(*) over (partition by OrderID) as Checkk
from Sales.OrdersArchive
)t where Checkk >1

--**sum function
--find the total sales across all orders and the total sales for each product 
--additionally , provide details such as order ID, order Date
select 
OrderID,
OrderDate,
Sales,
sum (Sales) over () as TotalSale,
sum (Sales) over (partition by ProductID) as TotalSaleProduct
from Sales.Orders

--comaprision 
--find the percentage contribution of each product's sales to the total sales
select 
OrderID,
ProductID,
Sales,
--another way =>round((Sales*100.0)/sum(Sales) over () ,2) as Percentag,
round(Cast( Sales as float)/sum(Sales) over ()*100,2) as Percentag,
sum(Sales) over ()
from Sales.Orders

--***  avg() handled without null
--find the average sales across all orders and the average sales for each product.
--additionally,provide details such as orderID and order date
select
OrderID,
OrderDate,
Sales,
avg(Sales) over () as tSale,
avg(Sales) over (partition by ProductID) as SaleByProduct
from Sales.Orders

--***  avg() handled  null
--find the average score of customers
--additionally provide details such as customerid, and last name
select
CustomerID,
LastName,
avg(Score) over () AVGScorewithNULL,
avg(coalesce(Score,0)) over () as Avgscore
from Sales.Customers

-- *** subqueries and comparision 
--find all orders where sales are higher than the average sales across all orders
select*
from (
select
OrderID,
ProductID,
Sales,
Avg(coalesce(Sales,0)) over () AvgSales
from Sales.Orders
)t
where AvgSales < Sales

-- ** max and min
--find the highest and lowest sales of all orders
--find the highest and lowest sales for each product
--additionally provide details such order id, order date
select
ProductID,
OrderID,
OrderDate
Sales, 
max(sales) over () as [max],
min(sales) over () as [min],
max(sales) over (partition by ProductID) maxbyproduct,
min(sales) over (partition by ProductID) minbyproduct
from Sales.Orders

--show the employees who have highest salaries with fukk detail then we neeed to solve by subquiries
select*
from (
select *,
max(Salary) over () as Highestsalary
from Sales.Employees
) t where Highestsalary = Salary

--calculate the deviation of each sale from both the minimum and maximum sales amount
select
Sales,
Sales-min(Sales) over () as [mindeviation],
max(Sales) over() -Sales as [maxdeviation]
from Sales.Orders

-- ** rolling avg and moving avg
--calculate moving average of sales for each product over time
--calculate moving average of sales for each product over time, including only the next order
select
OrderID,
ProductID,
OrderDate,
Sales,
avg(Sales) over ( Partition by ProductID) as AvgSales,
avg(Sales) over ( Partition by ProductID order by OrderDate) as MoivngAvg,
avg(Sales) over ( Partition by ProductID order by OrderDate rows between current row and 1 following) as RollingAvg
from Sales.Orders

-- ** ranks functions that gives integr values
--rank the orders based on their sales from highest to lowest
select 
OrderID,
ProductID,
OrderDate,
Sales,
ROW_NUMBER() over (order by Sales desc) as rankingbyRownumber, 
Rank() over (order by Sales desc) as rankingbyRank,
dense_rank() over (order by Sales desc) as rankingbyDenserank
from Sales.Orders

--find the top highest sales for each product
select*
from(
select
OrderID,
ProductID,
OrderDate,
Sales,
ROW_NUMBER() over(partition by ProductID order by Sales Desc) as ranking
from Sales.Orders
) t where ranking =1

--find the lowest 2 customers based on their total sales
select *
from 
(
select 
CustomerID,
sum(Sales) as Saless,
ROW_NUMBER() over(order by sum(Sales) ) as rankcustomers
from Sales.Orders
group by CustomerID
) t where rankcustomers <=2

--assign unique ids to the rows of the orderarchive table
select 
ROW_NUMBER() over (order by OrderID) as UniqueID,
*
from Sales.OrdersArchive

--identify duplicates rows in the table orderarchive and return a clean result without any duplicates
--and return a clean result without any duplicate
select *
from
(
select *,
row_number () over (partition by OrderID order by CreationTime desc) as rn
from Sales.OrdersArchive
)t where rn =1


--** ntile function
--segment all orders into 3 categories : high, medium, low
select*,
case when buckets =1 then 'high'
 when buckets =2 then 'medium'
 when buckets =3 then 'low'
end
from(
select
OrderID,
Sales,
ntile(3) over (order by Sales desc) buckets
from Sales.Orders
) t 

--in order to export the data ,divide the orders into 2 groups
select
ntile(2) over (order by OrderID) buckets,
*
from Sales.Orders


-- find the product that fall within the highest 40% of their prices
select*,
concat(rankk*100,'%'),
concat(rankkk*100,'%')
from(
select
Product,
Price,
CUME_DIST() over (order by Price desc) as rankk ,
percent_rank() over (order by Price desc) as rankkk 
from Sales.Products
)t where rankk <=0.4


-- ** lead and lag functions 

--analyze the month over month performance by finding the percentage change in sales between the current and previous month
select*,
currentmonthsale - prevmonthsale as momChange,
round(cast(currentmonthsale - prevmonthsale as float)/prevmonthsale*100,1) as percentchane
from
(
select
month(OrderDate) as ordermonth,
sum(Sales) as currentmonthsale,
lag(sum(Sales)) over (order by month(OrderDate))  as prevmonthsale
from Sales.Orders
group by month(OrderDate)
)t

--****************important
--in order to analyze customer loyalty,
--rank customer based on the average days between their orders
select
avg(daysuntilnextorder) avgdays,
rank () over(order by coalesce(avg(daysuntilnextorder),99999)) rankavg
from(
select
OrderID,
CustomerID,
OrderDate as currentorder,
lead(OrderDate) over (partition by CustomerID order by OrderDate) as nextOrder,
datediff(day,OrderDate,lead(OrderDate) over (partition by CustomerID order by OrderDate) ) as daysuntilnextorder
from Sales.Orders
) t
group by CustomerID


*/

-- ** first_value and last_value function 
--find the lowest and highest sales for each product
--find the difference in sales between the current and lowest sales
select
OrderID,
ProductID,
Sales,
FIRST_VALUE(Sales) OVER (partition by ProductID order by Sales) as lowestSales,
LAST_VALUE(Sales) OVER (partition by ProductID order by Sales rows between current row and unbounded following ) as highestSales,
FIRST_VALUE(Sales) OVER (partition by ProductID order by Sales desc) as highestSales,
min(Sales) over(partition by ProductID) as lowestsale2,
max(Sales) over(partition by ProductID) as highestsale2,
Sales-min(Sales) over(partition by ProductID) as salesdifference
from Sales.Orders
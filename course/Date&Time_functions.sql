
/*
-- show the sources of date values
select
OrderID,
OrderDate as column_stored_date,
'2025-12-19' as hardcoded_date,
getdate() as system_current_date
from Sales.orders


--extract day, month , year from a column
select
OrderID,
CreationTime,
year(CreationTime) as year,
MONTH(CreationTime) as month,
day(CreationTime) as day
from Sales.Orders

--datepart()
select
OrderID,
CreationTime,
DATEPART(year,CreationTime) as year,
DATEPART(month,CreationTime) as month,
DATEPART(day,CreationTime) as day,
DATEPART(HOUR,CreationTime) as hours,
DATEPART(QUARTER,CreationTime) as quarter,
DATEPART(WEEKDAY,CreationTime) as weekday,
DATEPART(DAYOFYEAR,CreationTime) as day
from Sales.Orders

--datename()
select
OrderID,
CreationTime,
DATENAME(month,CreationTime) as month,
DATENAME(weekday,CreationTime) as weekday,
DATENAME(year,CreationTime) as year
from Sales.Orders

--datetrunc()
select
OrderID,
CreationTime,
DATETRUNC(second,CreationTime) as seconds,
DATETRUNC(MINUTE,CreationTime) as minutes,
DATETRUNC(hour,CreationTime) as hour,
DATETRUNC(day,CreationTime) as day,
DATETRUNC(month,CreationTime) as month,
DATETRUNC(year,CreationTime) as year
from Sales.Orders

--select order month wise
select
datetrunc(month,CreationTime),
count(*)
from Sales.Orders
group by datetrunc(month,CreationTime)

--extract start of month and end of month
select
OrderID,
CreationTime,
EOMONTH(CreationTime) as eomonth,
datetrunc(month,CreationTime) as sominth
from Sales.Orders

--how many orders were places each year
select 
year ( OrderDate),
count(*)
from Sales.Orders
group by year ( OrderDate)

--how many orders were places each month
select 
month( OrderDate),
count(*)
from Sales.Orders
group by month( OrderDate)

--how many orders were places each month with month name
select 
datename( month,OrderDate),
count(*)
from Sales.Orders
group by datename( month,OrderDate)

--show all orders that were placed durig the month of february
select
*
from Sales.orders
where month(OrderDate)= 20

--DIFFERENT FORMAT
select
OrderID,
CreationTime,
format( CreationTime ,'') as day,
format( CreationTime ,'d') as dyname,
format( CreationTime ,'dd') as Sdyname,
format( CreationTime ,'ddd') as sdyname,
format( CreationTime ,'dddd') as ldayname,
format( CreationTime ,'M') as month,
format( CreationTime ,'MM') as monthname,
format( CreationTime ,'MMM') as Smonthname,
format( CreationTime ,'MMMM') as LmonthnaME,
format( CreationTime ,'dd-MM-yyyy') 
from sales.Orders


--convert the date format to Day Wed Jan Q1 2025 12::34:56 PM
select 
OrderID,
CreationTime,
'Day '+format( CreationTime ,'ddd MMM')+' Q'+DATENAME(quarter,CreationTime)+' '+format( CreationTime ,'yyyy hh::mm:ss tt') as customFormat
from Sales.Orders


--convert string to int and string to date on static values
select
convert(int,'123') as [string to int convert]
convert(date,'2025-08-20') as [string to date convert]

--convert the creation time  itno usa and euro std
select
CreationTime,
convert (date,CreationTime) as [date time to date convert],
convert(varchar,CreationTime,32) as [usa std. style :32],
convert(varchar,CreationTime,34) as [euro std. style :32]
from Sales.Orders

-- using cast function change the datatype
select
cast('123' as int) as [string to int],
cast (123 as varchar) as [ int to string],
cast ('12-01-2025' as date) as [string to date ],
cast('2025-01-22' as datetime2) as [date to datetime]

--using dateadd add or subtract year ,month,day
select
OrderID,
OrderDate,
DATEADD(year,2,OrderDate) as[added two more year],
DATEADD(month,-2,OrderDate) as[less 2 month ],
DATEADD(day,2,OrderDate) as[added two more day]
from Sales.Orders

--calculate the age of employee
select
EmployeeID,
BirthDate,
DATEDIFF(year,BirthDate,getDATE())
from Sales.Employees

--find the average shipping duration in days for each month
select
month(OrderDate) as orderdate,
avg( datediff(day,OrderDate,ShipDate) )as avgship, 
count(*)
from Sales.Orders
group by month(OrderDate)

--find the number of days between each order and the previous order
select
OrderID,
OrderDate as currentdate,
lag(OrderDate) over (order by OrderDate) as PreviousDate,
DATEDIFF ( day, lag(OrderDate) over (order by OrderDate),OrderDate) DifferenceInDate
from Sales.Orders

--check if these static values are dates
select
isdate('123') ,
isdate('2025-01-08'),
isdate('58-08-2025'),
isdate('2025'),
isdate('8')

--create a table then cast the data type into date with on invalid date type
select
--cast(OrderDate as Date) OrderDate
OrderDate,
isdate(OrderDate),
case when isdate(OrderDate) = 1 THEN cast(OrderDate as date) 
  else '9999-01-01'
end NewOrderDate
from
(
    select '2025-08-20' as OrderDate union
    select '2025-08-21'  union
    select '2025-08-23'  union
    select '2025-08'   
)t
*/



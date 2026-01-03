
/*
--create temporary table
select*
into #order
from Sales.Orders

--delete from order when order status s delivered
delete from #order
where OrderStatus = 'Delivered'

--change temporary table into permanent table
select*
into Sales.ordertest
from #order

--stored procedure
--step 1 - Write a query for US customers find the total nmber of customers and the average score
select
count(*) totalcustomers,
avg(Score) AvgScore
from Sales.Customers
where Country ='USA'

--step 2 turning the query into stored procedure
create procedure GetCustmerSummary as
begin
select
count(*) totalcustomers,
avg(Score) AvgScore
from Sales.Customers
where Country ='USA'
end

--execute the stored procedure
exec GetCustmerSummary

--drop germany stored procedure
drop procedure GetCustmerSummary

--execute 
exec GetCustmerSummaries @Country='Germany'

--default and parameter
--for german customers find the the total number of customers and the average score
alter procedure GetCustmerSummary @Country NVARCHAR(50) = 'USA'as
begin
begin try
declare @TotalCustomers int, @AvgScore float;
-- =========================
-- PREPARE & CLEANUP DATA
-- =========================
if exists (select 1 from Sales.Customers where Score is null and Country =@Country)
begin
print ('updating null score to 0')
update Sales.Customers
set Score =0
where Score is null and Country = @Country;
end
else
begin
print('no null score found');
end
-- ===================
--  generating report
-- ===================
--calculate total customers and average score for specific country
select
@TotalCustomers= count(*) ,
@AvgScore =avg(Score)
from Sales.Customers
where Country =@Country;

--print statement
print 'Total customers From '+ @Country +' : '+cast(@TotalCustomers as NVARCHAR);
print 'Average Score From '+@Country+' : '+cast(@AvgScore as NVARCHAR);

--calculate total number of order and total sales forspecific country
select
count(OrderID) as TotalOrders ,
sum(Sales) as TotalSales,
1/0
from Sales.Orders as o
join Sales.Customers as c
on c.CustomerID= o.CustomerID
where Country =@Country;
end try

begin catch
-- ================
-- error handling
-- ================
print('an error occured. ');
print('error message : '+error_message());
print('error number : '+cast(error_number() as nvarchar));
print('error line : '+cast(error_line() as nvarchar));
print('error procedure '+error_procedure())
end catch
end

go

exec GetCustmerSummary 
exec GetCustmerSummary @Country='Germany'

-- create a log table
create table Sales.EmployeeLogs(
LogID int identity(1,1) primary key,
EmployeeID int,
LogMessage varchar(255),
LogDate date
)

-- step 2 create a trigger 
create trigger trg_afterinsertemployee on Sales.Employees
after insert
as
begin
    insert into Sales.EmployeeLogs(EmployeeID,LogMessage,LogDate)
    select
        EmployeeID,
        'new employee added =' + cast(EmployeeID as varchar),
        getdate()
    from inserted
end

select*
from Sales.employeeLogs

insert into Sales.Employees
values 
(6,'Maria','Doe','HR','1988-01-12','F',80000,3)
*/


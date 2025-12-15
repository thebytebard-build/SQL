
select *
from orders

select first_name,country,score
from customers

--retrieve customers with a score not equal to 0
select *
from customers
where score !=0

--retrieve customers from germany
select *
from customers
where country = 'Germany'

--retrieve all customers and sort the results by the highest score first
select *
from customers
order by score desc

--retrieve all customers and sort the results by the country as asc then highest score 
select *
from customers
order by country asc,score desc

--find the total score
select country,sum(score) as unique_name
from customers
group by country


--find the total score and total number for each country
select country,sum(score),count(id)
from customers
group by country

--find the average score for each country considering only customers with score not equal to 0 and return only those countries with an average score greater than 430
select country,AVG(score) as avg_score
from customers
where score!=0
group by country
having AVG(score) >430

--return unique list of all company
select distinct country
from customers

--retrieve only 3 customers with highest score
select top 3 *
from customers
order by score 

--get two most recent orders
select top 2*
from orders
order by order_date







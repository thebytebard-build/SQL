/*
--retrieve all customers from germany
select *
from customers
where country = 'Germany'

--retrieve all customers from germany
select *
from customers
where country <> 'Germany'

--retrieve all customers with a score greater than 500
select *
from customers
where score >500

--retrieve all customers with a score greater than 500 or equal to 500
select *
from customers
where score >=500

--retrieve all customers with a score less than 500 or equal to 500
select *
from customers
where score <500


--retrieve all customers with a score less than 500 or equal to 500
select *
from customers
where score <=500

--retrieve all customers with a score greater than 500 and country equal to usa
select *
from customers
where country ='USA' and score >500

--retrieve all customers with a score greater than 500 or country equal to usa
select *
from customers
where country ='USA' or score >500

--retrieve all customers with a score not less than 500
select *
from customers
where not score < 500

--retrieve all customers with a score  falls in the range between 100 and 500
select *
from customers
where  score between 100 and 500

--retrieve all customers with a score  falls in the range between 100 and 500
select *
from customers
where  score between 100 and 500

--retrieve all customers either from usa or germany
select *
from customers
where  country in ('Germany','USA')

--retrieve all customers whose first name start with 'M'
select *
from customers
where first_name like 'M%'

--retrieve all customers whose names end with 'n'
select *
from customers
where first_name like '%n'

--retrieve all customers whose names have 'r'
select *
from customers
where first_name like '%r%'

--retrieve all customers whose names have 'r' at third place
select *
from customers
where first_name like '__r%'
*/



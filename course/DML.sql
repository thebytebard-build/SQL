
--insert data into cutsomers with two rows
insert into customers(id,first_name,country,score)
values 
       (6,'Anna', 'USA',null),
       (7,'Sam',null,100)

--insert data into cutsomers with one rows and without mentioning column name into insert line
insert into customers
values 
       (8,'Ram','India',100)

--insert data into cutsomers with one rows and with mentioning  only two column
insert into customers(id,first_name)
values 
       (9,'dam')


--insert data from customers to persons
insert into persons(id, person_name ,birth_date,phone)
select 
id,
first_name,
null,
'Unkwon'
from customers

--update score of id 6 to 0
update customers
set 
   score = 0
where id =6

--update null score to 0
update customers
set 
   score = 0
where score is null

--delete all customers with id greater than 5
delete from customers
where id >5


--delete all data from persons
truncate table persons


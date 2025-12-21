--STRING FUNCTION
------------------



--concatenate first name and country into one column
select
first_name,
country,
CONCAT(first_name,' ',country) as name_country
from customers

--convert the first name to lower case and uppercase
select
first_name,
lower(first_name) as lowerCase,
upper(first_name) as upperCase
from customers


--find customers whose first name contain trailing and leading spaces
select
first_name ,
trim( first_name),
len(first_name) -len(trim( first_name))
from customers
--where len(first_name) !=len(trim( first_name))
--where first_name != trim( first_name)

--remove dash form phone number
select 
'123-456-789' as phone_number,
replace( '123-456-789' ,'-','') as clean_number

--calculate the length of each customer first name 
select
first_name,
len(first_name)
from customers


--retrieve the first two character of each first name
select
first_name,
left( first_name ,2)  first_2_char
from customers

--retrieve the last two character of each first name
select
first_name,
right(first_name,2) last_2_char
from customers

--retrieve a list of customer's first names after removing the first character
select
first_name,
SUBSTRING ( first_name,2,len(first_name)-1) as sub_name,
SUBSTRING ( trim(first_name),2,len(first_name)) as _another_way
from customers


-- numeric functions
-----------------------

--round of to 2,1,0 on a static number
select
3.516,
round(3.516,2) as round_2,
round(3.516,1) as round_1,
round(3.516,0) as round_0

--remove minus sign from number
select
-10,
abs(-10)


--show the floor and ceil value of a static number
select
123.9 as number,
CEILING(123.9),
floor(123.9)






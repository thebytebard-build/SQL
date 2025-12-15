
/*--create a new table called persons with columns : id,person_name,birth_date, and phone
create table persons(
    id int not null,
    person_name varchar(50) not null,
    birth_date date,
    phone varchar(50) not null,
    constraint pk_persons primary key(id)
)

--add a new column 'email' to the person table with constraint not null
alter table persons
add email varchar(50) not null

-- remove email column from table 
alter table persons
drop column email

-- drop the person table
drop table persons
*/




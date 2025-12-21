/*--Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
SELECT 
    COUNT(CITY) - COUNT(DISTINCT CITY)
FROM STATION;

--Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
The STATION table is described as follows:

SELECT CITY, LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY) ASC, CITY ASC
FETCH FIRST 1 ROW ONLY;

SELECT CITY, LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY) DESC, CITY ASC
FETCH FIRST 1 ROW ONLY;

--Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE lower(city) LIKE 'a%' 
   OR lower(city) like 'e%' 
   OR lower(city) LIKE 'i%' 
   OR lower(city) like 'o%' 
   OR lower(city) LIKE 'u%';


Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
select distinct city
from station
where (lower(city) like 'a%' or 
      lower(city) like 'e%' or 
      lower(city) like 'i%' or 
      lower(city) like 'o%' or
      lower(city) like 'u%' )
     and (lower(city) like '%a' or
      lower(city) like '%e' or
      lower(city) like '%i' or
      lower(city) like '%o' or
      lower(city) like '%u') ;


Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
select distinct city
from station
where lower(city) not like 'a%' and
      lower(city) not like 'e%' and
      lower(city) not like 'i%' and
      lower(city) not like 'o%' and
      lower(city) not like 'u%' ;



--Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
select distinct city
from station
where (lower(city) not like '%a' and 
      lower(city) not like '%e' and 
      lower(city) not like '%i' and
      lower(city) not like '%o' and 
      lower(city) not like '%u' )
      or
      (lower(city) not like 'a%' and 
      lower(city) not like 'e%' and
      lower(city) not like 'i%' and
      lower(city) not like 'o%' and
      lower(city) not like 'u%');



*/


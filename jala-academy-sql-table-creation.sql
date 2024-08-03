#database creation
create database jalaacademysql;
use jalaacademysql;

#table creation and data insertion
CREATE TABLE SALESPEOPLE(SNUM INT(5) PRIMARY KEY,  SNAME CHAR(10),  CITY CHAR(20),  COMM DECIMAL(8,3));
INSERT INTO SALESPEOPLE VALUES (1001, 'Peel', 'London',0.12); 
INSERT INTO SALESPEOPLE VALUES(1002, 'Serres','San Jose',0.13); 
CREATE TABLE CUST(CNUM INT(5) PRIMARY KEY,  CNAME CHAR(20),  CITY CHAR(20), RATING INT(3),SNUM INT(4));
INSERT INTO CUST VALUES (2001, 'Hoffman', 'London',100,1001); 
INSERT INTO CUST VALUES (2002, 'Giovanne', 'Rome',200,1003);
CREATE TABLE ORDERS(ONUM INT(5) PRIMARY KEY,  AMT DECIMAL(5,2), ODATE Date, CNUM INT(4),SNUM INT(4));
INSERT INTO ORDERS VALUES (3001, 18.69, STR_TO_DATE('03-OCT-94', '%d-%b-%y'), 2008, 1007);
INSERT INTO ORDERS VALUES (3003,767.19,STR_TO_DATE('03-OCT-94', '%d-%b-%y'),2001,1001);
INSERT INTO SALESPEOPLE VALUES (1004, 'Motika', 'London', 0.11);
INSERT INTO SALESPEOPLE VALUES (1007, 'Rafkin', 'Barcelona', 0.15);
INSERT INTO SALESPEOPLE VALUES (1003, 'Axelrod', 'New York', 0.10);
INSERT INTO CUST VALUES (2003, 'Liu', 'San Jose', 300, 1002);
INSERT INTO CUST VALUES (2004, 'Grass', 'Berlin', 100, 1002);
INSERT INTO CUST VALUES (2006, 'Clemens', 'London', 300, 1007);
INSERT INTO CUST VALUES (2007, 'Pereia', 'Rome', 100, 1004);
ALTER TABLE ORDERS MODIFY AMT DECIMAL(10,2);
INSERT INTO ORDERS VALUES (3002, 1900.10, STR_TO_DATE('03-OCT-94', '%d-%b-%y'), 2007, 1004);
INSERT INTO ORDERS VALUES (3005, 5160.45, STR_TO_DATE('03-OCT-94', '%d-%b-%y'), 2003, 1002);
INSERT INTO ORDERS VALUES (3006, 1098.16, STR_TO_DATE('04-OCT-94', '%d-%b-%y'), 2008, 1007);
INSERT INTO ORDERS VALUES (3009, 1713.23, STR_TO_DATE('04-OCT-94', '%d-%b-%y'), 2002, 1003);
INSERT INTO ORDERS VALUES (3007, 75.75, STR_TO_DATE('05-OCT-94', '%d-%b-%y'), 2006, 1002);
INSERT INTO ORDERS VALUES (3008, 4723.00, STR_TO_DATE('05-OCT-94', '%d-%b-%y'), 2006, 1001);
INSERT INTO ORDERS VALUES (3010, 1309.95, STR_TO_DATE('06-OCT-94', '%d-%b-%y'), 2004, 1002);
INSERT INTO ORDERS VALUES (3011, 9891.88, STR_TO_DATE('06-OCT-94', '%d-%b-%y'), 2006, 1001);

select * from cust;
select * from orders;
select * from salespeople;

#questions and answer
#Display snum,sname,city and comm of all salespeople.
select snum, sname, city, comm from salespeople;

#Display all snum without duplicates from all orders.
select distinct snum from orders;

#Display names and commissions of all salespeople in london.
select sname,comm from salespeople where city = 'London';

#All customers with rating of 100.
select cname from cust where rating = 100;

#Produce orderno, amount and date form all rows in the order table.
select ordno, amt, odate from orders;

#All customers in San Jose, who have rating more than 200
select cname from cust where rating > 200;

#All customers who were either located in San Jose or had a rating above 200.
select cname from cust where city = 'San Jose' or rating > 200;

#All orders for more than $1000.
select *  from orders where amt > 1000;

#Names and citires of all salespeople in london with commission above 0.10.
select sname, city from salepeople where comm > 0.10 and city = 'London';

#All customers excluding those with rating < = 100 unless they are located in Rome.
select cname from cust where rating <= 100 or city = 'Rome';

#All salespeople either in Barcelona or in london.
select sname, city from salespeople where city in ('Barcelona','London');

#All salespeople with commission between 0.10 and 0.12. (Boundary values should be excluded)
select sname, comm from salespeople where comm > 0.10 and comm < 0.12;

#All customers with NULL values in city column.
select cname from cust where city is null; 

#All orders taken on Oct 3Rd and Oct 4th 1994.
SELECT * FROM orders WHERE odate IN (STR_TO_DATE('03-OCT-94', '%d-%b-%y'), STR_TO_DATE('04-OCT-94', '%d-%b-%y'));

#All customers serviced by peel or Motika
select cname from cust, orders where orders.cnum = cust.cnum and orders.snum in (select snum from salespeople where sname in ('Peel','Motika'));

#All customers whose names begin with a letter from A to B.
select cname from cust where CITY like 'A%' or CITY like 'B%';

#All orders except those with 0 or NULL value in amt field.
select onum from orders where amt <> 0 and amt is not null;

#Count the number of salespeople currently listing orders in the order table
select count(distinct snum) from orders;

#Largest order taken by each salesperson, datewise.
Select odate, snum, max(amt) from orders group by odate, snum order by odate,snum;

#Largest order taken by each salesperson with order value more than $3000.
select odate, snum, max(amt) from orders where amt > 3000 group by odate, snum order by odate,snum;

#Which day had the hightest total amount ordered.
select odate, amt, snum, cnum from orders where amt = (select max(amt)  from orders);

#count all orders for Oct 3rd.
select count(*) from orders where odate = STR_TO_DATE('03-OCT-94', '%d-%b-%y');

#Count the number of different non NULL city values in customers table.
select count(distinct city) from cust;

#Select each customer’s smallest order.
select cnum, min(amt) from orders group by cnum; 

#First customer in alphabetical order whose name begins with G.
select min(cname) from cust where cname like 'G%';

#Get the output like "For dd/mm/yy there are_orders.
Select 'For ' || to_char(odate,'dd/mm/yy') || ' there are '||  count(*) || ' Orders' from orders group by odate;

#Assume that each salesperson has a 12% commission. Produce order no., salesperson no., and amount of salesperson’s commission for that order.
select onum, snum, amt, amt * 0.12 from orders order by snum;

#Find highest rating in each city. Put the output in this form. For the city (city), the highest rating is : (rating).
select 'For the city (' || city || '), the highest rating is : (' ||  max(rating) || ')' from cust group by city;

#Display the totals of orders for each day and place the results in descending order.
select odate, count(onum) from orders group by odate order by count(onum);

#All combinations of salespeople and customers who shared a city. (ie same city )
select sname, cname from salespeople, cust where salespeople.city = cust.city;

#Name of all customers matched with the salespeople serving them.
select cname, sname from cust, salespeople where cust.snum = salespeople.snum;

#List each order number followed by the name of the customer who made the order.
select onum, cname from orders, cust where orders.cnum = cust.cnum;

#Names of salesperson and customer for each order after the order number.
select onum, sname, cname from orders, cust, salespeople where orders.cnum = cust.cnum and orders.snum = salespeople.snum;

#Produce all customer serviced by salespeople with a commission above 12%.
select cname, sname, comm from cust, salespeople where comm > 0.12 and cust.snum = salespeople.snum;

#Calculate the amount of the salesperson’s commission on each order with a rating above 100.
select sname, amt * comm from orders, cust, salespeople where rating > 100 and salespeople.snum = cust.snum and salespeoplesnum = orders.snum and cust.cnum = orders.cnum;

#Find all pairs of customers having the same rating.
select a.cname, b.cname,a.rating from cust a, cust b where a.rating = b.rating and a.cnum != b.cnum;

#Policy is to assign three salesperson to each customers. Display all such combinations.
select a.cname, b.cname,a.rating from cust a, cust b where a.rating = b.rating and a.cnum != b.cnum and a.cnum <> b.cnum;

#Display all customers located in cities where salesman serres has customer.
SELECT c.CNAME, s.SNAME
FROM CUST c
JOIN SALESPEOPLE s ON c.SNUM = s.SNUM
WHERE s.CITY IN (
    SELECT DISTINCT CITY
    FROM SALESPEOPLE
    WHERE SNAME = 'Serres'
)
ORDER BY c.CNAME;

#Find all pairs of customers served by single salesperson.
select cname from cust where city in ( select city from cust, orders where cust.cnum = orders.cnum and orders.snum in ( select snum  from salespeople where sname = 'Serres'));

#Produce all pairs of salespeople which are living in the same city. Exclude combinations of salespeople with themselves as well as duplicates with the order reversed.
select cname from cust where snum in (select snum from cust group by snum having count(snum) > 1);

#Produce names and cities of all customers with the same rating as Hoffman.
select cname, city from cust where rating = (select rating from cust where cname = 'Hoffman') and cname != 'Hoffman';

#Extract all the orders of Motika.
select onum from orders	where snum = ( select snum from salespeople where sname = 'Motika');

#All orders credited to the same salesperson who services Hoffman.
Select onum, sname, cname, amt from orders a, salespeople b, cust c where a.snum = b.snum and a.cnum = c.cnum and a.snum = ( select snum from orders where cnum = ( select cnum from cust where cname = 'Hoffman')); 

#All orders that are greater than the average for Oct 4.
select *  from orders where amt > ( select avg(amt)  from orders where odate = STR_TO_DATE('03-OCT-94', '%d-%b-%y'));

#Find average commission of salespeople in london.
select avg(comm) from salespeople where city = 'London';

#Find all orders attributed to salespeople servicing customers in london.
select snum, cnum  from orders where cnum in (select cnum  from cust where city = 'London'); 

#Extract commissions of all salespeople servicing customers in London.
select comm from salespeople where snum in (select snum from cust where city = 'London');

#Find all customers whose cnum is 1000 above the snum of serres.
select cnum, cname from cust where cnum > ( select snum+1000  from salespeople where sname = 'Serres');

SELECT COUNT(*)
FROM CUST
WHERE RATING > (
    SELECT AVG(RATING)
    FROM CUST
    WHERE CITY = 'San Jose'
);
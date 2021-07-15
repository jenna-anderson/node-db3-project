-- Multi-Table Query Practice

-- Display the ProductName and CategoryName for all products in the database. Shows 77 records.
select p.productname, c.categoryname
from product as p
left join category as c
    on c.id = p.categoryid;

-- Display the order Id and shipper CompanyName for all orders placed before August 9 2012. Shows 429 records.
select o.id, o.shipname, o.orderdate
from 'order' as o
where orderdate < '2012-08-09';

-- Display the name and quantity of the products ordered in order with Id 10251. Sort by ProductName. Shows 3 records.
select p.productname, od.quantity
from orderdetail as od
join product as p
    on p.id = od.productid
where od.orderid = 10251;

-- Display the OrderID, Customer's Company Name and the employee's LastName for every order. All columns should be labeled clearly. Displays 16,789 records.
select o.id as 'orderid', c.companyname, e.lastname
from 'order' as o
join customer as c
    on c.id = o.customerid
join employee as e
    on e.id = o.employeeid;



-- STRETCH

--Find the number of shipments by each shipper
select  s.companyname as shipper, count(s.companyname) as 'number of shipments'
from shipper as s
left join 'order' as o
    on o.shipvia = s.id
group by s.companyname

--Find the 5 best performing employees measured in number of orders
select e.firstname, e.lastname, count(e.id) as 'number of orders'
from 'order' as o
join employee as e
    on e.id = o.employeeid
group by e.id
order by count(e.id) desc
limit 5;


--Find the top 5 best performing employees measured in revenue (hint: you can do things like sum(quantity * price) )
select 
    e.firstname, 
    e.lastname, 
    round(
        sum(
            (od.unitprice * od.quantity) 
                - od.discount * od.unitprice * od.quantity
            )
        ,2) as totalrevenue
from 'order' as o
join employee as e
    on e.id = o.employeeid
join orderdetail as od
    on od.orderid = o.id
group by e.id
order by totalrevenue desc
limit 5;

--Find the category that brings in the most revenue
select 
    c.categoryname,
    round(sum(od.quantity * od.unitprice 
        - od.discount * od.quantity * od.unitprice),2) as revenue
from orderdetail as od
join product as p
    on p.id = od.productid
join category as c
    on c.id = p.categoryid
group by c.id
order by revenue desc
limit 1;

--Find the customer country with the most orders
select c.country, count(o.id) as totalorders
from customer as c
join 'order' as o
    on o.customerid = c.id
group by c.country
order by totalorders desc
limit 1;

--Find the shipper that moves the most cheese measured in units
select s.companyname, count(od.quantity) as totalUnitsOfCheeseShipped
from shipper as s
join 'order' as o
    on o.shipvia = s.id
join orderdetail as od
    on od.orderid = o.id
join product as p
    on p.id = od.productid
join category as c
    on c.id = p.categoryid
where c.id = 4
group by s.id
order by totalUnitsOfCheeseShipped desc
limit 1;
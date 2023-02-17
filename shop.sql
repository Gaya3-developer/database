CREATE TABLE customer (
  customer_id int(11) NOT NULL,
  customer_name varchar(200) DEFAULT NULL
) 
insert into customer(customer_id,customer_name) values ('1','John');
insert into customer(customer_id,customer_name) values ('2','Smith');
insert into customer(customer_id,customer_name) values ('3','Ricky');
insert into customer(customer_id,customer_name) values ('4','Walsh');
insert into customer(customer_id,customer_name) values ('5','Stefen');
insert into customer(customer_id,customer_name) values ('6','Fleming');
insert into customer(customer_id,customer_name) values ('7','Thomson');
insert into customer(customer_id,customer_name) values ('8','David');

create table product(
	product_id int not null primary key,
	product_name varchar(200) not null,
	product_price bigint not null,
	
);
INSERT INTO product(product_id, product_name, product_price) VALUES
(1, 'Television', 19000),
(2, 'DVD', 3600),
(3, 'Washing Machine', 7600),
(4, 'Computer', 35900),
(5, 'Ipod', 3210),
(6, 'Panasonic Phone', 2100),
(7, 'Chair', 360),
(8, 'Table', 490),
(9, 'Sound System', 12050),
(10, 'Home Theatre', 19350);
create table orders (
	order_id int not null primary key,
	customer_id int not null,
	order_date date not null,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

insert into orders(order_id, customer_id, order_date) values('1','4','2005-01-10')
insert into orders(order_id, customer_id, order_date) values('2','2','2006-02-10')
insert into orders(order_id, customer_id, order_date) values('3','3','2005-03-20')
insert into orders(order_id, customer_id, order_date) values('4','3','2006-03-06')
insert into orders(order_id, customer_id, order_date) values('5','1','2007-04-05')
insert into orders(order_id, customer_id, order_date) values('6','7','2006-12-13')
insert into orders(order_id, customer_id, order_date) values('7','6','2008-03-13')
insert into orders(order_id, customer_id, order_date) values('8','6','2004-11-29')
insert into orders(order_id, customer_id, order_date) values('9','5','2005-01-13')
insert into orders(order_id, customer_id, order_date) values('10','1','2007-12-12')


create table order_details(
order_details_id int not null primary key,
	order_id int not null,
	product_id int not null,
	quantity int not null,
	foreign key (order_id) references orders(order_id),
	foreign key (product_id) references product(product_id)
);


insert into order_details(order_details_id,order_id,product_id,quantity) values ('1','1','3','1');
insert into order_details(order_details_id,order_id,product_id,quantity) values ('2','1','2','3');
insert into order_details(order_details_id,order_id,product_id,quantity) values ('3','2','10','2');
insert into order_details(order_details_id,order_id,product_id,quantity) values ('4','3','7','10');
insert into order_details(order_details_id,order_id,product_id,quantity) values ('5','3','4','2');
insert into order_details(order_details_id,order_id,product_id,quantity) values ('6','3','5','4');
insert into order_details(order_details_id,order_id,product_id,quantity) values ('7','4','3','1');
insert into order_details(order_details_id,order_id,product_id,quantity) values ('8','5','1','2');
insert into order_details(order_details_id,order_id,product_id,quantity) values ('9','5','2','1');
insert into order_details(order_details_id,order_id,product_id,quantity) values ('10','6','5','1');
insert into order_details(order_details_id,order_id,product_id,quantity) values ('11','7','6','1');
insert into order_details(order_details_id,order_id,product_id,quantity) values ('12','8','10','2');
insert into order_details(order_details_id,order_id,product_id,quantity) values ('13','8','3','1');
insert into order_details(order_details_id,order_id,product_id,quantity) values ('14','9','10','3');
insert into order_details(order_details_id,order_id,product_id,quantity) values ('15','10','1','1');

--Fetch all the Customer Details along with the product names that the customer has ordered.
1. select c.customer_id,c.customer_name,od.order_id,od.product_id,p.product_name from orders o
join customer c on o.customer_id = c.customer_id
join order_details od on o.order_id = od.order_id
join product p on od.product_id = p.product_id
order by c.customer_id

or 

select c.customer_id,c.customer_name,od.order_id,od.product_id,p.product_name
from 
customer c, orders o, order_details od, product p
where
c.customer_id= o.customer_id and od.order_id=o.order_id and od.product_id = p.product_id
order by c.customer_id;

or

select c.customer_id,c.customer_name,prd.order_id,prd.product_id,prd.product_name from customer c 
left join 
(select o.order_id,o.customer_id,p.product_id,p.product_name from orders o
join order_details od on o.order_id = od.order_id
join product p on od.product_id = p.product_id								 )
as prd on c.customer_id = prd.customer_id
order by c.customer_id
--Fetch Order_Id, Ordered_Date, Total Price of the order (product price*qty).

2. select o.order_id, o.order_date, order_det.product_id,order_det.product_name,
order_det.product_price,order_det.quantity, (order_det.product_price * order_det.quantity) as total_price from orders o
left join (
	select od.order_id,p.product_id,p.product_name,p.product_price,od.quantity from order_details od
	join product p on od.product_id = p.product_id
) as order_det on o.order_id = order_det.order_id
order by o.order_id


or 

select o.order_id, o.order_date, p.product_id,p.product_name,
p.product_price,od.quantity, 
(p.product_price * od.quantity) as total_price 
from orders o
join  order_details od on o.order_id = od.order_id
join product p on od.product_id = p.product_id
order by o.order_id
--Fetch the Customer Name, who has not placed any order

3. select * from customer 
where not customer_id  in (select customer_id from orders)

or 
select * from customer 
where not customer_id  in (select customer_id from orders o, order_details od
						  where o.order_id = od.order_id)
--Fetch the Product Details without any order(purchase)
	  
						  4. select * from product 
where not product_id  in (select product_id from  order_details
						 )
						 
--Fetch the Customer name along with the total Purchase Amount
						 
5. select c.customer_id,c.customer_name,
sum(COALESCE((ord.quantity*ord.product_price),0)) as total_price
from customer c
left join (
select o.customer_id,p.product_id,p.product_name,od.quantity,p.product_price 
	from orders o
	join order_details od on o.order_id = od.order_id
	join product p on p.product_id = od.product_id
) as ord on c.customer_id = ord.customer_id
group by c.customer_id
order by c.customer_id

or

select c.customer_id,c.customer_name,
sum(COALESCE((od.quantity*p.product_price),0)) as total_price 
from customer c
 join orders o on c.customer_id = o.customer_id
	join order_details od on o.order_id = od.order_id
	join product p on p.product_id = od.product_id

group by c.customer_id
order by c.customer_id


--Fetch the Customer details, who has placed the first and last order
6.	
(select c.customer_id,c.customer_name,o.order_id,o.order_date from orders o,customer c where c.customer_id=o.customer_id  order by order_date asc limit 1)
UNION ALL
(select c.customer_id,c.customer_name,o.order_id,o.order_date from orders o,customer c where c.customer_id=o.customer_id order by order_date desc limit 1)

--Fetch the customer details , who has placed more number of orders

7.select c.customer_id,c.customer_name,order_count.ordercount,o.order_id from 
(select order_id, count(order_id)as ordercount from order_details group by order_id
having count(order_id) = (
select max(mycount)  from (select count(order_id) as mycount from order_details group by order_id) as o)
) as order_count join orders o on o.order_id = order_count.order_id
join customer c on c.customer_id = o.customer_id


--Fetch the customer details, who has placed multiple orders in the same year
8.
select c.customer_id,c.customer_name, max(order_count) as max_order_count,oc.fullyear from
(select o.customer_id as cust_id,count(*) as order_count,date_part('year', o.order_date) as fullyear 
 from orders o
join order_details od on od.order_id=o.order_id
group by o.customer_id,fullyear 
having count(*) > 1 
order by customer_id) as oc
join customer c on c.customer_id = oc.cust_id
group by oc.fullyear,c.customer_id


--Fetch the name of the month, in which more number of orders has been placed
9.
select moc.order_id,moc.max_order, to_char(o.order_date, 'Month') AS Month  from (
select od.order_id,count(*) as max_order from order_details od
group by od.order_id
having count(*) = (
select max(order_count) from (
select count(*) as order_count from order_details group by order_id
) as oc
)
) as moc join orders o on moc.order_id=o.order_id



--Fetch the maximum priced Ordered Product
10.
select  od.order_id, sum(od.quantity*p.product_price) as max_price,p.product_name from order_details od
join product p on od.product_id = p.product_id
group by od.order_id,p.product_id
having sum(od.quantity*p.product_price) = (
select max(max_price) from (
	select sum(od.quantity*p.product_price) as max_price from order_details od
	join product p on od.product_id = p.product_id
	group by od.order_id,p.product_id
) as mxprice
)
order by od.order_id






					










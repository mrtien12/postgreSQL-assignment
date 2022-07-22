--task 1
--create index country_info on customers(country)
--select * from customers
--where country = 'Canada'

--task 2
--create index cost on orders(netamount)
--select * from orders 
--where netamount > 100

--task 3
--create index total on orders(totalamount)
--select * from orders
--where totalamount > 100

--task 4
--select p.title, count(ol.prod_id) as quantities
--from orderlines ol
--inner join  products p on ol.prod_id = p.prod_id
--group by ol.prod_id,p.title

--task 5
--select ord.customerid, concat(firstname,' ', lastname) as fullname from customers cus
--inner join orders ord on cus.customerid = ord.customerid

--task 6
--select cus.customerid, concat(firstname,' ', lastname) as fullname from customers cus
--left join orders ord on cus.customerid = ord.customerid
--where ord.customerid is NULL

--task 7
--select ord.customerid, concat(firstname,' ', lastname) as fullname, sum(ord.totalamount)
--from customers cus
--inner join orders ord on cus.customerid = ord.customerid
--group by ord.customerid, concat(firstname,' ', lastname) 

--task 8
--select prod_id, sum(quantity) 
--from orderlines
--group by prod_id
--order by prod_id

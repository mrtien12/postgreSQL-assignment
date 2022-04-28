select count(BusinessEntityID) from HumanResources.Employee
------------------
alter table add FullName nvarchar(150) null 
update Person.Person
set fullname = rtrim(concat(FirstName + ' ', MiddleName + ' ', LastName + ' '))

select d.FullName,count(OrderQty) as quantity from Sales.SalesOrderDetail as a
inner join 	Sales.SalesOrderHeader as b on b.SalesOrderID = a.SalesOrderID
inner join Sales.Customer as c on c.CustomerID = b.CustomerID
inner join Person.Person as d on c.PersonID = d.BusinessEntityID
group by FullName
having count(OrderQty) > 10


-------------------------
select b.Name,count(OrderQty) as quantity from Sales.SalesOrderDetail as a 
full outer join Production.Product as b on a.ProductID = b.ProductID
group by b.Name
having count(OrderQty) < 1


--Movies Table
Create Table Movies
( Id int Primary key Identity (1,1) not null,
 Title Varchar(50) not null,
 Director Varchar(50) not null,
 ReleaseYear int not null,
 Price decimal(6,2) not null,
)

--Insert Values in Movies Table
Insert into Movies
values ('Interstellar','Christopher Nolan',2014,179.00)

Insert into Movies
values ('Hobbit:Battle of the five armies','Peter Jackson',2014,179.00)

Insert into Movies
values ('The Wolf of Wall Street','Martin Scorcese',2013,119.00)

Insert into Movies
values ('Pulp Fiction','Quentin Tarantino',1994,49.00)

select * from Movies

--Customers Table
Create Table Customers
( Id int Primary key Identity (1,1) not null,
 Firstname Varchar(50) not null,
 Lastname Varchar(50) not null,
 BillingAddress Varchar(90) not null,
 BillingZip int not null,
 BillingCity Varchar(50) not null,
 DeliveryAddress Varchar(90) not null,
 DeliveryZip int not null,
 DeliveryCity Varchar(90) not null,
 EmailAddress Varchar(50) not null,
 PhoneNumber varchar(50) not null
)

--Insert Values in Customers Table
Insert into Customers
 values ('Jonas','Gray','23 Green Corner Street',56743,'Birmingham','23 Green Corner Street',56743,'Birmingham','jonas.gray@hotmail.com','0708123455')

 Insert into Customers
 values ('Jane','Harolds','10 West Street',43213,'London','10 West Street',43213,'London','jane_h77@gmail.com','0701245512')

 Insert into Customers
 values ('Peter','Birro','12 Fox Street',45581,'New York','89 Moose Plaza',45321,'Seattle','peter_the_great@hotmail.com','0739484322')

  select * from Customers

  --Order Table
  Create Table Orders
  (Id int Primary key Identity (1,1) not null,
  OrderDate date not null,
  CustomerId int FOREIGN KEY REFERENCES Customers(Id) not null 
  )

  --OrderRows Table
  Create Table OrderRows
  (Id int Primary key Identity (1,1) not null,
  OrderId int Foreign Key References Orders(Id) not null,
  MovieId int FOREIGN KEY REFERENCES Movies(Id) not null,
  Price decimal(6,2) not null
  )

 --Insert Values in Orders and OrderRows Table
  Insert into Orders  values('2015-01-01',1);
  insert into OrderRows  values(1,1,179.00);
  insert into OrderRows  values(1,4,49.00);

  Insert into Orders  values('2015-01-15',3);
  insert into OrderRows  values(2,3,119.00);
  insert into OrderRows  values(2,3,119.00);

  Insert into Orders  values('2014-12-20',1);
  insert into OrderRows  values(3,3,119.00);
  Go

  select * from Orders;
 
   select * from OrderRows

   --UPDATE
   --Write a query that changes the price of all movies made in 2014 to 169 kr.
   update Movies
   set Price='169.00'
   where ReleaseYear=2014

   select * from Movies

   -- SELECT
   --A. Get Firstname, Lastname, PhoneNo and Email to all Customers
    Select FirstName,LastName,PhoneNumber,EmailAddress from Customers

   --B. Get all movies, ordered by Year from newest to oldest
   select * from Movies 
   Order by ReleaseYear Desc

   --C. Get all movie titles, ordered by Price, from cheapest to most expensive. 
   select * from Movies 
   Order by Price Asc

   --D. Get Firstname, Lastname, DeliveryAddress, DeliveryZip, DeliveryCity for all customers who bought The Wolf of Wall Street.  
   --Without using JOIN's
  Select FirstName,LastName,DeliveryAddress,DeliveryZip,DeliveryCity from customers where id in
(select customerid from orders where id in
(select orderid from orderRows where movieid in
(select id from Movies where Title='The Wolf of Wall Street')))

--With JOIN's
Select distinct FirstName,LastName,DeliveryAddress,DeliveryZip,DeliveryCity from customers as c
JOIN Orders as o on o.CustomerId=c.Id
JOIN OrderRows as ors on ors.OrderId=o.Id
JOIN Movies as m on ors.MovieId=m.Id and m.Title='The Wolf of Wall Street'

--E. Get Id, Date, Customer (Firstname, Lastname) and total cost of every individual order. 
select o.Id, o.OrderDate, c.Firstname, c.Lastname, sum(ors.Price) as TotalCost from orders as o, customers as c, orderRows as ors
where ors.OrderId = o.id and o.customerid=c.id group by ors.OrderId, o.Id, o.OrderDate, c.Firstname, c.Lastname

--F. (Optional) Get Customer (Firstname, Lastname), total number of movies ordered by this customer, number of orders by this customer and total cost of all orders by this customer
  select c.Firstname, c.Lastname, Count(ors.OrderId) as NoOfMovies, Count(o.CustomerId) as NoOfOrders, 
  sum(ors.price) as TotalCost
  from orders as o, customers as c, orderRows as ors
  where ors.OrderId = o.id and o.customerid=c.id group by c.Firstname, c.Lastname

  --G. (Optional) Get number of orders and total cost for all orders in the database.
  select count(o.Id) as TotalOrders, sum(ors.price) as TotalCost from orders as o, OrderRows as ors
  where o.Id=ors.OrderId
  
   select * from OrderRows

--   COPY  
 -- Add a new column, CellNo to the Customers table. The column should contain the customer’s cellphone number. 
alter table customers
add Cellno varchar(50) 


select * from Customers

--Write a query to copy the information from PhoneNo to CellNo
update Customers
set CellNo=PhoneNumber;

--Write a query to empty the PhoneNo column(Sets it to an empty string) 
update Customers
set PhoneNumber='';
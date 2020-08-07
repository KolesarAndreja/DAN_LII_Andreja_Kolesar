IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'dbBirthdayCakes')
CREATE DATABASE dbBirthdayCakes;
GO
USE dbBirthdayCakes
--dropping tables
IF OBJECT_ID('vwOrder') IS NOT NULL
DROP VIEW vwOrder;

IF OBJECT_ID('tblSingleCakeOrder') IS NOT NULL
DROP TABLE tblSingleCakeOrder;

IF OBJECT_ID('tblOrder') IS NOT NULL 
DROP TABLE tblOrder;

IF OBJECT_ID('tblCake') IS NOT NULL 
DROP TABLE tblCake;

IF OBJECT_ID('tblUser') IS NOT NULL 
DROP TABLE tblUser;

CREATE TABLE tblUser(
	userId INT PRIMARY KEY IDENTITY(1,1),
	fullname VARCHAR(40) NOT NULL,
	phone VARCHAR(12) NOT NULL,
	numberOfOrders INT DEFAULT 0,
	username VARCHAR(30) not null,
	password VARCHAR(30) not null
	);


CREATE TABLE tblCake(
	cakeId INT PRIMARY KEY IDENTITY(1,1),
	cakeName VARCHAR(40) NOT NULL,
	purchasePrice INT NOT NULL,
	salePrice as (1.2*purchasePrice),
	childCake BIT not null
	);


CREATE TABLE tblOrder(
	orderId INT PRIMARY KEY IDENTITY(1,1),
	orderDate DATE NOT NULL,
	userId INT FOREIGN KEY REFERENCES  tblUser(userId)
	);

CREATE TABLE tblSingleCakeOrder(
	singleId INT PRIMARY KEY IDENTITY(1,1),
	orderId INT FOREIGN KEY REFERENCES  tblOrder(orderId),
	totalPrice NUMERIC,
	numberOfCakes INT
	);

GO
CREATE VIEW vwOrder
as
select s.*,o.orderDate,o.userId
from tblSingleCakeOrder s
inner join tblOrder o
on s.orderId = s.orderId

go
INSERT INTO tblCake(cakeName,purchasePrice,childCake)
VALUES('Ljubavno gnezdo', 1000,0),('Lincer',2000,0),('Cheese cake',1200,0),('Dobos', 2500,1), ('Bomba',800,1), ('Kinder',2500,1);
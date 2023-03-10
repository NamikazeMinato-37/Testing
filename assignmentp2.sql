use db;
CREATE TABLE Customer
(
	CustID INT PRIMARY KEY,
	CustName VARCHAR(50),
	City VARCHAR(50),
	Grade INT,
	SalesMan_ID INT
);
INSERT INTO Customer
VALUES
	(3001,'Nick Rimando','New York',100,5001),
	(3002,'Brad Davis','New York',200,5001),
	(3003,'Graham Zusi','California',200,5002),
	(3004,'Julian Green','London',300,5002),
	(3005,'Fabian John','Paris',300,5006),
	(3006,'Geoff Rock','Berlin',100,5003),
	(3007,'Rozy Altidor','Moscow',200,5007),
	(3008,'Brad Gujan','London',300,5005);

CREATE TABLE Orders
(
	OrderNo INT,
	OrderDate DATE,
	Order_Amt INT,
	Cust_ID INT REFERENCES Customer(CustID),
	SalesMan_Id INT,
	Commision Varchar(3)
);
INSERT INTO Orders
VALUES
	(1,'2005/12/22',160,3001,5002,'13%'),
	(9,'2005/08/10',190,3001,5005,'11%'),
	(2,'2005/07/13',500,3002,5001,'15%'),
	(4,'2005/07/15',420,3002,null,'0'),
	(7,'2005/12/22',1000,3003,null,'0'),
	(5,'2006/10/02',820,3004,5001,'15%'),
	(8,'2006/11/03',2000,3004,5001,'15%'),
	(10,'2006/10/09',1500,3005,5006,'14%'),
	(12,'2006/10/20',1800,3005,5003,'12%') ;
select * from Orders;
select * from Customer;   
SELECT c.CustID,c.CustName,Count(o.Cust_ID) NoOfOrders
	FROM Customer c JOIN Orders o ON
	c.CustID=o.Cust_ID
	GROUP BY CustID,CustName;

SELECT o.OrderNo,o.OrderDate,o.Order_Amt,o.Cust_ID
	FROM Orders o
	WHERE o.Cust_ID NOT IN (SELECT c.CustID		
				     FROM Customer as c);
SELECT DISTINCT c.CustName
	FROM Customer c JOIN Orders o ON
	c.CustID=o.Cust_ID
	WHERE MONTH(o.OrderDate)=7 OR MONTH(o.OrderDate)=8;
SELECT c.CustID,c.CustName,o.Order_Amt
	FROM Customer c LEFT OUTER JOIN Orders o ON
	o.Cust_ID=c.CustID
	WHERE O.Order_Amt<(SELECT AVG(Order_Amt) FROM Orders);
SELECT MIN(Order_Amt) MinimumAmt,MAX(Order_Amt) MaximumAmt,AVG(Order_Amt) AverageAmt	
	FROM Orders;
SELECT c.City,COUNT(o.OrderNo) as No_Of_Order,SUM(o.Order_Amt) as Order_Value
	FROM Customer c JOIN Orders o ON
	c.CustID=o.Cust_ID
	GROUP BY City
	ORDER BY Order_Value;
SELECT c.CustID,SUM(o.Order_Amt) as Total
	FROM Customer c JOIN Orders o ON
	c.CustID=o.Cust_ID
	GROUP BY CustID
	ORDER BY Total DESC limit 2;

SELECT c.City,COUNT(*) OrderNo,SUM(o.Order_Amt) MaxOrderAmount
	FROM Customer c JOIN Orders o ON
	c.CustID=o.Cust_ID
	Group by City
	Order BY MaxOrderAmount DESC limit 1;










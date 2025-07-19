# Lesson-17: Practice

> **Notes before doing the tasks:**
> - Tasks should be solved using **SQL Server**.
> - Case insensitivity applies.
> - Alias names do not affect the score.
> - Scoring is based on the **correct output**.
> - One correct solution is sufficient.

---

### 1. You must provide a report of all distributors and their sales by region.  If a distributor did not have any sales for a region, rovide a zero-dollar value for that day.  Assume there is at least one sale for each region

**SQL Setup:**
```sql
DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);
```



**Input:**
```
|Region       |Distributor    | Sales |
|-------------|---------------|--------
|North        |ACE            |   10  |
|South        |ACE            |   67  |
|East         |ACE            |   54  |
|North        |Direct Parts   |   8   |
|South        |Direct Parts   |   7   |
|West         |Direct Parts   |   12  |
|North        |ACME           |   65  |
|South        |ACME           |   9   |
|East         |ACME           |   1   |
|West         |ACME           |   7   |
```

select * from #RegionSales
with ct1 as (
	select Region
	from #RegionSales
	group by Region
),
ct2 as (
	select Distributor
	from #RegionSales
	group by Distributor
) 
select ct1.region, ct2.Distributor, isnull(sales, 0) as Sales
from  ct1 cross join ct2
left join #RegionSales on ct1.region = #RegionSales.region and ct2.Distributor = #RegionSales.Distributor


**Expected Output:**
```
|Region |Distributor   | Sales |
|-------|--------------|-------|
|North  |ACE           | 10    |
|South  |ACE           | 67    |
|East   |ACE           | 54    |
|West   |ACE           | 0     |
|North  |Direct Parts  | 8     |
|South  |Direct Parts  | 7     |
|East   |Direct Parts  | 0     |
|West   |Direct Parts  | 12    |
|North  |ACME          | 65    |
|South  |ACME          | 9     |
|East   |ACME          | 1     |
|West   |ACME          | 7     |
```



---
### 2. Find managers with at least five direct reports

**SQL Setup:**
```sql
CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);
```

**Input:**
```
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
```
**Expected Output:**
```
+------+
| name |
+------+
| John |
+------+
```

select e1.name, count(*)
from Employee e1
join Employee e2 on e1.id = e2.managerId
group by e1.name, e1.id
having count(*) >= 5

```
You cal also solve this puzzle in Leetcode: https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/?envType=study-plan-v2&envId=top-sql-50
```

---

### 3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.

**SQL Setup:**
```sql
CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);
```

**Input:**
```
| product_id  | product_name          | product_category |
+-------------+-----------------------+------------------+
| 1           | Leetcode Solutions    | Book             |
| 2           | Jewels of Stringology | Book             |
| 3           | HP                    | Laptop           |
| 4           | Lenovo                | Laptop           |
| 5           | Leetcode Kit          | T-shirt          |
```



**Expected Output:**
```
| product_name       | unit  |
+--------------------+-------+
| Leetcode Solutions | 130   |
| Leetcode Kit       | 100   |
```
select *
from Products;

select Product_name, unit
from (
	select Product_Id, Sum(Unit) as unit
	from Orders 
	where year(Order_date) = 2020 and month(order_date) = 2
	group by Product_id
) as PRDT
join Products on Products.Product_id = PRDT.Product_ID
where Unit >= 100

---

### 4. Write an SQL statement that returns the vendor from which each customer has placed the most orders


**SQL Setup:**
```sql
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');
```

**Input:**
```
|Order ID   | Customer ID | Order Count|     Vendor     |
---------------------------------------------------------
|Ord195342  |     1001    |      12    |  Direct Parts  |
|Ord245532  |     1001    |      54    |  Direct Parts  |
|Ord344394  |     1001    |      32    |     ACME       |
|Ord442423  |     2002    |      7     |     ACME       |
|Ord524232  |     2002    |      16    |     ACME       |
|Ord645363  |     2002    |      5     |  Direct Parts  |
```

**Expected Output:**
```
| CustomerID | Vendor       |
|------------|--------------|
| 1001       | Direct Parts |
| 2002       | ACME         |
```
with CTE as (
select CustomerID, Max(Count) as MaxCount
from Orders
group by CustomerId
)
select CTE.CustomerID, vendor
from CTE
join Orders on CTE.MaxCount = Orders.Count
---

### 5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime'

**Example Input:**
```sql
DECLARE @Check_Prime INT = 91;
-- Your WHILE-based SQL logic here
``

**Expected Output:**
```
This number is not prime(or "This number is prime")
```
DECLARE @Check_Prime INT = 91;

DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @IsPrime BIT = 1;  -- assume prime

-- Edge case: 1 is not prime
IF @Check_Prime <= 1
BEGIN
    SET @IsPrime = 0;
END
ELSE
BEGIN
    WHILE @i * @i <= @Check_Prime
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END
END

-- Final result
IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

---

### 6. Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.

**SQL Setup:**
```sql
CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');
`

**Expected Output:**
```
| Device_id | no_of_location | max_signal_location | no_of_signals |
|-----------|----------------|---------------------|---------------|
| 12        | 2              | Bangalore           | 6             |
| 13        | 2              | Secunderabad        | 5             |
```
WITH TotalSignals AS (
    SELECT 
        Device_id,
        COUNT(*) AS no_of_signals
    FROM Device
    GROUP BY Device_id
),
LocationCounts AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS signal_count
    FROM Device
    GROUP BY Device_id, Locations
),
MaxLocation AS (
    SELECT 
        Device_id,
        Locations AS max_signal_location,
        ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY COUNT(*) DESC) AS rn
    FROM Device
    GROUP BY Device_id, Locations
),
DistinctLocations AS (
    SELECT 
        Device_id,
        COUNT(DISTINCT Locations) AS no_of_location
    FROM Device
    GROUP BY Device_id
)
SELECT 
    t.Device_id,
    d.no_of_location,
    m.max_signal_location,
    t.no_of_signals
FROM TotalSignals t
JOIN DistinctLocations d ON t.Device_id = d.Device_id
JOIN MaxLocation m ON t.Device_id = m.Device_id AND m.rn = 1
ORDER BY t.Device_id;

---

### 7. Write a SQL  to find all Employees who earn more than the average salary in their corresponding department. Return EmpID, EmpName,Salary in your output

**SQL Setup:**
```sql

CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);
```

**Expected Output:**
```
| EmpID | EmpName | Salary |
|-------|---------|--------|
| 1001  | Mark    | 60000  |
| 1004  | Peter   | 35000  |
| 1005  | John    | 55000  |
| 1007  | Donald  | 35000  |
```

with CTE as (
	select Avg(Salary) as AVG_Salary, DeptID
	from Employee
	group by DeptID
)
select EmpID, EmpName, Salary from CTE 
join Employee on CTE.DeptID = Employee.DeptID and Salary >= Avg_Salary

select * 
from Employee
---

### 8. You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each tickets chosen numbers.  If a ticket has some but not all the winning numbers, you win $10.  If a ticket has all the winning numbers, you win $100.    Calculate the total winnings for todays drawing.

**Winning Numbers:**
```
|Number|
--------
|  25  |
|  45  |
|  78  |

```


**Tickets:**
```
| Ticket ID | Number |
|-----------|--------|
| A23423    | 25     |
| A23423    | 45     |
| A23423    | 78     |
| B35643    | 25     |
| B35643    | 45     |
| B35643    | 98     |
| C98787    | 67     |
| C98787    | 86     |
| C98787    | 91     |

-- Step 1: Create the table
CREATE TABLE Numbers (
    Number INT
);

-- Step 2: Insert values into the table
INSERT INTO Numbers (Number)
VALUES
(25),
(45),
(78);


-- Step 1: Create the Tickets table
CREATE TABLE Tickets (
    TicketID VARCHAR(10),
    Number INT
);

-- Step 2: Insert the data into the table
INSERT INTO Tickets (TicketID, Number)
VALUES
('A23423', 25),
('A23423', 45),
('A23423', 78),
('B35643', 25),
('B35643', 45),
('B35643', 98),
('C98787', 67),
('C98787', 86),
('C98787', 91);


```

**Expected Output would be $110, as you have one winning ticket, and one ticket that has some but not all the winning numbers.**

-- Step 1: Count matches per ticket
WITH MatchCount AS (
    SELECT 
        t.TicketID,
        COUNT(*) AS MatchedNumbers
    FROM Tickets t
    JOIN Numbers n ON t.Number = n.Number
    GROUP BY t.TicketID
),

-- Step 2: Assign prize based on matches
Prize AS (
    SELECT 
        TicketID,
        CASE 
            WHEN MatchedNumbers = 3 THEN 100
            WHEN MatchedNumbers IN (1, 2) THEN 10
            ELSE 0
        END AS PrizeAmount
    FROM MatchCount
)

-- Step 3: Sum the total winnings
SELECT SUM(PrizeAmount) AS TotalWinnings
FROM Prize;


---

### 9. The Spending table keeps the logs of the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile devices.

## Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.

**SQL Setup:**
```sql
CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);
```

**Expected Output:**
```
| Row | Spend_date | Platform | Total_Amount | Total_users |
|-----|------------|----------|--------------|-------------|
| 1   | 2019-07-01 | Mobile   | 100          | 1           |
| 2   | 2019-07-01 | Desktop  | 100          | 1           |
| 3   | 2019-07-01 | Both     | 200          | 1           |
| 4   | 2019-07-02 | Mobile   | 100          | 1           |
| 5   | 2019-07-02 | Desktop  | 100          | 1           |
| 6   | 2019-07-02 | Both     | 0            | 0           |
```

WITH UsagePerDay AS (
  SELECT 
    User_id,
    Spend_date,
    MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS UsedMobile,
    MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS UsedDesktop,
    SUM(Amount) AS TotalAmount
  FROM Spending
  GROUP BY User_id, Spend_date
),
LabeledUsage AS (
  SELECT
    Spend_date,
    CASE 
      WHEN UsedMobile = 1 AND UsedDesktop = 1 THEN 'Both'
      WHEN UsedMobile = 1 THEN 'Mobile'
      WHEN UsedDesktop = 1 THEN 'Desktop'
    END AS Platform,
    TotalAmount,
    User_id
  FROM UsagePerDay
),
FinalStats AS (
  SELECT 
    Spend_date,
    Platform,
    SUM(TotalAmount) AS Total_Amount,
    COUNT(DISTINCT User_id) AS Total_users
  FROM LabeledUsage
  GROUP BY Spend_date, Platform
)
-- Include all possible date/platform combinations
SELECT 
  d.Spend_date,
  p.Platform,
  ISNULL(f.Total_Amount, 0) AS Total_Amount,
  ISNULL(f.Total_users, 0) AS Total_users
FROM 
  (SELECT DISTINCT Spend_date FROM Spending) d
CROSS JOIN 
  (SELECT 'Mobile' AS Platform UNION SELECT 'Desktop' UNION SELECT 'Both') p
LEFT JOIN 
  FinalStats f
  ON d.Spend_date = f.Spend_date AND p.Platform = f.Platform
ORDER BY d.Spend_date, 
         CASE 
           WHEN p.Platform = 'Mobile' THEN 1
           WHEN p.Platform = 'Desktop' THEN 2
           WHEN p.Platform = 'Both' THEN 3
         END;

---


### 10. Write an SQL Statement to de-group the following data.

**Input Table: 'Grouped'**
```
|Product  |Quantity|
--------------------
|Pencil   |   3    |
|Eraser   |   4    |
|Notebook |   2    |
```

**Expected Output:**
```
|Product  |Quantity|
--------------------
|Pencil   |   1    |
|Pencil   |   1    |
|Pencil   |   1    |
|Eraser   |   1    |
|Eraser   |   1    |
|Eraser   |   1    |
|Eraser   |   1    |
|Notebook |   1    |
|Notebook |   1    |
```

**SQL Setup:**
```sql
DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);


-- Step 1: Create a numbers (tally) table from 1 to max Quantity
WITH Numbers AS (
    SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM master..spt_values -- system table with many rows
),
Expanded AS (
    SELECT 
        g.Product,
        1 AS Quantity
    FROM Grouped g
    JOIN Numbers n ON n.n <= g.Quantity
)
SELECT * 
FROM Expanded
ORDER BY Product;

---

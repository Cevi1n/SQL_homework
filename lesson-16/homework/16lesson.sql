# Lesson-16: CTEs and Derived Tables

> **Notes before doing the tasks:**
> - Tasks should be solved using **SQL Server**.
> - Case insensitivity applies.
> - Alias names do not affect the score.
> - Scoring is based on the **correct output**.
> - One correct solution is sufficient.

---
# Easy Tasks

1. Create a numbers table using a recursive query from 1 to 1000.

with cte as (
Select 1 as number
union all
Select number+1 from cte where number <= 999
)
Select * from cte

2. Write a query to find the total sales per employee using a derived table.(Sales, Employees)

select *
from employees e
join (
	select EmployeeID, 
	Sum(SalesAmount) As TotalSales
	from Sales
	Group By EmployeeID
) s on e.EmployeeID = s.EmployeeID 
;

3. Create a CTE to find the average salary of employees.(Employees)

With CTE as (
	Select Avg(Salary) as AVG_Salary
	from Employees
)
select AVG_Salary from CTE


4. Write a query using a derived table to find the highest sales for each product.(Sales, Products)

select MaxSaleslAmount.ProductID, ProductName, MaxSaleslAmount
from (
	select ProductID, Max(SalesAmount) as MaxSaleslAmount 
	from Sales 
	group by ProductID
	) as MaxSaleslAmount
join Products  on Products.ProductID = MaxSaleslAmount.PRoductID
;

5. Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.

WITH DoubledNumbers AS (
    SELECT 1 AS Number
    UNION ALL
    SELECT Number * 2
    FROM DoubledNumbers
    WHERE Number * 2 < 1000000
)
SELECT *
FROM DoubledNumbers;

6. Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)

select *
from sales;

select *
from Employees;

with Cte as (
	select EmployeeID, Count(*) as Saless
	from Sales
	group by EmployeeID
)
select C.EmployeeID, FirstName + ' ' + LastName as Name
from Cte C
join Employees E on E.EmployeeID = C.EmployeeID
where C.Saless > 5

7. Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)

select *
from Sales;

with CTE as (
	select ProductID, MAX(SalesAmount) as TotalAmount
	from Sales
	group by ProductID
)
Select ProductName
from CTE C
join Products P on P.ProductID = C.ProductID

8. Create a CTE to find employees with salaries above the average salary.(Employees)

with CTE as (
	select Avg(Salary) as AVG_Salary
	from Employees
)
select FirstName + ' ' + LastName, Salary, EmployeeID, DepartmentID
from CTE
join Employees on Salary > AVG_Salary

# Medium Tasks
1. Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)

SELECT TOP 5
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    s.OrderCount
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        COUNT(*) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
) s ON e.EmployeeID = s.EmployeeID
ORDER BY s.OrderCount DESC;


2. Write a query using a derived table to find the sales per product category.(Sales, Products)

select SDT.ProductID, CategoryID, ProductName, Price
from (
	select ProductID, Sum(SalesAmount) as TotalAmount
	from Sales
	group by ProductID) as SDT
join Products P on P.ProductID = SDT.ProductID

3. Write a script to return the factorial of each value next to it.(Numbers1)

WITH Factorials AS (
    --Boshlanish: har bir son uchun 1 dan boshlaymiz
    SELECT 
        n.Number,
        1 AS Step,
        1 AS Factorial
    FROM Numbers1 n

    UNION ALL

    -- Rekursiv bosqich: Step * Factorial
    SELECT 
        f.Number,
        f.Step + 1,
        f.Factorial * (f.Step + 1)
    FROM Factorials f
    WHERE f.Step + 1 <= f.Number
)
-- Yakuniy natija: har bir Number uchun maksimal Step = Number bo‘lgan faktorial
SELECT 
    Number,
    MAX(Factorial) AS Factorial
FROM Factorials
GROUP BY Number
OPTION (MAXRECURSION 1000);  -- Rekursiya chegarasi oshirilgan

4. This script uses recursion to split a string into rows of substrings for each character in the string.(Example)

WITH SplitChars AS (
    -- Boshlanish: 1-pozitsiyadagi harf
    SELECT 
        Id,
        1 AS Position,
        SUBSTRING(String, 1, 1) AS Character
    FROM Example
    WHERE LEN(String) >= 1

    UNION ALL

    -- Har safar keyingi pozitsiyadagi harfni ajratish
    SELECT 
        s.Id,
        s.Position + 1,
        SUBSTRING(e.String, s.Position + 1, 1) AS Character
    FROM SplitChars s
    JOIN Example e ON e.Id = s.Id
    WHERE s.Position + 1 <= LEN(e.String)
)
SELECT 
    Id,
    Position,
    Character
FROM SplitChars
ORDER BY Id, Position
OPTION (MAXRECURSION 1000);

select *
from example


5. Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)

WITH MonthlySales AS (
    SELECT 
        FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY FORMAT(SaleDate, 'yyyy-MM')
),
SalesDiff AS (
    SELECT 
        SaleMonth,
        TotalSales,
        LAG(TotalSales) OVER (ORDER BY SaleMonth) AS PrevMonthSales
    FROM MonthlySales
)
SELECT 
    SaleMonth,
    TotalSales,
    PrevMonthSales,
    TotalSales - ISNULL(PrevMonthSales, 0) AS SalesDifference
FROM SalesDiff;


6. Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)

SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    t.Quarter,
    t.TotalSales
FROM
    (
        SELECT 
            EmployeeID,
            DATEPART(QUARTER, SaleDate) AS Quarter,
            SUM(SalesAmount) AS TotalSales
        FROM Sales
        GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
        HAVING SUM(SalesAmount) > 45000
    ) AS t
JOIN Employees e ON e.EmployeeID = t.EmployeeID;


# Difficult Tasks
1. This script uses recursion to calculate Fibonacci numbers

WITH Fibonacci (n, value) AS (
    SELECT 1, 0
    UNION ALL
    SELECT 2, 1
    UNION ALL
    SELECT n + 1, 
           (SELECT f1.value + f2.value 
            FROM Fibonacci f1, Fibonacci f2 
            WHERE f1.n = Fibonacci.n - 1 AND f2.n = Fibonacci.n - 2)
    FROM Fibonacci


2. Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)

SELECT *
FROM FindSameCharacters
WHERE LEN(Vals) > 1
  AND LEN(REPLACE(Vals, LEFT(Vals, 1), '')) = 0;


3. Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)

DECLARE @n INT = 5;

WITH Numbers AS (
    SELECT 1 AS num, CAST('1' AS VARCHAR(MAX)) AS Sequence
    UNION ALL
    SELECT num + 1, Sequence + CAST(num + 1 AS VARCHAR)
    FROM Numbers
    WHERE num + 1 <= @n
)
SELECT Sequence
FROM Numbers
OPTION (MAXRECURSION 100);


4. Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)

SELECT TOP 1 e.EmployeeID, e.FirstName, e.LastName, t.TotalSales
FROM (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
) AS t
JOIN Employees e ON e.EmployeeID = t.EmployeeID
ORDER BY t.TotalSales DESC;


5. Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)

-- Misol: '1233435' → qolishi kerak: '1345' (faqat 1 marta qatnashganlar)

WITH SplitChars AS (
    SELECT 
        PawanName,
        Pawan_slug_name,
        SUBSTRING(Pawan_slug_name, Number, 1) AS digit
    FROM RemoveDuplicateIntsFromNames
    JOIN master..spt_values
        ON Number BETWEEN 1 AND LEN(Pawan_slug_name)
    WHERE type = 'P'
        AND SUBSTRING(Pawan_slug_name, Number, 1) LIKE '[0-9]'
),
Filtered AS (
    SELECT PawanName, digit
    FROM SplitChars
    GROUP BY PawanName, digit
    HAVING COUNT(*) = 1
)
SELECT DISTINCT PawanName,
       STRING_AGG(digit, '') WITHIN GROUP (ORDER BY digit) AS CleanedDigits
FROM Filtered
GROUP


```sql

CREATE TABLE Numbers1(Number INT)

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')



CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )





CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL
);


INSERT INTO Example VALUES('123456789'),('abcdefghi');


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'García', 77000.00),
(10, 1, 'William', 'Martínez', 69000.00);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Finance'),
(5, 'IT'),
(6, 'Operations'),
(7, 'Customer Service'),
(8, 'R&D'),
(9, 'Legal'),
(10, 'Logistics');

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);
```

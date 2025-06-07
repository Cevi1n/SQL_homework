# Lesson 3: Importing and Exporting Data

✅ Importing Data (BULK INSERT, Excel, Text)
✅ Exporting Data (Excel, Text)
✅ Comments, Identity column, NULL/NOT NULL values
✅ Unique Key, Primary Key, Foreign Key, Check Constraint
✅ Differences between UNIQUE KEY and PRIMARY KEY

> **Notes before doing the tasks:**
> - Tasks should be solved using **SQL Server**.
> - Case insensitivity applies.
> - Alias names do not affect the score.
> - Scoring is based on the **correct output**.
> - One correct solution is sufficient.

______________________________________

## 🟢 Easy-Level Tasks (10)
1. Define and explain the purpose of BULK INSERT in SQL Server.

BULK INSERT is a SQL Server command used to quickly and efficiently load large amounts of data from an external file (e.g., CSV) into a table.

2. List four file formats that can be imported into SQL Server.

.csv – Comma-separated values

.txt – Plain text

.xml – XML files

.json – JSON files

3. Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).

Create table Products (ProductID INT PRIMARY KEY, ProductName VARCHAR(50), Price DECIMAL(10,2))

4. Insert three records into the Products table using INSERT INTO.

Insert Into Products values (1, 'Dazmol', 50000), 
(2, 'Telivizor', 1000000),
(3, 'Kompyuter', 2500000)

5. Explain the difference between NULL and NOT NULL.

NULL: Indicates that the data is missing or empty (no value).

NOT NULL: The data must be present (cannot be empty).

6. Add a UNIQUE constraint to the ProductName column in the Products table.

Alter table Products
add constraint Uq_ProductName Unique (ProductName)

7. Write a comment in a SQL query explaining its purpose.

 Write a comment in a SQL query explaining its purpose.

-- This query inserts a new product into the Products table
INSERT INTO Products (ProductID, ProductName, Price)
VALUES (4, 'Monitor', 150.00);

8. Add CategoryID column to the Products table.

Alter table Products
Add CategoryID int

9. Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.

Create table Categories(CategoryID Int Primary key, CategoryName varchar(30) unique)

10. Explain the purpose of the IDENTITY column in SQL Server.

The IDENTITY column auto-generates unique numeric values for each row, often used for primary keys.

## 🟠 Medium-Level Tasks (10)

11. Use BULK INSERT to import data from a text file into the Products table.

Bulk insert Products
From 'C:\Users\user\Desktop\Maab SSQ\id, name, age.txt'
With(Fieldterminator = ',', Rowterminator = '\n', Firstrow = 2)

12. Create a FOREIGN KEY in the Products table that references the Categories table.

 Alter table Products
 Add constraint Fk_products_Categories
 Foreign Key (CategoryID)
 References Categories(CategoryID)


13. Explain the differences between PRIMARY KEY and UNIQUE KEY.

PRIMARY KEY: Ensures values are unique and not null. Only one per table is allowed.
UNIQUE KEY: Ensures values are unique, but nulls are allowed. You can have multiple unique keys in one table.

14. Add a CHECK constraint to the Products table ensuring Price > 0.

Alter table Products
add constraint Check_price
Check (Price > 0)

15. Modify the Products table to add a column Stock (INT, NOT NULL).

Alter table Products
Add Stock int not null

16. Use the ISNULL function to replace NULL values in Price column with a 0.

Update Products
set Price = 0
where Price is Null

17. Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.

FOREIGN KEY constraint links to a column in another table. It ensures data integrity by allowing only existing values to be inserted.

## 🔴 Hard-Level Tasks (10)
18. Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.

Create table Customers (CustoerID int primary key, name varchar(50), age int check (age >= 18))

19. Create a table with an IDENTITY column starting at 100 and incrementing by 10.

Create table Invoice (InvoiceID int Identity(100, 10) Primary key, Amount decimal(10,2))

20. Write a query to create a composite PRIMARY KEY in a new table OrderDetails.

Create table ORderdetails (ORderID int, ProductID int, Quantity int,  Primary key (OrderID, ProductID))

21. Explain the use of COALESCE and ISNULL functions for handling NULL values.

ISNULL(expr, replacement) – Returns replacement if expr is NULL.

COALESCE(expr1, expr2, ...) – Returns the first non-NULL value from the list.

SELECT ISNULL(NULL, 'Default')         -- Output: 'Default'
SELECT COALESCE(NULL, NULL, 'Value')   -- Output: 'Value'

22. Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.

Create table Employees(EmpID int Primary Key, name varchar(50), Email varchar(50) unique)

23. Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerID INT,
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID)
ON DELETE CASCADE
ON UPDATE CASCADE

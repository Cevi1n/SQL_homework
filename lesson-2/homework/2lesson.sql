# Lesson 2: DDL and DML Commands

> **Notes before doing the tasks:**
> - Tasks should be solved using **SQL Server**.
> - Case insensitivity applies.
> - Alias names do not affect the score.
> - Scoring is based on the **correct output**.
> - One correct solution is sufficient.

---

### **Basic-Level Tasks (10)**  
1. Create a table `Employees` with columns: `EmpID` INT, `Name` (VARCHAR(50)), and `Salary` (DECIMAL(10,2)).  

Create table Employees (EmpID int, Name Varchar(50), Salary Decimal(10,2))

2. Insert three records into the `Employees` table using different INSERT INTO approaches (single-row insert and multiple-row insert).  

Insert Into Employees values (1, 'Samandar', 8900000)
Insert Into Employees values (2, 'Izzat', 10000), (3, 'Humoyun', 6000)
Insert Into Employees
Select 4, 'Nurbek', 5000

3. Update the `Salary` of an employee to `7000` where `EmpID = 1`.  

Update Employees 
Set Salary = 7000
Where EmpID = 1

4. Delete a record from the `Employees` table where `EmpID = 2`.  

Delete from Employees
Where EmpID =2

5. Give a brief definition for difference between `DELETE`, `TRUNCATE`, and `DROP`.

DELETE: Removes specific rows from a table based on a WHERE clause. It is DML (Data Manipulation Language), and can be rolled back (if inside a transaction).
TRUNCATE: Removes all rows from a table quickly without logging individual row deletions. It is DDL (Data Definition Language), cannot be rolled back in most databases, and resets identity counters.
DROP: Completely removes the table (or other database object) from the database. It is DDL, and cannot be rolled back. The table structure and data are lost.

6. Modify the `Name` column in the `Employees` table to `VARCHAR(100)`.  

Alter Table Employees
Alter column Name Varchar(50)


7. Add a new column `Department` (`VARCHAR(50)`) to the `Employees` table.  

Alter table Employees
ADD Department Varchar(50)

8. Change the data type of the `Salary` column to `FLOAT`.  

Alter Table Employees
alter column Salary float

9. Create another table `Departments` with columns `DepartmentID` (INT, PRIMARY KEY) and `DepartmentName` (VARCHAR(50)).  

Create Table Departments (DepartmentID Int Primary key, DepartmentName varchar(50))

10. Remove all records from the `Employees` table without deleting its structure.  

Truncate Table Employees 

---

### **Intermediate-Level Tasks (6)**  
11. Insert five records into the `Departments` table using `INSERT INTO SELECT` method(you can write anything you want as data).  

Insert Into Departments
Select 1, 'HR'

Insert Into Departments
Select 2, 'Finance'

Insert Into Departments
Select 3, 'IT'

Insert Into Departments
Select 4, 'Marketing'

Insert Into Departments
Select 5, 'Logistics'


Insert Into Employees
Select 2, 'Samandar', 7000, 'HR'

Insert Into Employees
Select 1, 'Izzat', 5500, 'Finance'

Insert Into Employees
Select 3, 'Humoyun', 4800, 'IT'

Insert Into Employees
Select 4, 'Nurbek', 7200, 'Marketing'

Insert Into Employees
Select 5, 'Behruz', 3000, 'Logistics'


12. Update the `Department` of all employees where `Salary > 5000` to 'Management'. 

Update Employees
Set Department = 'Management'
Where Salary > 5000

13. Write a query that removes all employees but keeps the table structure intact.   

Truncate Table Employees

14. Drop the `Department` column from the `Employees` table.   

Alter Table Employees
Drop Column Department

15. Rename the `Employees` table to `StaffMembers` using SQL commands.  

EXEC sp_rename 'Employees', 'StaffMembers'

16. Write a query to completely remove the `Departments` table from the database.  

Drop table Departments

---

### **Advanced-Level Tasks (9)**        
17. Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)

Create Table Products(ProductID Int Primary Key, ProductName varchar, Category varchar, Price Decimal)

18. Add a CHECK constraint to ensure Price is always greater than 0.

Alter Table Products
ADD Constraint CHK_Price_Positive CHeck(Price > 0)

19. Modify the table to add a StockQuantity column with a DEFAULT value of 50.

Alter table Products
ADD StockQuantity int default 50

20. Rename Category to ProductCategory

EXEC sp_rename 'Products.Category', 'ProductCategory', 'Column'

21. Insert 5 records into the Products table using standard INSERT INTO queries.

Insert Into Products values (1, 'Laptop', 'Electronics', 1000)
--(2, 'Smartphone', 'Electronics', 600.00),
--(3, 'Desk Chair', 'Furniture', 150.00),
--(4, 'Notebook', 'Stationery', 5.00),
--(5, 'Backpack', 'Accessories', 40.00)

22. Use SELECT INTO to create a backup table called Products_Backup containing all Products data.

select * from products

SELECT * INTO Products_Backup
FROM Products;

23. Rename the Products table to Inventory.

EXEC sp_rename 'Products', 'Inventory'

24. Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.

Alter Table Inventory
Alter column Price Float

25. Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to `Inventory` table.

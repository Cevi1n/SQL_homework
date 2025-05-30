# Lesson 1: Introduction to SQL Server and SSMS

> **Notes before doing the tasks:**
> - Tasks should be solved using **SQL Server**.
> - Case insensitivity applies.
> - Alias names do not affect the score.
> - Scoring is based on the **correct output**.
> - One correct solution is sufficient.

## Easy
1. Define the following terms: data, database, relational database, and table.

Data refers to raw facts, figures, or values that have not yet been processed or analyzed. It can be numbers, text, images, or other types of information that can be stored and used for various purposes.

Database:
database is an organized collection of data that allows for easy access, management, and updating. It stores data in a structured format, often electronically, to support efficient retrieval and manipulation.

Relational Database:
A relational database is a type of database that organizes data into tables (also called relations) that are linked to each other based on defined relationships. It uses structured query language (SQL) to manage and query data, and ensures data integrity through constraints and relationships like primary keys and foreign keys.

Table:
table is a collection of related data organized in rows and columns within a database. Each table represents a specific entity (e.g., customers, orders), with columns representing attributes (fields) and rows representing individual records (entries).


2. List five key features of SQL Server.

Data Management and Storage:
SQL Server efficiently stores and manages large amounts of structured data. It supports tables, views, indexes, and various data types, making it ideal for both small and enterprise-level applications.

T-SQL (Transact-SQL):
SQL Server uses Transact-SQL, an enhanced version of SQL, which includes procedural programming, error handling, and transaction control for writing powerful queries and scripts.

Security Features:
SQL Server offers advanced security mechanisms such as authentication (Windows and SQL), encryption, role-based access control, and auditing to protect data from unauthorized access.

High Availability and Disaster Recovery (HA/DR):
Features like Always On Availability Groups, failover clustering, and log shipping help ensure that databases remain available and recoverable in case of hardware failures or disasters.

Business Intelligence (BI) Tools:
SQL Server includes built-in BI tools like SQL Server Integration Services (SSIS), SQL Server Reporting Services (SSRS), and SQL Server Analysis Services (SSAS) for data integration, reporting, and analysis.

3. What are the different authentication modes available when connecting to SQL Server? (Give at least 2)

Windows Authentication Mode
SQL Server Authentication Mode
Mixed Mode Authentication

## Medium
4. Create a new database in SSMS named SchoolDB.

create Database SchoolDB 

5. Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).

create table Students (StudentID INT Primary key, Name VARCHAR(50), Age INT)

6. Describe the differences between SQL Server, SSMS, and SQL.

SQL Server -	Software (DBMS - Stores and manages data
SSMS -	Application (GUI) -	Interface to manage SQL Server
SQL	- Language -	Used to query and manipulate data

## Hard
7. Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.

Dql - Data quary language
select

DML - Data manipulation language
insert
Delete
update

DDL - Data definition language
Create
Drop
Alter
Truncate

DCL - Data control language

Grant
Revoke

TCL - Transaction Control language

Begin transaction
Commit
Rollback

8. Write a query to insert three records into the Students table.

Insert into Students (StudentID, Name, Age) Values(1, 'Samandar', 22)

9. Restore AdventureWorksDW2022.bak file to your server. (write its steps to submit)
   You can find the database from this link :`https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak`

   Steps to Restore AdventureWorksDW2022.bak in SSMS
Open SQL Server Management Studio (SSMS) and connect to your SQL Server instance.

In Object Explorer, right-click on the Databases folder.

Select Restore Database... from the context menu.

In the Restore Database window:

Source:

Select Device.

Click the [...] button next to the device field.

In the Select backup devices window, click Add.

Browse to the location where the AdventureWorksDW2022.bak file is stored, select it, and click OK.

Click OK again to return to the Restore Database window.

Destination:

Ensure the Database field has the name you want for the restored database, e.g., AdventureWorksDW2022.

In the Files tab, optionally verify or change the paths where the database files (MDF and LDF) will be restored.

In the Options tab:

Check Overwrite the existing database (WITH REPLACE) if you are restoring over an existing database.

Optionally, check Close existing connections to destination database if needed.

Click OK to start the restore process.

Wait for the success message:
"The database was restored successfully."


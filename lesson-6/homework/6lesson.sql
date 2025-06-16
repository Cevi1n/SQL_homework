# Lesson-6: Practice

> **Notes before doing the tasks:**
> - Tasks should be solved using **SQL Server**.
> - Case insensitivity applies.
> - Alias names do not affect the score.
> - Scoring is based on the **correct output**.
> - One correct solution is sufficient.

## Puzzle 1: Finding Distinct Values
Question: Explain at least two ways to find distinct values based on two columns.

**Input table (`InputTbl`):**
```
| col1 | col2 |
|------|------|
| a    | b    |
| a    | b    |
| b    | a    |
| c    | d    |
| c    | d    |
| m    | n    |
| n    | m    |
```
**Result should be like this:**
```
| col1 | col2 |
|------|------|
| a    | b    |
| c    | d    |
| m    | n    |

```

```sql
CREATE TABLE InputTbl (
    col1 VARCHAR(10),
    col2 VARCHAR(10)
);
    INSERT INTO InputTbl (col1, col2) VALUES 
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c', 'd'),
('c', 'd'),
('m', 'n'),
('n', 'm');
```
select distinct * 
from InputTbl
where col1 < col2;
---

## Puzzle 2: Removing Rows with All Zeroes
**Question: If all the columns have zero values, then don’t show that row. In this case, we have to remove the 5th row while selecting data.**

### Table Schema:
```sql
CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);
```
select *
from TestMultipleZero
where A = 1 or B = 1 or C = 1 or D = 1;

---

## Puzzle 3: Find those with odd ids
```sql
create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')
```

select *
from section1
where id % 2 = 1;

## Puzzle 4: Person with the smallest id (use the table in puzzle 3)

select Top 1 *
from section1
Order by id asc;
---

## Puzzle 5: Person with the highest id (use the table in puzzle 3)

select Top 1 *
from section1
Order by id desc;

---

## Puzzle 6: People whose name starts with b (use the table in puzzle 3)

select *
from section1
where name like 'b%';
---

## Puzle 7: Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).
```sql
CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);

INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');

select *
from ProductCodes
Where Code like '%[_]%';

```

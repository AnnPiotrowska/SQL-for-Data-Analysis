# SQL for Data Analysis

This repository contains my solutions of the quizes that I did as part of Udacity's course [SQL for Data Analysis](https://in.udacity.com/course/sql-for-data-analysis--ud198).

## Course Overview

- [x]  SQL Basic
- [x]  SQL Joins
- [x]  SQL Aggregations
- [x]  SQL Subqueries & Temporary Tables
- [x]  SQL Data Cleaning
- [x]  SQL Window Functions [Advanced]
- [x]  SQL Advanced Joins & Performance Tuning

##

You can restore the toy dataset  "parch and posey" to your local machines from the file **parch_and_posey_db** using the following steps:

1. Open Terminal.
2. Enter PostgreSQL console - `psql` 
3. Create a new database - `CREATE DATABASE parch_and_posey;`
4. Restore into the database - `pg_restore -d parch_and_posey /path/to/parch_and_posey_db`

Now, SQL commands can be used to explore the dataset and run queries on it.

## 

The entire course uses a database called "Parch and Posey" which has info about a paper selling (imaginary)company.

Here is the schema of the database used for all the queries.


![image](https://user-images.githubusercontent.com/81607668/129864934-84e25368-7b19-430e-a5e4-2ab48e2dd9d2.png)

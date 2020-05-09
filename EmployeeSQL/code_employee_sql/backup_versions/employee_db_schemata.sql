--SQL_HOMEWORK
--FILE NAME:  employees_db_schemata.sql
--Rob_Gauer
--DATE:  May 8, 2020

-- DATA MODELING --
-- Create ERD. 
-- Export ERD files to folder:  data_modeling_ERD
-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/

-- DATA ENGINEERING --
-- Create SQL code and load data files into tables.
-- Export SQL database called:  employees_db to folder:  employee_sql_code

-- CREATE TABLES.
-- Create Table departments...
CREATE TABLE "departments" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "dept_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

-- Create Table dept_manager...
CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "emp_no" INTEGER   NOT NULL
);

-- Create Table dept_emp...
CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR(255)   NOT NULL
);

-- Create Table employees...
CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR(255)   NOT NULL,
    "birth_date" DATE,
    "first_name" VARCHAR(255)   NOT NULL,
    "last_name" VARCHAR(255)   NOT NULL,
    "sex" CHAR(255)   NOT NULL,
    "hire_date" DATE,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

-- Create Table salaries...
CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" DEC   NOT NULL
);

-- Create Table titles...
CREATE TABLE "titles" (
    "title_id" VARCHAR(255)   NOT NULL,
    "title" VARCHAR(255)   NOT NULL
);

-- Create constraints and foreign keys...
ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_title_id" FOREIGN KEY("title_id")
REFERENCES "employees" ("emp_title_id");

-- Import data files from folder called:  data
-- Review Table Data... 
--SELECT * FROM employees;
--SELECT * FROM titles;
--SELECT * FROM salaries;
--SELECT * FROM departments;
--SELECT * FROM dept_manager;
--SELECT * FROM dept_emp;

-- If needed, Drop Table Commands.
--DROP TABLE employees
--DROP TABLE titles
--DROP TABLE salaries
--DROP TABLE departments
--DROP TABLE dept_manager
--DROP TABLE dept_emp


-- EOF --

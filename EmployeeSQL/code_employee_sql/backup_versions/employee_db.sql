--SQL_HOMEWORK
--FILE NAME:  employees_db
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


-- DATA ANALYSIS --
-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees LEFT JOIN salaries ON employees.emp_no=salaries.emp_no
ORDER BY employees.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE DATE_PART('year',hire_date) = 1986
ORDER BY emp_no;

-- 3. List the manager of each department with the following information: department number, department name, 
-- the manager's employee number, last name, first name.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
LEFT JOIN employees ON dept_manager.emp_no = employees.emp_no;

-- 4. List the department of each employee with the following information: employee number, last name, 
-- first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees INNER JOIN dept_emp ON employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no=departments.dept_no;

-- 5. List first name, last name, and sex for employees whose first name is "Hercules" and last names 
-- begin with "B."
SELECT employees.first_name, employees.last_name, employees.sex 
FROM employees
WHERE first_name='Hercules'
AND last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, 
-- and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
FROM employees LEFT JOIN dept_emp ON employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no=departments.dept_no
WHERE departments.dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, 
-- last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
FROM employees LEFT JOIN dept_emp ON employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no=departments.dept_no
WHERE departments.dept_name IN ('Sales','Development');

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees 
-- share each last name.
SELECT employees.last_name, COUNT(*) AS frequency_count 
FROM employees
GROUP BY employees.last_name
ORDER BY frequency_count DESC;

-- The following does the same as above, ie. employees table.
--SELECT last_name, COUNT(*) AS frequency_count
--FROM employees
--GROUP BY last_name
--ORDER BY frequency_count DESC;

-- End of Data Analysis.
-- EOF --

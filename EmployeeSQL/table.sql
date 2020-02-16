-- drop existing table (as needed)
drop table departments;
drop table dept_emp;
drop table dept_manager;
drop table employees;
drop table salaries;
drop table titles;

-- create tables and import data into tables

-- departments

create table departments
(
	dept_no VARCHAR(5) not null,
	dept_name VARCHAR(30) not null,
	PRIMARY KEY (dept_no)
);

COPY departments FROM 'C:\Users\ZoeC\Desktop\UMN Data Visualization Bootcamp\sql-challenge\EmployeeSQL\data\departments.csv' DELIMITER ',' CSV HEADER;

select * from departments;

-- employees

create table employees
(
	emp_no INT not null,
	birth_date DATE not null,
	first_name VARCHAR(50) not null,
	last_name VARCHAR(50) not null,
	gender VARCHAR(1) not null,
	hire_date DATE not null,
	PRIMARY KEY (emp_no)
);

copy employees from 'C:\Users\ZoeC\Desktop\UMN Data Visualization Bootcamp\sql-challenge\EmployeeSQL\data\employees.csv'
with (format CSV, HEADER);

select * from employees;

-- dept_emp

create table dept_emp
(
	emp_no INT not null,
	dept_no VARCHAR(5) not null,
	from_date DATE not null,
	to_date DATE not null,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

COPY dept_emp FROM 'C:\Users\ZoeC\Desktop\UMN Data Visualization Bootcamp\sql-challenge\EmployeeSQL\data\dept_emp.csv' DELIMITER ',' CSV HEADER;

select * from dept_emp;

-- dept_manager

create table dept_manager
(
	dept_no VARCHAR(5) not null,
	emp_no INT not null,
	from_date DATE not null,
	to_date DATE not null,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no, dept_no)
);

copy dept_manager from 'C:\Users\ZoeC\Desktop\UMN Data Visualization Bootcamp\sql-challenge\EmployeeSQL\data\dept_manager.csv'
with (format CSV, HEADER);

select * from dept_manager;

-- salaries

create table salaries
(
	emp_no INT not null,
	salary INT not null,
	from_date DATE not null,
	to_date DATE not null,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no, from_date)
);

copy salaries from 'C:\Users\ZoeC\Desktop\UMN Data Visualization Bootcamp\sql-challenge\EmployeeSQL\data\salaries.csv'
with (format CSV, HEADER);

select * from salaries;

-- titles

create table titles
(
	emp_no INT not null,
	title VARCHAR(50) not null,
	from_date DATE not null,
	to_date DATE not null,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);

copy titles from 'C:\Users\ZoeC\Desktop\UMN Data Visualization Bootcamp\sql-challenge\EmployeeSQL\data\titles.csv'
with (format CSV, HEADER);

select * from titles;

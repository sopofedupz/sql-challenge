-- List employee number, last name, first name, gender, and salary
SELECT e.emp_no as "Employee Number", e.last_name as "Last Name", e.first_name as "First Name",
	e.gender as "Gender", s.salary as "Salary"
	FROM employees AS e
	INNER JOIN salaries AS s ON
	e.emp_no = s.emp_no;

-- List employees who were hired in 1986
SELECT emp_no AS "Employee Number", first_name AS "First Name", last_name AS "Last Name",
extract(year from hire_date) AS "Year of Hire"
FROM employees
WHERE extract(year from hire_date) = 1986;

-- List the manager of each department with the following information: department number, 
-- department name, the manager's employee number, last name, first name, and start and end 
-- employment dates
SELECT d.dept_no AS "Dept. No.", d.dept_name AS "Dept. Name", 
m.emp_no AS "Manager''s Employee No.", e.last_name as "Last Name", e.first_name as "First Name",
m.from_date, m.to_date
FROM departments AS d
JOIN dept_manager m on d.dept_no = m.dept_no
JOIN employees e on e.emp_no = m.emp_no
ORDER BY m.dept_no, m.from_date;

-- List the department of each employee with the following information: employee number, 
-- last name, first name, and department name
SELECT e.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name",
d.dept_no AS "Department Number", d.dept_name AS "Department Name"
FROM employees AS e
FULL JOIN dept_emp m on e.emp_no = m.emp_no
FULL JOIN departments d on m.dept_no = d.dept_no
ORDER BY e.emp_no;

-- listing the department number and department name (combining the departments that an employee
-- may have worked in, in the same row instead of having multiple rows)
SELECT e.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name",
array_to_string(array_agg(d.dept_no), ', ') AS "Department Number", 
array_to_string(array_agg(d.dept_name), ', ') AS "Department Name"
FROM employees AS e
FULL JOIN dept_emp m on e.emp_no = m.emp_no
FULL JOIN departments d on m.dept_no = d.dept_no
GROUP by e.emp_no;

-- List all employees whose first name is "Hercules" and last names begin with "B"
SELECT * from employees
WHERE first_name = 'Hercules' and last_name like 'B%';

-- List all employees in the Sales department, including their employee number, 
-- last name, first name, and department name
SELECT e.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name",
d.dept_name AS "Department Name"
FROM employees as e
JOIN dept_emp m on e.emp_no = m.emp_no
JOIN departments d on m.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- List all employees in the Sales and Development departments, including their employee number, 
-- last name, first name, and department name
SELECT e.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name",
d.dept_name AS "Department Name"
FROM employees as e
JOIN dept_emp m on e.emp_no = m.emp_no
JOIN departments d on m.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' or d.dept_name = 'Development'
ORDER by e.emp_no;

-- In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name
SELECT last_name, COUNT(last_name) AS "Count"
FROM employees
GROUP BY last_name
ORDER BY "Count" DESC;

-- BONUS QUESTION
-- Each employee has multiple titles at different date ranges. Therefore, I want to append the
-- salary from the salary table to the correct title using the overlapping date ranges
CREATE TABLE combined_salary_title AS
SELECT salaries.*, titles.title
FROM salaries
Inner JOIN 
titles ON salaries.emp_no = titles.emp_no
WHERE salaries.from_date >= titles.from_date AND (salaries.to_date <= salaries.to_date)
order by emp_no;

SELECT * from combined_salary_title;
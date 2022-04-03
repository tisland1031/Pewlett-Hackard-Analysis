--Create new table for retiring employees


-- Joining departments and dept_manager tables
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

--Joining retirment _info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
 retirement_info.last_name,
 	dept_emp.to_date
From retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

__Joining retirement_info and dept_emp tables nickmane
SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no =de.emp_no;
--adding new table and joining 
SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no =de.emp_no
WHERE de.to_date =('9999-01-01');
SELECT * FROM current_emp

--Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO department_breakdown
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT e.emp_no, 
	e.first_name, 
e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE(birth_date BETWEEN '1952-01-01'AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31' )
	AND (de.to_date='9999-01-01');
	
-- List of managers per department
Select dm.dept_no,
	   d.dept_name,
	   dm.emp_no,
	   ce.last_name,
	   ce.first_name,
	   dm.from_date,
	   dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON (dm.dept_no =d.dept_no)
	Inner JOIN current_emp AS ce
		ON (dm.emp_no = ce.emp_no);

-- List of department info 
Select ce.last_name,
	   ce.first_name,
	   d.dept_name	   
INTO dept_info
FROM current_emp AS ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	Inner JOIN departments AS d
		ON (de.dept_no = d.dept_no);
		

-- Add department to retirement_info, sales dept only
SElECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
INTO retirement_info_sales
FROM retirement_info AS ri
	INNER JOIN dept_emp as de
		ON (ri.emp_no = de.emp_no)
	INNER JOIN departments as d
		ON (de.dept_no = d.dept_no)
WHERE (d.dept_no = 'd007');

-- add department to retirement_info, sales and development dept only
SElECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
--INTO dept_info
FROM retirement_info AS ri
	INNER JOIN dept_emp as de
		ON (ri.emp_no = de.emp_no)
	INNER JOIN departments as d
		ON (de.dept_no = d.dept_no)
WHERE d.dept_no IN ('d007','d005');
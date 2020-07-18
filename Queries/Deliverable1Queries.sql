
----------------------------------------------------
--Challenge
----------------------------------------------------
--Deliverable 1
--1.1 Retiring Employees by Title
--total list of retiring employees
drop table ret_empl_by_title;

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	s.salary,
	s.from_date
	,ti.title
INTO ret_empl_by_title
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN TITLES as ti
ON (s.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
    AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');

select * from ret_empl_by_title;
select count(*) from ret_empl_by_title;

--retiring employees total count
drop table ret_empl_ttl_count;

SELECT count(*)
INTO ret_empl_ttl_count
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (s.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
    AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01')
;
select * from ret_empl_ttl_count;

--count grouped by title
drop table ret_empl_by_title_count;

SELECT ti.title, count(*)
INTO ret_empl_by_title_count
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN TITLES as ti
ON (s.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
    AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01')
group by ti.title;

select * from ret_empl_by_title_count;

-- Deliverable 1
-- 1.2 Remove duplicate titles
-- Partition the data to show only most recent title per employee
-- and create new table (current_titles) with the retiring employees most recent title
SELECT tmp.emp_no,
 tmp.title,
 tmp.from_date,
 tmp.to_date
 INTO current_titles
FROM
 (SELECT
  emp_no,
 title,
 from_date,
 to_date,
 ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY to_date DESC) rn
 FROM titles
 ) tmp WHERE rn = 1
ORDER BY emp_no;

select count(*) from current_titles;

select count(*) from titles
select count(*) from employees


--rejoin original tables to new current_titles
--total list of retiring employees with current title
drop table retiring_employees;
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	s.salary,
	s.from_date as salary_from_dt
	,ti.title
INTO retiring_employees
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN current_titles as ti
ON (s.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
    AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01')
;

select * from retiring_employees;

--new total retiring employees count 
drop table retiring_employees_count;

SELECT count(*) as ret_empl_count
INTO retiring_employees_count
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN current_titles as ti
ON (s.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
    AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01')
;

select * from retiring_employees_count;

--new count grouped by title
drop table retiring_empl_title_count;

SELECT ti.title, count(*)
INTO retiring_empl_title_count
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN current_titles as ti
ON (s.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
    AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01')
group by ti.title;

select * 
from retiring_empl_title_count;
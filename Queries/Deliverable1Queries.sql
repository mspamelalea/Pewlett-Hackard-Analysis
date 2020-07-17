
--Challenge
--Deliverable 1
--1.Retiring Employees by Title
drop table ret_empl_by_title;

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	s.salary,
	ti.to_date
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

--1. Retiring Employees by Title count grouped by title
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
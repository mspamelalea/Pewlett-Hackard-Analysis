
--retireve current employees eligilble to mentor
SELECT ee.emp_no
	, ee.first_name
	, ee.last_name
	, ct.title as current_title
	, ct.from_date as title_from_date
	, ct.to_date as title_to_date
INTO current_eligible_to_mentor
FROM employees ee
LEFT JOIN dept_emp as de --get only current employees
	ON ee.emp_no = de.emp_no
INNER JOIN salaries as s 
	ON (ee.emp_no = s.emp_no)
INNER JOIN  current_titles as ct --current titles only
	ON (ee.emp_no = ct.emp_no)
WHERE de.to_date = ('9999-01-01')
 AND birth_date BETWEEN '1965-01-01' AND '1965-12-31'
 order by title, last_name;

Select department_id, count(employee_id)
From employees
Where job_id like 'IT_%'
Group by department_id


-- Show number of department have it in name and count number of the employee that have it in job_id

Select department_id, count(employee_id)
From employees
Group by department_id
Having min(salary) > 1000

-- show all department have people that min salary is larger than 1000 and quantities of them in the department

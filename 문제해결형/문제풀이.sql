select e.employee_id, e.first_name || ' ' || e.last_name 이름, p.department_name 부서명, e.salary 내급여,
        r.rank 급여순위, d.*, to_char(hire_date, 'yyyy-mm') 입사년월, c.*, j.job_title 담당업무, o.*
from employees e,        
    (SELECT RANK() OVER(ORDER BY salary desc) rank, employee_id FROM employees) r,
    (select department_id, department_name from departments) p,
    (select max(salary) 부서최대급여, round(avg(salary), 2) 부서평균급여, min(salary) 부서최서급여 
    from employees group by department_id) d,
    (select count(*) 동시입사자, max(salary) 입사일기준최대급여, round(avg(salary), 2) 입사일기준평균급여, min(salary) 입사일기준최저급여, hire_date 
     from employees group by hire_date) c,
    (select job_title, job_id from jobs) j,
    (select max(salary) 업무기준최대급여, round(avg(salary), 2) 업무기준평균급여, min(salary) 업무기준최저급여 
     from employees group by job_id) o
where  e.employee_id < 140
and   e.employee_id = r.employee_id
and   nvl(e.department_id, 0) = nvl(p.department_id, 0)
and   nvl(e.department_id, 0) = nvl(d.department_id, 0)
and   e.hire_date = c.hire_date
and   e.job_id = j.job_id
and   e.job_id = o.job_id
;











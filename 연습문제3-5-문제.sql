--보너스는 
--부서코드가  10~30 이면 급여의 10%
--            40~60 이면 급여의 20%
--           70~100 이면 급여의 30%
--           그외 부서원은 급여의 5%
--
--사번, 성, 부서코드, 급여, 보너스 조회

select  employee_id, last_name, department_id, salary,   --범위 비교 연산
        case 
            when department_id between 10 and 30    then salary * 0.1
            when department_id between 40 and 60    then salary * 0.2
            when department_id between 70 and 100   then salary * 0.3
            else salary * 0.05            
        end          
from    employees; 






-----------------------------------------------------------------------------------------------
--보너스는 
--부서코드가 20이하 이면           급여의 30%
--급여가 10000 이상이면            급여의 20%
--업무코드가 clerk 종류의 업무이면 급여의 10% 
--그외는                           급여의 5%
--
--사번, 이름, 성, 부서코드, 급여, 업무코드, 보너스 조회


select  employee_id, last_name, department_id, job_id, salary,   
        case 
            when department_id <= 20    then salary * 0.3
            when salary >= 10000        then salary * 0.2
            when job_id like '%clerk%'  then salary * 0.1
            else salary * 0.05            
        end          
from    employees; 




-----------------------------------------------------------------------------------------------
--[연습문제 3-5]
--1. 사원들의 사번, 이름, 업무코드, 업무등급 조회
--업무등급은 업무코드에 따라 분류한다.
--DECODE 와 CASE~END 사용하여 조회
--
--업무코드    업무등급
--AD_PRES      A
--ST_MAN       B
--IT_PROG      C
--SA_REP       D
--ST_CLERK     E
--그 외        X

select  employee_id, last_name, department_id, salary,   
        case 
            when job_id = 'AD_PRES'     then 'A'
            when job_id = 'ST_MAN'      then 'B'
            when job_id = 'IT_PROG'     then 'C'
            when job_id = 'SA_REP'      then 'D'
            when job_id = 'ST_CLERK'    then 'E'
            else 'x'          
        end         
from    employees; 








-----------------------------------------------------------------------------------------------

--2. 모든 사원의 각 사원들의 근무년수, 근속상태를 파악하고자 한다.
--사원들의 사번, 성, 입사일자, 근무개월수, 근무년수, 근속상태 조회
--근무년수는 오늘을 기준으로 근무한 년수를 정수로 표현한다.
--근속상태는 근무년수에 따라 표현한다.
--근무년수가 15년 미만 이면              '15년 미만 근속'으로 표현
--           15년 이상 17년 미만 이면    '17년 미만 근속'으로 표현
--           17년 이상 이면              '17년 이상 근속'으로 표현     

select  employee_id, last_name, hire_date, 
        case 
            when to_char(SYSDATE,'YYYY') - to_char(hire_date,'YYYY') < 15      then '15년 미만'
            when to_char(SYSDATE,'YYYY') - to_char(hire_date,'YYYY') >= 15     
            and to_char(SYSDATE,'YYYY') - to_char(hire_date,'YYYY') < 17       then '15년 이상 17년 미만'
            else '17년이상'          
        end         
from    employees;                








-----------------------------------------------------------------------------------------------

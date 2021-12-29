※ ROLLUP
 : GROUP BY 절에서 ROLLUP 함수를 사용하여 GROUP BY 구문에 의한 결과와 함께
 단계별 소계, 총계 정보를 구함.
--★ GROUP BY 절에서 ★ROLLUP 으로 묶은 컬럼표현★ 에 대해 총계를 구함

01. 각 부서별, 업무별 사원수와 급여합계, 부서별소계(???), 총계(???)를 총회
SELECT department_id, job_id, SUM(salary)
FROM   employees
--WHERE department_id IS NOT NULL
GROUP BY ROLLUP(department_id, job_id)
--HAVING
ORDER BY department_id ASC, job_id ASC;

SELECT *
FROM   employees;

※ CUBE
 : GROUP BY 절에서 CUBE 함수를 사용하여 GROUP BY 구문에 의한 결과와 함께
  모든 경우의 조합에 대해 소계, 총계 정보를 구함.
--★ GROUP BY 절에서 ★CUBE 으로 묶은 컬럼표현★ 에 대해 총계합 구함.
  
SELECT department_id, job_id, SUM(salary)
FROM   employees
--WHERE
GROUP BY CUBE(department_id, job_id)
--HAVING
ORDER BY department_id ASC, job_id ASC;

-----------------------------------------------------------------------------------------------                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               

--실습
--01. 우리회사 사원들의 업무형태(업무코드)별 사원 수를 파악하고자 한다.
--업무형태(업무코드), 사원수 조회
SELECT job_id, COUNT(*) 사원수
FROM   employees
GROUP BY job_id;




--02. 부서별 급여 정보를 파악하고자 한다.
--부서코드, 급여평균 조회- 급여평균이 높은 부서부터 정렬하고
--급여평균는 반올림하여 소수 둘째자리까지 표현.
SELECT department_id, ROUND(AVG(salary),2) 급여평균
FROM   employees
GROUP BY department_id
ORDER BY 2 DESC;



--03. 부서별, 업무별 급여합계를 파악하고자 한다.
--부서코드, 업무코드, 급여합계 조회
SELECT department_id, job_id, SUM(salary) 급여합계
FROM   employees
GROUP BY department_id, job_id;



--04. 부서코드 60번 부서에 속한 사원들의 사원 수를 파악하고자 한다.
--60 번 부서에 속한 사원들의 사원 수를 조회(HAVING 절 사용)
SELECT department_id, COUNT(*) 사원수
FROM   employees
--WHERE  department_id = 60
GROUP BY department_id
HAVING department_id = 60;



--05. 부서의 급여평균이 10000 이상인 부서를 파악하고자 한다.
--부서의 급여평균이 10000이상인 부서코드, 급여평균를 조회
--급여평균는 반올림하여 소수 둘째자리까지 표현.
SELECT department_id, ROUND(AVG(salary),2) 급여평균
FROM   employees
GROUP BY department_id
HAVING ROUND(AVG(salary),2) >= 10000;



--06. 각 부서별 부서코드, 부서원수, 부서급여평균 조회
SELECT department_id, COUNT(*) 부서원수, ROUND(AVG(salary),2) 급여평균
FROM   employees
WHERE  department_id IS NOT NULL
GROUP BY department_id;



--07. 100번 부서에 대한 정보를 파악하고자 한다.
--100번 부서의 부서코드, 부서원수, 부서급여평균 조회
SELECT department_id, COUNT(*) 부서원수, ROUND(AVG(salary),2) 급여평균
FROM   employees
WHERE  department_id = 100
GROUP BY department_id;



--08. 각 부서별 정보를 파악하고자 한다.
--각 부서별 부서원수가 15명 이상인 부서에 대해 부서코드, 부서원수, 부서급여평균 조회
SELECT department_id, COUNT(*) 부서원수, ROUND(AVG(salary),2) 급여평균
FROM   employees
GROUP BY department_id
HAVING COUNT(*) >= 15;


--09. 각 부서의 부서급여평균이 8000 이상인 부서에 대해
--부서코드, 부서원수, 부서급여평균 조회
SELECT department_id, COUNT(*) 부서원수, ROUND(AVG(salary),2) 급여평균
FROM   employees
GROUP BY department_id
HAVING ROUND(AVG(salary),2) >= 8000;



--10. 각 부서별 최대급여를 파악하고자 한다. 
-- 각 부서의 최대급여가 10000 이상인 부서코드, 최대급여를 조회. 
SELECT department_id, COUNT(*) 부서원수, MAX(salary) 최대급여
FROM   employees
GROUP BY department_id
HAVING MAX(salary) > = 10000;



--11. 두 명 이상 있는 성이 어떤 것들이 있나 파악하고자 한다. 
--두 명 이상 있는 성과, 수를 조회
SELECT last_name, COUNT(*) 부서원수
FROM   employees
GROUP BY last_name
HAVING COUNT(*) >= 2;



--12. 년도별(오름차순)로 입사한 사원 수를 파악하고자 한다. 
--입사년도, 사원 수 조회 - 년도는 2020의 형태로 표현

--입사년도     사원수
--2001	        1
--2002	      	7
--2003	      	6
--2004	      	10
--2005	      	29
--2006	      	24
--2007	      	19
--2008	      	11
SELECT TO_CHAR(hire_date, 'YYYY') 입사년도, COUNT(*) 사원수
FROM   employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
ORDER BY 2;

--13. 각 부서별로 정보를 파악하고자 한다.
--각 부서별 부서코드, 부서원수, 부서급여평균, 부서최고급여, 부서최저급여 조회
SELECT department_id, COUNT(*) 부서원수, ROUND(AVG(salary),2) 급여평균,
       MAX(salary) 최고급여, MIN(salary) 최저급여
FROM   employees
WHERE department_id IS NOT NULL
GROUP BY department_id;




--14. 각 업무별로 정보를 파악하고자 한다.
--각 업무별 업무코드, 업무하는사원수, 업무급여평균, 업무최고급여, 업무최저급여 조회
SELECT job_id, COUNT(*) 부서원수, ROUND(AVG(salary),2) 급여평균,
       MAX(salary) 최고급여, MIN(salary) 최저급여
FROM   employees
GROUP BY job_id;




--15. 각 부서별 부서내 업무별로 부서코드, 업무코드, 사원수, 급여평균 조회
SELECT department_id, job_id, COUNT(*) 부서원수, ROUND(AVG(salary),2) 급여평균
FROM   employees
WHERE department_id IS NOT NULL
GROUP BY department_id, job_id;


-----------------------------------------------------------------------------------------------
--[연습문제 4-3]
--01. 사원테이블에서 똑같은 이름(first_name)이 둘 이상 있는 이름과 그 이름이 모두 몇 명인지를 
--조회하는 쿼리문을 작성한다. 
--이름별로 몇명인지를 구함
SELECT first_name, COUNT(*)
FROM   employees
GROUP BY first_name
HAVING COUNT(first_name) >= 2;


--02. 부서번호, 각 부서별 급여총액과 급여평균를 조회하는 쿼리문을 작성한다. 
--단, 부서 급여평균이 8000 이상인 부서만 조회되도록 한다.
SELECT department_id, COUNT(*) 부서원수, SUM(salary) 급여총액, ROUND(AVG(salary),2) 급여평균
FROM   employees
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING  ROUND(AVG(salary),2) >= 8000;


--03. 년도별로 입사한 사원수를 조회하는 쿼리문을 작성한다.
--단, 년도는 2014 의 형태로 표기되도록 한다.
SELECT TO_CHAR(hire_date, 'YYYY') 입사년도, COUNT(*) 사원수
FROM   employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
ORDER BY 2;


-----------------------------------------------------------------------------------------------

5. 조인(JOIN)
   하나의 테이블로부터 데이터를 조회할 수 없는 경우
   여러개의 테이블로부터 데이터를 조회하여
   합쳐진 테이블의 테이터를 조회
-- ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣

부서정보 --27
SELECT * FROM department;
사원정보 --107
SELECT * FROM employees;
업무정보 --19
SELECT * FROM jobs;

1. CARTESIAN PRODUCT(곱하기)
 : WHERE 절에 JOIN 조건을 기술하지 않아 잘못된 데이터행의 결과를 갖게 되는 현황
   cartesian product, cross join 이라고 함, SQL에서는 쓰이는 경우가 없음
사번, 성, 부서명 조회
SELECT employee_id, last_name, department_name --107*27 : cross 됨, 제대로된 JOIN이 아니다
FROM   employees, departments;

2. EQUI JOIN(ANSI 에서는 INNER JOIN), 교집합
 : WHERE 절에 동등(=)한 연산자를 사용하는 JOIN 형식이다
   즉, 테이블간에 공통으로 만족되는 값을 가진 경우의 결과를 반화
   
※ JOIN 조건 ☞ 컬럼의 값이 같은 컬럼에 대해 조인조건식 설정
    조인조건식: 테이블명.컬럼명 = 테이블명.컬럼명
--              ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣

※ 테이블 조인수선
1. FROM 절에 테이블목록을 나열하며, 테이블명에 ALIAS 설정
   (코드 라인을 줄이고 가독성을 높이기 위해)
2. 조인조건을 WHERE 절에 작성

※ 내부 해석 순서
5. SELECT
1. FROM
2. WHERE
3. GROUP BY
4. HAVING
6. ORDER BY

01. employees, departments 테이블을 사용하여
사원들의 사번, 성, 부서명 조회
SELECT employee_id, last_name, departments.department_name 부서명
FROM   employees, departments
WHERE  employees.department_id = departments.department_id;

SELECT e.employee_id, e.last_name, d.department_name 부서명
FROM   employees e, departments d
WHERE  e.department_id = d.department_id
order by 1;

02. 사번, 성, 부서코드, 부서명 조회
SELECT e.employee_id, e.last_name, e.department_id, d.department_name 부서명
FROM   employees e, departments d
WHERE  e.department_id = d.department_id;

03. 사번, 성, 업무코드, 업무제목 정보 조회
SELECT e.employee_id, e.last_name, e.job_id, j.job_title 업무제목
FROM   employees e, jobs j
WHERE  e.job_id = j.job_id;

JOIN 하는 대상 테이블이 추가되면 JOIN 조건을 추가
WHERE 절에 JOIN 조건과 일반 조건을 함께 사용

WHERE 조인조건식에서
일반 조건식과 JOIN 조건식이 모두 필요한 경우
WHERE 조인조건식
AND   일반조건식 의 형태로 사용

조인조건은 테이블개수 -1 만큼 필요

04. 사번, 성, 부서명, 업무제목 조회
SELECT e.employee_id, e.last_name, d.department_name 부서명, j.job_title 업무제목
FROM   employees e,  departments d, jobs j
WHERE  e.department_id = d.department_id
AND    e.job_id = j.job_id;

05. 사번, 성, 부서코드, 부서명, 업무코드, 업무제목 조회
SELECT e.employee_id, e.last_name, e.department_id, d.department_name 부서명, e.job_id, j.job_title 업무제목
FROM   employees e,  departments d, jobs j
WHERE  e.department_id = d.department_id
AND    e.job_id = j.job_id;

6.사번이 101인 사원의 사번, 이름, 부서명, 업무제목조회
SELECT e.employee_id, e.first_name, d.department_name 부서명, j.job_title 업무제목
FROM   employees e,  departments d, jobs j
WHERE  e.department_id = d.department_id
AND    e.job_id = j.job_id
AND    e.employee_id = 101;

07. 사번이 100, 120, 130, 140인 사원들의 사번, 성, 부서코드, 부서명 조회
SELECT e.employee_id, e.last_name, d.department_name 부서명, j.job_title 업무제목
FROM   employees e,  departments d, jobs j
WHERE  e.department_id = d.department_id
AND    e.job_id = j.job_id
AND    e.employee_id IN (100, 120, 130, 140);

08. 매니저가 없는 사원의 사번, 이름, 업무제목 조회
SELECT e.employee_id, e.last_name, j.job_title 업무제목
FROM   employees e, jobs j
WHERE  e.job_id = j.job_id
AND    e.manager_id IS NULL;



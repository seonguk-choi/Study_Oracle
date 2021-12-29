6. FROM 절에 사용하는 INLINE VIEW 서브쿼리
SELECT 절의 결과를 FROM 절에서 하나의 테이블 처럼 사용(테이블 대체 용도)
--★★★FROM 절에 사용하는 INLINE VIEW 서브쿼리에서 그룹하수는 반드시 ALIAS 로 지정해야함
--★★★메인 쿼리에서 ALIAS 명을 컬럼명으로 사용하기 위해

01. 우리회사 최대급여, 최소급여, 평균급여 조회
SELECT MAX(salary) max_sal, MIN(salary) min_sal, ROUND(AVG(salary),0) avg_sal
FROM   employees;

02. 우리회사 사번, 성, 급여, 최대급여, 최소급여, 평균급여 조회

--SCALA
SELECT employee_id, last_name,
        (SELECT MAX(salary)
         FROM employees) max_sal,
        (SELECT MIN(salary) 
         FROM  employees) min_sal,
        (SELECT ROUND(AVG(salary),0) 
         FROM employees) avg_sal
FROM   employees;

--INLINE VIEW SUBQUERY
SELECT employee_id, last_name, m.*
FROM   employees,  
       (SELECT MAX(salary) max_sal,
               MIN(salary) min_sal,
               ROUND(AVG(salary),0) avg_sal
        FROM employees) m;

03. 사원이 받는 급여가 회사평균급여 이상 최대 급여 이하에 해상하는 사원들의
사번, 성, 급여, 우리회사 최대급여, 우리회사 최소급여, 우리회사 평균급여 조회

--SCALA
SELECT employee_id, last_name, salary,
        (SELECT MAX(salary)
         FROM employees) max_sal,
        (SELECT MIN(salary) 
         FROM  employees) min_sal,
        (SELECT ROUND(AVG(salary),0) 
         FROM employees) avg_sal
FROM   employees
WHERE salary BETWEEN  (SELECT ROUND(AVG(salary),0) FROM employees)
AND (SELECT MAX(salary) FROM employees);

--INLINE VIEW SUBQUERY
SELECT employee_id, last_name, salary, m.*
FROM   employees,  
       (SELECT MAX(salary) max_sal,
               MIN(salary) min_sal,
               ROUND(AVG(salary),0) avg_sal
        FROM employees) m
WHERE  salary BETWEEN m.avg_sal AND m.max_sal;

04. 각 부서별 가장 많은 급여를 받는 사원들의
사번, 성, 부서코드, 급여 조회

--다중컬럼
SELECT e.employee_id, e.last_name, e.department_id, e.salary
FROM   employees e
WHERE  (NVL(e.department_id,0), e.salary) IN (SELECT NVL(department_id,0), MAX(salary)
                                              FROM   employees
                                              GROUP BY department_id);
                                                           
--INLINE VIEW SUBQUERY
SELECT e.employee_id, e.last_name, e.department_id, e.salary
FROM   employees e, (SELECT  department_id, MAX(salary) max_sal
                     FROM   employees
                     GROUP BY department_id) m
WHERE NVL(e.department_id,0) = NVL(m.department_id,0)
AND   e.salary = m.max_sal;

05.사번, 성, 부서코드, 급여, 각 부서별 부서원수, 부서최대급여, 부서최소급여, 부서평균급여 조회
--INLINE VIEW SUBQUERY
SELECT e.employee_id, e.last_name, e.salary, m.*
FROM   employees e,  
       (SELECT department_id,
               COUNT(*) CNT,
               MAX(salary) max_sal,
               MIN(salary) min_sal,
               ROUND(AVG(salary),0) avg_sal
        FROM employees
        GROUP BY department_id) m
WHERE NVL(e.department_id,0) = NVL(m.department_id,0);

7. 몇 개의 데이터 행만 조회해 보자
데이터 행을 조회 : ROWNUM - 테이블에 존재하는 컬럼은 아니지만 사용할 수 있는 가짜 컬럼(Pseudo Column),
--★ SELECT 및 WHERE 절에서 사용
--★ 쿼리문의 결과(조회 후, 즉 SELECT 절의 결과)로 나온 각행에 대한 순서값
* 서브쿼리에서 먼저 정렬(ORDER BY) 후 메인 퀴리에서 순번 넣기(ROWNUM)
--※ ROWNUM 과 INLINE VIEW 의 특성을 이용해서 페이징 처리 등의 작업을 수행

01. 우리회사 사원들의
사번, 성, 급여 조회
SELECT ROWNUM, employee_id, last_name, salary
FROM   employees;

급여를 많이 받는 순으로
SELECT ROWNUM, employee_id, last_name, salary
FROM   employees
ORDER BY salary DESC;

사번순으로 조회하여 10번까지
사번, 성, 급여 조회
SELECT ROWNUM, employee_id, last_name, salary
FROM   employees
WHERE ROWNUM <= 10;

사번순으로 조회하여 10번까지 급여내림차순
사번, 성, 급여 조회
SELECT ROWNUM, employee_id, last_name, salary
FROM   employees
WHERE ROWNUM <= 10
ORDER BY salary DESC;

INLINE VIEW SUBQUERY 급여 상위 10명에 대한
사번, 성, 급여 조회
SELECT employee_id, last_name, salary
FROM   employees
ORDER BY salary DESC;

SELECT ROWNUM, e.*
FROM   (SELECT employee_id, last_name, salary
        FROM   employees
        ORDER BY salary DESC) e
WHERE ROWNUM <= 10;

INLINE VIEW SUBQUERY 급여 하위 10명에 대한
SELECT ROWNUM, e.*
FROM   (SELECT employee_id, last_name, salary
        FROM   employees
        ORDER BY salary ASC) e
WHERE ROWNUM <= 10;

INLINE VIEW SUBQUERY 가장 최근에 입사한 10명에 대한
SELECT ROWNUM, e.*
FROM   (SELECT employee_id, last_name, hire_date
        FROM   employees
        ORDER BY hire_date DESC) e
WHERE ROWNUM <= 10;

INLINE VIEW SUBQUERY 가장 빨리 입사한 10명에 대한
SELECT ROWNUM, e.*
FROM   (SELECT employee_id, last_name, hire_date
        FROM   employees
        ORDER BY hire_date ASC) e
WHERE ROWNUM <= 10;

8. 순위를 결정하고 싶다면
RANK() OVER(순위결정기준)       : 1, 2, 3, 4
DENSE_RANK() OVER(순위결정기준) : 1, 2, 2, 3, 3, 3, 4

입사일자를 기준으로 먼저 입사한 사원 10명의
순위, 사번, 성, 입사일자 조회
SELECT RANK() OVER(ORDER BY e.hire_date ASC) rank, e.employee_id, e.last_name, e.hire_date
FROM   employees e
--WHERE  RANK() OVER(ORDER BY e.hire_date ASC) X
--GROUP BY e.employee_id, e.last_name, e.hire_date X
--HAVING  RANK() OVER(ORDER BY e.hire_date ASC) X

그래서, INLINE VIEW SUBQUERY 사용
SELECT ROWNUM, e.*
FROM (SELECT RANK() OVER(ORDER BY hire_date ASC) rank, employee_id, last_name, hire_date
FROM   employees) e
WHERE ROWNUM <= 10;
      
SELECT e.*
FROM (SELECT RANK() OVER(ORDER BY hire_date ASC) rank, employee_id, last_name, hire_date
FROM   employees) e
WHERE e.rank <= 10;
      
SELECT e.*
FROM (SELECT DENSE_RANK() OVER(ORDER BY hire_date ASC) rank, employee_id, last_name, hire_date
FROM   employees) e
WHERE e.rank <= 10;

-----------------------------------------------------------------------------------------------
[연습문제 6-4]

01. 급여가 적은 상위 5명 사원의 
순위, 사번, 이름, 급여를 조회하는 쿼리문을 
ROWNUM 과 DENSE_RANK()를 사용한 인라인뷰 서브 쿼리를 사용하여 작성

급여 하위 5명의 순위, 사번, 이름, 급여 조회

1. ROWNUM 사용
SELECT ROWNUM, e.*
FROM   (SELECT employee_id, first_name, salary
        FROM   employees
        ORDER BY 3 DESC) e
WHERE  ROWNUM <= 5;



2. DENSE_RANK()사용
SELECT e.*
FROM   (SELECT DENSE_RANK() OVER(ORDER BY salary DESC) rank, employee_id, first_name, salary
        FROM   employees) e
WHERE  e.rank <= 5;


02. 부서별로 가장 급여를 많이 받는 사원의 
사번, 이름, 부서코드, 급여, 업무코드를 조회하는 쿼리문 
인라인 뷰 서브 쿼리를 사용하여 작성
다중컬럼 서브쿼리를 사용하여 작성

1. 인라인뷰 서브쿼리
SELECT e.employee_id, e.first_name, e.department_id, salary, job_id, m.max_sal
FROM  employees e, 
     (SELECT MAX(salary) max_sal, department_id
      FROM   employees
      GROUP BY  department_id) m
WHERE  NVL(e.department_id,0) = NVL(m.department_id,0)
AND    e.salary = m.max_sal;

2. 다중컬럼 서브쿼리
SELECT e.employee_id, e.first_name, e.department_id, e.salary, e.job_id
FROM   employees e
WHERE  (e.salary, NVL(e.department_id,0)) IN (SELECT MAX(salary) max_sal, NVL(department_id,0)
                                              FROM   employees
                                              GROUP BY department_id);


-----------------------------------------------------------------------------------------------














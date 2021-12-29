05. 성에 대소문자 무관하게 Z가 포함된 성을 가진 사원들과 같은 부서에 속한
사원들의 사번, 성명, 부서코드, 업무코드, 조회
SELECT department_id
FROM   employees
WHERE  LOWER(last_name) LIKE '%z%';

SELECT employee_id, last_name, department_id, job_id
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   employees
                         WHERE  LOWER(last_name) LIKE '%z%');
        
※비교
성에 대소문자 무관하게 Z가 포함된 성을 가진 사원들의
사번, 성, 부서코드, 업무코드 조회
SELECT employee_id, last_name, department_id, job_id
FROM   employees
WHERE  LOWER(last_name) LIKE '%z%';

06. 60번 부서원들과 같은 급여를 받는 사원들의
사번, 성, 급여, 부서코드
SELECT employee_id, last_name, salary, department_id
FROM   employees
WHERE  salary IN (SELECT salary
                  FROM   employees
                  WHERE  department_id = 60);

07. 60번 부서에 속하지 않으면서 
60번사원들과 같은 급여를 받는 사원들의
사번, 성, 급여, 부서코드
SELECT employee_id, last_name, salary, department_id
FROM   employees
WHERE  salary IN (SELECT salary
                  FROM   employees
                  WHERE  department_id = 60)
--AND    department_id != 60;
--AND    department_id <> 60;
AND    department_id NOT IN 60;

08. 우리회사 사원들 중 부서명이 Marketing 이거나 IT에 속한 부서의 사원들의
사번, 성, 부서코드 조회
SELECT employee_id, last_name, department_id
FROM   employees
--WHERE   LOWER(department_name) LIKE ('marketing','it'); --XXX
----------------------------------------------------
--WHERE   LOWER(department_name) LIKE '%marketing%'
--OR      LOWER(department_name) LIKE '%it%'--OOO
----------------------------------------------------
WHERE  department_id IN (SELECT department_id 
                         FROM   departments
                         WHERE  LOWER(department_name) IN ('marketing', 'it'));
                         
3. 다중 컬럼 서브쿼리 : 서브쿼리의 결과 컬럼이 여러 컬럼인 경우, 조건의 결과값을 기준으로 컬럼이 여러개
--★ 다중컬럼은 쌍(pair) 형태로 비교
01. 부서별로 가장 많은 급여를 받는 사원의
부서코드, 최대급여, 이름 조회
SELECT department_id, first_name,  MAX(salary) max_sal --문법은 맞으나 결과가 안맞음
FROM   employees
GROUP BY department_id, first_name
ORDER BY 1; 
            
SELECT department_id, salary, first_name --NULL 처리하는 방법이 중요함
FROM   employees
WHERE  (NVL(department_id, 0), salary) IN (SELECT NVL(department_id, 0), MAX(salary) --처리만 할 뿐 보여주는건 아님. 보여주는건 SELECT기 때문에
                                           FROM   employees
                                           GROUP BY department_id)
ORDER BY 1;     
            
02. 부서별로 가장 많은 급여를 받는 사원의
부서코드, 최대급여, 이름 조회
SELECT  department_id, MAX(salary) max_sal, first_name
FROM    employees
--WHERE     
GROUP BY department_id, first_name
ORDER BY 1; --문법은 맞지만 결과가 이상함
            
SELECT  e.department_id, e.salary, e.first_name
FROM    employees e
WHERE   (NVL(e.department_id,0), e.salary) IN ( SELECT NVL(department_id,0), MAX(salary)
                                         FROM   employees 
                                         GROUP BY department_id )
ORDER BY 1;

NVL(대상, NULL 일때 표현)
--  ￣￣￣￣￣￣￣￣￣￣(데이터 타입이 일치해야 함)

NVL2(대상, NULL이 아닐때 표현, NULL 일때 표현)
--         ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣(데이터 타입이 일치해야 함)


03. 부서별로 가장 많은 급여를 받는 사원의
사번, 성, 부서코드, 최대급여, 업무코드
부서별로 가장 많은 급여
SELECT  department_id, MAX(salary)
FROM    employees
GROUP BY department_id;

SELECT  e.employee_id, e.last_name, e.department_id, e.salary, e.job_id
FROM    employees e
WHERE   (NVL(e.department_id,0), e.salary) IN ( SELECT  NVL(department_id,0), MAX(salary)
                                                FROM    employees
                                                GROUP BY department_id )
ORDER BY 3;

04. 각 부서별로 가장 최근에 입사한 사원들의
사번, 성, 부서코드, 가장 최근 입사일자 조회

부서별로 가장 최근에 입사일자
SELECT  department_id, MAX(hire_date)
FROM    employees
GROUP BY department_id;

SELECT  e.employee_id, e.last_name, e.department_id, hire_date
FROM    employees e
WHERE   (NVL(department_id,0), hire_date) IN ( SELECT  NVL(department_id,0), MAX(hire_date)
                                               FROM    employees
                                               GROUP BY department_id )
ORDER BY department_id;

05. 매니저가 없는 사원이 매니저로 있는
부서코드, 부서명 조회
SELECT DISTINCT e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+)
AND    e.manager_id IN (SELECT employee_id
                        FROM   employees
                        WHERE  manager_id IS NULL);

4. 상호연관 서브쿼리 : 메인쿼리의 컬럼이 서브쿼리의 조건절에 사용되는 형태
- 메인쿼리의 값을 서브쿼리에 주고, 서브쿼리의 결과값을 받아서 메인쿼리로 반환해서 수행하는 쿼리
- 메인쿼리의 컬럼이 서브쿼리의 조건절에 사용되어 메인쿼리에 독집적이지 않은 형태
- 메인테이블과 서브쿼리 테이블간의 JOIN 조건이 사용됨
- 메인 쿼리와 서브쿼리가 계속 정보를 주고 받는다는 의미

* 메인 쿼리의 컬럼이 서브 쿼리의 조건절에 사용되는
  상호연관 서브쿼리의 형태로 사용된다.(WHERE 절에서 사용)
  SCALA 서브쿼리에서 다룰 예정
  
5. SCALA 서브쿼리 : SELECT 절에 사용, 단일결과행, 단일컬럼만 조회가능
- 단순한 그룹함수의 결과를 SELECT 절에서 조회하고자 할 때
- SELECT 절에 서브쿼리를 사용하여 하나의 컬럼처럼 사용하기 위한 목적(표현용도)
- JOIN의 대체 표현으로도 자주 사용
- 코드성 데이터를 조회하고자 할 때
- 조인 조건식이 필요할 때는 서브쿼리 안에서 WHERE 조건식 사용

1) 단순한 그룹함수의 결과값을 SELECT 절에서 조회하고자 할 때

01. 모든 사원의 사번, 성, 급여, 회사평균, 회사 최대급여 조회
SELECT e.employee_id, e.last_name, e.salary,
       (SELECT ROUND(AVG(salary), 2) FROM employees) avg_sal,
       (SELECT MAX(salary) FROM employees) max_sal
FROM   employees e
GROUP BY e.employee_id, e.last_name, e.salary;

2) 코드성 테이블에서 코드명(데이터 컬럼명)을 SELECT 절에서 조회하고자 할 때 : 상호연관 서브쿼리, OUTER JOIN 한 것처럼
01. 모든 사원의 사번, 성, 부서코드, 부서명
--일반 쿼리
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+);

--SCALA 서브쿼리
SELECT e.employee_id, e.last_name, e.department_id,
       (SELECT department_name
        FROM departments
        WHERE department_id = e.department_id) 부서명
FROM   employees e;

-----------------------------------------------------------------------------------------------
01. 모든 사원의 사번, 성, 부서코드, 부서명 조회 ( 스칼라 서브 쿼리로 "부서명" 구하기 )

--일반 쿼리
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+);

--스칼라 서브쿼리
SELECT e.employee_id, e.last_name, e.department_id,
       (SELECT department_name
        FROM departments
        WHERE department_id = e.department_id) 부서명
FROM   employees e;

-----------------------------------------------------------------------------------------------
02. 모든 사원의 사번, 성, 부서코드, 업무코드, 업무제목 조회 ( 스칼라 서브 쿼리로 "업무제목" 구하기 )

--일반 쿼리
SELECT e.employee_id, e.last_name, e.department_id, j.job_title
FROM   employees e, jobs j
WHERE  e.job_id = j.job_id(+);

--스칼라 서브쿼리
SELECT e.employee_id, e.last_name, e.department_id,
       (SELECT job_title
        FROM jobs
        WHERE job_id = e.job_id) 업무제목
FROM   employees e;


-----------------------------------------------------------------------------------------------
03. 각 부서에 대해 부서코드, 부서명, 도시를 조회 ( 스칼라 서브 쿼리로 "도시" 구하기 )

--일반 쿼리
SELECT d.department_id, d.department_name, l.city
FROM   departments d, locations l
WHERE  d.location_id = l.location_id;

--스칼라 서브쿼리
SELECT d.department_id, d.department_name,
       (SELECT city
        FROM locations
        WHERE location_id = d.location_id) 도시
FROM   departments d;

-----------------------------------------------------------------------------------------------
04. 모든 사원들의 사번, 성, 급여, 부서코드, 부서명, 업무코드 조회

--일반 쿼리
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name, e.job_id
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+);

--스칼라 서브쿼리
SELECT e.employee_id, e.last_name, e.salary, e.department_id,
       (SELECT department_name
        FROM   departments
        WHERE  department_id = e.department_id) 부서명,
        e.job_id
FROM   employees e;


-----------------------------------------------------------------------------------------------
05. 각 부서에 대해 부서코드, 부서명, 위치코드, 도시명 조회

--일반 쿼리
SELECT d.department_id, d.department_name, d.location_id, l.city
FROM   departments d, locations l
WHERE  d.location_id = l.location_id;

--스칼라 서브쿼리
SELECT d.department_id, d.department_name, d.location_id,
       (SELECT city
        FROM locations
        WHERE location_id = d.location_id) 도시
FROM   departments d;

-----------------------------------------------------------------------------------------------
06. 각 부서별 부서코드, 부서평균급여 조회

--일반 쿼리
SELECT e.department_id, ROUND(AVG(e.salary), 2) 평균급여
FROM   employees e
GROUP BY e.department_id
ORDER BY 1;

--스칼라 서브쿼리
SELECT e.department_id,
       (SELECT ROUND(AVG(salary), 2)
        FROM   employees
        WHERE  NVL(department_id,0) = NVL(e.department_id,0)) 평균급여
FROM   employees e
GROUP BY e.department_id
ORDER BY 1;


-----------------------------------------------------------------------------------------------
07. 각 사원에 대해 사원이 소속된 부서의 급여정보 대비 사원의 급여를 파악하고자 한다.
사번, 성, 부서코드, 급여, 각 사원이 속한 부서의 평균급여 조회
--                        ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
--스칼라 서브 쿼리( 스칼라 서브 쿼리로 "평균급여" 구하기 )

--각부서 평균급여
SELECT ROUND(AVG(salary), 2)
FROM   employees
GROUP BY department_id;


SELECT e.employee_id, last_name, e.department_id, salary,
       (SELECT ROUND(AVG(salary), 2)
        FROM   employees
        WHERE  NVL(department_id,0) = NVL(e.department_id,0)) 평균급여
FROM   employees e
ORDER BY 1;

-----------------------------------------------------------------------------------------------










































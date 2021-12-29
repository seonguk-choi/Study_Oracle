6.1 서브쿼리(Sub Query) : 
    SQL 문장안에 존재하는 또 다른 SQL 문장을 서브쿼리라 한다.
    서브쿼리는 괄호() 로 묶어 사용하고, 서브쿼리가 포함된 쿼리문을 메인쿼리라 한다.
--             ￣￣￣￣￣￣￣￣￣￣
    서브쿼리는 단일 행 또는 복수행 비교 연산자와 함께 사용 가능
    서브쿼리는 ORDER BY 를 사용하지 못함.
    ORDER BY 는 메인쿼리의 문장의 마지막에 하나만 사용할 수 있다.
    서브쿼리의 결과는 메인쿼리의 조건으로 사용
    서브쿼리는 메인쿼리가 서브쿼리를 포함하는 종속적인 관계
    서브쿼리는 연산자의 오른쪽에 사용
    여러번의 쿼리를 수행해야만 얻을 수 있는 결과를 하나의 중첩된 SQL 문장으로 간편하게 결과를 얻을 수 있게 해줌
    
※ 서브쿼리 사용이유
1. 알려지지 않은 기준을 이용한 검색을 하기 위해
★ 테이블내에서 조건을 설정하기가 어려워 다른 테이블에서 조건을 가져와야 할 경우
  단일 SELECT 문으로 조건식을 만들기에는 조건이 복잡할  때
  또는 완전히 다른 데이블에서 데이터 값을 조회하여 메인쿼리의 조건으로 사용하고자 할 경우
  
2. DB에 접근하는 속도를 향상 시킴

※ 서브쿼리가 사용가능 한 곳
SELECT 
FROM
WHERE  : 제일 많이 사용되는 곳
HAVING
ORDER BY

INSERT 절의 VALUES
UPDATE 절의 SET    : 두번째로 많이 씀

※ 서브쿼리의 위치에 따른 명칭
1. SELECT 절에 사용하는 서브쿼리
   ○ SCALA 서브쿼리 : 단일값(크기하나), VECTOR : 크기와 방향
   SELECT 절에서 하나의 컬럼처럼 사용하기 위한 목적(컬럼 표현 용도)
   JOIN의 대체 표현식으로 자주사용
   
2. FROM   절에 사용하는 서브쿼리
   ○ INLINE VIEW 서브쿼리 
   SELECT 절의 결과를 FROM 절에서 하나의 테이블처럼 사용(테이블 대체)
   INLINE VIEW 서브쿼리에서 ORDER BY 절은 올 수 없음(출력용도가 아니고 테이블용도이므로)
   INLINE VIEW 서브쿼리에서는 반드시 그룹함수에 대해 ALIAS 사용
   
3. WHERE  절에 사용하는 서브쿼리
   ○ 일반 서브쿼리 : 메인 쿼리 안에 있는 또 다른 쿼리문(WHERE / HAVING 조건절 안에서 사용)
   ★ 서브쿼리의 SELECT 절에 결과를 하나의 변수 또는 상수처럼 사용
   (조건절의 서브쿼리의 결과에 따라 달라짐) ☞ 단일 결과행, 다중 결과행, 다중 컬럼인지에 따라 달라짐
--------------------------------------------------------------------------------
   보통 함수로 구한 값과 비교할 때, 다른 곳에서 구한 값과 비교할 때
--------------------------------------------------------------------------------
3.1 단일 결과행 서브쿼리 - 조건절에 사용하는 서브쿼리의 결과행인 단일행인 경우
    (조건의 결과값을 기준으로 결과가 하나)
3.2 다중 결과행 서브쿼리 - 조건절에 사용하는 서브쿼리의 결과행인 여러행인 경우
    (조건의 결과값을 기준으로 결과가 여러개)
3.3 단 결과행 서브쿼리 - 조건절에 사용하는 서브쿼리의 결과컬럼인 여러컬럼인 경우
    (조건의 결과값을 기준으로 컬럼이 여러개)

01. 급여가 우리회사 평균 급여보다 더 적은 급여를 받는 사원의
사번, 이름, 성, 급여정보 조회
SELECT employee_id, first_name, last_name, salary
FROM   employees
WHERE  salary < AVG(salary); --그룹함수 사용 불가

우리회사 평균 급여
SELECT AVG(salary) --6461.831775700934579439252336448598130841
FROM   employees

SELECT employee_id, first_name, last_name, salary --56
FROM   employees
WHERE  salary < 6461.831775700934579439252336448598130841;

상수대신 그룹함수 대입 --XXX
사번, 이름, 성, 급여정보 조회
SELECT employee_id, first_name, last_name, salary
FROM   employees
WHERE  salary < AVG(salary);

※ 서브쿼리 : 보통 함수로 구한 값과 비교할 때, 다른 곳에서 구한 값과 비교 할 때
사번, 이름, 성, 급여정보 조회
SELECT employee_id, first_name, last_name, salary --56
FROM   employees
WHERE  salary < (SELECT AVG(salary) 
                FROM employees);
                
02. 급여가 우리회사 급여 평균보다 더 많이 받는 사원들의
사번, 성, 업무코드, 급여 조회
SELECT employee_id, last_name, job_id, salary --51
FROM   employees
--WHERE salary > (우리회사 평균 급여)
WHERE  salary > (SELECT AVG(salary) 
                FROM employees);

03. 우리회사에서 가장 많은 급여를 받는 사원들의
사번, 이름, 급여 조회
SELECT employee_id, first_name, salary
FROM   employees
WHERE  salary = (SELECT MAX(salary) 
                 FROM employees);

03. 사번 150번 보다 많은 급여를 받는 사원들의
사번, 성, 부서코드, 업무코드, 급여 조회
SELECT employee_id, last_name, department_id, job_id, salary
FROM   employees
WHERE  salary > (SELECT salary
                 FROM employees
                 WHERE employee_id = 150);

05. 월급여가 가장 많은 사원의
사번, 이름, 성, 업무제목 정보를 조회
SELECT e.employee_id, e.first_name, e.last_name, j.job_title
FROM   employees e, jobs j
WHERE  e.job_id = j.job_id
AND    salary = (SELECT MAX(salary) 
                 FROM employees);

06. 사원들의 급여가 우리 회사 평균급여 이상, 최고급여 이하에 해당하는 사원들의
사번, 성, 급여 조회
SELECT employee_id, last_name, salary
FROM   employees
WHERE  salary BETWEEN (SELECT AVG(salary)
                       FROM employees)
AND                   (SELECT MAX(salary)
                       FROM employees);

------------------------------------------------------------------------
[연습문제 6-1]
01. 우리회사에서 가장 적은 급여를 받는 사원의 
사번, 성, 업무코드, 부서코드, 부서명, 급여 조회 --1
서브쿼리
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, e.salary
FROM   employees e, departments d
WHERE  e.department_id = d.department_id
AND    salary = (SELECT MIN(salary)
                 FROM employees);



02. 부서명이 Marketing 인 부서에 속한 사원들의 
사번, 성명, 부서코드, 업무코드 조회 --2
일반쿼리
SELECT e.employee_id, e.first_name || ' ' || e.last_name 성명, e.department_id, e.job_id
FROM   employees e, departments d
WHERE  e.department_id = d.department_id
AND    UPPER(d.department_name) LIKE '%MARKETING%';
서브쿼리
SELECT employee_id, first_name || ' ' || last_name 성명, department_id, job_id
FROM   employees
WHERE  department_id = (SELECT department_id
                        FROM departments
                        WHERE UPPER(department_name) LIKE '%MARKETING%');


03. 우리회사 사장님보다 먼저 입사한 사원들의 
사번, 성명, 입사일자 조회 --10
사장은 그를 관리하는 매니저가 없는 사원을 말한다
일반쿼리
SELECT e.employee_id, e.first_name || ' ' || e.last_name 성명, e.hire_date
FROM   employees e, employees m
WHERE  e.hire_date < m.hire_date
AND    m.manager_id IS NULL;

서브쿼리
SELECT employee_id, first_name || ' ' || last_name 성명, hire_date
FROM   employees
WHERE  hire_date < (SELECT hire_date
                    FROM   employees
                    WHERE  manager_id IS NULL);
--------------------------------------------------------------------------------
1. 조건절(WHERE, HAVING)에 사용하는 단일결과행 서브쿼리, 조건의 결과값을 기준으로 결과가 하나
--단일 결과행 서브쿼리 연산자 : --★★★★★ : =, !=, <>, <, <=, >, >=
--------------------------------------------------------------------------------
2. 조건절(WHERE, HAVING)에 사용하는 다중결과행 서브쿼리, 조건의 결과값을 기준으로 결과가 여러개
--다중 결과행 서브쿼리 연산자 : --★★★★★ : IN, NOT IN
--------------------------------------------------------------------------------

2. 다중결과행 서브쿼리
 : 조건절에 사용한 서브쿼리의 결과행이 여러행인 경우, 조건의 결과값을 기준으로 결과가 여러개
 - 연산자 : IN, NOT IN('=' 을 IN으로 대체한다고 생각),
   비교 대상의 두개 이상은 대소비교 불가, 그래서 IN 연산자 사용
   서브쿼리의 결과가 여러행일 경우 '=', '<', '<' 와 같은 연산자는 대소비교가 불가
   WHERE 절에서는 그룹함수 사용 불가
   WHERE 절이 아닌 서브쿼리에서는 그룹함수 사용 가능
 - 컬럼표현 IN
 - NOT 컬럼표현 IN, 컬럼표현 NOT IN

01. 부서의 위치 코드가 1700인 부서에 속한 사원들의
사번, 성, 부서코드, 업무코드 조회

--일반쿼리
SELECT e.employee_id, e.last_name, e.department_id, e.job_id
FROM   employees e, departments d
WHERE  e.department_id = d.department_id
AND    d.location_id = 1700; 

--서브쿼리
SELECT employee_id, last_name, department_id, job_id
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   departments
                         WHERE  location_id = 1700);

02. 우리회사 mgr 업무에 종사하는 사원들과 같은 부서에 속한 사원들의
사번, 성, 업무코드, 부서코드 조회
--일반쿼리
SELECT e.employee_id, e.last_name, e.department_id, e.job_id --8
FROM   employees e, employees m
WHERE  e.department_id = m.department_id(+)
AND    LOWER(m.job_id) LIKE '%mgr%';

--서브쿼리
SELECT employee_id, last_name, department_id, job_id
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   employees
                         WHERE  LOWER(job_id) LIKE '%mgr%');

03. 각 부서의 최소급여가 40번 부서의 최소급여보다 더 많이 받는 부서의
부서코드, 최소급여 조회
SELECT MIN(salary)
FROM   employees
WHERE  department_id = 40;

SELECT department_id, MIN(salary) min_sal
FROM   employees
GROUP BY department_id
--WHERE  최소급여 < 40번 부서의 최소급여 -- WHERE 는 그룹함수 사용 불가
HAVING MIN(salary) > (SELECT MIN(salary)
                      FROM   employees
                      WHERE  department_id = 40) 
AND    department_id IS NOT NULL
ORDER BY 1;

04. 근무지의 국가코드가 UK(즉, country_id 가 UK)인 위치(코드)에 있는
부서코드, 위치코드, 부서명
--일반쿼리
SELECT d.department_id, d.location_id, d.department_name
FROM   departments d, locations l
WHERE  d.location_id = l.location_id
AND    l.country_id = 'UK';

--서브쿼리
SELECT department_id, location_id, department_name
FROM   departments
WHERE  location_id IN (SELECT location_id
                       FROM   locations
                       WHERE  country_id LIKE 'UK');


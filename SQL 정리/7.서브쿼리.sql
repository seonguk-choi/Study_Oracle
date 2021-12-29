6장. 서브쿼리(Sub Query)

6. 서브쿼리(Sub Query) : 
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

--------------------------------------------------------------------------------


6.1 단일행 서브쿼리 : 하나의 결과행을 반환하는 서브쿼리
단일행 연산자 ( =, >, >=, <, <=, <>, != ) 사용
  결과행이 한 행이므로 그룹함수 사용 가능
--￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣


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


6.2. 다중결과행 서브쿼리
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


------------------------------------------------------------------------------------------

                         
6.3. 다중 컬럼 서브쿼리 : 서브쿼리의 결과 컬럼이 여러 컬럼인 경우, 조건의 결과값을 기준으로 컬럼이 여러개
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


------------------------------------------------------------------------------------------



6.4. 상호연관 서브쿼리 : 메인쿼리의 컬럼이 서브쿼리의 조건절에 사용되는 형태
- 메인쿼리의 값을 서브쿼리에 주고, 서브쿼리의 결과값을 받아서 메인쿼리로 반환해서 수행하는 쿼리
- 메인쿼리의 컬럼이 서브쿼리의 조건절에 사용되어 메인쿼리에 독집적이지 않은 형태
- 메인테이블과 서브쿼리 테이블간의 JOIN 조건이 사용됨
- 메인 쿼리와 서브쿼리가 계속 정보를 주고 받는다는 의미

* 메인 쿼리의 컬럼이 서브 쿼리의 조건절에 사용되는
  상호연관 서브쿼리의 형태로 사용된다.(WHERE 절에서 사용)
  SCALA 서브쿼리에서 다룰 예정


------------------------------------------------------------------------------------------


  
6.5. SCALA 서브쿼리 : SELECT 절에 사용, 단일결과행, 단일컬럼만 조회가능
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



6.6. FROM 절에 사용하는 INLINE VIEW 서브쿼리
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


----------------------------------------------------------------------------------------


6.7. 몇 개의 데이터 행만 조회해 보자
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


------------------------------------------------------------------------------------------


6.8. 순위를 결정하고 싶다면
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














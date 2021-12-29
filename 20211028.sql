--실습
-----------------------------------------------------------------------------------------------
--01. 성에 대소문자 무관하게 z가 있는 성을 가진 사원들의
--사번, 성, 부서코드, 부서명 조회 --5개
SELECT e.employee_id, e.last_name, e.department_id, d.department_name 부서명
FROM   employees e, departments d
WHERE  e.department_id = d.department_id
AND   UPPER(e.last_name) LIKE '%Z%';


--02. 커미션을 받는 사원들의 
--사번, 성, 급여, 커미션요율, 업무제목 조회 --35개
SELECT e.employee_id, e.last_name, e.salary, e.commission_pct, j.job_title
FROM   employees e, jobs j
WHERE  e.job_id = j.job_id
AND   e.commission_pct IS NOT NULL;


--03. 커미션을 받는 사원들의 
--사번, 성, 급여, 커미션금액, 부서명 조회  --34개
SELECT e.employee_id, e.last_name, e.salary, e.salary * e.commission_pct 커미션금액,
       d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id
AND    e.commission_pct IS NOT NULL;


--04. 각 부서에 대한 정보를 파악하고자 한다.
--각 부서의 부서코드, 부서명, 위치코드, 도시를 조회  --27개
--위치코드 : location_id 
--도시명   : city
SELECT d.department_id, d.department_name, l.location_id, l.city
FROM   departments d, locations l
WHERE  d.location_id = l.location_id


--05. 사번, 성, 부서코드, 부서명, 근무지도시명, 주소 조회  --106개, 조인조건은 table갯수 -1 만큼 필요!!
--주소     : street_address
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, l.city, l.street_address
FROM   employees e, departments d, locations l
WHERE  e.department_id = d.department_id
AND    d.location_id = l.location_id;


--06. 사번, 성, 부서코드, 부서명, 업무코드, 업무제목 조회  --106개, 조인조건은 table갯수 -1 만큼 필요!!
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, e.job_id, j.job_title
FROM   employees e, departments d, jobs j
WHERE  e.department_id = d.department_id
AND    e.job_id = j.job_id;


--07. 각 부서의 부서코드, 부서명, 위치코드, 도시명, 국가코드, 국가명, 대륙명 조회 --27개, 조인조건은 table갯수 -1 만큼 필요!!
--위치코드 : location_id 
--도시명   : city
--국가코드 : country_id
--국가명   : country_name
--대륙명   : region_name
SELECT d.department_id, d.department_name, l.location_id, l.city, l.country_id, c.country_name, r.region_name
FROM   departments d, locations l, countries c, regions r
WHERE  d.location_id = l.location_id
AND    l.country_id = c.country_id
AND    c.region_id = r.region_id;


-----------------------------------------------------------------------------------------------

3. NON-EQUI JOIN
 : 비교연산자(<, <=, >, >=), 범위연산자(BETWEEN), IN 연산자의
 동등연산자(=) 이외의 연산자를 사용하는 JOIN 형식이다.
 JOIN하는 컬럼이 일치하지 않게 사용하는 JOIN 조건으로 거의 사용하지 않는다.
 
01. employee 테이블의 급여가 jobs 테이블의 최고급여(max_salary) / 최저급여(min_salary) 범위 내에 있는
50번 부서원의
사번, 이름, 급여, 업무제목 조회
SELECT e.employee_id, e.first_name, e.salary, j.job_title
FROM   employees e, jobs j
WHERE  e.job_id = j.job_id
AND    e.salary BETWEEN j.min_salary AND j.max_salary
AND     e.department_id = 50;

4. OUTER JOIN : NULL 값이 생략되는 정보도 포함해서 표시하기 위한 조인, 합집합
EQUI 조인은 조인조건에 동등비교연산자(=) 로 비교한 형태,
즉, 테이블간에 공통으로 만족되는 값을 가진 경우의 결과를 변환

하지만, OUTER JOIN 은 막존되는 값이 없는 경의 결과까지 반환한다.
만족되는 값이 없는 테이블 컬럼에 (+) 기호를 표시한다.
--￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
즉, 데이터 행의 누락이 발생하지 않도록 하기 위한 조인기법
--★ 조인조건식에서 (+)기호를 데이터 행이 없는 조인조건쪽에 붙여준다.
--------------------------------------------------------------------------------
사원테이블(employees)    부서테이블(departments)           위치테이블(locations)
사번  부서코드           부서코드(+)  부서명  위치코드     위치코드(+)  부서위치
100   10                 10           영업부  1600         1600         Seatle
101   20                 20           총무부  1700         1700         Paris
178   NULL               NULL         NULL    NULL         NULL         NULL
--------------------------------------------------------------------------------

01.모든 사원(107개)의 사번, 성, 부서코드, 부서명 조회
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+);

NULL 개수 파악
SELECT COUNT(*)
FROM   employees
WHERE  department_id IS NULL;

SELECT COUNT(*)
FROM   departments
WHERE  department_id IS NULL;

--------------------------------------------------------------------------------
--사원테이블에서 부서배치 받지 않은 사원 데이터행(NULL) 이 있고
--부서테이블에서 부서코드가 NULL 인 것에 대한 데이터행이 없으므로
--(만족되는 데이터가 없는 쪽 JOIN 컬럼에 (+)를 추가
--부서테이블의 부서코드 쪽에 OUTER 기호 (+)를 붙인다.
--------------------------------------------------------------------------------
OUTER JOIN ☞ LEFT / RIGHT OUTER JOIN : 기준이 되는 테이블 방향으로 조인한다.
LEFT  OUTER JOIN  : 왼  쪽 테이블을 기준으로 NULL 포함하여 모두 출력(즉, 등호의 오른쪽에 (+) 를 붙인다.
RIGHT  OUTER JOIN : 오른쪽 테이블을 기준으로 NULL 포함하여 모두 출력(즉, 등호의 왼  쪽에 (+) 를 붙인다.

※ 즉, NULL 이 있는 반대쪽에 (+) 를 붙인다.

02. 모든 사원의 사번, 성, 업무코드, 업무제목 조회
SELECT e.employee_id, e.last_name, e.department_id, j.job_title
FROM   employees e, jobs j
WHERE  e.job_id = j.job_id;

NULL 개수 파악
SELECT COUNT(*)
FROM   employees
WHERE  job_id IS NULL;

SELECT COUNT(*)
FROM   jobs
WHERE  job_id IS NULL;

03. 모든 사원의 사번, 성, 부서명, 업무제목 조회
SELECT e.employee_id, e.last_name, d.department_name, j.job_title
FROM   employees e, departments d, jobs j
WHERE  e.department_id = d.department_id(+)
AND    e.job_id = j.job_id;

04. 모든 사원의 사번, 성, 부서코드, 부서명, 위치코드, 도시 조회
SELECT e.employee_id, e.last_name, d.department_name, l.location_id, l.city
FROM   employees e, departments d, locations l
WHERE  e.department_id = d.department_id(+)
AND    d.location_id = l.location_id(+);

05. 모든 사원의 사번, 성, 부서코드, 부서명, 업무코드, 업무제목 조회
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, e.job_id, j.job_title
FROM   employees e, departments d, jobs j
WHERE  e.department_id = d.department_id(+)
AND    e.job_id = j.job_id;


-----------------------------------------------------------------------------------------------

--실습
-----------------------------------------------------------------------------------------------
--01. 관리자 사번이 149인 사원들의 
--사번, 성, 부서코드, 부서명을 조회 --6
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+)
AND    e.manager_id = 149;


--02. 성에 대소문자 무관하게 a 가 있는 성을 가진 사원들의 
--사번, 성, 부서명 조회 --56
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+)
AND    LOWER(e.last_name) LIKE '%a%';


--03. 커미션을 받는 사원들의 사번, 성, 부서명, 도시명 조회 --35
SELECT e.employee_id, e.last_name, d.department_name,l.city
FROM   employees e, departments d, locations l
WHERE  e.department_id = d.department_id(+)
AND    d.location_id = l.location_id(+)
AND    e.commission_pct IS NOT NULL;


-----------------------------------------------------------------------------------------------
--SELECT 절에 사용한 ALIAS 명이나 SELECT 절에서의 위치는 
--ORDER BY 절에서만 사용 할 수 있다.
--: WHERE 절, GROUP BY 절, HAVING 절에서는 
--  SELECT 목록의 컬럼 ALIAS 나 컬럼의 위치를 사용할 수 없다.
-----------------------------------------------------------------------------------------------

--04. 부서별 사원들의 정보를 파악하고자 한다.
--부서코드가 60 번 이하인 부서에 대해 부서의 평균급여가 5000 이상인 부서만 
--부서코드, 사원 수, 급여합계, 급여평균, 최대급여, 최저급여, 
--최근입사일자, 최초입사일자 조회 --3
SELECT e.department_id, COUNT(*), SUM(e.salary) 급여합계, ROUND(AVG(e.salary), 2) 급여평균,
       MAX(e.salary) 최대급여, MIN(e.salary)최저급여, MAX(e.hire_date), MIN(e.hire_date)
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+)
AND    d.department_id <= 60
GROUP BY e.department_id
HAVING ROUND(AVG(salary), 2) >= 5000;


--05. 업무형태(job_id)별로 사원들의 정보를 파악하고자 한다.
--업무형태별로 사원 수가 10명이상인 업무형태에 대해
--업무코드, 업무별사원수, 업무별평균급여, 업무별최대급여, 업무별최소급여, 
--업무별최근입사일자, 업무별최초입사일자 조회 --3
SELECT e.job_id, COUNT(*), ROUND(AVG(e.salary), 2) 급여평균, MAX(e.salary) 최대급여,
       MIN(e.salary)최저급여, MAX(e.hire_date), MIN(e.hire_date)
FROM   employees e, jobs j
WHERE  e.job_id = j.job_id
GROUP BY e.job_id
HAVING COUNT(*) >= 10;

-----------------------------------------------------------------------------------------------

5. SELF JOIN
 : 하나의 테이블을  두번 명시하여 동일한 테이블 두개로부터 JOIN 을 통해
   데이터를 조회하여 결과를 반환, 즉, 한 테이블 내에서 두 데이터 컬럼이 연관관계 있다.
   
01. 모든사원의 사번, 이름, 매니저 사번, 매니저 이름 조회
SELECT e.employee_id, e.first_name, e.manager_id, m.first_name
FROM   employees e, employees m
WHERE    e.manager_id = m.employee_id(+);

--사원테이블 2개가 아니라 사원테이블 1개, 매니저테이블 1개라고 생각

NVL(대상, NULL일때 반환표현)
--  ￣￣￣￣￣￣￣￣￣￣￣￣(데이터형이 같아야함) 
NVL2(대상, NULL이 아닐때 표현, NULL일때 반환표현)
--  ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣(데이터형이 같아야함)

매니저 사전, 매니저 이름이 NULL 로 조회됐을때 NULL 처리하기
사번, 성            매니저사번1, 매니저사번2, 매니저사번3,     매니저사번4,     매니저이름1, 매니저이름2,        매니저이름3
매니저사업이 없으면 (NULL)       0(NVL)       매니저없음(NVL)  매니저없음(NVL2)
매니저이름이 없으면 (NULL)                                                                   매니저이름없음(NVL) 매니저이름없음(NVL)
SELECT e.employee_id, e.last_name,
       e.manager_id 매니저사번1,
       NVL(e.manager_id, 0) 매니저사번2,
       NVL(TO_CHAR(e.manager_id), '매니저없음') 매니저사번3,
       NVL2(e.manager_id, TO_CHAR(e.manager_id), '매니저없음') 매니저사번3,
       m.first_name 매니저이름1,
       NVL(m.first_name, '매니저이름없음') 매니저이름2,
       NVL2(m.first_name, m.first_name, '매니저이름없음') 매니저이름3
FROM   employees e, employees m
WHERE    e.manager_id = m.employee_id(+);


-----------------------------------------------------------------------------------------------
--[ 연습문제 5-1 ]                                                                             
--01. 이름에 소문자 v가 포함된 모든 사원의 사번, 이름, 부서명을 조회하는 쿼리문을 작성한다. --8
SELECT e.employee_id, e.first_name, d.department_name
FROM   employees e, departments d
WHERE  e.manager_id = d.manager_id(+)
AND    e.first_name LIKE '%v%';


--02. 커미션을 받는 사원의 사번, 이름, 급여, 커미션 금액, 부서명을 조회하는 쿼리문을 작성한다.
--단, 커미션 금액은 월급여에 대한 커미션 금액을 나타낸다. --35
SELECT e.employee_id, e.first_name, e.salary, e.salary * e.commission_pct, d.department_name
FROM   employees e, departments d
WHERE  e.manager_id = d.manager_id(+)
AND    e.commission_pct IS NOT NULL;


--03. 각 부서의 부서코드, 부서명, 위치코드, 도시명, 국가코드, 국가명을 조회하는 쿼리문을 작성한다. --27
SELECT d.department_id, d.department_name, l.location_id, l.city, c.country_id, c.country_name
FROM   departments d, locations l, countries c 
WHERE  d.location_id = l.location_id
AND    l.country_id = c.country_id;


--04. 사원의 사번, 이름, 업무코드, 매니저의 사번, 매니저의 이름, 매니저의 업무코드를 조회하여 
--사원의 사번 순서로 정렬하는 쿼리문을 작성한다. --107
SELECT e1.employee_id, e1.first_name, e1.job_id, e1.manager_id, e2.first_name, e2.job_id 
FROM   employees e1, employees e2
WHERE  e1.manager_id = e2.employee_id(+);


--05. 모든 사원의 사번, 이름, 부서명, 도시, 주소 정보를 조회하여 사번 순으로 정렬하는 쿼리문을 작성한다. --107
SELECT e.employee_id, e.first_name, d.department_name, l.city, l.street_address
FROM   employees e, departments d, locations l
WHERE  e.manager_id = d.manager_id(+)
AND    d.location_id = l.location_id;


-----------------------------------------------------------------------------------------------
--실습
--01. 모든 사원의 사번, 성명, 업무코드, 매니저사번, 매니저성명, 매니저의 업무코드 조회하여
--사번 순으로 정렬 --107, SELF JOIN
SELECT e1.employee_id, e1.first_name, e1.job_id, e1.manager_id, e2.first_name, e2.job_id 
FROM   employees e1, employees e2
WHERE  e1.manager_id = e2.employee_id(+)
ORDER BY 1;


--02. 성이 King인 사원들의 사번, 성명, 부서코드, 부서명 조회 --2
SELECT e.employee_id, e.first_name || ' ' || e.last_name, d.department_name
FROM   employees e, departments d
WHERE  e.manager_id = d.manager_id(+)
AND    e.last_name LIKE 'King%';


--03. 위치코드가 1400 인 도시에는 어느 부서가 있나 파악하고자 한다.
--위치코드가 1400 인 도시명, 부서명 조회 --2
SELECT d.department_name, l.city
FROM   departments d, locations l
WHERE  d.location_id = l.location_id
AND    l.location_id = 1400;


--04. 위치코드 1800 인 곳에 근무하는 사원들의 
--사번, 성명, 업무코드, 급여, 부서명, 위치코드 조회 --2
SELECT e.employee_id, e.first_name || ' ' || e.last_name, e.job_id, salary, d.department_name, l.location_id
FROM   employees e, departments d, locations l
WHERE  e.department_id = d.department_id(+)
AND    d.location_id = l.location_id(+)
AND    d.location_id = 1800;


--05. 자신의 매니저보다 먼저 입사한 사원들의  --내입사일자 < 매니저입사일자
--사번, 성명, 입사일자, 매니저성명, 매니저 입사일자 조회 --37, SELF JOIN
SELECT e1.employee_id, e1.first_name, e1.job_id, e1.hire_date, e2.first_name, e2.hire_date 
FROM   employees e1, employees e2
WHERE  e1.manager_id = e2.employee_id(+)
AND    e1.hire_date < e2.hire_date;


--06. toronto 에 근무하는 사원들의 
--사번, 성, 업무코드, 부서코드, 부서명, 도시 조회 --2
SELECT e.employee_id, e.last_name, d.department_id, d.department_name, l.city
FROM   employees e, departments d, locations l
WHERE  e.department_id = d.department_id(+)
AND    d.location_id = l.location_id(+)
AND    LOWER(l.city) LIKE 'toronto';


--07. 커미션을 받는 모든 사원들의 성, 부서명, 위치코드, 도시 조회 --35
SELECT e.last_name, d.department_name, l.location_id, l.city
FROM   employees e, departments d, locations l
WHERE  e.manager_id = d.manager_id(+)
AND    d.location_id = l.location_id(+)
AND    e.commission_pct IS NOT NULL;




-----------------------------------------------------------------------------------------------













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

5.6 ANSI JOIN
 : 모든 RDBMS 에서 공통적으로 사용할 수 있는 국제 표준 형식
1. INNER JOIN(오라클의 EQUI JOIN), 교집합

--------------------------------------------------------------------------------
오라클 조인                           | ANSI 조인
--------------------------------------------------------------------------------
5. SELECT   컬럼명1, 컬럼명2, ...     | SELECT   컬럼명1, 컬럼명2, ...
1. FROM     테이블명1, 테이블명2, ... | FROM     테이블명1 INNER JOIN 테이블명2
2. WHERE    조인조건식                | ON       조인조건식
                                      | (또는)
                                      | USING    (조인컬럼명만)
   AND      일반조건식                | WHERE    일반조건식 --ON, USING 다음의 WHERE 사용
3. GROUP BY                           | GROUP BY    
4. HAVING                             | HAVING
5. ORDER BY                           | ORDER BY
--------------------------------------------------------------------------------
조인 조건절
ON    절 : 조인조건식(테이블명.컬럼명 = 테이블명.컬럼명)
           조인하는 컬럼명이 동일하면 반드시 테이블명을 명시
--                                    ￣￣￣￣￣￣￣￣￣￣￣
USING 절 : (조인컬럼명만)
           조인하는 컬럼명이 동일하면 반드시 테이블명을 명시
--                                    ￣￣￣￣￣￣￣￣￣￣￣
           USING 절에 사용되는 컬럼에 대해서는 테이블명을 절대로 명시하면 안됨
--                                             ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
           
--------------------------------------------------------------------------------

01. 부서코드가 60번인 사번, 성, 부서코드, 부서명 조회
오라클 조인
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+)
AND    e.department_id = 60;

ANSI JOIN ON
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM   employees e INNER JOIN departments d
ON     e.department_id = d.department_id
WHERE  e.department_id = 60;

ANSI JOIN USING
SELECT e.employee_id, e.last_name, department_id, d.department_name
FROM   employees e INNER JOIN departments d
USING  (department_id)
WHERE  department_id = 60;

--------------------------------------------------------------------------------

02. 사번, 성, 업무코드, 업무제목 조회
오라클 조인
SELECT e.employee_id, e.last_name, e.job_id, j.job_title
FROM   employees e, jobs j
WHERE  e.job_id = j.job_id(+);

ANSI JOIN ON
SELECT e.employee_id, e.last_name, e.job_id, j.job_title
FROM   employees e INNER JOIN jobs j
ON     e.job_id = j.job_id(+);

ANSI JOIN USING
SELECT e.employee_id, e.last_name, job_id, j.job_title
FROM   employees e INNER JOIN jobs j
USING  (job_id);

--------------------------------------------------------------------------------

03.
오라클 조인
SELECT e.employee_id, e.last_name, e.job_id, j.job_title
FROM   employees e, jobs j
WHERE  e.job_id = j.job_id(+);

ANSI JOIN ON
SELECT e.employee_id, e.last_name, e.job_id, j.job_title
FROM   employees e INNER JOIN jobs j
ON     e.job_id = j.job_id(+);

ANSI JOIN USING
SELECT e.employee_id, e.last_name, job_id, j.job_title
FROM   employees e INNER JOIN jobs j
USING  (job_id);

--------------------------------------------------------------------------------

04. 우리회사 부서정보를 조회하고자 한다.
부서코드, 부서명, 위치코드, 도시조회
오라클 조인
SELECT d.department_id, d.department_name, l.location_id, l.city
FROM   departments d, locations l
WHERE  d.location_id = l.location_id;

ANSI JOIN ON
SELECT d.department_id, d.department_name, l.location_id, l.city
FROM   departments d INNER JOIN locations l
ON     d.location_id = l.location_id;

ANSI JOIN USING
SELECT d.department_id, d.department_name, location_id, l.city
FROM   departments d INNER JOIN locations l
USING  (location_id);

--------------------------------------------------------------------------------

05. 매니저의 부서가 60이상인 부서의 속한 사원들의
사번, 성, 매니저 사번, 매니저 성 조회
오라클 조인
SELECT e1.employee_id, e1.first_name, e1.job_id, e1.manager_id, e2.first_name
FROM   employees e1, employees e2
WHERE  e1.manager_id = e2.employee_id(+)
AND    e2.department_id >=60;

ANSI JOIN ON
SELECT e1.employee_id, e1.first_name, e1.job_id, e1.manager_id, e2.first_name
FROM   employees e1 INNER JOIN employees e2
ON     e1.manager_id = e2.employee_id(+)
WHERE  e1.department_id >= 60;

ANSI JOIN USING --조인되는 컬럼명이 다르므로 USING 사용불가

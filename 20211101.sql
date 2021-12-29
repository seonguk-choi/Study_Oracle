--------------------------------------------------------------------------------
JOIN 에 사용되는 테이블이 3개 이상일 경우
첫번째 JOIN 의 경과 두번째 JOIN을 추가하는 형태로 JOIN 형식을 사용한다.
--------------------------------------------------------------------------------

06.부서코드 10, 20, 40, 60 인 부서에 속한 사원들의
사번, 성, 부서코드, 부서명, 업무코드, 업무제목
오라클 조인
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, j.job_id, j.job_title
FROM   employees e, departments d, jobs j
WHERE  e.department_id = d.department_id
AND    e.job_id = j.job_id
AND    e.department_id IN(10, 20, 40, 60);

ANSI JOIN ON
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, j.job_id, j.job_title
FROM   employees e INNER JOIN departments d
ON  e.department_id = d.department_id
INNER JOIN jobs j
ON    e.job_id = j.job_id
WHERE    e.department_id IN(10, 20, 40, 60);

ANSI JOIN USING
SELECT e.employee_id, e.last_name, department_id, d.department_name, job_id, j.job_title
FROM   employees e INNER JOIN departments d
USING  (department_id)
INNER JOIN jobs j
USING    (job_id)
WHERE    department_id IN(10, 20, 40, 60);

-------------------------------------------------------------------------------------------------
--실습 오라클 조인, ANSI JOIN(JOIN ON, JOIN USING) 까지 --INNER 조인까지만
--
--01. 사번, 성, 부서코드, 부서명, 위치코드, 도시 조회 --106

오라클 조인
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, l.location_id, l.city
FROM   employees e, departments d, locations l
WHERE  e.department_id = d.department_id(+)
AND    d.location_id = l.location_id(+);


ANSI 조인 JOIN ON
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, l.location_id, l.city
FROM   employees e INNER JOIN departments d
ON  e.department_id = d.department_id(+)
INNER JOIN locations l
ON    d.location_id = l.location_id;


ANSI 조인 JOIN USING
SELECT e.employee_id, e.last_name, department_id, d.department_name, location_id, l.city
FROM   employees e INNER JOIN departments d
USING (department_id)
INNER JOIN locations l
USING  (location_id);


--02. 사번이 110, 130, 150 인 사원들의 사번, 성, 부서명 조회 --3

오라클 조인
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+)
AND    e.employee_id IN(110, 130, 150);


ANSI 조인 JOIN ON
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e INNER JOIN departments d
ON     e.department_id = d.department_id(+)
WHERE    e.employee_id IN(110, 130, 150);


ANSI 조인 JOIN USING
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e INNER JOIN departments d
USING  (department_id)
WHERE  e.employee_id IN(110, 130, 150);


--03. 사번, 성명, 관리자사번, 관리자 성명, 관리자업무코드 조회 --106, SELF JOIN

오라클 조인
SELECT e1.employee_id, e1.first_name || ' ' || e1.last_name, e2.employee_id, e1.manager_id, e2.first_name || ' ' || e1.last_name, e2.manager_id
FROM   employees e1, employees e2
WHERE  e1.manager_id = e2.employee_id;

ANSI 조인 JOIN ON
SELECT e1.employee_id, e1.first_name || ' ' ||e1.last_name, e2.employee_id, e1.manager_id, e2.first_name || ' ' || e1.last_name, e2.manager_id
FROM   employees e1 INNER JOIN employees e2
ON  e1.manager_id = e2.employee_id;


ANSI 조인 JOIN USING



--04. 성이 king 인 사원의 사번, 성명, 부서코드, 부서명 조회 --2

오라클 조인
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+)
AND    UPPER(e.last_name) LIKE '%KING%';


ANSI 조인 JOIN ON
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM   employees e INNER JOIN departments d
ON     e.department_id = d.department_id(+)
WHERE  UPPER(e.last_name) LIKE '%KING%';


ANSI 조인 JOIN USING
SELECT e.employee_id, e.last_name, department_id, d.department_name
FROM   employees e INNER JOIN departments d
USING  (department_id)
WHERE  UPPER(e.last_name) LIKE '%KING%';


--05. 관리자 사번이 149 번인 사원의 
--사번, 성, 부서코드, 부서명 조회 --5

오라클 조인
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+)
AND    e.manager_id = 149;


ANSI 조인 JOIN ON
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM   employees e INNER JOIN departments d
ON     e.department_id = d.department_id(+)
WHERE  e.manager_id = 149;


ANSI 조인 JOIN USING
SELECT e.employee_id, e.last_name, department_id, d.department_name
FROM   employees e INNER JOIN departments d
USING  (department_id)
WHERE  e.manager_id = 149;



--06. 위치코드 1400인 도시명, 부서명 조회 --1

오라클 조인
SELECT d.department_name, l.city
FROM   departments d, locations l
WHERE  d.location_id = l.location_id
AND    l.location_id = 1400;


ANSI 조인 JOIN ON
SELECT d.department_name, l.city
FROM   departments d INNER JOIN locations l
ON     d.location_id = l.location_id
WHERE   l.location_id = 1400;


ANSI 조인 JOIN USING
SELECT d.department_name, l.city
FROM   departments d INNER JOIN locations l
USING  (location_id)
WHERE  location_id = 1400;



--07. 위치코드 1800에 근무하는 사원들의 
--사번, 성, 업무코드, 부서명, 위치코드 조회 --2

오라클 조인
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, l.location_id
FROM   employees e, departments d, locations l
WHERE  e.department_id = d.department_id(+)
AND    d.location_id = l.location_id(+)
AND    l.location_id = 1800;


ANSI 조인 JOIN ON
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, l.location_id
FROM   employees e INNER JOIN departments d
ON  e.department_id = d.department_id(+)
INNER JOIN locations l
ON    d.location_id = l.location_id
WHERE    l.location_id = 1800;

ANSI 조인 JOIN USING
SELECT e.employee_id, e.last_name, department_id, d.department_name, l.location_id
FROM   employees e INNER JOIN departments d
USING (department_id)
INNER JOIN locations l
USING  (location_id)
WHERE  location_id = 1800;


--08. 성에 대소문자 무관하게 z가 있는 사원들의 
--사번, 성, 부서명 조회 --5

오라클 조인
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+)
AND    LOWER(e.last_name) LIKE '%z%';


ANSI 조인 JOIN ON
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e INNER JOIN departments d
ON     e.department_id = d.department_id(+)
WHERE  LOWER(e.last_name) LIKE '%z%';


ANSI 조인 JOIN USING
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e INNER JOIN departments d
USING  (department_id)
WHERE  LOWER(e.last_name) LIKE '%z%';




--09. 관리자보다 먼저 입사한 사원의 
--사번, 성, 입사일자, 관리자사번, 
--관리자성, 관리자입사일자 조회 --37

오라클 조인
SELECT e1.employee_id,e1.last_name, e1.hire_date, e2.employee_id, e1.last_name, e2.hire_date
FROM   employees e1, employees e2
WHERE  e1.manager_id = e2.employee_id
AND    e1.hire_date < e2.hire_date;


ANSI 조인 JOIN ON
SELECT e1.employee_id, e1.first_name || ' ' || e2.employee_id, e1.manager_id, e2.first_name || ' ' || e1.last_name, e2.manager_id
FROM   employees e1 INNER JOIN employees e2
ON     e1.manager_id = e2.employee_id
WHERE  e1.hire_date < e2.hire_date;

ANSI 조인 JOIN USING



--10. 업무코드가 clerk종류의 업무형태인 사원들의 
--사번, 성, 부서명, 업무제목 조회 --45

오라클 조인
SELECT e.employee_id, e.last_name, d.department_name, j.job_title
FROM   employees e, departments d, jobs j
WHERE  e.department_id = d.department_id(+)
AND    e.job_id = j.job_id(+)
AND    LOWER(e.job_id) LIKE '%clerk%';


ANSI 조인 JOIN ON
SELECT e.employee_id, e.last_name, d.department_name, j.job_title
FROM   employees e INNER JOIN departments d
ON     e.department_id = d.department_id(+)
INNER JOIN jobs j
ON     e.job_id = j.job_id
WHERE  LOWER(e.job_id) LIKE '%clerk%';


ANSI 조인 JOIN USING
SELECT e.employee_id, e.last_name, d.department_name, j.job_title
FROM   employees e INNER JOIN departments d
USING  (department_id)
INNER JOIN jobs j
USING  (job_id)
WHERE  LOWER(job_id) LIKE '%clerk%';


--11. toronto 에 근무하는 
--사번, 성, 부서코드, 부서명, 도시명 조회 --2

오라클 조인
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, l.city
FROM   employees e, departments d, locations l
WHERE  e.department_id = d.department_id(+)
AND    d.location_id = l.location_id(+)
AND    UPPER(l.city) LIKE '%TORONTO%';


ANSI 조인 JOIN ON
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, l.city
FROM   employees e INNER JOIN departments d
ON  e.department_id = d.department_id(+)
INNER JOIN locations l
ON    d.location_id = l.location_id
WHERE  UPPER(l.city) LIKE '%TORONTO%';

ANSI 조인 JOIN USING
SELECT e.employee_id, e.last_name, department_id, d.department_name, l.city
FROM   employees e INNER JOIN departments d
USING (department_id)
INNER JOIN locations l
USING  (location_id)
WHERE  UPPER(l.city) LIKE '%TORONTO%';

-------------------------------------------------------------------------------------------------

2. OUTER JOIN : 오라클에서 기호(+)를 사용, 합집합
FROM 절에 LEFT OUTER JOIN / RIGHT OUTER JOIN 을 사용하고
JOIN 조건은 ON / USING 절에 명시한다.
OUTER JOIN ☞ 기준이 되는 테이블 방향으로 조인한다.
LEFT OUTER JOIN  : 왼  쪽 테이블 기준으로 NULL 포함하여 모두 출력(오라클 조인에서 동회의 오른쪽에 (+)  붙은 것)
RIGHT OUTER JOIN : 오른쪽 테이블 기준으로 NULL 포함하여 모두 출력(오라클 조인에서 동회의 왼  쪽에 (+)  붙은 것)

01. 모든 사원들의 사번, 성, 부서코드, 부서명 조회
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+);

NULL 갯수 파악
employees의 department_id
SELECT COUNT(*) cnt
FROM   employees
WHERE  department_id IS NULL;

ANSI JOIN ON
SELECT e.employee_id, e.last_name, department_id, d.department_name
FROM   employees e LEFT OUTER JOIN departments d
USING  (department_id);

-----------------------------------------------------------------------------------------------
--실습
--01. 모든 사원의 사번, 성, 부서명 조회 --107
--오라클 조인
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+);

--ANSI JOIN ON 
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e LEFT OUTER JOIN departments d
ON     e.department_id = d.department_id;

--ANSI JOIN USING
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e LEFT OUTER JOIN departments d
USING  (department_id);

-----------------------------------------------------------------------------------------------
--02. 모든 사원의 사번, 성, 부서명, 업무코드 조회 --107

--오라클 조인
SELECT e.employee_id, e.last_name, d.department_name, e.job_id
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+);

--ANSI JOIN ON 
SELECT e.employee_id, e.last_name, d.department_name, e.job_id
FROM   employees e LEFT OUTER JOIN departments d
ON     e.department_id = d.department_id;

--ANSI JOIN USING
SELECT e.employee_id, e.last_name, d.department_name, e.job_id
FROM   employees e LEFT OUTER JOIN departments d
USING  (department_id);

-----------------------------------------------------------------------------------------------
--03. 모든 사원의 사번, 성, 부서명, 도시명 조회 --107

--오라클 조인
SELECT e.employee_id, e.last_name, d.department_name, l.city
FROM   employees e, departments d, locations l
WHERE  e.department_id = d.department_id(+)
AND    d.location_id = l.location_id(+);

--ANSI JOIN ON 
SELECT e.employee_id, e.last_name, d.department_name, l.city
FROM   employees e LEFT OUTER JOIN departments d
ON     e.department_id = d.department_id
LEFT OUTER JOIN locations l
ON    d.location_id = l.location_id;

--ANSI JOIN USING
SELECT e.employee_id, e.last_name, d.department_name, l.city
FROM   employees e LEFT OUTER JOIN departments d
USING  (department_id)
LEFT OUTER JOIN locations l
USING  (location_id);

-----------------------------------------------------------------------------------------------
--04. 관리자사번이 149번인 
--모든 사원의 사번, 성, 부서명 조회 --6

--오라클 조인
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+)
AND    e.manager_id = 149;

--ANSI JOIN ON 
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e LEFT OUTER JOIN departments d
ON     e.department_id = d.department_id(+)
WHERE  e.manager_id = 149;

--ANSI JOIN USING
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e LEFT OUTER JOIN departments d
USING  (department_id)
WHERE  e.manager_id = 149;

-----------------------------------------------------------------------------------------------
--05. 커미션을 받는 모든 사원들의 
--사번, 성, 부서명, 도시명 조회 --35

--오라클 조인
SELECT e.employee_id, e.last_name, d.department_name, l.city
FROM   employees e, departments d, locations l
WHERE  e.department_id = d.department_id(+)
AND    d.location_id = l.location_id(+)
AND    e.commission_pct IS NOT NULL;

--ANSI JOIN ON 
SELECT e.employee_id, e.last_name, d.department_name, l.city
FROM   employees e LEFT OUTER JOIN departments d
ON     e.department_id = d.department_id
LEFT OUTER JOIN locations l
ON     d.location_id = l.location_id
WHERE  e.commission_pct IS NOT NULL;

--ANSI JOIN USING
SELECT e.employee_id, e.last_name, d.department_name, l.city
FROM   employees e LEFT OUTER JOIN departments d
USING  (department_id)
LEFT OUTER JOIN locations l
USING  (location_id)
WHERE  e.commission_pct IS NOT NULL;

-----------------------------------------------------------------------------------------------
--06. 모든 부서에 대해 
--부서코드, 부서명, 도시명, 국가명, 대륙명 조회 --27

--오라클 조인
SELECT d.department_id, d.department_name, l.city, c.country_name, r.region_name
FROM   departments d, locations l, countries c, regions r
WHERE  d.location_id = l.location_id
AND    l.country_id = c.country_id
AND    c.region_id = r.region_id;

--ANSI JOIN ON 
SELECT d.department_id, d.department_name, l.city, c.country_name, r.region_name
FROM   departments d LEFT OUTER JOIN locations l
ON  d.location_id = l.location_id
LEFT OUTER JOIN countries c 
ON    l.country_id = c.country_id
LEFT OUTER JOIN regions r
ON    c.region_id = r.region_id;

--ANSI JOIN USING
SELECT d.department_id, d.department_name, l.city, c.country_name, r.region_name
FROM   departments d LEFT OUTER JOIN locations l
USING  (location_id)
LEFT OUTER JOIN countries c 
USING  (country_id)
LEFT OUTER JOIN regions r
USING  (region_id);

-----------------------------------------------------------------------------------------------
--07. 사원들이 근무하는 부서와 그 부서에 사원이 몇 명이나 있나 파악하고자 한다.
--    부서코드, 부서명, 사원수 조회 --12

--오라클 조인
SELECT e.department_id, d.department_name, COUNT(*) 사원수
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+)
GROUP BY e.department_id, d.department_name;

--ANSI JOIN ON 
SELECT e.department_id, d.department_name, COUNT(*) 사원수
FROM   employees e LEFT OUTER JOIN departments d
ON     e.department_id = d.department_id(+)
GROUP BY e.department_id, d.department_name;
--ANSI JOIN USING
SELECT department_id, d.department_name, COUNT(*) 사원수
FROM   employees e LEFT OUTER JOIN departments d
USING  (department_id)
GROUP BY department_id, d.department_name;

-----------------------------------------------------------------------------------------------
--08. 성에 대소문자 무관하게 a 가 있는 성을 가진 사원들의 
--사번, 성, 부서명 조회 --56

--오라클 조인
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+)
AND    LOWER(e.last_name) LIKE '%a%';


--ANSI 조인 JOIN ON
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e LEFT OUTER JOIN departments d
ON     e.department_id = d.department_id
WHERE  LOWER(e.last_name) LIKE '%a%';

--ANSI 조인 JOIN USING
SELECT e.employee_id, e.last_name, d.department_name
FROM   employees e LEFT OUTER JOIN departments d
USING  (department_id)
WHERE  LOWER(e.last_name) LIKE '%a%';

-----------------------------------------------------------------------------------------------
--[연습문제 5-2]
--01. 사번이 110, 130, 150 인 사원들의
--    사번, 이름, 부서명 조회 --3

--오라클 조인
SELECT e.employee_id, e.first_name, d.department_name
FROM   employees e, departments d
WHERE  e.department_id = d.department_id(+)
AND    e.employee_id IN (110, 130, 150);

--ANSI 조인 JOIN ON
SELECT e.employee_id, e.first_name, d.department_name
FROM   employees e LEFT OUTER JOIN departments d
ON     e.department_id = d.department_id
WHERE  e.employee_id IN (110, 130, 150);

--ANSI 조인 JOIN USING
SELECT e.employee_id, e.first_name, d.department_name
FROM   employees e LEFT OUTER JOIN departments d
USING  (department_id)
WHERE  e.employee_id IN (110, 130, 150);

-----------------------------------------------------------------------------------------------
--02. 모든사원의 사번, 성, 부서코드, 업무코드, 업무제목 조회 --107
--사번순으로 정렬

--오라클 조인
SELECT e.employee_id, e.last_name, department_id, d.department_name, j.job_id, j.job_title
FROM   employees e, departments d, jobs j
WHERE  e.department_id = d.department_id(+)
AND    e.job_id = j.job_id(+)
ORDER BY 1;


--ANSI 조인 JOIN ON
SELECT e.employee_id, e.last_name, department_id, d.department_name, j.job_id, j.job_title
FROM   employees e LEFT OUTER JOIN departments d
ON     e.department_id = d.department_id(+)
LEFT OUTER JOIN jobs j
ON     e.job_id = j.job_id
ORDER BY 1;


--ANSI 조인 JOIN USING
SELECT e.employee_id, e.last_name, department_id, d.department_name, job_id, j.job_title
FROM   employees e LEFT OUTER JOIN departments d
USING  (department_id)
LEFT OUTER JOIN jobs j
USING  (job_id)
ORDER BY 1;

-----------------------------------------------------------------------------------------------

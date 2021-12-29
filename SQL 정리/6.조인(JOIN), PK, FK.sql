5. 조인(JOIN)
   하나의 테이블로부터 데이터를 조회할 수 없는 경우
   여러개의 테이블로부터 데이터를 조회하여
   합쳐진 테이블의 테이터를 조회
-- ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣

------------------------------------------------------------------------------------------------


PK(Primary Key) : 테이블의 레코드를 구분할 수 있는 최소의 컬럼(UNIQUE, NOT NULL)
FK(Foreign Key) : 다른 테이블의 PK를 참조하는 컬럼, NULL허용
   : 참조 데이터 무결성 보장 -> 참조 관계에 있는 테이블의 데이터 추가, 삭제, 수정을 통제할 수 있다.
  PK는 부, FK는 자식, 부모와 자식관계로 볼 수 있습니다.
--￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
  PK는 주로 학번, 주민번호, 사원번호 등 유일한 값을 가지는 컬럼이 주로 PK 의 대상이 됩니다.

예)
학생 테이블 
학번(PK)    이름     주소        학과번호(FK)
1111       홍길동   광주시         a11
1112       강감찬   서울시         a11
1113       이순신   인천시         a12
1114       유관순   경기도         a12

--↓ 정규화 : 최대한 축소시켜 필요한 것만 남김
학과 테이블
학과번호(PK) 학과명
a11          전산과
a12          수학과

위와 같이 두개의 테이블이 있습니다.  
학생 테이블에서 학생 개개인을 유일하게 구분할 수 있는 컬럼으로 학번이 적절하기에 PK가 되며 
학과번호 컬럼은 중복이 되기에 구분이 가능한 키가 아니지만

학과 테이블의 학과번호(PK)와 연결될 수 있기에 FK가 됩니다. 
이러한 관계를 통해 두 테이블은 조합하여 데이터를 추출할 수 있게 됩니다.  

예를 들어 학생 테이블의 모든 학생의  학번, 이름, 주소, 학과번호, 학과명을 출력하고자 하면
--                                   ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
SELECT  학번, 이름, 주소, 학생테이블.학과번호, 학과명
FROM    학생테이블, 학과테이블                        --컴마(,)로 구분하는데 테이블명을 나열한것을 JOIN 이라 함
WHERE   학생테이블.학과번호 = 학과테이블.학과번호 ;   --조인조건식 FK = PK;

  라고 조인을 걸어서 해결할 수 있습니다. 이렇게 PK 와 FK 를 나누게 된 이유는 
  데이터의 중복을 최소화 하기 위한 정규화에 의해 테이블이 나뉘어졌기 때문입니다. 
--￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
예를 들어 학생, 학과 테이블로 나눠지지 않고 처음부터 합쳐져 있었다면

합쳐진 테이블

학번(PK)    이름     주소        학과번호(FK)   학과명
1111       홍길동   광주시         a11          전산과
1112       강감찬   서울시         a11          전산과
1113       이순신   인천시         a12          수학과
1114       유관순   경기도         a12          수학과

으로 되있겠으나 학과명이 중복됩니다. 
현재 예제는 컬럼의 양이 적어서 크게 느껴지지 않겠지만
컬럼이 10개 20개 30개만 되도 엄청난 데이터의 낭비가 발생함을 알 수 있습니다. 
이렇게 중복되는 데이터를 최소화 하고자 정규화가 생겨났습니다.
--                                    ★￣￣￣
결론 - PK와 FK는 관계형 데이터베이스 RDBMS(테이블형태로 된 관계형데이터베이스) 에서 반드시 필요하다.

PK는 데이터를 구분할 수 있는 컬럼이며 
FK는 PK와 대응되거나 NULL 값을 갖는다.
--  ★￣￣￣￣￣     ￣￣￣￣       

--------------------------------------------------------------------------------------------


부서정보 --27
SELECT * FROM department;
사원정보 --107
SELECT * FROM employees;
업무정보 --19
SELECT * FROM jobs;

5.1. CARTESIAN PRODUCT(곱하기)
 : WHERE 절에 JOIN 조건을 기술하지 않아 잘못된 데이터행의 결과를 갖게 되는 현황
   cartesian product, cross join 이라고 함, SQL에서는 쓰이는 경우가 없음
사번, 성, 부서명 조회
SELECT employee_id, last_name, department_name --107*27 : cross 됨, 제대로된 JOIN이 아니다
FROM   employees, departments;

5.2. EQUI JOIN(ANSI 에서는 INNER JOIN), 교집합
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
WHERE  e.department_id = d.department_id;

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


5.3. NON-EQUI JOIN
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


-----------------------------------------------------------------------------------------------


5.4. OUTER JOIN : NULL 값이 생략되는 정보도 포함해서 표시하기 위한 조인, 합집합
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


5.5. SELF JOIN
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



5.5. SELF JOIN
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

5.6. ANSI JOIN
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







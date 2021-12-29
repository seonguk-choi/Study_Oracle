--주석처리 : ctr + shift + /, 또는 --(-표시 2개)

--HR 유저에 관리되는 table 확인
SELECT table_name
FROM user_tables; --명령어의 끝은 세미콜론(;)으로 끝남, 명령어의 실행은 Ctrl + Enter, f5


TABLE_NAME
-------------
COUNTRIES   : 국가정보
REGIONS     : 대륙정보
LOCATIONS   : 위치정보
DEPARTMENTS : 부서정보
JOBS        : 업무정보
EMPLOYEES   : 사원정보
JOB_HISTORY : 업무이력정보

2.1 데이터 조회
--DESC(DESCRIBE) : 테이블의 컬럼이름, 데이터형, 길이, NULL허용여부 등 테이블의 특정 정보를 제공
DESC 테이블 명  == DESCRIBE 테이블명

DESC employees; --employees 테이블의 구조 파악

이름             널?       유형       
-------------- -------- ------------
EMPLOYEE_ID    NOT NULL NUMBER(6)    : 사번
FIRST_NAME              VARCHAR2(20) : 이름
LAST_NAME      NOT NULL VARCHAR2(25) : 성
EMAIL          NOT NULL VARCHAR2(25) : 이메일
PHONE_NUMBER            VARCHAR2(20) : 전화번호
HIRE_DATE      NOT NULL DATE         : 입사일
JOB_ID         NOT NULL VARCHAR2(10) : --업무코드
SALARY                  NUMBER(8,2)  : 급여
COMMISSION_PCT          NUMBER(2,2)  : 상여율
MANAGER_ID              NUMBER(6)    : 메니저아이디
DEPARTMENT_ID           NUMBER(4)    : 부서코드

SELECT ☞ 테이블에 저장된 데이터를 조회하기 위한 명령어, SQL문 중 가장 많이 사용
         SELECT 문에는 FROM 키워드가 반드시 따라와야함.
WHERE  ☞ SELECT 문에서 마지막에 쓸 수 있는데 원하는 레코드만 검색하고자 할 때 사용
         조건절의 구성은 컬럼, 연산자, 비교 대상값이 올 수 있다.
         
SELECT 안의
*      : 모든컬럼
컬럼명 : 특정컬럼명

SELECT *
FROM 테이블명;

SELECT 컬럼명1, 컬럼명2 ...
FROM   테이블명

--사원테이블(employees)에서 모든 컬럼 조회
SELECT *
FROM employees; --실행 : crtl + enter, f5

--사원테이블에서 사번, 이름, 성조회
SELECT employee_id, first_name, last_name
FROM employees;

--사원테이블에서 사번, 이름, 부서코드, 입사일자, 업무코드, 급여 조회
SELECT employee_id, first_name, last_name, department_id, hire_date, job_id, salary
FROM employees;


------------------------------------------------------------------------------------


2.2 WHERE 조건절 : 특정 조건에 맞는 데이터행을 조회하고자 할 경우
                 : WHERE 절에서는 ALIAS(별명) 사용 불가!
                 
SELECT 절 : 필드명
FROM   절 : 테이블명
WHERE  절 : 조건

○ WHERE 절에 사용가능한 연산자
1. 산술연산자 : +, _, *, / : SELECT 절과 WHERE 절에서 사용 가능
2. 문자열연결연산자 : || : SELECT 절과 WHERE 절에서 사용 가능
3. 비교연산자 : =(같다), !=, <>, ^=(같지 않다), >(초과), <(미만), >=(이상), <=(이하)
              : DB에서는 같다가 '=='가 아니고 '=' 하나만 사용
              : 문자, 날짜는 반드시 홑따옴표('')로 묶어 사용
4. 논리조건연산자 : AND, OR, NOT
5. 범위조건연산자 : BETWEEN ~ AND
6. IN조건연산자 : OR 연산자와 동일한 기능을 수행
7. LIKE 조건연산자 : --＊＊＊＊매우중요 컬럼값들 중에 특정 패턴에 속하는 값을 조회
8. NULL 처리 조건연산자 : 데이터값이 없는 형태 ☞ 비교불가, 연산불가
                        : 값 = NULL(X), 값 != NULL(X)
                        : 값 IS NULL(O), 값 IS NOT NULL(O)

--사원테이블에서 사번, 이름, 부서코드, 입사일자, 업무코드, 급여 조회
SELECT employee_id, first_name, last_name, department_id, hire_date, job_id, salary
FROM employees;


------------------------------------------------------------------------------------

2.3 산술연산자
2.3.1. 산술연산자 : +, -, *, / : SELECT 절과 WHERE 절에서 사용 가능

01. 80번 부서의 사원의
사번, 성 급혀 한해동안 받은 급여(연봉) 조회
SELECT employee_id, last_name 이름, salary * 12 AS "연봉" --34
FROM   employees
WHERE department_id = 80;

SELECT 절에 다음과 같을 때 ALIAS(별칭, 별명, 애칭)를 습관적으로 지정하기
1. 칼럼표현에 연산지/함구가 사용되는 경우
2. 컬럼표현이 지나치게 긴 경우

○ ALIAS 사용 방법
1. 키워드 AS 사용          : 컬럼표현 AS ALIAS명
2. 공백을 두고 사용        : 컬럼표현 ALIAS명 --＊가장 많이 사용
3. ALIAS명에 공뱅이 있으면 쌍따옴표(더블쿼테이션"")를 사용하고 공백이 없으면 쌍따옴표 생략

02. 연봉이 15000이상인 사원들의
사번, 이름, 성, 업무코드, 급여, 연봉 조회
SELECT employee_id, last_name, first_name, department_id, salary, salary * 12 연봉
FROM   employees
--WHERE 연봉 >= 15000; --XXX, WHERE절에서는 ALIAS 사용불가
WHERE  salary * 12 >= 15000;

03. 성명이 'StevenKing' 인 사원의
사번, 이름 업무코드, 급여, 부서코드(dept_id 로 ALIAS) 조회
SELECT employee_id, first_name || ' ' || last_name, job_id, salary, department_id "dept_id"
FROM   employees
WHERE  first_name || last_name = 'StevenKing'; --성명이 StevenKing

04. 사번이 101번인 사원의 사번, 성명을 조회한다.
성명은 이름과 성을 합해서 사용하고 'name'으로 ALIAS 한다.
SELECT employee_id, first_name || ' ' || last_name name
FROM   employees
WHERE  employee_id = 101;

05. 사번이 101번인 사원의 성명과 연봉을 조회한다.
성명은 이름과 성을 합해서 사용하고 'name'으로 ALIAS
연봉은 'annual salary'로 ALIAS
SELECT employee_id, first_name || ' ' || last_name name, salary * 12 "annual salary"
FROM   employees
WHERE  employee_id = 101;

2.3.2. 비교 연산자 : =, !=, <>, ^=, >, <, >=, <=
01. 급여가 3000이하인 사원의
사번, 성, 급여, 부서코드, 업무코드 조회
SELECT employee_id, first_name, salary, job_id, department_id
FROM   employees
WHERE  salary <= 3000;

02. 부서코드가 80 초과인 사원의
사번, 성, 급여, 부서코드 조회
SELECT employee_id, first_name, salary, job_id, department_id
FROM   employees
WHERE  department_id > 80;

03. 부서코드가 90인 부서의 속한 사원들의
사번, 이름, 성, 부서코드, 업무코드 조회
SELECT employee_id, first_name, job_id, department_id
FROM   employees
WHERE  department_id = 90;

＊ 문자데이터의 표현 : 반드시 홑따옴표로 묶어 사용(문자, 날짜)
04. 성이 King인 사원들의
사번, 이름, 성, 부서코드 조회
SELECT employee_id, first_name, last_name, department_id
FROM   employees
WHERE  last_name = 'King';

기본날짜 데이터 포맷 조회
시스템의 현재날짜를 반환하는 함수 - SYSDATE
다른함수와는 달리 파라미터가 필요하지 않은 함수
--직접 입력된 날짜는 TO_CHAR로 변환 안됨
--SYSDATE와 hire_date 등 날짜가 입력되어 있는 컬럼은 TO_CHAR로 변환

SELECT *
FROM v$nls_parameters;

SELECT VALUE
FROM nls_session_parameters
WHERE parameter = 'NLS_DATE_FORMAT';

--오늘 날짜를 조회,
SELECT SYSDATE today --21/10/19, 날짜는 '/'로 구분
FROM   dual; --dual : 가짜데이터 테이블

--TO_CHAR : 날짜 포맹을 이용하여 사용자가 원하는 형태의 문자로 변환
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') today
FROM   dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') today
FROM   dual;

SELECT TO_CHAR(SYSDATE, 'YYYY.MM.DD') today
FROM   dual;

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH:MI:SS') today --2021/10/19 11:30:03
FROM   dual;

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') today --2021/10/19 11:30:03(24시간제)
FROM   dual;

SELECT TO_CHAR(SYSDATE, 'YEAR-MONTH-DAY') today --TWENTY TWENTY-ONE-10월-화요일
FROM   dual;

SELECT TO_CHAR(SYSDATE, 'YEAR-MON-DY') today --TWENTY TWENTY-ONE-10월-화
FROM   dual;

05. 입사일이 2004년 1월 1일 이전(2003년까지)이 사원의
사원코드, 성, 입사일자 조회
SELECT employee_id, last_name, hire_date
FROM employees
--WHERE hire_date <= '2003/12/31'; --날짜는 반드시 홑따옴표로 묶어 사용
--WHERE hire_date < '2004/01/01'; --날짜는 반드시 홑따옴표로 묶어 사용
--WHERE hire_date <= '2003-12-31'; --날짜는 반드시 홑따옴표로 묶어 사용
--WHERE hire_date < '2004-01-01'; --날짜는 반드시 홑따옴표로 묶어 사용
--WHERE hire_date <= '03/12/31'; --날짜는 반드시 홑따옴표로 묶어 사용
--WHERE hire_date < '04/01/01'; --날짜는 반드시 홑따옴표로 묶어 사용
--WHERE hire_date <= '03-12-31'; --날짜는 반드시 홑따옴표로 묶어 사용
--WHERE hire_date < '04-01-01'; --날짜는 반드시 홑따옴표로 묶어 사용
--WHERE TO_CHAR(hire_date, 'YYYY') < 2004; --묵시적 행변환 숫자를 문자로 자동인식
--WHERE TO_CHAR(hire_date, 'YYYY') < 2004;
--WHERE TO_CHAR(hire_date, 'YYYY') <= 2003;
WHERE TO_CHAR(hire_date, 'YYYY') <= 2003;

SELECT 10 + '10' --20
FROM dual;

2.3.3. 논리연산자
2.3.3.1 AND 연산자 : 조건이 모두 TRUE 일때만 TRUE를 반환

01. 30번 부서 사원 중 급여가 10000이하인 사원의
사번, 성명, 급여, 부서코드 조회
성명은 이름과 성을 합하여 사용하고 'name'으로 ALIAS 한다.
SELECT employee_id, first_name || ' ' || last_name name, salary, department_id
FROM   employees
WHERE  department_id = 30
AND    salary <= 10000;

02. 30번 부서에서 급여가 10000이하이면서 2005년 이번(즉, 2004년까지)에 입사한
사번, 성명, 급여, 부서코드, 입사일자 조회
SELECT employee_id, first_name, salary, department_id, hire_date
FROM  employees
WHERE department_id = 30
AND   salary <=10000
--AND   hire_date <= '2004/12/31'; --날짜, 문자는 반드시 홑따옴표로 묶음
AND   TO_CHAR(hire_date, 'YYYY') < '2005';

03. 부서코드가 10이상 30이하인 사원들의
사번, 성명 부서코드 조회
성명은 이름과 성을 합하여 사용하고 'name'으로 별명한다.
SELECT employee_id, first_name || ' ' || last_name name, department_id
FROM   employees
WHERE  department_id >= 10
AND    department_id <=30;

04. 급여가 10000이상 15000이하인 사원들의
사번, 성명, 급여, 업무코드 조회
성명은 이름과 성을 합하여 사용하고 'name'으로 별명한다.
SELECT employee_id, first_name || ' ' || last_name name, salary, job_id
FROM   employees
WHERE  salary >= 10000
AND    salary <= 15000;
 
05. 부서가 60인 부서에서 급여가 5000이상인 사원들의
사번, 성명, 부서코드, 급여 조회
성명은 이름과 성을 합하여 사용하고 'name'으로 별명한다.
SELECT employee_id, first_name || ' ' || last_name name, department_id, salary
FROM   employees
WHERE  department_id = 60
AND    salary >= 5000;

06. 부서 코드가 60이하인 2003년 6월 17일 이전 입사한 사원의
사번, 성명, 입사일자 조회
성명은 이름과 성을 합하여 사용하고 'name'으로 별명한다.
SELECT employee_id, first_name || ' ' || last_name name, hire_date
FROM   employees
WHERE  department_id <= 60
AND    hire_date <= '2003/06/17';

2.3.3.2 OR  연산자는 조건중에 하나만 TRUE이면 TRUE를 반환한다.
07. 30번 부서나 60번 부서에 속한 사원들의
사번, 성명, 급여, 부서코드 조회
SELECT employee_id, first_name || ' ' || last_name name, salary, department_id
FROM   employees
WHERE  department_id = 30
OR     department_id = 60;

08. 부서코드가 10, 20, 30 인 부터에 속한 사원들의
사번, 성명, 급여, 부서코드 조회
SELECT employee_id, first_name || ' ' || last_name name, salary, department_id
FROM   employees
WHERE  department_id = 10
OR     department_id = 20
OR     department_id = 30;

2.3.3.3 AND 연산자와 OR 연산자를 혼합하여 문자을 작성하낟.
09. 30번 부서의 급여가 10000미만인 사원과
    60번 부서의 급여가 5000이상인 사원의
    성명, 급여, 부서코드 조회
SELECT employee_id, first_name || ' ' || last_name name, salary, department_id
FROM   employees
WHERE  (department_id = 30 AND salary < 10000)
OR     (department_id = 60 AND salary >= 5000);

연산자 순위
산술연산인 경우 : *,/ -> +,-
논리연산인 경우 : AND -> OR

2.3.4. 범위 조건 연산자 : BETWEEN ~ AND
BETWEEN 시작값 AND 미자막값 : 시작값 이상 마지막값 이하와 같다
BETWEEN 이나 관계연산자로 비교한 수 있는 값은 숫자, 문자, 날짜 데이터
A이상 B이하 : 컬럼명 BETWEEN A AND B
A미만 B초과 : 컬럼명 NOT BETWEEN A AND B
            : NOT 컬럼명 BETWEEN A AND B
            
01. 사번 110번부터 120번까지
사번, 성명, 급여, 부서코드 조회
SELECT employee_id, first_name || ' ' || last_name name, salary, department_id
FROM   employees
--WHERE  employee_id >= 110
--AND    employee_id <= 120;
WHERE employee_id BETWEEN 110 AND 120;

02. 사번 110번 미만부터 120번 초과까지
사번, 성명, 급여, 부서코드 조회
SELECT employee_id, first_name || ' ' || last_name name, salary, department_id
FROM   employees
--WHERE  employee_id >= 110
--OR    employee_id <= 120;
--WHERE employee_id NOT BETWEEN 110 AND 120;
WHERE NOT employee_id BETWEEN 110 AND 120;

03. 사번이 110에서 120인 사원 중 급여가 5000에서 10000사이의
사번, 성명, 급여, 부서코드 조회
SELECT employee_id, first_name || ' ' || last_name name, salary, department_id
FROM   employees
WHERE  employee_id BETWEEN 110 AND 120
AND    salary BETWEEN 5000 AND 10000;

04. 2005SUS 1월 1일 이후부터 2007년 12월 31일 사이에 입사한 사원의
사번, 성명, 급여, 입사일자 조회
SELECT employee_id, first_name || ' ' || last_name name, salary, hire_date
FROM   employees
-- WHERE  hire_date BETWEEN '2005/01/01' AND '2007/12/13'; --71
--WHERE  TO_CHAR(hire_date, 'YYYY') BETWEEN '2005' AND '2007'; --72
WHERE  TO_CHAR(hire_date, 'YYYY') BETWEEN 2005 AND 2007; --72

※ DATE 타입의 hire_date 의 값을 문자값으로 비교했음에도 오류없이 결과가 나오는 이유는
오라클 SQL엔진 자동으로 묵시적 형변환을 했기 떄문이다.
하지만 가급적 명시적으로 형변환 하는 것이 바람직하다.
명시적 형변환 함수는 TO_DATE() 이다.
SELECT employee_id, first_name || ' ' || last_name name, salary, hire_date
FROM   employees
WHERE  hire_date BETWEEN TO_DATE('2005/01/01') AND TO_DATE('2007/12/31'); --72

06. 입사일자가 2003년 8월 1일부터 2005년 7월 31일에 해당하는 사원들의
사번, 성명, 입사일자 조회
SELECT employee_id, first_name || ' ' || last_name name, salary, hire_date
FROM   employees
WHERE  hire_date BETWEEN TO_DATE('2003/08/01') AND TO_DATE('2005/07/31');

07. 부서코드가 20, 30, 40, 60, 100 인 부서에 속한 사원들의
사번, 성명, 부서코드 조회
SELECT employee_id, first_name || ' ' || last_name, department_id
FROM employees
WHERE department_id = 20
OR    department_id = 30
OR    department_id = 40
OR    department_id = 60
OR    department_id = 100;

2.3.5. IN 조건 연산자
여러개의 값 중에서 일치하는 값이 있는지 비교할 때는 IN(값1, 값2, 값3, ...) 의 형태로
비교하는 값의 목록을 나열한다.
: 동일한 컴럼표현에 대해 동등 비교한 형태의 조건식을 OR  형태로 나열한 것
컬럼표현 IN (데이터값 목록) <-> 컬럼표현 NOT IN (데이터값 목록)
                                NOT 컬럼표현 IN (데이터값 목록)
                                
IN 연산자는 OR 연산자와 동인한 기능을 수행
비교할 값이 많을 때 OR 연산자를 사용하면 SQL 문장이 복잡해지는데
IN 연산자를 사용하면 문장이 깔끔해지고 가독성이 높아짐.

01. 30번 부서원 또는 60번 부서원 또는 90번 부서원의
사번, 성명, 급여, 부서코드 조회
SELECT employee_id, first_name || ' ' || last_name, salary, department_id
FROM employees
--WHERE department_id = 30
--OR    department_id = 60
--OR    department_id = 90
WHERE department_id IN(30, 60, 90);

02 30번 부서원 또는 60번 부서원 또는 90번 부서원이 아닌
사번, 성명, 급여, 부서코드 조회
SELECT employee_id, first_name || ' ' || last_name, salary, department_id
FROM employees
--WHERE department_id != 30
--AND   department_id != 60
--AND   department_id != 90;
--WHERE department_id NOT IN(30, 60, 90);
WHERE NOT department_id IN(30, 60, 90);


-----------------------------------------------------------------------------------------------
--실습
--01. 부서코드 30, 40, 60인 부서에 속한 사원들의
--사번, 성명, 부서코드, 급여를 조회하여 성명순으로 정렬한다.
SELECT  employee_id, first_name || ' ' || last_name name, department_id, salary --12
FROM    employees
WHERE   department_id IN (30,40,60);

--02. 커미션을 받는 사원들의 사번, 성명, 급여, 커미션요율을 조회하여
--커미션요율이 높은 사원부터 낮은 사원순으로 정렬한다.
SELECT  employee_id, first_name || ' ' || last_name name, salary, commission_pct --35
FROM    employees
WHERE   commission_pct IS NOT NULL
ORDER BY commission_pct DESC;

--03. 성명에 대/소문자 무관하게 z 가 있는 사원들의
--사번, 성명 을 조회하여 성명순으로 정렬한다.
SELECT  employee_id, first_name || ' ' || last_name name
FROM    employees
WHERE   first_name || ' ' || last_name LIKE '%z%'
OR      first_name || ' ' || last_name LIKE '%Z%';

-----------------------------------------------------------------------------------------------
--[연습문제 2-1]
--01. 사번이 200인 사원의 성명과 부서코드를 조회하는 쿼리문을 작성한다.
SELECT  first_name || ' ' || last_name name, department_id
FROM    employees 
WHERE   employee_id = 200;

--02. 급여가 3000에서 15000 사이에 포함되지 않는 사원의 
--사번, 성명, 급여 정보를 조회하는 쿼리문을 작성한다.
--(단, 이름은 성과 이름을 공백문자를 두어 합쳐서 조회한다. 
--예를 들어 이름이 John 이고 성이 Seo 이면  John Seo 로 조회되도록 한다.)
SELECT  employee_id, first_name || ' ' || last_name name, salary
FROM    employees
--WHERE   salary NOT BETWEEN 3000 AND 15000;
WHERE   NOT salary BETWEEN 3000 AND 15000;

--03. 부서코드 30과 60 에 소속된 사원의 
--사번, 성명, 부서코드, 급여를 조회하는데, 
--성명을 알파벳순서로 정렬하여 조회하는 쿼리문을 작성한다.
SELECT  employee_id, first_name || ' ' || last_name name, department_id, salary
FROM    employees
WHERE   department_id IN (30,60)
--ORDER BY name;
--ORDER BY 2;
ORDER BY first_name || ' ' || last_name;

--04. 급여가 3000에서 15000 사이 이면서, 부서코드 30 또는 60에 소속된 사원의 
--사번, 성명, 급여를 조회하는 쿼리문을 작성한다.
--(단, 조회되는 컬럼명을 이름은 성과 이름을 공백문자를 두어 합쳐 name 으로,
--급여는 Monthly Salary 로 조회되도록 한다.)
SELECT  employee_id, first_name || ' ' || last_name name, salary "Monthly Salary"
FROM    employees
WHERE   salary BETWEEN 3000 AND 15000
AND     department_id IN (30,60);

--05. 소속된 부서코드가 없는 사원의 
--사번, 성명, 업무코드를 조회하는 쿼리문을 작성한다.
SELECT  employee_id, first_name || ' ' || last_name name, job_id
FROM    employees
WHERE   department_id IS NULL;

--06. 커미션을 받는 사원의 
--사번, 성명, 급여, 커미션을 조회하는데, 
--커미션이 높은 사원부터 낮은 사원 순서로 정렬하여 조회하는 쿼리문을 작성한다. 
SELECT  employee_id, first_name || ' ' || last_name name, salary, commission_pct
FROM    employees
WHERE   commission_pct IS NOT NULL
ORDER BY commission_pct DESC;


--07. 성명에 대소문자 구분없이 문자 z 또는 Z 가 포함된 사원의 
--사번과 성명(name)을 조회하는 쿼리문을 작성한다.
SELECT  employee_id, first_name || ' ' || last_name name
FROM    employees
WHERE   first_name || ' ' || last_name LIKE '%z%'
OR      first_name || ' ' || last_name LIKE '%Z%';

-----------------------------------------------------------------------------------------------












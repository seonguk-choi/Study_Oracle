2.3.6. 검색에 해당하는 연산자 : 필드명 LIKE 조건연산자(--*포함하는)
                          : 필드명 NOT LIKE 조건연산자(--*포함하지 않는)

컬럼값들 중에 특정 패턴에 속하는 값을 조회하고자 할 경우 LIKE 연산자를 사용한다.

% : 모든 것
_ : 한 글자

컬럼표현 LIKE % + 검색문자 + %
성명 LIKE '최%' ☞ 성명이 최로 시작하는 모든 것 : 최성욱, 최고, 최
성명 LIKE '%최' ☞ 성명이 최로 끝나는 모든 것 : 성욱최, 고최, 최
성명 LIKE '%최%' ☞ 성명이 최을 포함하는 모든 것 : 최성욱, 최고, 성욱최, 고최, 최

01. 이름이 K로 시작하는 사원들의
사번, 이름, 성, 입사일자 조회
SELECT employee_id, first_name, last_name, hire_date
FROM   employees
WHERE  first_name LIKE 'K%';

02. 이름이 S로 끝나는 사원들의
사번, 이름, 성, 입사일자 조회
SELECT employee_id, first_name, last_name, hire_date
FROM   employees
WHERE  first_name LIKE '%s';

03. 성에 소문자 z가 포함된 성을 가진 사원들의
사번, 이름, 성, 입사입자 조회
SELECT employee_id, first_name, last_name, hire_date
FROM   employees
WHERE  last_name LIKE '%z%';

04. 성에 대소문자 무관하게 z가 포함된 성을 가진 사원들의
사번, 이름, 성, 입사일자 조회
SELECT employee_id, first_name, last_name, hire_date
FROM   employees
WHERE  last_name LIKE '%z%'
OR     last_name LIKE '%Z%';

05. 성명에 대소문자 무관하게 z가 포함된 성을 가진 사원들의
사번, 이름, 성, 입사일자 조회
SELECT employee_id, first_name, last_name, hire_date
FROM   employees
WHERE  first_name || last_name LIKE '%z%'
OR     first_name || last_name LIKE '%Z%';

06. 성에 소문자 z가 앞에서 2번째에 위치해 있는 성을 가진 사원들의
사번, 이름, 성, 입사일자 조회
SELECT employee_id, first_name, last_name, hire_date --1
FROM   employees
WHERE  last_name LIKE '_z%';

07. 성에 소문자 Z가 앞에서 5번째 위치에 있는 성을 가진 사람들
사번, 이름, 성, 입사일자 조회
SELECT employee_id, first_name, last_name, hire_date --2
FROM   employees
WHERE  last_name LIKE '____z%';

08. 성에 소문자 z가 뒤에서부터 5번째 위치에 있는 성을 가진 사원들의
사번, 이름, 성, 입사일자 조회
SELECT employee_id, first_name, last_name, hire_date --1
FROM   employees
WHERE  last_name LIKE '%z____';

LKIE 연산자 역시 BETWEEN 이나 IN 과 같이 NOT 연산자를 함께 사용 할 수 있다.
09. 전화번호가 6으로 시작되지 않는 사원의
사번, 이름, 성, 입사일자 조회
SELECT employee_id, first_name, last_name, hire_date
FROM   employees
WHERE  phone_number NOT LIKE '6%';
--WHERE  NOT phone_number LIKE '6%';

10. 입사일자가 12월에 입사한 사원의
사번, 이름, 성, 입사일자 조회
SELECT employee_id, first_name, last_name, hire_date --7
FROM   employees
--WHERE  hire_date LIKE '%12%'; --XX
--WHERE  hire_date LIKE '%/12/%'; --OO
--WHERE  hire_date LIKE '%___12___%'; --OO
--WHERE  hire_date LIKE '___12%'; --OO
--WHERE  hire_date LIKE '__/12'; --OO
--WHERE  hire_date LIKE '__%/12/%__'; --OO
--WHERE  TO_CHAR(hire_date, 'MM') = '12'; --OO
--WHERE  TO_CHAR(hire_date, 'MM') = 12; --OO
--WHERE  TO_CHAR(hire_date, 'MM') LIKE '12'; --OO


LIKE 연산자와 함께 사용된 '%', '_' 를 문자 자체로 인식시키려면
%, _ 앞에 기호문자를 붙이고 옵션을 줘야한다.
컬럼표현 LIKE '%특수문자_%' ESCAPE '특수문자'
컬럼표현 LIKE '%특수문자%%' ESCAPE '특수문자'
특수문자 : ~,!,@,#,$,^,^,&,*,-,?,\ --'\'를 가장 많이 사용

11. 사원들의 업무형태(업무코드 : job_id)를 파악하고자 한다.
업무코드가 _A 인 사원들의 사번, 이름, 성, 입사일자, 업무코드 조회
SELECT employee_id, first_name, last_name, hire_date, job_id --7
FROM   employees
--WHERE  job_id LIKE '%_A%'; --XXX, A앞에 한글자 있는 모든 것
WHERE  job_id LIKE '%\_A%' ESCAPE '\';

2.3.7. 데이터 값이 없는 협태의 표현 : NULL -- 비교불가, 연산불가
그래서, 컬럼표현 IS NULL / IS NOT NULL 로 판단 ☞ NULL 인지 아닌지 판단
컬럼표현 = NULL(X), 컬럼표현 != NULL(X)
컬럼표현 IS NULL(O), 컬럼표현 IS NOT NULL(O)

SELECT * --23
FROM   locations;

SELECT *
FROM  locations
WHERE state_province LIKE '%'; --% : 모든것, NULL 제외

값이 있는 것만 조회
SELECT *
FROM   locations
WHERE  state_province IS NOT NULL; --IS NOT NULL : NULL이 아닌, 즉 값이 있는

01. 부서배치 받지 않은(부서가 NULL) 사원의
사번, 성, 부서코드, 업무코드, 급여 조회
SELECT employee_id, last_name, department_id, job_id, salary
FROM   employees
WHERE  department_id IS NULL;

02. 커미션을 받는 사원들의
사번, 성, 부서코드, 커미션요율 조회
SELECT employee_id, last_name, department_id, commission_pct
FROM   employees
WHERE  commission_pct IS NOT NULL;

2.4 데이터행 정렬 : ORDER BY 절 : 항상 쿼리문의 제일 마지막 위치
SELECT  
FROM
WHERE
ORDER BY

ORDER BY 정렬기준표현(컬럼명) + ASC(ascending) : 오름차순, 기본값, 생략시 오름차순
ORDER BY 정렬기준표현(컬럼명) + DESC(descending) : 내림차순

정렬기준표현 : 컬럼명, ALIAS 명, SELECT 목록에서의 컬럼 위치번호
프로그램상에서는 정렬 잘 안함(즉, DB에서만 정렬해서 프로그램으로 넘김)

01. 80번 부서의 사번, 성, 급여, 부서코드에 대해 성을 오름차순/내림차순 정렬
SELECT employee_id 사번, last_name 성, salary 급여, department_id 부서코드
FROM   employees
WHERE  department_id = 80
--ORDER BY last_name;
--ORDER BY last_name ASC; --컬럼명
--ORDER BY 2 ASC;         --컬럼위치
ORDER BY 2 ASC;           --ALIAS

02. 60번 부서의 사번, 성 연봉에 대해 연봉을 기준으로 오름차순
SELECT employee_id 사번, last_name 성, salary * 12 연봉, department_id 부서코드
FROM   employees
WHERE  department_id = 60
--ORDER BY 연봉; --ALIAS
--ORDER BY 3;    --컬럼목록 위치번호
ORDER BY salary * 12; --컬럼명

03. 사번, 성, 부서 코드, 급여, 입사일자 조회
부서코드 순, 급여는 내일차순
SELECT employee_id 사번, last_name 성, salary 급여, department_id 부서코드
FROM   employees
--WHERE
--ORDER BY department_id, salary DESC; --컬럼표현
--ORDER BY 3, 4 DESC;  --컬럼위치 목록
ORDER BY department_id, 4 DESC; --혼합

NULL은 오름차순일때는 맨뒤에 위치(즉, 마지막 순위를 가짐)
NULL은 내림차순일때는 맨앞에 위치(즉, 우선   순위를 가짐)
오름차순일때 NULL 이 맨 뒤에 위치하므로 맨 앞으로 위치시키려면  ASC NULLS FIRST
내림차순일때 NULL 이 맨 앞에 위치하므로 맨 뒤으로 위치시키려면 DESC NULLS LAST

SELECT *
FROM   locations
ORDER BY  state_province ASC NULLS FIRST;

SELECT *
FROM   locations
ORDER BY  state_province DESC NULLS LAST;

--------------------------------------------------------------------------------
--실습
--01. 부서코드 30, 40, 60인 부서에 속한 사원들의
--사번, 성명, 부서코드, 급여를 조회하여 성명순으로 정렬한다.
SELECT employee_id, first_name || ' ' || last_name, department_id, salary
FROM   employees
WHERE department_id IN (30, 40, 60)
ORDER BY  2;



--02. 커미션을 받는 사원들의 사번, 성명, 급여, 커미션요율을 조회하여
--커미션요율이 높은 사원부터 낮은 사원순으로 정렬한다.
SELECT employee_id, first_name || ' ' || last_name, salary, commission_pct
FROM   employees
WHERE commission_pct IS NOT NULL
ORDER BY  4 DESC;



--03. 성명에 대/소문자 무관하게 z 가 있는 사원들의
--사번, 성명 을 조회하여 성명순으로 정렬한다.
SELECT employee_id, first_name || ' ' || last_name
FROM   employees
WHERE  first_name || ' ' || last_name LIKE '%Z%'
OR     first_name || ' ' || last_name LIKE '%z%'
ORDER BY  2 ASC;

--01. 사번이 200인 사원의 성명과 부서코드를 조회하는 쿼리문을 작성한다.
SELECT employee_id, first_name || ' ' || last_name, department_id
FROM   employees
WHERE  employee_id = 200;




--02. 급여가 3000에서 15000 사이에 포함되지 않는 사원의 
--사번, 성명, 급여 정보를 조회하는 쿼리문을 작성한다.
--(단, 이름은 성과 이름을 공백문자를 두어 합쳐서 조회한다. 
--예를 들어 이름이 John 이고 성이 Seo 이면  John Seo 로 조회되도록 한다.)
SELECT employee_id, first_name || ' ' || last_name, salary
FROM   employees
WHERE  salary NOT BETWEEN 3000 AND 15000;




--03. 부서코드 30과 60 에 소속된 사원의 
--사번, 성명, 부서코드, 급여를 조회하는데, 
--성명을 알파벳순서로 정렬하여 조회하는 쿼리문을 작성한다.
SELECT employee_id, first_name || ' ' || last_name, department_id, salary
FROM   employees
--WHERE
ORDER BY 2 ASC;



--04. 급여가 3000에서 15000 사이 이면서, 부서코드 30 또는 60에 소속된 사원의 
--사번, 성명, 급여를 조회하는 쿼리문을 작성한다.
--(단, 조회되는 컬럼명을 이름은 성과 이름을 공백문자를 두어 합쳐 name 으로,
--급여는 Monthly Salary 로 조회되도록 한다.)
SELECT employee_id, first_name || ' ' || last_name, salary
FROM   employees
WHERE  salary BETWEEN 3000 AND 15000
AND    (department_id = 30 OR department_id = 60)





--05. 소속된 부서코드가 없는 사원의 
--사번, 성명, 업무코드를 조회하는 쿼리문을 작성한다.
SELECT employee_id, first_name || ' ' || last_name, department_id
FROM   employees
WHERE  department_id IS NULL;




--06. 커미션을 받는 사원의 
--사번, 성명, 급여, 커미션을 조회하는데, 
--커미션이 높은 사원부터 낮은 사원 순서로 정렬하여 조회하는 쿼리문을 작성한다. 
SELECT employee_id, first_name || ' ' || last_name, salary, commission_pct
FROM   employees
--WHERE
ORDER BY 4 DESC;


--07. 성명에 대소문자 구분없이 문자 z 또는 Z 가 포함된 사원의 
--사번과 성명(name)을 조회하는 쿼리문을 작성한다.
SELECT employee_id, first_name || ' ' || last_name
FROM   employees
WHERE first_name || ' ' || last_name LIKE '%z%'
OR    first_name || ' ' || last_name LIKE '%Z%'

3장. 기본함수 (단일 결과행)
: 숫자, 문자, 날짜, 형변환, 일반함수

함수의 유형 : 단일결과행 함수, 다중결과행(복수행) 함수
: 함수에 사용하는 파라미터와 반환되는 값의 유형에 따라 함수를 구분

단일결과행 함수 : 하나의 데이터 행에 대해 하나의 결과를 반환하는 함수
숫자함수 :   ROUND, TRUNC, CEIL, FLOOR
문자함수 :   UPPER, LOWER, TRIM, LTRIM/RTRIM, LPAD/RPAD
             SUBSTR, INSTR, REPLACE, TRANSLATE
날짜함수 :   SYSDATE, MONTHS_BETWEEN, ADD_MONTHS, LAST_DAY
형변환함수 : TO_CHAR, TO_NUMBER, TO_DATE
일반함수 :   NVL, NVL2, COALESCE, DECODE, CASE~END

3.1 숫자함수
ABS(n) : n의 절대값을 변환
SELECT ABS(32), ABS(-32) -- 32, 32
FROM   dual;

SIGN(n) : n ☞ 양수 -> 1, n ☞ 음수 -> -1, n ☞ 0 -> 0
SELECT SIGN(32), SIGN(-32), SIGN(0) -- 1, -1, 0
FROM   dual;

1) 반올림 함수 : ROUND(숫자, 소수이하 / 소수이상 자리수)
소수이하 / 소수이상 자리수 : 음수도 지정가능, 생략시 기본값을 0(정수로 표현)
SELECT ROUND(1234.5678, 2)  r1, --1234.57
       ROUND(1234.5678, 1)  r2, --1234.6
       ROUND(1234.5678, 0)  r3, --1235, 0 : 소수이하 없음
       ROUND(1234.5678, -1) r4, -- 1230, -1 : 0이 한개
       ROUND(1234.5678, -2) r5  -- 1200  -2 : 0이 두개
FROM   dual;

2) 무조건 버림함수 : TRUNC(숫자, 소수이하 / 소수이상 자리수)
소수이하 / 소수이상 자리수 : 음수도 지정가능, 생략시 기본값을 0(정수로 표현)
SELECT TRUNC(1234.5678, 2)  t1, --1234.56
       TRUNC(1234.5678, 1)  t2, --1234.5
       TRUNC(1234.5678, 0)  t3, --1234
       TRUNC(1234.5678, -1) t4, --1233
       TRUNC(1234.5678, -2) t5  --1200
FROM   dual;

게시판에서 페이지 나눌때(페이징 처리)사용 : 게시글 수 / 10

3) 숫자보다 같거나 큰 정수를 반환하는 함수 : CEIL(n) : 무조건 올림함수
SELECT CEIL(0.99999999999)  C1, --1
       CEIL(0.00000000001)  C2, --1
       CEIL(0)              C3  --0       
FROM   dual;

4) 숫자보다 같거나 작은 정수를 반환하는 함수 : FLOOR(n) : 무조건 내림함수
SELECT FLOOR(0.99999999999)  F1, --0
       FLOOR(0.00000000001)  F2, --0
       FLOOR(0)              F3  --0       
FROM   dual;

숫자 데이터를 표현할 수 있는 함수 : ROUND, TRUNC, CEIL, FLOOR
소수점 데이터를 표현할 수 있는 함수 : ROUND, TRUNC
정수 데이터를 표현할 수 있는 함수 : ROUND, TRUNC(두번째 파라미터가 0 또는 생략), CEIL, FLOOR

5) 나머지를 반환하는 함수 : MOD(숫자, 나눌숫자)
SELECT MOD(17, 4)
FROM   dual;















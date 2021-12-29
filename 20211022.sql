3.3 날짜 함수 : 송금, 출결, 회원가입날짜, 결제시간
1. 시스템의 현재 날짜를 반환하는 함수 : SYSDATE
다른 함수와 달리 파라미터가 없어 () 를 사용하지 않음

SELECT SYSDATE
FROM   dual;

날짜 + 숫자 : 날짜
날짜 - 날짜 : 숫자

오늘날짜 + 1 : 내일날짜
오늘날짜 - 1 : 어제날짜

SELECT SYSDATE + 1 Tommorow, SYSDATE - 1 Yesterday
FROM   dual;

오늘날짜로부터 30일 후 
SELECT SYSDATE + 30 "30일 후"
FROM   dual;

SELECT SYSTIMESTAMP --밀리초(백만)까지 출력
FROM   dual;

2. 특정 날짜로부터 몇개월 전 / 후 의 날짜를 반환하는 함수
 : ADD_MONTHS(날짜, + / - 개월수)
 오늘로부터 6개월후의 날짜를 조회, 오늘로부터 3개월 전의 날짜를 조회
SELECT ADD_MONTHS(SYSDATE, 6) "6개월 후",
       ADD_MONTHS(SYSDATE, -3) "3개월 전"       
FROM   dual;

3. 두 날짜 사이의 개월수의 차이를 반환하는 함수
 : MONTHS_BETWEEN(날짜1, 날짜2) ☞ 날짜1 > 날짜2
--                                ￣￣￣￣￣￣￣ 
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE('21/09/13')), 1)  "지난 개월수",
       TRUNC(MONTHS_BETWEEN(TO_DATE('22/03/18'), SYSDATE), 1)  "남은 개월수"
FROM   dual;

우리회사 사번 100번인 사원의
사번, 성, 입사일자, 근무개월수, 근무년수 조회
-근무개월수, 근무년수는 오늘을 기준으로 계산하여 정수로 표현
1.5년을 근무했다면 근무년수를 정수로 1년 근무로 표현 : FLOOR, TRUNC
SELECT employee_id, last_name, hire_date,
       FLOOR(MONTHS_BETWEEN(SYSDATE, hire_date))    "근무개월수1",
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date))    "근무개월수2",  
       FLOOR(MONTHS_BETWEEN(SYSDATE, hire_date)/12) "근무년수1",
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12) "근무년수2"       
FROM   employees
WHERE  employee_id = 100;

4. 해당 날짜가 포함된 달의 마지막 일자를 반환하는 함수
 : LAST_DAY(날짜)
 
SELECT LAST_DAY(SYSDATE) l1,
       LAST_DAY(ADD_MONTHS(SYSDATE, -3)) l2, --3개월 전
       LAST_DAY(ADD_MONTHS(SYSDATE, 3))  l3  --3개월 후
FROM   dual;

5. 해당 날짜 이후 날짜 중에서 char 로 명시된 요일에 해당되는 첫번째 날짜 반환
 : NEXT_DAY(날짜, char)
 char : 요일문자 ☞ 일요일, 월요일, ..., 일, 월, ..., 숫자도 가능(1:일요일, 2:월요일)
 
SELECT NEXT_DAY(SYSDATE, '일요일') n1, --21/10/24
       NEXT_DAY(SYSDATE, '일')     n2, --21/10/24
       NEXT_DAY(SYSDATE, 1)        n3  --21/10/24
FROM   dual;

3.4 형변환 함수
1. 숫자화 함수 : TO_NUMBER(대상) ☞ 문자 -> 숫자
byte < short < int < long
int i = 10;
short s = 5;
명시적 형변환
s = (short)i ; 4-> 2 : 안담김
i = (int)s   ; 2-> 4 : 담김
i = s;

암묵적 형변환
SELECT 10 + 20,
       10 + '20'
FROM   dual;

SELECT '12345',
       TO_NUMBER('12345'),
       12345
FROM   dual;

--------------------------------------------------------------------------------
     TO_CHAR        TO_DATE
     ------>        ------>
숫자          문자           날짜
NUMBER        CHARACTER      DATE
    <--------          <------
    TO_NUMBER          TO_CHAR
--------------------------------------------------------------------------------

2. 문자화 함수 : TO_CHAR(숫자나 날짜를 문자로 변환)
1) 숫자 -> 문자 : TO_CHAR(대상[, 포맷형식]) ☜ 포맷형식 생략 가능(단순히 문자로만 변환)
포맷 형식 : 정수는 지정한 형식보다 값이 길면 오류, 소수는 지정한 길이보다 길면 반올림
 9 : 한자리 숫자, 무효 숫자 공백으로 채워짐 (정수일때), 소수는 지정한 길이보다 길면 반올림
                  자리수가 부족할 때는 자리수 만큼 # 표시
 0 : 한자리 숫자, 무효 숫자는 0으로 채워짐, 소수 이하 일때는 0으로 채워짐
                  자리수가 부족할 때는 자리수 만큼 # 표시
 , : 천단위 표시
 L : Local Currency : 지역통화표시
 
SELECT 123456                           n1,
       TO_CHAR(123456)                  n2,
       TO_CHAR(123456, '999999')        n3, --_123456
       TO_CHAR(123456, '99999999')      n4, --___123456
       TO_CHAR(123456, '9999')          n5, --#####
       TO_CHAR(123456, '999,999,999')   n6, --_____123,456
       TO_CHAR(1234.56, '$999,999,999') n7, --_______$1,235
       TO_CHAR(123456, 'L999,999,999')  n8, --____________￦123,456
       TRIM(TO_CHAR(123456, '999999'))        t1, --123456
       TRIM(TO_CHAR(123456, '99999999'))      t2, --123456
       TO_CHAR(123456, 'FML999,999,999')      t3,  --￦123,456 FM : 공백문자열 제거
       TRIM(TO_CHAR(123456, 'L999,999,999'))  t4  --￦123,456
FROM   dual;

SELECT TO_CHAR(123) c1,
       TO_CHAR(123, '00000') C2,           
       TRIM(TO_CHAR(123, '00000')) C3,
       TO_CHAR(123, 'FM00000') C4
FROM   dual;


2) 날짜 -> 문자 : TO_CHAR(대상[, 표현형식])
표현형식
년 ☞   YEAR(년도를 영문으로 표시 : TWENTY-TWENTY-ONE)
       YYYY, YY, RRRR, RR
월 ☞   MONTH(월의 용면표기 모두 표시)
       MON(월의 영문표기 약어 3글자)
일 ☞   DD
요일 ☞ DAY(월요일, 화요일), DY(한글날짜 약어 월, 화)
시 ☞   HH, HH24
분 ☞   MI
초 ☞   SS

SELECT SYSDATE                                       c1,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD DY HH24:MI:SS')  c2, --2021-10-22 금 11:06:36
       TO_CHAR(SYSDATE, 'AM')                        c3,
       TO_CHAR(SYSDATE, 'D')                         c4, --6 : 금요일
       TO_CHAR(SYSDATE, 'DY')                        c5,
       TO_CHAR(SYSDATE, 'DAY')                       c6
FROM   dual;


3. 날짜화 함수 : TO_DATE(대상[, 표현형식])
※ TO_DATE()에 의해 변환된 날짜는 '/'로만 조회됨
날짜 형식은 : 'RR/MM/DD'
SELECT  '211022'                         d1,
        TO_DATE('211022')                d2, --21/10/22
        TO_DATE('21-10-22')              d3, --21/10/22
        TO_DATE('211022', 'DDMMRR')      d4, --22/10/21
        TO_DATE('211022', 'DD-MM-RR')    d5, --22/10/21
        TO_DATE('211022', 'YYYY-MM-DD')  d6  --리터럴이 형식 문자열과 일치하지 않음
                                             --년도 4자리 RRRR, YYYY에러
FROM    dual;

-----------------------------------------------------------------------------------------------
--[연습문제 3-3]
--01. 사원테이블에서 30번 부서의 사번, 성명, 급여, 근무개월수, 근무년수를 조회
--단, 근무개월수는 오늘 날짜를 기준으로 날짜함수를 사용
SELECT employee_id, first_name  || ' ' || last_name name, salary,
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) 근무개월수,
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12)  근무년수      
FROM   employees
WHERE  department_id = 30;



--02. 급여가 12000 이상인 사원들의 
--사번, 성명, 급여를 조회하여 급여순으로 정렬한다.
--급여는 공백없이(TRIM, FM) 천단위 기호(,)를 사용하여 표현한다.
--       ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
SELECT employee_id, first_name  || ' ' || last_name name,
       TO_CHAR(salary, 'FM999,999') salary1,
       TRIM(TO_CHAR(salary, '999,999')) salary2
FROM   employees
WHERE  salary >= 12000
ORDER BY salary ASC;



--03. 2005년 전(2004년까지)에 입사한 사원들의 
--사번, 성명, 입사일자, 입사일의 요일(DAY, DY) 을 조회하여 
--최근에 입사(DESC)한 사원순으로 정렬한다.
SELECT employee_id, first_name  || ' ' || last_name name, hire_date,
       TO_CHAR(hire_date, 'DAY') 요일,
       TO_CHAR(hire_date, 'DY')  요일
FROM   employees
WHERE  TO_CHAR(hire_date, 'YYYY') < 2005
ORDER BY 3 DESC;



-----------------------------------------------------------------------------------------------

※ 일반함수 : NULL 이 계산되었을 때 결과값이 NULL 로 변경이 되어버림 --* 많이 사용

상여율 확인
SELECT employee_id, salary, commission_pct
FROM   employees;

커미션 금액이 1000 미안인 사원의
사번, 이름, 급여, 커미션요율, 커미션금액 조회
커시면금액 = 급여 * 커미션요율
SELECT employee_id, first_name  || ' ' || last_name name, salary, commission_pct,
       salary * commission_pct 커미션금액
FROM   employees
WHERE  salary * commission_pct < 1000; --ALIAS 사용불가

※ 조회된 NULL값을 치환하는 함수 : NVL(NULL Value)함수,  NVL2함수
1. 데이터 값이 NULL 인 경우 다른 값으로 대체하여 반환하는 함수
 : NVL(대상, NULL일 때 반환표현) ☞ NULL, VALUE, 오라클에서만 사용하는 함수
--    ￣￣￣￣￣￣￣￣￣￣￣￣￣ ***대상과 NULL일 때 반환표현의 데이터 타입이 일치해야한다.

DESC employees;

SELECT employee_id, first_name  || ' ' || last_name name, salary, commission_pct,
       salary * NVL(commission_pct, 0) 커미션금액
FROM   employees
WHERE  salary * NVL(commission_pct, 0) < 1000


서번, 성, 급여 커미션요율, 총급여
총급여 = 급여 + 커미션 금액
       = 급여 + (급여 * 커미션요율)
       = 급여 * (1+ 컴시션요율)

SELECT employee_id, first_name  || ' ' || last_name name, salary, NVL(commission_pct, 0),
       salary * NVL(commission_pct+1, 0) 총급여
FROM   employees;

2. NVL 함수는 데이테 값이 NULL 인 경우에 다른 값으로 대체하여 반환하는 함수
   데이터값이 NULL 인 경우 반환표현과 NULL 이 아닌 경우 반환표현을 각각 지정할 수 있는 형태의 함수
   NVL2(대상, NULL 이 아닌경우 반환값, NULL 인 경우 반환값)
--            ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
--            ***NULL 이 아닌경우 반환값, NULL 인 경우 반환값의 데이터 타입이 일치해야 함

커미션을 받는 사원은    총급여 = 급여 + 커미션금액
커미션요율에는 커미션요율, 커미션요율표시는 커미션요율을 '0.00' 형태로 표시
커미션금액은 커미션금액으로 표시

커미션을 받지 않는 사원은    총급여 = 급여
커미션요율에는 0,          커미션요율표시는 커미션요율을 '커미션요율없음' 형태로 표시
커미션금액은 0 으로 표시

사번, 성, 급여, 커미션요율, 커미션요율표시, 커미션금액, 총급여
SELECT employee_id, last_name, salary, commission_pct,
       NVL(commission_pct, 0) 커미션요율,
       NVL(TO_CHAR(commission_pct, '0.00'), '커미션요율없음') 커미션요율표시1,
       NVL2(commission_pct, TO_CHAR(commission_pct, '0.00'), '커미션요율없음') 커미션요율없음표시,
       salary * NVL(commission_pct, 0) 커미션금액1,
       NVL2(commission_pct, salary * commission_pct, 0) 커미션금액2,
       salary + (salary * NVL(commission_pct,0)) 총급여1,
       NVL2(commission_pct, salary + (salary * commission_pct), salary) 총급여2,
       NVL2(salary + (salary * commission_pct), salary + (salary * commission_pct), salary) 총급여3,
       NVL2(salary + (salary * NVL(commission_pct,0)), salary + (salary * NVL(commission_pct,0)), salary) 총급여4       
FROM   employees;





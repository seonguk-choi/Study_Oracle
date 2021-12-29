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


-----------------------------------------------------------------------------------------------


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
5) 나머지를 반환 함수 : MOD(숫자, 나눌 숫자)
SELECT MOD(17, 4)   M1, -- 1
       MOD(17, 4)   M2, -- 1
       MOD(-17, 4)  M3, -- (-1)
       MOD(-17, -4) M4, -- (-1)
       MOD(17, 0)   M5  -- 17
FROM   dual;
            값   개수   몫   나머지
    17/  4 : 17 =  4  *  4  + 1
    17/ -4 : 17 = -4  * -4  + 1
   -17/  4 : 17 =  4  * -4  + (-1)
   -17/ -4 : 17 = -4  *  4  + (-1)
    17/  0 : 17 =  0  *  0  + 17

-----------------------------------------------------------------------------------------------
--[연습문제 3-1]
--01. 사원 테이블에서 부서코드가 100, 110 인 부서에 속한 사원들의
--사번, 성명, 급여, 부서코드, 15%인상된 급여 조회 - 인상된 급여는 정수로 표현
--컬럼명은 Increased Salary 로 표시한다.
SELECT employee_id, first_name || ' ' || last_name, salary, department_id,
            (salary * 1.15)    "Increased Salary1",
       ROUND(salary * 1.15)    "Increased Salary2",
       ROUND(salary * 1.15, 0) "Increased Salary3",
       TRUNC(salary * 1.15)    "Increased Salary4",
       TRUNC(salary * 1.15, 0) "Increased Salary5",
       CEIL (salary * 1.15)    "Increased Salary6",
       FLOOR(salary * 1.15)    "Increased Salary7"
FROM   employees
WHERE  department_id IN(100, 110);


----------------------------------------------------------------------------------------------


3.2  문자 함수 
3.2.1. 대/소문자 변환 함수 : UPPER / LOWER(문자) : 문자데이터, 날짜 데이터 : 반드시 홑따옴표로 묶음
01. 성이 King 인 사원들의 사번, 이름, 성 조회
SELECT employee_id, first_name, last_name
FROM   employees
--WHERE  last_name = 'King';
--WHERE  UPPER(last_name) = 'KING'; -- UPPER : 대문자로 변환
WHERE  LOWER(last_name) = 'king'; -- LOWER : 소문자로 변환

02. 성에 대소문자 무관하게 Z 가 포함된 사원들의
사번, 이름, 성 조회
SELECT employee_id, first_name, last_name
FROM   employees
--WHERE  last_name LIKE '%Z%'    OR     last_name LIKE '%z%;
--WHERE  LOWER(last_name) LIKE '%z%'
WHERE  UPPER(last_name) LIKE '%Z%';

3.2.2. 단어 단위로 첫글자는 대문자, 나머지는 소문자로 변환하는 함수 : INTICAP(대상)
: 이니셜만 대문자로 변환
SELECT INITCAP('we are studing oracle') initcap
FROM   dual;

SELECT email, INITCAP('email') initcap,
       first_name, UPPER(first_name) upper, LOWER(first_name) lower
FROM   employees;

3.2.3. 문자 데이터(char1)에 특정문자(char2)를 채워서 반환하는 함수
: LPAD / RPAD(char1, n[, char2])
: LPAD / RPAD(대상, 전체크기[, 충전문자]), pad : 채워 넣는 것
: 세번째 파라미터인 충전문자 생략가능 : default : 공백

SELECT LPAD('abc', 5, '?') lp1, --??abc
       LPAD('abc', 5)      lp2, --  abc : 생략시 공백채움.
       RPAD('abc', 5, '#') lp3, --abc##
       RPAD('abc', 5)      lp4  --abc__ : 생략시 공백채움.
FROM   dual;

SELECT employee_id,
       LPAD(last_name, 10, ' ') last_name1, --공백(' ')채움
       LPAD(last_name, 10)      last_name2  --생략시 공백채움
FROM   employees;

3.2.4. 문자데이터에서 특정문자를 제거하고 반환하는 함수
 : 제거할 문자는 한글자만 지정 가능 : TRIM()
--               ￣￣￣￣￣￣￣￣￣             
 : 입력상자에서 사용자 실수로 공백을 입력시
 : request.getParameter('userId').TRIM()
 
TRIM([LEADING TRAILING, BOTH] [, TRIM_CHAR] [FROM] char)
TRIM(제거할 위치              제거문자 한 개 FROM 대상문자)
--                            ￣￣￣￣￣￣￣
제거할 위치 - LEADING : 왼쪽부터, TRAILING : 오른쪽부터, BOTH : 양쪽
제거할 위치 생략시 :    BOTH
제거문자 한 개 생략시 : 공백

SELECT TRIM('a' FROM 'abcdcbaaaaaaa')          t1,
       TRIM(LEADING  'a' FROM 'abcdcbaaaaaaa') t2,
       TRIM(TRAILING 'a' FROM 'abcdcbaaaaaaa') t3,
       TRIM(BOTH     'a' FROM 'abcdcbaaaaaaa') t4,
       '   abcdcbaaaaaaa   '                   t5,
       TRIM('   abcdcbaaaaaaa   ')             t6
FROM   dual;

3.2.5. 문자데이터의 특정문자를 제거하느 반환함수
 : 제거할 문자를 여러개 지정가능 ☜ TRIM 함수와 차이점
--               ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
 : LTRIM / RTRIM(char1[, char2])
 : LTRIM / RTRIM(대상문자[, 제거할 문자나열]) 
 : 두번째 파라미터 생략시 : 기본값은 공백문자

SELECT LTRIM('abcdcba', 'a')      lt1, --bcdcba
       LTRIM('abcdcba', 'ba')     lt2, --cdcba
       LTRIM('abcdcba', 'acb')    lt3, --dcba
       LTRIM('abcdcba', 'adb')    lt4, --cdcba
       LTRIM('  abcdcba   ')      lt5, --abcdcba___ 생략시 공백문자
       RTRIM('abcdcba', 'adb')    rt5, --cdcba
       RTRIM('  abcdcba   ')      rt7  --___abcdcba 생략시 공백문자
FROM   dual;


3.2.6. 문자열에서 문자열의 일부를 반환하는 함수, (몇번째부터 몇글자)
--                                           ￣￣￣￣￣￣￣￣￣
 : SUBSTR(대상문자열, 시작위치, 몇글자)
 : 두번째 파라미터(시작위치) : 음수지정가능 ☞ 오른쪽에서부터
--                             ￣￣￣￣￣￣￣￣￣￣￣￣￣￣ 
 : 세번째 파라미터(몇글자)   : 생략시 문자열의 끝까지 반환
--                             ￣￣￣￣￣￣￣￣￣￣￣￣￣￣
               1   5   9   13
SELECT SUBSTR('You are not alone', 5, 3)  s1, --are
       SUBSTR('You are not alone', 5)     s2, --are not alone
       SUBSTR('You are not alone', -5)    s3, --alone
       SUBSTR('You are not alone', -5, 3) s4  --alo
FROM   dual;

110 * 120
50  * 110
120 *  30

3.2.7. 문자열에서 특정문자열의 위치한 시작위치를 반환하는 함수
--                                ￣￣￣￣￣￣￣￣
 : INSTR(대상문자열, 찾는 문자열, 문자열 찾는 위치, 몇 번째거)
 : 세번째 파라메터가 : 문자열 찾는 위치, 생략시 왼쪽부터
     음수로 지정가능 : 오른쪽에서부터 왼쪽 방향으로 쭉 계속 진행
--                                                  ￣￣￣￣￣￣                                     
 : 네번째 파라미터 : 몇번째 거, 생략시 : 첫번째 거
              1     7   11 14 17 20
SELECT INSTR('Every sha-la-la-la-la','la',  1, 2) i1, --14
       INSTR('Every sha-la-la-la-la','la', 12, 2) i2, --17
       INSTR('Every sha-la-la-la-la','la', 12, 4) i3, -- 0
       INSTR('Every sha-la-la-la-la','la', 12)    i4, --14
       INSTR('Every sha-la-la-la-la','la', -3, 2) i5, --14
       INSTR('Every sha-la-la-la-la','la', -10)   i6  --11
FROM   dual;

본인의 이메일에서 아이디와 서비스제공자를 조회
SELECT 'abcdefg@naver.com' "나의 이메일",
       'abcdefg' 아이디,
       'naver.com' 서비스제공자
FROM   dual;

@의 시작위치
SELECT INSTR('abcdefg@naver.com','@') "@위치"
FROM   dual;

ID 가져오기
SELECT SUBSTR('abcdefg@naver.com', 1, INSTR('abcdefg@naver.com','@')-1) 아이디
FROM   dual;

서비스제공자 가저오기
SELECT SUBSTR('abcdefg@naver.com', INSTR('abcdefg@naver.com','@')+1) 서비스제공자
FROM   dual;

결합
SELECT 'abcdefg@naver.com' "나의 이메일",
       SUBSTR('abcdefg@naver.com', 1, INSTR('abcdefg@naver.com','@')-1) 아이디,
       SUBSTR('abcdefg@naver.com', INSTR('abcdefg@naver.com','@')+1) 서비스제공자
FROM   dual;

길이구하기
SELECT LENGTH('abcdefg@naver.com')
FROM   dual;

JOBS 테이블에서 업무코드, 업무제목, 직무, 직책 조회
직무, 직책은 업무코드(job_id)에서 '-' 기준으로 조회(직무_직책)
SELECT *
FROM   jobs;

SELECT job_id, job_title,
       INSTR(job_id,'_') "_위치",
       SUBSTR(job_id, 1, INSTR(job_id,'_')-1) 직무,
       SUBSTR(job_id, INSTR(job_id,'_')+1) 직책
FROM   jobs;

'_' 시작위치
SELECT INSTR(job_id, '_') "_위치"
FROM   jobs;

SELECT job_id, job_title,
       SUBSTR(job_id, 1, INSTR(job_id, '_')-1) 직무, --'_' 위치 이전까지 
       SUBSTR(job_id, INSTR(job_id, '_')+1) 직책     --'_' 위치 이후부터
FROM   jobs;

-----------------------------------------------------------------------------------------------
--[ 연습문제 3-2 ]                            
--01. 사원 테이블에서 이름(first_name)이 A로 시작하는 
--모든 사원의 이름과 이름의 길이를 조회(LENGTH()함수)하는 쿼리문 작성.
SELECT first_name, LENGTH(first_name)
FROM   employees
WHERE first_name LIKE 'A%';


--02. 80번 부서원의 이름과 급여를 조회하는 쿼리문을 작성한다.
--단, 급여는 15자 길이로 왼쪽에 $ 기호가 채워진 형태로 표시되도록 한다.
SELECT first_name, LPAD(salary, 15, '$')
FROM   employees
WHERE department_id = 80;



--03. 60번 부서, 80번 부서, 100번 부서에 소속된 사원의 
-- 사번, 성, 전화번호, 전화번호의 지역번호, 개인번호를 조회하는 쿼리문 작성
-- 단, 개인번호의 컬럼은 private_number, 지역번호의 컬럼은 local_number 라고 표시하고, 
-- 지역번호는 515.124.4169 에서 515, 
--            590.423.4568 에서 590, 
--            011.44.1344.498718 에서 011 이 지역번호라 한다.
--
-- 개인번호는 515.124.4169 에서 4169, 
--            590.423.4568 에서 4568, 
--      011.44.1344.498718 에서 498718 이 개인번호라 한다.
--                    
--부서코드가 60,80,100 인 부서에 속한 사원들의 
--사번, 성, 전화번호, 지역번호, 개인번호 조회하는 쿼리문 작성

SELECT employee_id, last_name, phone_number,
       INSTR(phone_number, '.') ".위치1",
       INSTR(phone_number, '.', -1) ".위치2",
       SUBSTR(phone_number, 1,INSTR(phone_number, '.') -1)    local_number,
       SUBSTR(phone_number, INSTR(phone_number, '.', -1)  +1) private_number
FROM   employees
WHERE department_id IN (60, 80, 100);


--★★★★★★★★★★★★★★★★★결과
--                             local_number  private_number 
--박문수  515.124.4567         515           4567
--임꺽정  011.44.1344.467268   011           467268 
--홍길동  02.1234.5678         02            5678
--전우치  062.9874.5422        062           5422
--심청    0652.4523.6221       0652          6221

-----------------------------------------------------------------------------------------------


3.3 날짜 함수 : 송금, 출결, 회원가입날짜, 결제시간
3.3.1. 시스템의 현재 날짜를 반환하는 함수 : SYSDATE
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

3.3.2. 특정 날짜로부터 몇개월 전 / 후 의 날짜를 반환하는 함수
 : ADD_MONTHS(날짜, + / - 개월수)
 오늘로부터 6개월후의 날짜를 조회, 오늘로부터 3개월 전의 날짜를 조회
SELECT ADD_MONTHS(SYSDATE, 6) "6개월 후",
       ADD_MONTHS(SYSDATE, -3) "3개월 전"       
FROM   dual;

3.3.3. 두 날짜 사이의 개월수의 차이를 반환하는 함수
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

3.3.4. 해당 날짜가 포함된 달의 마지막 일자를 반환하는 함수
 : LAST_DAY(날짜)
 
SELECT LAST_DAY(SYSDATE) l1,
       LAST_DAY(ADD_MONTHS(SYSDATE, -3)) l2, --3개월 전
       LAST_DAY(ADD_MONTHS(SYSDATE, 3))  l3  --3개월 후
FROM   dual;

3.3.5. 해당 날짜 이후 날짜 중에서 char 로 명시된 요일에 해당되는 첫번째 날짜 반환
 : NEXT_DAY(날짜, char)
 char : 요일문자 ☞ 일요일, 월요일, ..., 일, 월, ..., 숫자도 가능(1:일요일, 2:월요일)
 
SELECT NEXT_DAY(SYSDATE, '일요일') n1, --21/10/24
       NEXT_DAY(SYSDATE, '일')     n2, --21/10/24
       NEXT_DAY(SYSDATE, 1)        n3  --21/10/24
FROM   dual;


-----------------------------------------------------------------------------------------------


3.4 형변환 함수
3.4.1. 숫자화 함수 : TO_NUMBER(대상) ☞ 문자 -> 숫자
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

3.4.2. 문자화 함수 : TO_CHAR(숫자나 날짜를 문자로 변환)
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


3.4.3. 날짜화 함수 : TO_DATE(대상[, 표현형식])
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

3.5 NULL 관련함수

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
3.5.1. 데이터 값이 NULL 인 경우 다른 값으로 대체하여 반환하는 함수
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

3.5.2. NVL 함수는 데이테 값이 NULL 인 경우에 다른 값으로 대체하여 반환하는 함수
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

3.5.3. 데이터 값이 NULL 인 경우 대체해서 반환 표현을 여러개 지정할 수 있는 형태의 함수
: NULL 이 아닌 첫번째 데이터를 반환하는 함수
: COALESCE : 합치다, 합체하다, 합동하다.
: COALESCE(대체표현1, 대체표현2, ....) ALIAS 명

--------------------------------------------------------------------------------
name      cellular        home            office
홍길동    010-1111-1111  
심청                      062-222-2222    062-333-3333
전우치                                    062-444-4444 
--------------------------------------------------------------------------------
SELEC name 이름, COALESCE(cellular, home, office) 연락처
FRom  dual;

이름      연락처
홍길동    010-1111-1111
심청      062-222-2222
전우치    062-444-4444


--------------------------------------------------------------------------------



※ 조건문 : DECODE, CASE ~ END  WHEN THEN ELSE
3.6 DECODE 와 CASE ~ END
3.6.1. 조건문에 해당하는 함수
IF (조건식1) {
  실행문1
} ELSE IF (조건식2) {
  실행문2
} ELSE IF (조건식3) {
  실행문3
} ELSE {
  실행문n
} 

부서별로 보너스를 지급하고자 한다.
부서코드가 10이면 급여의 10%, 
           20이면 급여의 20%,  
           30이면 급여의 30%, 
           나머지 부서원은 급여의 5%

IF (부서코드 == 10) {
  보너스 = 급여 * 0.1;
} ELSE IF (부서코드 == 20) {
  보너스 = 급여 * 0.2;
} ELSE IF (부서코드 == 30) {
  보너스 = 급여 * 0.3;
} ELSE {
  보너스 = 급여 * 0.05;
}

3.6.1.1 조건문에 해당하는 함수 : DECODE
: DECODE (대상표현, 비교데이터표현1, 반환데이터1,
--        ￣￣￣￣￣￣￣￣￣￣￣￣￣
                    비교데이터표현2, 반환데이터2,
                    비교데이터표현3, 반환데이터3,
                    default반환데이터n) ALIAS 명
대상표현과 비교데이터표현의 데이터유형은 일치해야 함(즉, 문자는 문자로, 숫자는 숫자로 비교)

: DECODE(컬럼, A, 1, B, 2, 3) : 컬럼값이 A 이면 1, B 이면 2, 그것도 아니면 3)
사번, 성, 부서코드, 급여, 보너스
부서별로 보너스를 지급하고자 한다.
부서코드가 10이면 급여의 10%, 
           20이면 급여의 20%,  
           30이면 급여의 30%, 
           나머지 부서원은 급여의 5%
SELECT  employee_id, last_name, department_id, salary,
        DECODE(department_id, 10, salary * 0.1,
                              20, salary * 0.2,  
                              30, salary * 0.3,
                              salary * 0.05) bonus
FROM    employees;

3.6.1.2 조건문에 해당하는 함수 : CASE ~ END
: DECODE 보다 더 큰 개념을 가진 표현식이다.
DECODE 동등비교연산만 할 수 있으나
--     ￣￣￣￣￣￣￣
CASE ~ END 좀 더 다양한 범위비교 연산까지도 가능하다.
--                      ￣￣￣￣￣￣￣￣￣￣￣￣

동등비교연산(=)
--------------------------------------------------------------------------------
CASE  대상표현
--    ￣￣￣￣
  WHEN  비교데이터값1  THEN 반환데이터1 --컴마 없음
--      ￣￣￣￣￣￣￣  
  WHEN  비교데이터값2  THEN 반환데이터2 --컴마 없음
  WHEN  비교데이터값3  THEN 반환데이터3 --컴마 없음
  ELSE  default반환데이터n
END  ALIAS 명
--------------------------------------------------------------------------------

범위비교연산
--------------------------------------------------------------------------------
CASE  --(연산자 : =, !=, >, <, >=, <= 등 사용)
  WHEN  대상표현 연산자 비교데이터값1  THEN 반환데이터1 --컴마 없음
--      ￣￣￣￣        ￣￣￣￣￣￣￣  
  WHEN  대상표현 연산자 비교데이터값2  THEN 반환데이터2 --컴마 없음
  WHEN  대상표현 연산자 비교데이터값3  THEN 반환데이터3 --컴마 없음
  ELSE  default반환데이터n
END  ALIAS 명
--------------------------------------------------------------------------------
사번, 성, 부서코드, 급여, 보너스 --동등비교연산
SELECT  employee_id, last_name, department_id, salary,
        CASE department_id
          WHEN  10  THEN  salary * 0.1 --컴마없음
          WHEN  20  THEN  salary * 0.2 --컴마없음
          WHEN  30  THEN  salary * 0.3 --컴마없음
          ELSE  salary * 0.05 --컴마없음
        END bonus
FROM    employees;

사번, 성, 부서코드, 급여, 보너스 --범위 비교연산
SELECT  employee_id, last_name, department_id, salary,
        CASE 
          WHEN  department_id = 10  THEN  salary * 0.1 --컴마없음
          WHEN  department_id = 20  THEN  salary * 0.2 --컴마없음
          WHEN  department_id = 30  THEN  salary * 0.3 --컴마없음
          ELSE  salary * 0.05 --컴마없음
        END bonus
FROM    employees;


-----------------------------------------------------------------------------------------------
--[연습문제 3-5]
--보너스는 
--부서코드가  10~30 이면 급여의 10%
--            40~60 이면 급여의 20%
--           70~100 이면 급여의 30%
--           그외 부서원은 급여의 5%
--
--사번, 성, 부서코드, 급여, 보너스 조회

select  employee_id, last_name, department_id, salary,   --범위 비교 연산
        case 
            when department_id between 10 and 30    then salary * 0.1
            when department_id between 40 and 60    then salary * 0.2
            when department_id between 70 and 100   then salary * 0.3
            else salary * 0.05            
        end          
from    employees; 


-----------------------------------------------------------------------------------------------
--[연습문제 3-5]
--보너스는 
--부서코드가 20이하 이면           급여의 30%
--급여가 10000 이상이면            급여의 20%
--업무코드가 clerk 종류의 업무이면 급여의 10% 
--그외는                           급여의 5%
--
--사번, 이름, 성, 부서코드, 급여, 업무코드, 보너스 조회


select  employee_id, first_name, last_name, department_id, job_id, salary,   
        case 
            when department_id <= 20    then salary * 0.3
            when salary >= 10000        then salary * 0.2
            when LOWER(job_id) like '%clerk%'  then salary * 0.1
            else salary * 0.05            
        end bonus         
from    employees;


-----------------------------------------------------------------------------------------------
--[연습문제 3-5]
--1. 사원들의 사번, 이름, 업무코드, 업무등급 조회
--업무등급은 업무코드에 따라 분류한다.
--DECODE 와 CASE~END 사용하여 조회
--
--업무코드    업무등급
--AD_PRES      A
--ST_MAN       B
--IT_PROG      C
--SA_REP       D
--ST_CLERK     E
--그 외        X

SELECT  employee_id, last_name, department_id, job_id, salary,
        DECODE (job_id, 'AD_PRES',  'A',
                        'ST_MAN',   'B',
                        'IT_PROG',  'C',
                        'SA_REP',   'D',
                        'ST_CLERK', 'E',
                        'X') decode,
        CASE 
            when job_id LIKE 'AD_PRES'  then 'A'
            when job_id LIKE 'ST_MAN'   then 'B'
            when job_id LIKE 'IT_PROG'  then 'C'
            when job_id LIKE 'SA_REP'   then 'D'
            when job_id LIKE 'ST_CLERK' then  'E'
            else 'X'            
        END caseend         
FROM    employees;


-----------------------------------------------------------------------------------------------

--2. 모든 사원의 각 사원들의 근무년수, 근속상태를 파악하고자 한다.
--사원들의 사번, 성, 입사일자, 근무개월수, 근무년수, 근속상태 조회
--근무년수는 오늘을 기준으로 근무한 년수를 정수로 표현한다.
--근속상태는 근무년수에 따라 표현한다.
--근무년수가 15년 미만 이면              '15년 미만 근속'으로 표현
--           15년 이상 17년 미만 이면    '17년 미만 근속'으로 표현
--           17년 이상 이면              '17년 이상 근속'으로 표현     

SELECT  employee_id, last_name, hire_date,
        TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) 근무개월수,
        TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12) 근무년수,
        CASE 
            when  TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12) < 15  then '15년 미만 근속'
            when  TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12) BETWEEN 15 AND 17 THEN '17년 미만 근속'
            WHEN  TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12) >= 17 THEN '17년 이상근속'
            ELSE  '17년 이상근속'
        END 근속상태         
FROM    employees;                


-----------------------------------------------------------------------------------------------



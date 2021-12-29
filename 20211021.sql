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
1. 대/소문자 변환 함수 : UPPER / LOWER(문자) : 문자데이터, 날짜 데이터 : 반드시 홑따옴표로 묶음
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

2. 단어 단위로 첫글자는 대문자, 나머지는 소문자로 변환하는 함수 : INTICAP(대상)
: 이니셜만 대문자로 변환
SELECT INITCAP('we are studing oracle') initcap
FROM   dual;

SELECT email, INITCAP('email') initcap,
       first_name, UPPER(first_name) upper, LOWER(first_name) lower
FROM   employees;

3. 문자 데이터(char1)에 특정문자(char2)를 채워서 반환하는 함수
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

4. 문자데이터에서 특정문자를 제거하고 반환하는 함수
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

5. 문자데이터의 특정문자를 제거하느 반환함수
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


6. 문자열에서 문자열의 일부를 반환하는 함수, (몇번째부터 몇글자)
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

7. 문자열에서 특정문자열의 위치한 시작위치를 반환하는 함수
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
































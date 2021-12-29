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
 









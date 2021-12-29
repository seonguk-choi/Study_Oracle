4장. 그룹함수
GRUOP 함수 : 여러행으로부터 하나의 결과값을 반환,
             전체 데이터를 그룹별로 구분하여 통계적인 결과를 구하기 위해서 사용하는 함수
             
             
--------------------------------------------------------------------------------
※ 그룹함수의 종류
 1. COUNT      : 입력되는 데이터의 총 객수를 출력
 2. SUM        : 입력되는 데이터의 합계값을 출력
 3. AVG        : 입력되는 데이터의 평균값을 출력
 4. MAX        : 입력되는 데이터의 최대값을 출력
 5. MIN        : 입력되는 데이터의 최소값을 출력 


 6. ROLLUP     : 입력되는 데이터의 소계 및 총계값을 출력
 7. CUBE       : 입력되는 데이터의 소계 및 총계값을 출력(아래에 다시 데이터를 출력)
 
 
 8. RANK       : 주어진 컬럼값의 그룹에서 값의 순위를 계산한 후 순위를 출력
                 --GOUPR BY 사용안해도 됨 1,2,3,4,.....
 9. DENSE_RANK : RANK 함수와 비슷하지만 동인한 순위를 하나의 건수로 취급하므로 연속된 순위 보여줌
                 --GOUPR BY 사용안해도 됨 1,2,2,3,3,....., DENSE : 밀접한
 
--------------------------------------------------------------------------------

4.1 DISTINCT : 중복제거

--부서를 조회
SELECT department_id --107
FROM   employees
ORDER BY 1;

--중복된 부서를 조회
SELECT DISTINCT department_id --12, DISTINCT : NULL 포함
FROM   employees
ORDER BY 1;

11개의 부서를 출력
SELECT DISTINCT department_id --11
FROM   employees
WHERE department_id IS NOT NULL --NULL 제외
ORDER BY 1;

-----------------------------------------------------------------------------------------------
--[연습문제 4-1]
--우리회사에 매니저로 있는 사원들이 누군인지 파악하고자 한다.
--매니저인 사원들의 manager_id 를 조회 --18개

SELECT DISTINCT manager_id
FROM employees
WHERE manager_id IS NOT NULL
ORDER BY 1;


-----------------------------------------------------------------------------------------------


4.2 그룹 함수 : 여러행으로부터 하나의 결과를 반환하는 함수 : NULL 제외
4.2.1 데이터행이 몇 건 존재하는지 개수 반환 : COUNT 
01. 우리회사 사원수 조회
SELECT COUNT(employee_id) cnt1,
       COUNT(*)           cnt2
FROM   employees;

02. 우리회사 부서배치 받는 사원수
SELECT COUNT(department_id)  cnt1, --NULL 제외
       COUNT(*)              cnt2
FROM   employees;


권장 
SELECT COUNT(*) 사원수
FROM   employees
WHERE  department_id IS NOT NULL;

03. 우리회사 사원들 중 부서코드가 60번인 부서에 속한 사원들의 수 조회
SELECT COUNT(*) "60번부서 사원수"
FROM   employees
WHERE  department_id = 60;

04. clerk 종류의 업무를 하는 사원의 수
SELECT COUNT(*)
FROM   employees
WHERE  LOWER(job_id) LIKE '%clerk%'; --clerk 업무에 종사하는

4.2.2. 데이터값을 합하여 반환하는 함수 : SUM(컬럼명), --숫자에만 사용
01. 우리회사 한달 급여의 총액 조회
SELECT SUM(salary) sum_sal
FROM   employees;

02. 우리회사 60번 부서의 급여 총액 조회
SELECT SUM(salary) sum_sal
FROM   employees
WHERE  department_id = 60;

03. 우리회사 60번 부서의 급여 총액 조회 해서 통화기호와 제자리마다 쉼표 입력
SELECT TO_CHAR(SUM(salary), 'FM$999,999,999') sum_sal1,
       TRIM(TO_CHAR(SUM(salary), 'L999,999,999')) sum_sal2
FROM   employees
WHERE  department_id = 60;

4.2.3. 데이터값 중 가장 큰 / 작은 값을 반환하는 함수 : MAX / MIN(컬럼명)
-- 숫자, 날짜, 문자 모두 사용가능
01. 우리회사 사원들 중 가장 높은 / 낮은 급여 조회
SELECT MAX(salary) max_sal, MIN(salary) min_sal
FROM   employees;

02. 우리회사 사원들 중 가장 처음 / 나중에 나오는 성 조회
SELECT MIN(last_name) "처음 나오는 성",
       MAX(last_name) "나중에 나오는 성"
FROM   employees;

03. 우리회사 사원들 중 가장 처음 / 나중에 입사한 사원의 입사일자 조회
SELECT MIN(hire_date) min_hire,
       MAX(hire_date) max_hire
FROM   employees;

04. clerk 업무에 종사하는 사원들 중
가장 먼저 입사한 입사일자, 가장 최근에 입사한 입사일자
SELECT MIN(hire_date) min_hire,
       MAX(hire_date) max_hire
FROM   employees
WHERE  LOWER(job_id) LIKE '%clerk%';

4.2.4. 데이터값의 평균을 반환하는 함수 : AVG(컬럼명) - 숫자만 가능
01. 우리회사 급여 평균 조회
급여평균은 소수이하 둘째자리에서 반올림
SELECT ROUND(AVG(salary),2) avg_sal
FROM   employees;

02. 60번 부서에 속한 사원들의 급여 평균 조회
급여평균은 소수이하 둘째자리에서 반올림
SELECT ROUND(AVG(salary),2) avg_sal
FROM   employees
WHERE  department_id = 60;

03. clerk 종류의 업무를 하는 사원들의 급여 평균
급여평균은 소수이하 둘째자리에서 반올림
SELECT ROUND(AVG(salary),2) avg_sal
FROM   employees
WHERE  LOWER(job_id) LIKE '%clerk%';

-----------------------------------------------------------------------------------------------
--실습
--01. 성에 대소문자 무관하게 z가 포함된 성을 가진 사원들이 모두 몇명인지 파악하고자 한다.
--성에 대소문자 무관하게 z가 포함된 성을 가진 사원들의 수를 조회하시오. --5
SELECT COUNT(*) 사원수
FROM   employees
WHERE  LOWER(last_name) LIKE '%z%';


--02. 우리회사 사원들 최고급여와 최저급여 간 급여차를 파악하고자 한다.
--우리회사 최고급여와 최저급여의 급여차를 조회하시오. --21900
SELECT MAX(salary) 최고급여,
       MIN(salary) 최저급여,
       MAX(salary) - MIN(salary) 급여차
FROM   employees;

--03. 우리회사에 매니저로 있는 사원들의 수를 파악하고자 한다.
--우리회사 매니저인 사원들의 수를 조회하시오. --18
SELECT COUNT(DISTINCT(manager_id)) 매니저사원수
FROM   employees;

--04. 우리회사 account 업무를 하는 사원들의 급여평균를 조회하시오.
--소수이하 2자리까지 구하시오. --7983.33
SELECT ROUND(AVG(salary),2) 급여평균
FROM   employees
WHERE  UPPER(job_id) LIKE '%ACCOUNT%';


--05. 우리회사 사원들의 사번, 성, 부서코드, 급여 조회하여 부서코드 순으로 정렬한다.
SELECT employee_id, last_name, department_id, salary
FROM   employees
ORDER BY 3;


--06. 부서코드 50번 부서의 급여평균를 조회, 소수이하 2자리 --3475.56
SELECT ROUND(AVG(salary),2) 급여평균
FROM   employees
WHERE  department_id = 50;


-----------------------------------------------------------------------------------------------
--[연습문제 4-2]
--01. 우리회사 사원들 중 커미션을 받는 사원들이 모두 몇명인지 파악하고자 한다.
--커미션을 받는 사원의 수를 조회 --35
SELECT COUNT(commission_pct) "커미션 받는 사원수"
FROM   employees;





--02. 우리회사 사원들 중 가장 먼저/나중에 입사한 사원의 입사일자 조회 --01/01/13	08/04/21
SELECT MIN(hire_date) "가장 먼저 입사한 날짜",
       MAX(hire_date) "가장 늦게 입사한 날짜"
FROM   employees;




--03. 우리회사 부서코드 90번인 부서에 속한 사원들의 급여평균 조회, 소수이하 2자리 --19333.33
SELECT ROUND(AVG(salary),2) 급여평균
FROM   employees
WHERE  department_id = 90;


-----------------------------------------------------------------------------------------------


4.3 GROUP BY 절 : 그룹별로 조회
전체 데이터행을 하나의 그룹으로 보고 그룹함수로 데이터를 조회
특정 기준을 두어 기준으로 그룹을 짓고 그룹별로 하나의 결과를 조회하고자 할 때 사용


01. 사원들의 사번, 성, 부서코드, 급여 조회하여 부서코드 순으로 정렬
SELECT employee_id, last_name, department_id, salary
FROM   employees
ORDER BY 3;

02. 50번 부서의 급여평균 조회
SELECT ROUND(AVG(salary),2) avg_sal
FROM   employees
WHERE  department_id = 50;

03. 50번 부서의 부서코드, 업무코드, 급여평균 조회
SELECT department_id, job_id,
       ROUND(AVG(salary),2) avg_sal
FROM   employees
WHERE  department_id = 50;

SELECT   절 : 조회하고자 하는 컬럼목록 
FROM     절 : SELECT 절에 컬럼이 있는 테이블
WHERE    절 : 조건에 맞는 데이터행을 조회하고자 할 때 --* 그룹함수 조건 사용 불가, ALIAS 불가
GROUP BY 절 : 특정 기준으로 그룹을 지을 때 --ALIAS 불가
HAVING   절 : 그룹함수 조건 지정 --ALIAS 불가
ORDER BY 절 : 데이터행의 절령

GROUP BY + 그룹짓고자 하는 기준

SELECT 목록에
       그룹함수를 사용한 표현(COUNT, SUM, AVG, MAX, MIN 등) 과
       그룹함수를 사용하지 않는 표현(즉, 일반컬럼) 이 함께 있다면
반드시 그룹함수를 사용하지 않으면 표현(일반컬럼)에 대해서는 (즉, 그룸함수 이외의 일반컬럼)
GROUP BY 절에 명시해야만 한다.

그러나, GROUP BY 절에 명시된 컬럼은 SELECT 절에 사용하지 않아도 된다.

04. 각 부서별로 급여평균을 조회
SELECT department_id, ROUND(AVG(salary),2) 급여평균
FROM   employees
WHERE  department_id IS NOT NULL
GROUP BY department_id
ORDER BY 1;

05. 부서별로 급여합계, 급여평균, 부서원수 조회
SELECT department_id,
       SUM(salary) 급여합계,
       ROUND(AVG(salary),2) 급여평균,
       COUNT(department_id) 부서원수
FROM   employees
WHERE  department_id IN (10, 20, 30, 40, 60)
GROUP BY department_id
ORDER BY 1;

06. 각 부서별 업무별 급여평균 조회
SELECT department_id, job_id,
       ROUND(AVG(salary),2) 급여평균
FROM   employees
WHERE department_id IS NOT NULL
GROUP BY department_id, job_id
ORDER BY 1;

07. 부서코드 10, 20, 30, 40, 60 번 부서에 대해
해당부서별로 부서코드 부서원수, 부서급여평균 조회
SELECT department_id,
       COUNT(department_id) 부서원수,
       ROUND(AVG(salary),2) 급여평균
FROM   employees
WHERE  department_id IN (10, 20, 30, 40, 60)
GROUP BY department_id;


08. clerk 종류의 업무별로 사원수, 급여평균 조회
SELECT job_id,
       COUNT(*) 부서원수,
       ROUND(AVG(salary),2) 급여평균
FROM   employees
WHERE  UPPER(job_id) LIKE '%CLERK%'
GROUP BY job_id;

09. 우리회사 부서코드 10, 20, 30, 40, 60 번 부서에 속한 사원들의
어떤 업무를 하는지 파악하고자 한다.
해당 부서에 속한 사원들이 하는 업무코드 조회
SELECT job_id,
       COUNT(*) 부서원수
FROM   employees
WHERE  department_id IN (10, 20, 30, 40, 60)
GROUP BY job_id;

GROUP BY 의 결과 행에 대해 특정 조건에 맞는 데이터행을 조회하기 위한 조건절
 : HAVING 절 사용
조건절 : 
WHERE  : ALIAS 사용불가, 그룹함수 사용불가 --***
HAVING : ALIAS 사용불가, 그룹함수 사용불가 --***

10. 80번 부서의 부서와 급여평균 조회
SELECT department_id, ROUND(AVG(salary))
FROM   employees
WHERE  department_id = 80
GROUP BY  department_id;

SELECT department_id, ROUND(AVG(salary))
FROM   employees
GROUP BY  department_id
HAVING  department_id = 80;

11. 각 부서별로 소속된 사원수 수가 5명 이하인 부서와 그 수를 조회
SELECT department_id, COUNT(*) 사원수
FROM   employees
--WHERE  COUNT(*) <= 5 -- WHERE : 일반컴럼만 가능, 그룹함수 사용불가
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING COUNT(*) <= 5
ORDER BY 1;

12. 각 부서별 사원에 대해 사원수가 10명 이상인 부서의
부서코드, 사원수, 급여평균, 최대급여, 최저급여 조회
SELECT department_id,
       COUNT(*) 사원수,
       ROUND(AVG(salary),2) 급여평균,
       MAX(salary) 최대급여,
       MIN(salary) 최저급여
FROM   employees
GROUP BY department_id
HAVING COUNT(*) >= 10
ORDER BY 1;


-----------------------------------------------------------------------------------------------


4.4 ROLLUP
 : GROUP BY 절에서 ROLLUP 함수를 사용하여 GROUP BY 구문에 의한 결과와 함께
 단계별 소계, 총계 정보를 구함.
--★ GROUP BY 절에서 ★ROLLUP 으로 묶은 컬럼표현★ 에 대해 총계를 구함

01. 각 부서별, 업무별 사원수와 급여합계, 부서별소계(???), 총계(???)를 총회
SELECT department_id, job_id, SUM(salary)
FROM   employees
--WHERE department_id IS NOT NULL
GROUP BY ROLLUP(department_id, job_id)
--HAVING
ORDER BY department_id ASC, job_id ASC;

SELECT *
FROM   employees;


-----------------------------------------------------------------------------------------------



4.5 CUBE
 : GROUP BY 절에서 CUBE 함수를 사용하여 GROUP BY 구문에 의한 결과와 함께
  모든 경우의 조합에 대해 소계, 총계 정보를 구함.
--★ GROUP BY 절에서 ★CUBE 으로 묶은 컬럼표현★ 에 대해 총계합 구함.
  
SELECT department_id, job_id, SUM(salary)
FROM   employees
--WHERE
GROUP BY CUBE(department_id, job_id)
--HAVING
ORDER BY department_id ASC, job_id ASC;

-----------------------------------------------------------------------------------------------                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               

--실습
--01. 우리회사 사원들의 업무형태(업무코드)별 사원 수를 파악하고자 한다.
--업무형태(업무코드), 사원수 조회
SELECT job_id, COUNT(*) 사원수
FROM   employees
GROUP BY job_id;




--02. 부서별 급여 정보를 파악하고자 한다.
--부서코드, 급여평균 조회- 급여평균이 높은 부서부터 정렬하고
--급여평균는 반올림하여 소수 둘째자리까지 표현.
SELECT department_id, ROUND(AVG(salary),2) 급여평균
FROM   employees
GROUP BY department_id
ORDER BY 2 DESC;



--03. 부서별, 업무별 급여합계를 파악하고자 한다.
--부서코드, 업무코드, 급여합계 조회
SELECT department_id, job_id, SUM(salary) 급여합계
FROM   employees
GROUP BY department_id, job_id;



--04. 부서코드 60번 부서에 속한 사원들의 사원 수를 파악하고자 한다.
--60 번 부서에 속한 사원들의 사원 수를 조회(HAVING 절 사용)
SELECT department_id, COUNT(*) 사원수
FROM   employees
--WHERE  department_id = 60
GROUP BY department_id
HAVING department_id = 60;



--05. 부서의 급여평균이 10000 이상인 부서를 파악하고자 한다.
--부서의 급여평균이 10000이상인 부서코드, 급여평균를 조회
--급여평균는 반올림하여 소수 둘째자리까지 표현.
SELECT department_id, ROUND(AVG(salary),2) 급여평균
FROM   employees
GROUP BY department_id
HAVING ROUND(AVG(salary),2) >= 10000;



--06. 각 부서별 부서코드, 부서원수, 부서급여평균 조회
SELECT department_id, COUNT(*) 부서원수, ROUND(AVG(salary),2) 급여평균
FROM   employees
WHERE  department_id IS NOT NULL
GROUP BY department_id;



--07. 100번 부서에 대한 정보를 파악하고자 한다.
--100번 부서의 부서코드, 부서원수, 부서급여평균 조회
SELECT department_id, COUNT(*) 부서원수, ROUND(AVG(salary),2) 급여평균
FROM   employees
WHERE  department_id = 100
GROUP BY department_id;



--08. 각 부서별 정보를 파악하고자 한다.
--각 부서별 부서원수가 15명 이상인 부서에 대해 부서코드, 부서원수, 부서급여평균 조회
SELECT department_id, COUNT(*) 부서원수, ROUND(AVG(salary),2) 급여평균
FROM   employees
GROUP BY department_id
HAVING COUNT(*) >= 15;


--09. 각 부서의 부서급여평균이 8000 이상인 부서에 대해
--부서코드, 부서원수, 부서급여평균 조회
SELECT department_id, COUNT(*) 부서원수, ROUND(AVG(salary),2) 급여평균
FROM   employees
GROUP BY department_id
HAVING ROUND(AVG(salary),2) >= 8000;



--10. 각 부서별 최대급여를 파악하고자 한다. 
-- 각 부서의 최대급여가 10000 이상인 부서코드, 최대급여를 조회. 
SELECT department_id, COUNT(*) 부서원수, MAX(salary) 최대급여
FROM   employees
GROUP BY department_id
HAVING MAX(salary) > = 10000;



--11. 두 명 이상 있는 성이 어떤 것들이 있나 파악하고자 한다. 
--두 명 이상 있는 성과, 수를 조회
SELECT last_name, COUNT(*) 부서원수
FROM   employees
GROUP BY last_name
HAVING COUNT(*) >= 2;



--12. 년도별(오름차순)로 입사한 사원 수를 파악하고자 한다. 
--입사년도, 사원 수 조회 - 년도는 2020의 형태로 표현

--입사년도     사원수
--2001	        1
--2002	      	7
--2003	      	6
--2004	      	10
--2005	      	29
--2006	      	24
--2007	      	19
--2008	      	11
SELECT TO_CHAR(hire_date, 'YYYY') 입사년도, COUNT(*) 사원수
FROM   employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
ORDER BY 2;

--13. 각 부서별로 정보를 파악하고자 한다.
--각 부서별 부서코드, 부서원수, 부서급여평균, 부서최고급여, 부서최저급여 조회
SELECT department_id, COUNT(*) 부서원수, ROUND(AVG(salary),2) 급여평균,
       MAX(salary) 최고급여, MIN(salary) 최저급여
FROM   employees
WHERE department_id IS NOT NULL
GROUP BY department_id;




--14. 각 업무별로 정보를 파악하고자 한다.
--각 업무별 업무코드, 업무하는사원수, 업무급여평균, 업무최고급여, 업무최저급여 조회
SELECT job_id, COUNT(*) 부서원수, ROUND(AVG(salary),2) 급여평균,
       MAX(salary) 최고급여, MIN(salary) 최저급여
FROM   employees
GROUP BY job_id;




--15. 각 부서별 부서내 업무별로 부서코드, 업무코드, 사원수, 급여평균 조회
SELECT department_id, job_id, COUNT(*) 부서원수, ROUND(AVG(salary),2) 급여평균
FROM   employees
WHERE department_id IS NOT NULL
GROUP BY department_id, job_id;


-----------------------------------------------------------------------------------------------
--[연습문제 4-3]
--01. 사원테이블에서 똑같은 이름(first_name)이 둘 이상 있는 이름과 그 이름이 모두 몇 명인지를 
--조회하는 쿼리문을 작성한다. 
--이름별로 몇명인지를 구함
SELECT first_name, COUNT(*)
FROM   employees
GROUP BY first_name
HAVING COUNT(first_name) >= 2;


--02. 부서번호, 각 부서별 급여총액과 급여평균를 조회하는 쿼리문을 작성한다. 
--단, 부서 급여평균이 8000 이상인 부서만 조회되도록 한다.
SELECT department_id, COUNT(*) 부서원수, SUM(salary) 급여총액, ROUND(AVG(salary),2) 급여평균
FROM   employees
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING  ROUND(AVG(salary),2) >= 8000;


--03. 년도별로 입사한 사원수를 조회하는 쿼리문을 작성한다.
--단, 년도는 2014 의 형태로 표기되도록 한다.
SELECT TO_CHAR(hire_date, 'YYYY') 입사년도, COUNT(*) 사원수
FROM   employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
ORDER BY 2;


-----------------------------------------------------------------------------------------------











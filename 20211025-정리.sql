--tblMember 테이블 생성
CREATE TABLE  tblMember (
  num   NUMBER PRIMARY KEY,
  name  VARCHAR2(10),
  age   NUMBER,
  addr  VARCHAR2(50),
  tel   VARCHAR2(20)
);

--tblMember 구조보기
DESC  tblmember;

--레코드 삽입하기
INSERT INTO tblMember(num, name, age, addr, tel)
VALUES (1, '홍길동', 30, '광주시 서구 농성동', '010-1111-1111');

INSERT INTO tblMember
VALUES (2, '길길동', 27, '광주시 서구 쌍촌동', '010-2222-2222');

--전체레코드 검색
SELECT  num, name, age, addr, tel
FROM    tblMember;

SELECT  *
FROM    tblMember;

--메모리에만 저장되어 있는 내용을 최종적으로 DB에 반영, 작업 확정
COMMIT; 

--tblMember 테이블에 phone 필드 추가
ALTER TABLE tblMember
ADD   phone VARCHAR2(10);

DESC  tblmember;
이름    널?       유형           
----- -------- ------------ 
NUM   NOT NULL NUMBER       
NAME           VARCHAR2(10) 
AGE            NUMBER       
ADDR           VARCHAR2(50) 
TEL            VARCHAR2(20) 
PHONE          VARCHAR2(10) --크기를 20자로 변경

ALTER   TABLE tblMember
MODIFY  phone   VARCHAR2(20);

DESC  tblmember;
이름    널?       유형           
----- -------- ------------ 
NUM   NOT NULL NUMBER       
NAME           VARCHAR2(10) 
AGE            NUMBER       
ADDR           VARCHAR2(50) 
TEL            VARCHAR2(20) 
PHONE          VARCHAR2(20) 

--tblMember 테이블의 phone 필드의 이름을 mobilephone 으로 변경
ALTER   TABLE   tblMember
RENAME  COLUMN  phone TO mobilephone;

--구조보기
DESC  tblMember;
이름          널?       유형           
----------- -------- ------------ 
NUM         NOT NULL NUMBER       
NAME                 VARCHAR2(10) 
AGE                  NUMBER       
ADDR                 VARCHAR2(50) 
TEL                  VARCHAR2(20) 
MOBILEPHONE          VARCHAR2(20)

--tblMember 테이블의 mobilphone 필드 제거
ALTER TABLE tblMember
DROP  COLUMN  mobilephone;

DESC  tblMember; 
이름   널?       유형           
---- -------- ------------ 
NUM  NOT NULL NUMBER       
NAME          VARCHAR2(10) 
AGE           NUMBER       
ADDR          VARCHAR2(50) 
TEL           VARCHAR2(20)

--tblMember 테이블 제거
DROP TABLE  tblMember;--휴지통으로

DROP TABLE  tblMember PURGE;--완전제거


--tblMember 테이블을 복구
FLASHBACK TABLE tblMember TO BEFORE DROP;

--DML : 데이터 조작어
--임의의 레코드 삽입
INSERT INTO tblMember(tel, addr, age, num, name)
VALUES ('010-3333-3333', '광주시 북구 용봉동', 47, 3, '박길동');

--tblMember 테이블 조회
SELECT *
FROM   tblMember;

--작업취소 : ROllBACK
ROLLBACK;

--tblMember 테이블 조회
SELECT *
FROM   tblMember;

--작업확정
COMMIT;

SELECT *
FROM   tblMember;

COMMIT;

ROLLBACK;

SELECT *
FROM   tblMember;

INSERT INTO tblMember (num, name, age)
VALUES (4, '이순신', 55);

--조회
SELECT *
FROM   tblMember;

--4번 레코드 정보를 갱신(수정)
UPDATE tblMember --TABLE 예약어 없음, 반드시 조건절 기술, 조건절 없으면 다 바뀜
SET    addr = '광주시 광산구 신가동', tel = '010-4444-4444'
WHERE  num = 4;

--조회
SELECT *
FROM   tblMember;

--3번 레코드의 주소를 수정(서울시 강서구 화곡동)
UPDATE tblMember
SET    addr = '서울시 강서구 화곡동'
WHERE  num = 3;

--조회
SELECT *
FROM   tblMember;

--작업확정
COMMIT;

--4번 레코드 삭제
DELETE FROM tblMember
WHERE  num = 4;

--조회
SELECT *
FROM   tblMember;

--전체레코드 삭제
DELETE FROM tblMember;

--조회
SELECT *
FROM   tblMember;

--작업취소
ROLLBACK;

--조회
SELECT *
FROM   tblMember;

--번호, 이름, 주소만 출력
SELECT num, name, addr
FROM   tblMember;

--이름 김길동인 회원의 이름, 나이, 주소만 출력
SELECT  *
FROM   tblMember
WHERE  name = '홍길동';

--나이가 40세 이상인 회훤 출력(비교연산자)
SELECT *
FROM   tblMember
WHERE  age >= 40;

--나이가 30 ~50세 사이의 회원 출력
SELECT *
FROM   tblMember
WHERE  age >= 30
AND    age <= 50;

SELECT *
FROM   tblMember
WHERE  age BETWEEN 30 AND 50;

--주소에 특정 글자 보함된 회월을 출력 **** : LIKE
SELECT *
FROM   tblMember
WHERE  addr LIKE '%서구%'; --서구가 포함된 레코드 출력

--광주에 사는 회원 출력
SELECT *
FROM   tblMember
WHERE  addr LIKE '광주%';

--농성동에 사는 회원출력
SELECT *
FROM   tblMember
WHERE  addr LIKE '%농성동'; --농성동으로 끝나는 레코드 출력

--내장함수(COUNT, SUM, AVG, MAX, MIN)
SELECT COUNT(name) cnt --name 필드의 갯수
FROM   tblMember;

SELECT SUM(age) sum  --age 필드의 합계
FROM   tblMember;

SELECT TRUNC(AVG(age)) --age 필드의 평균
FROM   tblMember;

SELECT MAX(age) max --age 필드의 최대값
FROM   tblMember;

--내년의 나이 출력
SELECT age +1 "내년 나이"
FROM   tblMember;

--서구가 포함된 나이의 합계
SELECT SUM(age)
FROM   tblMember
WHERE  addr LIKE '%서구%';

--기타연산
SELECT *
FROM   tblMember
WHERE  num IN(1,3); --OR연산자

COMMIT;

ROLLBACK; --ROLLBAKC 안됨.

--tblPanme 테이블 생성
CREATE TABLE tblPanme (
 code  VARCHAR2(10) PRIMARY KEY,
 part  VARCHAR2(20),
 price NUMBER
);

DESC tblPanme;

--레코드 입력
INSERT INTO tblPanme (code, part, price) VALUES ('001', 'A영업부', 3000);
INSERT INTO tblPanme VALUES ('002', 'B영업부', 6000);
INSERT INTO tblPanme VALUES ('003', 'A영업부', 2000);
INSERT INTO tblPanme VALUES ('004', 'B영업부', 5000);
INSERT INTO tblPanme VALUES ('005', 'C영업부', 1000);
INSERT INTO tblPanme VALUES ('006', 'D영업부', 4000);

--조회
SELECT *
FROM   tblPanme;

--작업확정
COMMIT;

--각부서별(GROUP BY part)로 판매금액의 총합(SUM(price))을 구하여 출력
SELECT part, SUM(price) sum_price--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다 내장함수?
FROM   tblPanme
GROUP BY  part;

--각부서별(GROUP BY part)로 판매금액의 총합(SUM(price))을 구하여 부서의 오름차순으로 출력
SELECT part 부서, SUM(price) sum_price--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다 내장함수?
FROM   tblPanme
GROUP BY  part
--ORDER BY  part; --컬럼명
--ORDER BY  1; --컬럼위치번호
ORDER BY  부서; --ALIAS명

--부서명 출력
SELECT DISTINCT part --DISTINCT : 중복항목 제거
FROM   tblPanme;

--부서명출력(중복된 부서는 한번만 출력하고 부서명의 내림차순으로 출력)
SELECT DISTINCT part
FROM   tblPanme
ORDER BY 1 DESC;

--부서명의 개수 출력
SELECT COUNT(DISTINCT(part)) cnt
FROM   tblPanme;

--각부서별 판매금액의 총합을 구하여 부서의 오름차순으로 정렬하여 출력
--단, 부서가 2개 이상있는 부서만 대상으로 하시오. 즉, A영업부, B영업부
SELECT part 부서, SUM(price) 판매금액총합
FROM   tblPanme
--WHERE COUNT(part) >= 2 --WHERE W절에서는 ALIAS, 그룹함수 사용불가
GROUP BY part
HAVING COUNT(part) >= 2 --HAVING : 그룹함수 사용가능
ORDER BY part ASC;

--순서 기억
SELECT
FORM
WHERE
GROUP BY
HAVING
ORDER BY


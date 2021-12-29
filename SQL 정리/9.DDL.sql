9장. DDL(Data Definition Language) --AUTO COMMIT
CREATE, ALTER, DROP, TRUNCATE, RENAME

9.1.테이블 생성 --CREATE
CREATE TABLE 테이블명 (
 컬럼명1 테이터타입,
 컬럼명2 테이터타입,
 ....
 컬럼명n 테이터타입
);

* 데이터 타입 : 문자, 숫자, 날짜
- 문자 : CHAR, VARCHAR2
  CHAR(n) - 고정문자 : 지정된 크기만큼 메모리를 확보한다.
   CHAR(10) - 저장시 abcd 문자를 저장 -> abcd______
   ☞ 메모리를 10바이트 확보한 후 저장한다.
 
  VARCHAR2(n) - 가변문자 : 데이터를 저장할 때 메모리를 확보한다. 최대 4000바이트
   VARCHAR2(30) - 저장시 abcd문자를 저장 -> abcd
   
- 숫자 : NUMBER
    NUMBER(n) - 정수데이터
     NUMBER(8) - 정수 8자리, 즉, 99999999
    NUMBER(n,p) - 부동소숫점 데이터, 정수부 : n - p , 소수부 : p
     NUMBER(8,2) - 정수부 : 8 - 2 = 6, 소수부 : 2 -> 999999,99
     NUMBER(2,2) - 정수부 : 2 - 2 = 0, 소수부 : 2 -> 0.99
     
- 날짜 : DATE
    
CREATE TABLE temp (
    id NUMBER(4) PRIMARY KEY,
    name VARCHAR2(30)
);

INSERT INTO temp
VALUES (100, '홍길동');

INSERT INTO temp
VALUES (101, '이순신');

COMMIT;

SELECT *
FROM   temp;


----------------------------------------------------------------------------------------------


9.2. 테이블 구조 변경 -- ALTER
1) 컬럼추가
ALTER TABLE 테이블명
ADD (컬럼명1 데이터타입1(크기), 컬럼명2, 테이터타입2(크기), ....)

8자리로 salary 필드 추가
ALTER TABLE temp
ADD (salary NUMBER(8));

SELECT *
FROM   temp;

UPDATE temp
SET    salary = 3000
WHERE  id = 101;

SELECT *
FROM   temp;

2) 테이터타입 크기 변경 --MODIFY
ALTER TABLE 테이블명
MODIFY (컬럼명1, 테이터타입1(크기), 컬럼명2, 테이터타입2(크기), ....)

ALTER TABLE temp
MODIFY (salary NUMBER(10));

DESC temp;

3)컬럼 삭제 --DROP COLUMN
ALTER TABLE 테이블명
DROP COLUMN 컬럼명

ALTER TABLE temp
DROP COLUMN salary;

DESC temp;

4) 컬럼명 변경 --RENAME COLUMN
ALTER TABLE 테이블명
RENAME COLUMN 기존컬럼명 TO 새컬럼명

ALTER TABLE temp
RENAME COLUMN id TO temp_id;

DESC temp;


-------------------------------------------------------------------------------------------


9.3. 테이블 삭제
DROP TABLE 테이블명 [PURGE] -- PURGE : 휴지통을 거치지 않고 영구 삭제
DROP TABLE temp;

*삭제도니 테이블 복원
FLASHBACK TABLE temp TO BEFORE DROP;

SELECT *
FROM   temp;



------------------------------------------------------------------------------------------



9.4. 구조만 남기고 데이터 모두 삭제
TRUNCATE TABLE 테이블명 -- 조건절 사용불가, ROLLBACK 사용불가


------------------------------------------------------------------------------------------


9.5. 테이블명 변경 -- RENAME
RENAME 원래테이블명 TO 새테이블명

RENAME temp TO test;

SELECT *
FROM   test;


-------------------------------------------------------------------------------------------


9.6. 테이블 삭제 -- DROP
DROP TABLE 테이블명



-----------------------------------------------------------------------------------------------
※ DELETE, TRUNCATE, DROP 명령어의 차이점

- DELETE 명령어는 데이터는 지워지지만 테이블 용량은 줄어 들지 않는다. 
  원하는 데이터만 지울 수 있다. 삭제 후 잘못 삭제한 것을 되돌릴 수 있다.
- TRUNCATE 명령어는 용량이 줄어 들고, 인덱스 등도 모두 삭제 된다. 
  테이블은 삭제하지는 않고, 데이터만 삭제한다. 
  한꺼번에 다 지워진다. 삭제 후 절대 되돌릴 수 없다.
- DROP 명령어는 테이블 전체를 삭제, 공간, 객체를 삭제한다. 
  삭제 후 절대 되돌릴 수 없다.
  
[고객 테이블] [원본]       [DELETE 후]             [TRUNCATE 후]             [DROP 후]
이름      주소  연락처     이름   주소  연락처     이름   주소  연락처       삭제됨
홍길동    서울  1111       |   |  |   | |    |
홍길순    천안  2222       |   |  |   | |    |
이순신    부산  3333       |   |  |   | |    |
                           데이터만 지워지고,      테이블은 삭제 안되고,     테이블 전체 삭제
                           용량은 그대로           용량은 줄어들고,
                                                   인덱스 등 모두 삭제
                                                   
-----------------------------------------------------------------------------------------------

1. 입력정보요건에 따라 입력테이블인 회원관리 테이블을 생성한 후 
테이블구조를 확인하시오.
create  table member (
id        varchar2(50) constraint  member_id_pk    primary key,
password  varchar2(50) constraint  member_pw_nn    not null,
name      varchar2(20) constraint  member_nm_nn    not null,
phone     varchar2(13), constraint  member_phone
email     varchar2(50), constraint  member_email
joindate  date constraint  member_jdate_nn not null
);

desc member;


2. 샘플데이터를 활용하여 회원정보를 등록한 후 회원정보를 조회하시오.
insert into member
values ('hong', 'hong1234', '홍길동', '062-1234-5678', 'hong@naver.com', '2020-01-10');

insert into member 
values ('sim', 'simsim', '심청', null, 'sim@daum.net', '2020-01-12');

insert into member 
values ('park', 'park', '박문수', '010-5678-1234', 'park@naver.com', '2020-01-12');

insert into member 
values ('jeon', 'jeon9876', '전우치', '010-4252-9876', 'jeon@naver.com', '2020-01-14');

insert into member 
values ('java', 'park', '박자바', '032-8520-3697', 'java@hrd.co.kr', '2020-01-14');

UPDATE member SET email = 'jeon@gmail.com' where id ='jeon';

commit;

select * from member;


3. 변경정보를 활용하여 회원정보를 변경한 후 회원정보를 조회하시오.
UPDATE member SET phone = '02-4567-3210', email = 'sim02@daum.net' where id ='sim';
UPDATE member SET phone = null, email = 'jeon@naver.com' where id ='jeon';

commit;

select * from member;


4. 탈퇴정보를 활용하여 회원정보를 삭제한 후 회원정보를 조회하시오.
delete from member where id = 'java';

commit;

select * from member;


5. 조회요건에 따라 회원정보를 조회하시오.
    1) 성명이 홍길동인 회원정보를 조회하는 SQL을 작성하시오.
    select *
    from   member
    where  name = '홍길동';
    
    2) 전화번호가 없는 회원정보를 조회하는 SQL을 작성하시오.
    select *
    from   member
    where  phone is null;
    
    3) naver 이메일을 사용하는 회원정보를 조회하는 SQL을 작성하시오.
    select *
    from   member
    where  lower(email) like '%naver%';

    4) 가장 최근에 가입한 회원정보를 조회하는 SQL을 작성하시오.
    select *
    from   member
    where  joindate in (select max(joindate) from member);
    
    5) 가입일자별로 가입한 회원수를 파악할 수 있도록
       가입일자, 회원수를 조회하는 SQL을 작성하시오.( ALIAS　유의)
    select joindate, count(*)
    from   member
    group by joindate
    order by 2;




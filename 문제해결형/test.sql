 create  table member (
id          varchar2(50)    constraint  member_id_pk    primary key,
password    varchar2(50)    constraint  member_pw_nn    not null,
name        varchar2(20)    constraint  member_nm_nn    not null,
phone       varchar2(13),
email       varchar2(50),
joindate    date            constraint  member_jdate_nn not null
);

desc member;


--1. 입력테이블 : 회원관리테이블 생성 후 테이블 구조 확인

    create  table member (
        id          varchar2(50)    constraint  member_id_pk    primary key,
        password    varchar2(50)    constraint  member_pw_nn    not null,
        name        varchar2(20)    constraint  member_nm_nn    not null,
        phone       varchar2(13),
        email       varchar2(50),
        joindate    date            constraint  member_jdate_nn not null
    );

    desc member;
----------------------------------------------------------------------------------------------------

--2. 샘플데이터 입력 후 COMMIT 하고 난 후 회원정보 조회

--1)홍길동 입력
    insert into member
    values ('hong', 'hong1234', '홍길동', '062-1234-5678', 'hong@naver.com', '2020-01-10');
    select  *   from    member;
    commit;
--2)심청 입력
    insert into member
    values ('sim', 'simsim', '심청', null, 'sim@daum.net', '2020-01-12');
    select  *   from    member;
    commit;

--3)박문수 입력
    insert into member
    values ('park', 'park', '박문수', '010-5678-1234', 'park@naver.com', '2020-01-12');
    select  *   from    member;
    commit;

--4)전우치 입력
    insert into member
    values ('jeon', 'jeon9876', '전우치', '010-4252-9876', 'jeon@gmail.com', '2020-01-14');
    select  *   from    member;
    commit;

--5)박자바 입력
    insert into member
    values ('java', 'park', '박자바', '032-8520-3697', 'java@hrd.co.kr', '2020-01-04');
    select  *   from    member;
    commit;
----------------------------------------------------------------------------------------------------

--3. 정보변경 후 COMMIT 하고 난 후 회원 정보 조회
    update member
    set phone = '02-4567-3210', email='sim02@daum.net'
    where   id = 'sim';
    
    select * from member;
    commit;

    update member
    set phone = '', email='jeon@naver.com'
    where   id = 'jeon';
    
    select * from member;
    commit;

----------------------------------------------------------------------------------------------------

--4. 정보삭제 후 COMMIT 하고 난 후 회원 정보 조회
    delete  from    member
    where   id='java';

    select * from member;
    commit;

----------------------------------------------------------------------------------------------------

--5. 조회

--1) 성명이 홍길동인 회원정보를 조회하는 SQL을 작성
    select  *
    from    member
    where   name like '%홍길동%';

--2) 전화번호가 없는 회원정보를 조회하는 SQL을 작성
    select  *
    from    member
    where   phone is null;

--3) naver 이메일을 사용하는 회원정보를 조회하는 SQL을 작성
    select  *
    from    member
    where   email like '%naver%';

--4) 가장 최근에 가입한 회원정보를 조회하는 SQL을 작성
    select id, password, name, phone, email, joindate
    from    member
    where   joindate in (select max(joindate)
                         from   member);
    
    select  id, password, name, phone, email, joindate
    from    member, (select max(joindate) max_date
                     from   member)
    where   joindate = max_date;
    

--5) 가입일자별로 가입한 회원수를 파악할 수 있도록 가입일자, 회원수를 조회하는 SQL을 작성 
    select  joindate, count(*) su
    from    member
    group by joindate;

























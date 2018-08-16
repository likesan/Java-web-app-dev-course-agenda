-- DQL을 마쳤다.

-- DML > insert / update / delete
-- DML > DQL > select

-- DDL > create  / alter / drop

-------------------------------------------------------------------------------

-- alter : 수정 ( 뭘? 테이블의 column 값 추가 / 삭제 ,  제약조건 추가/ 삭제 ) 
-- 데이터 값과 column 의 조건을 모두 수정할 수 있는 세부적인 메스 = alter
--( 프로그램 개발을 위해서는 또 알긴 알아야한다고도 하는데... 음.. 프리랜서로 내가 원하는 것을 마음대로 다 만들어내려면 알아야하는 부분 아닐까?)


-- oracle에 정의된 객체의 내용을 수정할 때 사용하는 Quary
-- 테이블 컬럼 추가 / 삭제 , 제약조건의 추가 / 삭제
-- 테이블 컬럼 자료형의 변경 / 이름 변경 등

-- update : 데이터를 통제 ( column 의 한 field 값 )
-- alter : 객체를 통제 ( 테이블 자체 )

desc member; -- member 테이블이 생성 되어 있는지 여부 확인
drop table member; -- 있으면 지우기

create table member(
    userNo number primary key,
    userId varchar(20),
    userPwd varchar(20)
);

select * from member;

insert into member values (55,'1001','1024');

--------------------------------------------------------------------------------
-- column을 추가해보자. 
alter table member add (userName varchar(20)); -- userName 넣는 걸 깜빡하고 테이블을 만들었다면, 다음과 같이 userName column을 넣어줄 수 있다.
desc member;

alter table member add (userIP varchar(20));
alter table member add (userGender varchar(5));
---
alter table member add (userAge varchar(10) default 0 ); -- default 로 0을 넣을 수 도 있다.

-- 다시 userAge의 자료형을 바꿔보자. varchar > number형으로 -- 자료형도 바꿀 수 있는 alter
alter table member modify (userAge number default 0);
alter table member modify (userIP varchar(15) default '000,000,000'); -- 음.. 어떤 형태로 해야 default 값을 number 자료형 에서도 000,000,000 형태로 바꿀 수 있을까?
alter table member modify (userGender char(10) default '미기입');
---

-- column의 이름도 바꿔보자
alter table member rename column userpwd to password; -- 영문법과 정말 그대로 유사해서 편안하다 :)
alter table member rename column userIP to userHostAdr;
alter table member rename column userGender to userSex;

-- 눈앞에 있는게 중요하다. 먼저 눈앞에 있는 것들부터 해치워내자

alter table member drop (userAge); -- member라는 column 하나를 아예 없애버릴 수 있다.
alter table member drop (userIp);

------------------------------------------------------------------------------------------------
-- 테이블의 제약조건에 대해 알아보자 (unique , primary key 등등)

-- userid column 에 unique 속성을 추가해보자.

alter table member add unique (userId); -- unique 속성으로 바뀌어 중복된 값이 들어올 수 없도록 막힌다.

-- unique 가 들어갔는지 확인됐는지 알아내는 방법? 
-- 설명하기 앞서..

-- Data Dictionary : Oracle 이 기본적으로 가지고 있는 내장 테이블 
-- 종류 3가지
-- DBA_ : Database 시스템 계정 같은 최고 관리자가 적용하는 설정 및 생성하는 객체 정보 등을 기록하는 테이블
-- ALL_ : 현재 접속한 사용자의 설정 및 객체 정보와 권한을 가지고 있는 다른 계정 정보까지 포함하는 테이블
-- USER_ : 해당 서버에 접속한 사용자들의 설정 및 객체 정보만 기록하는 테이블 -- 제약이 있음
-- 관련 주소 : https://docs.oracle.com/cd/B10501_01/server.920/a96524/c05dicti.htm
-- 주가 누구냐가 중요

select table_name  from user_tables;

select constraint_name, constraint_type, table_name from user_constraints where table_name = 'MEMBER'; -- member를 대문자로만 지정해야한다
-- U : unique , P : primary key

-- 고로 제약조건을 지우고 싶다면, CONSTRAINTS_TYPE을 drop으로 지울 수 있다. 하지만 alter로 지우는게 더 좋은 방법?

alter table member drop constraint SYS_C007067; -- CONSTRAINTS_NAME 이 SYS_C007067이라는 애를 지워버림, CONSTRAINTS_NAME 만을 입력해야만 하는 듯.
alter table member drop constraint SYS_C007068;

----------------------------------------------------------------------------------------------------------------------------------------------------------------

alter table member add constraint userName_uniq unique (userName);


--username_uniq 삭제하기
alter table member drop constraint username_uniq;

--확인하기
select constraint_name, constraint_type, table_name from user_constraints where table_name = 'MEMBER';


---------------------------------------------------------------------------------------------------------------------------------------------------------------
-- alter는 constraints 들의 옵션도 수정해줄 수 있고 column의 자료형 조차 수정해줄 수 있다고.
-- 원래 개발자가 database 관리까지 전부다 다루지 않지만, dba가 존재하지 않는다면 개발자가 그 역할 해줘야함.
-- 이로서 DDL 끝 : Data Definition Language, 삭제 수정 입력?


-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DCL ( Data Control Langauge ) : DB에 대한 권한 설정, 보안, 무결성, 복구 등등 DB 제어하기 위한 Quary
-- (무결성?)
-- TCL ( Transaction Control Langauge ) : DBA 의 관리자 역할이긴 하나, 프로젝트를 위해 알아야하는 부분, 초창기 수업서 우리가 많이 쓰게될 부분이라고
-- Transaction : 주거나 받거나 서로 교환하는 과정이나 절차, 비즈니스

-- Grant / revoke / (commit / rollback / savepoint : TCL )


-- khConnection 은 resource 와 어쩌구 밖에 없어서, systemConnection 으로 바꿔줘야한다. 관리자 권한을 얻기 위해서.

create user test identified by test; 
-- identified by?

----------------------

-- grant 권한 주자 : ? = ( insert / delete / select / connect : 와 같은 동작들을 부여해주면 된다. ) grant ? to test;
grant connect to test; -- 연결 권한만 제공 test에

-- select 권한도 줘보자
grant select on kh.employee to test;

-- kh.department 에 select / insert 권한 주기
grant select on kh.department to test;
grant insert on kh.department to test;

-- delete 권한 줘보자
grant delete on kh.department to test;

-- revoke를 해보자?
revoke insert on kh.department from test; -- revoke 있던 권한을 뺏는 것. grant ~ to 가 아니라 revoke from 이다. 권한을 뺏는다 ~로부터 라는 뜻이 되므로

-- 관리자 권한도 줘보자 : 삭제, 수정 등등 모든 것들을 할 수 있기 때문에 매우 주의해야하는 권한
grant dba to test;
---------------------

-- DCL > TCL : Transaction Control Langauge

-- Transaction : 더 이상 나눠지지 않는 원자성을 주기 위함이다? 한꺼번에 수행되어야 할 최소의 작업 단위를 의미한다?

-- [안정성]? 무슨 말이지? 취소할 수 있다. 잘못 저지른 
-- 커맨드를 때렸을 때, transaction에 묶여서  물리적 db 장치에 들어가지 못한다. 왜? db에 직접 전달하지 않는걸까? - 안정성 위함
-- 예시로 delete 생각해보자. delete from employee; 이태림 직원 지우려함 > 깜빡하고 where절을 넣지 못하고 enter를 눌러버렸다! 그러면 모든 table의 내용이 사라짐
-- 하지만 transaction cancel 명령어를 사용하면, 복구가 가능하다. 직전에 있었던 명령어를 수정 가능하다.
-- 하지만 commit 명령어를 세미콜론; 찍어서 사용하면, transaction에 적용되었던 모든 명령어가 '수행된다.'
-- rollback : commit 된 명령어를 뒤로 돌릴 수 있다. 복구할 수 있다.
-- savepoint 3줄 써놓은 얘네를 기억해줘 ,5줄 써놓은 애들 -- 타이밍을 정해놓은 rollback 이라는 점 도 추가적으로 이해

-- [원자성]? 더이상 쪼개질 수 없는 단위
-- transaction의 존재 이유는, 안정성만이 있는게 아니다
-- 구매테이블, 고객의 구매한 정보가 담김, 외주 업체는 이걸 보고 아 이걸 보고 배송을 해줄 수 있도록 만듬, 서로 확인할 수 있음
-- 두 테이블이 모두 한 꺼번에 입력되는 것, 둘 중에 하나라도 서버의 끊김이라던가 데이테 송수신 상의 문제가 발생되지 않도록, 아예 한 작업단위로 만들어버리는 것
-- 나중에 쇼핑몰을 만들어 여러개 외주 업체와 연계해야할 경우 고려해야되는 부분.

----------------------------------------------------------------------------
-- 실제 해보자! -- commit / roll back

delete from person;
desc person;
insert into person values( 1001,'JACK',50); -- 세 가지 값 입력 -- 실제 적용 X : transaction에 묶여있는 상태.
select * from person; -- 이렇게 될 거라고 그냥 출력으로 알려주는 상황
commit; -- 위 내용을 반영해줘! 실제로 insert into person values(1001,'JACK',50) 은 db에 적용이 되버리게 만드는 명령어

insert into person values (1002,'JANE',25); -- 실제 DB에 적용된건지 아직 transaction에 머무르고 있는지 파악시켜주는 명령어는 없을까? 
select * from person;
rollback; -- transaction에 묶여있는 내용을 반영하지 않겠다. 철회하겠다. -- 실행시 '롤백 완료' 뜸

select * from person; --다시 확인을 해보면 insert into person values (1002,'JANE',25); 가 안되어있는 모습을 파악할 수 있다!~!

-- 왜 이런 현상이 발생하는가? rollback한다고 commit 된게 되는건 아님, transaction에 되어있는 놈만 철회하는 것이다. 이미 db에 적용된 애들은 rollback으로도 철회가 안된다. 이미 admit 했다면 늦었다.

-------------------------------------------------------------------------------------------------
insert into person values(1001, 'JACK', 50); -- 구매정보
insert into person values(1001, 'JACK', 25); --  배송정보 라고 가정해보자

-- 중간에 배송정보가 전달되는 과정 안에서, 에러가 났다면? 

-- 이런 과정을 해결하기 위해선 try-catch 구문을 사용하면 된다.


-- 가정----------------------------------------------------------------------------------------
--try {
--insert into person values(1001, 'JACK', 50); -- 구매정보 : transaction으로 전송되는 상황, 아직 db에 물리적으로 수정이 일어나진 않았음
--insert into person values(1001, 'JACK', 25); -- 배송정보 :  만약 이 라인에서 에러가 난다면, commit 되기 전에 catch 구문으로 이동된다. 그 후 rollback이 일어나, 구매정보가 db로 들어가는 걸 막을 수 있다. 구매자가 구매한 물건을 한없이 기다리게 할 상황을 애당초 방지할 수 있다.
--commit;
--}
--catch(Exception e){
--rollback;
--}
-------------------------------------------------------------------------------------------------
-- savepoint 

insert into person values(1001, 'JACK', 50); -- 구매정보 : transaction으로 전송되는 상황, 아직 db에 물리적으로 수정이 일어나진 않았음
insert into person values(1001, 'JACK', 25); -- 배송정보 :  만약 이 라인에서 에러가 난다면, commit 되기 전에 catch 구문으로 이동된다. 그 후 rollback이 일어나, 구매정보가 db로 들어가는 걸 막을 수 있다. 구매자가 구매한 물건을 한없이 기다리게 할 상황을 애당초 방지할 수 있다.
commit;

select * from  person;


savepoint beforeDelete; -- 이 자리가 savepoint가 된다? (맨 마지막 commit이 존재하던 자리가 바로 savepoint가 된다. ) 


delete from person; -- 지웠다. person table의 내용이, 아무런 내용도 그 안에 남아있지 않아보인다.

select * from person; -- 확인; 실제 확인해보니 사라져있다.

rollback to beforeDelete; -- 하지만 rollback을 호출하여 'beforeDelete'를 사용하면, savepoint 가 되어, delete가 사용되었던 시점 이전으로 이동하게 만들어준다.

-- savepoint 의 장점 : 내가 원하는 지점으로 rollback을 가능하게 만듦. 중요한 시점이 있을 때마다 사용하게 된다고, 그런데 rollback이 없다면, 그저 가장 최근에 commit 된 장소가 어딘지 파헤치며 찾아내야함. 되돌아갈 수 있는 순간을 찾아내게 해준다. 편리하게 해준다. 말뚝같은 느낌이다. 돌아갈 수 있는 포인트를 지정해준다는 점에서.

-- dba 는 자주 써야되는 기능이기에 그들이 많이 쓰지만, 개발자는 ...? 개발자의 commit 시점은 모든 프로그램이 완성되었을 때 뿐, 아예 코딩이 좀 잘못되어 프로그램을 만든다는 것 자체가 불가능하다. 왜냐하면 코드 한줄이 잘못 되어봤자 아예 프로그램이 만들어지는 것 자체가 불가능하기때문에 ~  

----------------------------------------------------------------------- 오전 수업 끝 

-- 오후 수업 시작
-- 우리가 TCL이 끝났다! 나중에 웹 개발할 때 다 쓰인다고한다~~~~ DDL DML DCL 다 끝냈다~~~
-- DB 내에 존재하는 객체(object), 어디에나 존재하는 내장 객채들이 있다고 한다.
-- 내장객체  앞으로 배우는 많은 것들 안에 이런 내장객체가 많다고, Android web 어쩌구 ~~

------------------------------------------------------------------------
-- SEQUENCE , VIEW 

-- SEQUENCE 에는 번호가 붙는다?
-- row 하나하나 마다 번호를 붙여놓는 것이 좋다. 왜냐면 언제 꺼내서 써야될 지 모르기 때문
-- insert 구문 생각, 쿼리를 짤 때, insert 첫번째 데이터는 1이라 쓴다. 두번째는 2라고, 세번째는 3. 숫자를 계속해서 증가시킴 rank() over()
-- 데이터 번호가 몇번까지 진행되는지 알 수 있으나 380개정도 된다 치자, 다른일을 보러간다 치자, 그리고 한달정도 무관심해졌음, 기억이 안남, 몇번째가 끝인지
-- database administrator 가 굳이 신경 쓸 필요없게, 몇번째가 끝인지 기억하게 만드는 명령어 = Sequence




create table product (
    num number,
    product_id varchar(10) primary key,
    product_name varchar(50) not null
    -- 상품의 등록 순서를 등록하려 한다 무얼 해야하나? sequence 라는 column 이름을 넣어놓자 = 이놈이 sequnce 인듯
    );

insert into product values(1, 1001 , '삿갓');

alter table product modify( product_id varchar(10) primary key);

-- 갑작스런 문제, 하지만 굳이 또 그렇게 해야하나? 그냥 table 날려버리고 다시 하면 되는거 아닌가? 그런데 이미 테이블에 중요값들이 들어가 있는 경우에는 어떻게 해야할까?
-- 일단 가장 먼저 해야될 것들은..? primary key가 설정되어있어서 안됨. 그러니 얘를 수정해야겠지? constraints 를 바꿔야겠지? constraints를 바꾸는게 뭐였지?

select constraint_name, constraint_type, table_name from user_constraints where table_name = 'PRODUCT';
alter table product drop constraint  SYS_C007076;
desc product;

select * from product;
-- 된건가 지금 이게 ? primary key constraints 가 설정 되었는지 보려면?
select constraint_name, constraint_type, table_name from user_constraints where table_name = 'PRODUCT'; -- product의 테이블에는 C라는 constraint type 한개만 존재한다는 것을 알 수 있다 .본래는 P라는 primary key constraint가 있어서 2개의 제약조건이 있었음을 확인할 수 있었다.
-- 하지만 지금은 그 primary key constraints 가 사라져 있는 모습을 볼 수 있다. 이 상태는 alter table product drop constraint constraint_name; 쓴 것을 알 수 있다.
-- 전초 단계로, constraint_name 명을 알기 위해선, constraint_name, constraint_type, table_name from user_constraints where table_name='PRODUCT';를 썼었어야한다.


-- 이걸 매우 쉽고 편안하게 사용할 수 있는 방법은 무엇이 있을까? 가장 소중한 것이 시간임을 생각할 때, 시간을 낭비하는 것들은.. 굉장히... 불필요하므로 drop table product; 로 날려버릴 수도 있었지 하지만 실제 상황, 이미 많은 사람들의 정보가 가득히 들어있는 테이블이었다면? 
-- alter 명령어를 사용했었어야했다. 가장 먼저, constraints primary key로 걸려있는 놈이 어떤 놈인지를 파악해서 alter table product drop constraint 로 해당 제약조건의 이름을 보내버렸어야한다. drop 으로 보내주는 것은 똑같지만 제약조건만을 떨궈내야했다는 점에서 서로 다르다.

----------------------------------------------------------------------------
-- 테이블에 primary key를 제거했으니, 이제 값을 넣어보자! primary key를 제거하지 않으면 중복이 불가능해져 

insert into product values(1,'P_001001','새우깡');
insert into product values(1,'P_001002','양파링');
insert into product values(2,'P_002001','조스바');
insert into product values(2,'P_002002','스크류바');
insert into product values(product_seq.nextval,'P_001003','칙촉'); -- product_seq.nextval 로서, 다음 next value에 맞게 알아서 위치가 설정된다.
insert into product values(product_seq.nextval,'P_002003','수박바');
select * from product;

update product set num=4 where product_name = '조스바';
-- 셀 안의 특정 내용을 바꿔버리고 싶은 경우에는 update ?1 set ?2 where ?3 = ' ?4 ' ; 로 적으면 된다. 
-- ?1 에는, 테이블 이름을, ?2에는 바꾸고 싶은 부분을, 아 이곳에 바꾸고 싶은 부분을 적으면 된다?! 헐.. ?3 에는 어디 위치에 있는 녀석인지 조건문을 정하는 것
------------------------------------------------------------------------------
-- sequence 가 등장, NUM 이라는 숫자에 특정 숫자들이 뜨고, 언제 작성되었는지 까지 알려주는 그런 녀석! 최대값은 무엇인지 도 알려주는 그런 녀석

create sequence product_seq -- 증가값과 감소값을 사람 대신 관리해주는 명령어.
start with 5 -- 5에서 부터 시작하여
increment by 1  -- 1씩 증가할 것이다.
nomaxvalue   -- 또는 maxvalue 100으로 작성이 가능. (1씩 5부터 증가하지만, 100까지만 증가가 가능하다 라는 뜻을 입력)

nocache;

--------------------------------------------------------------
-- no cycle?
-- maxvalue 가 nomaxvalue일 때는 쓰이지 않음
-- 하지만 maxvalue를 100으로 줬다고 했을 때, 싸이클을 명시하지 않으면 자동으로 1로 돌아간다.
-- 100을 넘어가면 다시 1이됨
-- 그런데 no cycle로 해두면, 다시 1로 돌아가는게 아니라 에러를 내버림.
---------------------------------------------------------------


-- 에러란 무엇일까? 에러.. 컴퓨터가 더이상 어떻게 처리해야할지 알 수가 없는 상태를 '에러'라고 할 수 있지 않을까? 다시말해 에러가 났을 경우 이렇게 처리해달라 라는 식으로 'Exception catch'를 해줘버리면?
-- 에러는 더 이상 에러가 아닌게 된다.
----------------------------------------------------------------
-- no cache?
-- cash는 뭐지? sequence야? 번호 몇번까지 했었지? 'secquence : ~번까지 했었습니다' 라고 알려줌
-- 하드디스크에 저장되어있는 그 순번을 알려줌.

-- sequence 에다 '내가 몇번째 마지막 작업을 끝냈었지?' 이렇게 물을 때마다, 물었던 기록이 hdd에 저장됨, hdd
-- cache 기능 : 알려주는 기능?
-- caching 기능을 끄지 않으면, 총 25번까지의 번호를 이미 메모리에 올려놓고 증가하는 값처럼 말한다? 바로바로 알려준다? 만약 전원이 나가거나 비정상적 해주면.. cache 에서 다음 번호가 26번이 되버림?
-- cache를 쓰면 성능적으로는 좋으나, sequence 번호가 아예 마지막으로 파악하려고 읽어냈던 값이 + 되어 나타남. caching 기능을 살려두는게 좋은데, 가끔식 조회하는 정도라면 아예 꺼놓는게 더 이익이다?
-- caching이 하는 기능이 뭐지? sequence 번호가 정말 높아져서 ? jump 뛴다???

-- cache 란 컴퓨터 안에 있는 작은 컴퓨터다. 하는 일은 sequence로 불러낼 때 지가 나서서 hdd에 몇번째에 있는지 알려주는 기능
-- 얘가 있으면 마지막값을 잘 알려주므로 좋긴 하지만, 중간에 컴퓨터가 꺼지거나 오작동을 일으키고나면, 에러가 발생될 수 있음. 그러므로 아예 꺼주는 것이 낫다고
-- 게다가 이 sequence로 계속 조회를 해줘야하는 경우에는 뭐랄까.. 음... 
-----------------------------------------------------------------------
-- 사용하던 sequence를 버리고 싶은 경우

drop sequence product_seq;

-- 문제 풀이

create table KH_MEMBER(
    MEMBER_ID number,
    MEMBER_NAME varchar2(20),
    MEMBER_AGE number,
    MEMBER_JOIN_COM number
    );
    
-- id와 join_com은 sequence를 써서 만들어내야함. 이 두개를 어떻게 만들어야하나?

create sequence memberId_seq -- 증가값과 감소값을 사람 대신 관리해주는 명령어.
start with 500 -- 5에서 부터 시작하여
increment by 10  -- 1씩 증가할 것이다.
maxvalue 10000   -- 또는 maxvalue 100으로 작성이 가능. (1씩 5부터 증가하지만, 100까지만 증가가 가능하다 라는 뜻을 입력)
nocache;
------------------------------------------------------------
create sequence memberJoinCom_seq
start with 1
increment by 1
maxvalue 10000
nocache;
-------------------------------------------------------
drop sequence memberId_seq;
drop sequence memberJoinCom_seq;
drop table kh_member;

insert into KH_MEMBER values(memberId_seq.nextval,'홍길동',20, memberJoinCom_seq.nextval);
insert into kh_member values(memberid_seq.nextval,'김말똥',30,memberjoincom_seq.nextval);
insert into kh_member values(memberid_seq.nextval,'삼식이',40,memberjoincom_seq.nextval);
insert into kh_member values(memberid_seq.nextval,'고길똥',24,memberjoincom_seq.nextval);

select * from kh_member;
-----------------------------------------------------------------------------------------
-- 갑자기 중간값

-- increment by 를 다시 alter sequence로 간다? 음? 안된다는 것?
-- sequence는 어짜피 증가하는 녀석이라 없애든 말든 고민할 필요 없다. 그냥 두자?

----------------------------------------------------------------------------------------
-- view 객체

-- create table as 블라블라

-- link 개념으로 봐라?
-- create table department_copy as select * from department; 
-- 원본 table이 아닌 다른 table에서 사용하는 것? view?

-- copy code와 굉장히 흡사하다고? 숨기고 싶은 정보는 숨겨두고 나머지 정보만 보이도록 만들고 싶은 것?

grant create view to kh;
commit;

-- transaction 이라는 놈이 모든 놈에게 영향을 주는 것은 아님
-- truncate table; 은 transaction을 거치지 않고 db의 데이터를 직접적으로 지워버림. 더 무서운녀석;
-- transaction 인지 아닌지 먼저 보고 생각을 해봐야한다고 한다.

create view emp_view as select emp_no, emp_name, email, phone from employee; -- view라.. 다른 사용자가 한 테이블의 일부 영역을 보고 싶은 경우? 이런걸 굳이 하는 이유가 있을까? 안보이도록 만드는 건가?
--  이 구문이 create table emp_table as select emp_no, emp_name, email, phone from employee; 로 한다면 

-- ( 반드시 SystemConnection 으로 바꿔줘야함 )
select * from emp_view;

select * from kh.emp_view; 
grant select on employee to test; -- 이걸 kh employee 에서 해줘야 가능해진다. 그런데 kh.employee라고 해서는 안되고, 
commit;

grant create view to test; -- view라는건 제한된 기능만 부여하고자 할때, 이런 식으로 볼 수 있는 것이다?
commit;

select * from employee;
update employee set emp_name = '조정석' where emp_id = 200;


rollback;

-- kh가 view를 만든다?

update employee set emp_name = '조정팔' where emp_id = 200;

-- test 계정이 뷰에서 대표의 이름을 '조정팔' 로 변경하고
-- kh계정에서 employee 테이블을 조회하여 변경된 것을 확인하세요.


create view emp_view as select emp_no, emp_name, email, phone from kh.employee; 
select * from emp_view;

---------------
-- kh.connection 에 grant 해준 상태 
grant update on kh.emp_view to test; -- 1 system에서 주는게 아니라 kh에서 줬으므로 안됐었음, DBL resouce 권한
commit; -- 2  : 권한을 주려는 놈도 commit 을 때려야 실질적으로 db에 값을 제공해줄 수 있다.

-- 2.5  test로 이동

update kh.emp_view set emp_name = '조정팔' where emp_name = '조정석'; -- 3

delete from emp_view where emp_name='조정팔';

-- select * from user_views; 해당 데이터 베이스에 존재하는 user가 갖고 있는 view들이 무엇인지 알게 해준다.


----------------
grant delete on kh.emp_view to test;
commit;
-- 이동
select * from emp_view;
delete from kh.emp_view where emp_name='조정팔';
----------------
select * from emp_view;

desc emp_view;
------
-- grant 역시 commit을 해줘야한다? 

---------------------------------------------------------------------------
-- Index 라는 놈?
-- 뭔가 겉으로 드러나는 애는 아니다. 
-- 대신에 성능과 관련된 아이다.
-- select quary가 만약 엄청 거대한 녀석이면? 
-- 빅데이터가 있는 DB들은 불러오는 시간이 굉장히 오래 걸린다. 

-- Index의 단점 
-- Index를 남발하면 추가적인 저장공간을 소모시킨다. 
-- 실제 갖고 있는 데이터에 따라서 지속적으로 변경된다.
-- Index 알고리즘도 수시로 막 변경된다.
-- 그래서, 수시로 변하는 column 에 값을 넣으면 성능이 되려 떨어진다고
-- 그렇기에 데이터 변동이 적은 column에 index를 써주는 것이 적절하다.
-- unique, primary key 같은 column들에 적용하는 것이 좋다.

-- 데이터의 변경작업 (insert / update / delete)  < - 얘는 뭔뜻

-- Index를 사용할 때의 장점
-- 적절한 상황에 적용했을 시 검색 속도를 높힐 수 있다.

-- Index의 효율적인 적용 상황
-- 한 테이블 내에 데이터가 대량 일 경우
-- 중복되지 않으면서 수정이 자주 일어나지 않는 테이블( 한번 입력된 데이터가 자주 변경되지 않는 테이블 ( unique / primary key ))

-- index가 있는 primary key를 해주면 검색성능이 가장 좋다 왜? primary key는 자동으로 index값을 형성하므로(이미 있으므로)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from user_ind_columns; -- Data Dictionary 의 종류로서 user_ind_columns , index가 적용되어 있는 columns 들이 무엇인지 파악하는 명령어
-- 음 그래서 어떻게 써야하는거지? 언제 써야하는거지? 왜 써야하는거지? 


------------------------------------------------------------------
-- index 만들어보기
create index emp_index on employee ( emp_name );
commit;

-- 이게 전부라고... 그저 속도 향상을 위한 방법인듯?
--------------------------------------------------------------------
-- synonym : 동의어

-- 길게 표현되는 것을 동의어로 설정해서 간단히 사용하는 것 : object, 객체로서 봐야한다. 
-- employee e 처럼, e를 줄여서, 마치 자바의 변수선언 하는 것처럼 값을 축약시켜 사용하는 방법을 synonym을 위함. dba의 편의성을 높히기 위함인 듯

create synonym emp for employee; -- emp라는 synonym을 만들겠다. 왜 ? employee라는 테이블명은 너무 기니까(권한 주어야한다 SystemConnection으로 부터 받음)

grant create synonym to kh; -- kh에게 synonym 만들 수 있는 권한을 준다 from SystemConnection
commit; -- kh에서 커밋 때리자.

create synonym emp for employee;
select * from user_synonyms;

select * from kh.emp; -- 이걸 test에서 볼 수 있는건, 권한이 있기 때문인건가? 무슨 권한이 있기 때문인거지? view 권한이 있어서 인건가?

---

revoke select on kh.employee from test;
commit;

-- 권한이 허용하는 안에서만 동의어기능(synonym을 사용할 수 있다.) -- 여기서는 select 기능을 말하는건가/ 아예 select 가 막혀버리면, 볼 수조차 없다. 뭐 어찌보면 너무 간단하고 당연한이야기

select * from kh.emp;
-------------------------------------------------------------------
-- unique 는 null 값을 허용한다. not null은.. null 값을 허용하지 않음, 다시말해 이 두가지 기능을 한 column에 모두 쓰면, primary key처럼 적용한다.

-- 종합문제










--------------------------------------------------------------------


-- 중요한 것? Test는 ? view를 볼 수 있는 권한이 없다.
-- kh가 grant를 해주는 것.
-- resource라고 하는 권한은 모든 권한을 갖는다. grant까지 가능함.
-- test에게 emp_view 를 select 하는 권한을 줌 grant select to test;
-- 원본테이블과 view라는 건 연결되어있다?
-- test가 employee는 못건드리지만 view는 볼 수 있으므로 test를 통해 emp_view 에 있는 조정석을 바꿔라

---------------------------------------------------------------------------
-- ## 느낀점
-- 글을 이렇게 써가면서 작성해야 무얼 하는지 ,어디에 적용시키라는 말인지, 파악이 가능하다. 그래서일까 정치인들이 서로 100분토론 반박에 나왔을 때, 서로의 말을 메모해가며 쓴다는 것을...
-- 나는 말로 해야하는건가? 아니 글로서 생각하는 것이 훨씬 내게 맞다. 머릿속이 어지럽지 않고 이해가 된다. 아예 머리만으로 생각하는 비율을 10%이하로 줄여버려야지. 글을 써가며 생각하는게 90%가 될때 뭔가 더 탁월해진다.
-- 강사님의 말도 더 따라갈 수 있고 부족함이 느껴지지 않는다.

-- 강사님의 말을 이해하는대로 타이핑 해가면서 듣다보면 확실히 이해가 빠르다.
-- 뭘 위주로 타이핑해나가야하나? 강사님이 하는 말을 내가 이해하는대로 차근차근 써나가다보면 내 의식이 끊기지 않고 강사님의 말을 좇는다.
-- 이렇게 써가면서 하다보면 ,이해가 잘되니, 어떤 문제들이 오던 이해 안되는 부분 없이 해결해낼 수 있을 것 같다.


-- 개발자 분들이 모든 명령어를 다 이해하시는건가요 아니면 외워서 하시는건가요 아니면

-- 궁금증 1. 나중에 자바를 활용하면 정말 버튼을 누르면 gettext 가 alter table member add ( string1, string2, num2 ) 이런식으로 연계되어 나가는건가? 아까 try-catch문을 통해 rollback 옵션을 줬던 것처럼?
-- 2. 얘네를 어떻게 다 소화시켜야하는거지? 마인드맵을 써야하는걸까? 오늘 배운건 좀 양이 많네... 으아

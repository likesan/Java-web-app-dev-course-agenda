-- 10일차

drop table member;

/* 

1. member table 생성하라

seq 숫자 비워둘 수 없음
id 문자 20 주키 설정
pw 문자20 비워둘 수 없음
name 문자 20 비워둘 수 없음
gender 문자 3 - '남'또는 '여'만 저장가능
address 문자 200 비워둘 수 없음
regdate date 비워둘 수 없음

2. sequence [member_seq]

1부터 무한대까지 1씩 
nocache





*/
drop table member;

create table member(
    seq number not null,
    id varchar(20) primary key,
    pw varchar(20) not null,
    name varchar(20) not null,
    gender varchar(3) check (gender in ('남', '여')),
    address varchar(200) not null,
    regdate date not null
);

drop sequence member_seq;

create sequence member_seq
start with 1
increment by 1
nomaxvalue
nocache;

select * from member;

select seq from member;

alter table member add constraint unique (name);

ALTER TABLE member ADD UNIQUE (name);

desc member;

select constraint_name, constraint_type, table_name from user_constraints where table_name = 'MEMBER';


select id,pw from member;
--------------------------------------------------------------------------------------------------------------table seller 

create table seller(
    seq number not null,
    id varchar(20) primary key
);

create sequence seller_seq
start with 1
increment by 1
nomaxvalue
nocache;

insert into seller values(seller_seq.nextval, 'omgeeee');
insert into seller values(seller_seq.nextval,'longsim');
insert into seller values(seller_seq.nextval,'onion');

insert into seller values(seller_seq.nextval,'samsong');

insert into seller values(seller_seq.nextval,'rg');


select * from seller;

drop table seller;

commit;

------------------------------------------------------------------------- product table 생성

drop table product;

create table product(
pid number primary key,
seller_id varchar(20) REFERENCES seller(id),
pname varchar(20) not null,
price number not null
);

drop sequence product_seq;

create sequence product_seq
start with 1
increment by 1
nomaxvalue
nocache;


insert into product values(product_seq.nextval,'longsim','새우깡',1000);
insert into product values(product_seq.nextval,'onion','고래밥',1500);
insert into product values(product_seq.nextval,'samsong','스마트폰',600000);
insert into product values(product_seq.nextval,'rg','그람노트북',1400000);

select * from product;


--------------------------------------------------------------------------------- purchase list 생성

create table purchase_list (
purchase_no number primary key,
id varchar(20) references member(id),
pid number references product(pid),
seller_id varchar(20) references seller(id),
pname varchar(20) not null,
price number default 0
);

create sequence purchase_seq
start with 1
increment by 1
nomaxvalue
nocache;



insert into purchase_list values(purchase_seq.nextval,?,?,?,?,?);
insert into purchase_list values(purchase_seq.nextval,'test',1,'rondo','macbook',2000000);


select * from purchase_list;
select * from product;
/* 
0 purchase_seq.nextval
setString 1, member ID : 구매자이름 -- 얘는 어디서 뽑아오지? memberlist? 로그인 한 사람의 이름에서 출력해와야하나? 그게 맞겠지? 로그인을 어디서 했지?
setString 2, product ID : 물품고유번호
setString 3, seller ID : 판매자 고유번호 - 얘는 뭐지?
setString 4, pname : 물품이름
setString 5, price : 가격
*/

create table delivery_list(
    seq number primary key,
    pId number references product(pid),
    -------------------------------------------------------------------------------------------------
    productName varchar(20) not null, -- 얘 reference를 지우니까 된다. 이유가 뭐지? 강사님한테 질문해야할 사항 인 듯
    -------------------------------------------------------------------------------------------------
    seller varchar(20) references seller(id),
    buyer varchar(20) references member(id)
);

create sequence delivery_seq
start with 1
increment by 1
nomaxvalue
nocache;

select * from product;
select * from delivery_list;

select * from member;
-- 이제 여기다 값을 넣어야지 insert문을 써서? 그러려면 connection 후에 executeUpdate로 넣어야지

insert into delivery_list values (delivery_seq.nextval, 1 , 'macbook' , 'rondo' , 'test');
insert into delivery_list values (delivery_seq.nextval, 5 , 'ginobili' , 'iphoneX' , '1234');

desc product;

commit;

drop table delivery_list;

desc ALL_CONS_COLUMNS;


desc product;

select column_name from all_cons_columns;

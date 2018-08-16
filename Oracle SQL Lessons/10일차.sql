-- 10����

drop table member;

/* 

1. member table �����϶�

seq ���� ����� �� ����
id ���� 20 ��Ű ����
pw ����20 ����� �� ����
name ���� 20 ����� �� ����
gender ���� 3 - '��'�Ǵ� '��'�� ���尡��
address ���� 200 ����� �� ����
regdate date ����� �� ����

2. sequence [member_seq]

1���� ���Ѵ���� 1�� 
nocache





*/
drop table member;

create table member(
    seq number not null,
    id varchar(20) primary key,
    pw varchar(20) not null,
    name varchar(20) not null,
    gender varchar(3) check (gender in ('��', '��')),
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

------------------------------------------------------------------------- product table ����

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


insert into product values(product_seq.nextval,'longsim','�����',1000);
insert into product values(product_seq.nextval,'onion','����',1500);
insert into product values(product_seq.nextval,'samsong','����Ʈ��',600000);
insert into product values(product_seq.nextval,'rg','�׶���Ʈ��',1400000);

select * from product;


--------------------------------------------------------------------------------- purchase list ����

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
setString 1, member ID : �������̸� -- ��� ��� �̾ƿ���? memberlist? �α��� �� ����� �̸����� ����ؿ;��ϳ�? �װ� �°���? �α����� ��� ����?
setString 2, product ID : ��ǰ������ȣ
setString 3, seller ID : �Ǹ��� ������ȣ - ��� ����?
setString 4, pname : ��ǰ�̸�
setString 5, price : ����
*/

create table delivery_list(
    seq number primary key,
    pId number references product(pid),
    -------------------------------------------------------------------------------------------------
    productName varchar(20) not null, -- �� reference�� ����ϱ� �ȴ�. ������ ����? ��������� �����ؾ��� ���� �� ��
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
-- ���� ����� ���� �־���� insert���� �Ἥ? �׷����� connection �Ŀ� executeUpdate�� �־����

insert into delivery_list values (delivery_seq.nextval, 1 , 'macbook' , 'rondo' , 'test');
insert into delivery_list values (delivery_seq.nextval, 5 , 'ginobili' , 'iphoneX' , '1234');

desc product;

commit;

drop table delivery_list;

desc ALL_CONS_COLUMNS;


desc product;

select column_name from all_cons_columns;

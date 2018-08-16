-- DQL�� ���ƴ�.

-- DML > insert / update / delete
-- DML > DQL > select

-- DDL > create  / alter / drop

-------------------------------------------------------------------------------

-- alter : ���� ( ��? ���̺��� column �� �߰� / ���� ,  �������� �߰�/ ���� ) 
-- ������ ���� column �� ������ ��� ������ �� �ִ� �������� �޽� = alter
--( ���α׷� ������ ���ؼ��� �� �˱� �˾ƾ��Ѵٰ� �ϴµ�... ��.. ���������� ���� ���ϴ� ���� ������� �� �������� �˾ƾ��ϴ� �κ� �ƴұ�?)


-- oracle�� ���ǵ� ��ü�� ������ ������ �� ����ϴ� Quary
-- ���̺� �÷� �߰� / ���� , ���������� �߰� / ����
-- ���̺� �÷� �ڷ����� ���� / �̸� ���� ��

-- update : �����͸� ���� ( column �� �� field �� )
-- alter : ��ü�� ���� ( ���̺� ��ü )

desc member; -- member ���̺��� ���� �Ǿ� �ִ��� ���� Ȯ��
drop table member; -- ������ �����

create table member(
    userNo number primary key,
    userId varchar(20),
    userPwd varchar(20)
);

select * from member;

insert into member values (55,'1001','1024');

--------------------------------------------------------------------------------
-- column�� �߰��غ���. 
alter table member add (userName varchar(20)); -- userName �ִ� �� �����ϰ� ���̺��� ������ٸ�, ������ ���� userName column�� �־��� �� �ִ�.
desc member;

alter table member add (userIP varchar(20));
alter table member add (userGender varchar(5));
---
alter table member add (userAge varchar(10) default 0 ); -- default �� 0�� ���� �� �� �ִ�.

-- �ٽ� userAge�� �ڷ����� �ٲ㺸��. varchar > number������ -- �ڷ����� �ٲ� �� �ִ� alter
alter table member modify (userAge number default 0);
alter table member modify (userIP varchar(15) default '000,000,000'); -- ��.. � ���·� �ؾ� default ���� number �ڷ��� ������ 000,000,000 ���·� �ٲ� �� ������?
alter table member modify (userGender char(10) default '�̱���');
---

-- column�� �̸��� �ٲ㺸��
alter table member rename column userpwd to password; -- �������� ���� �״�� �����ؼ� ����ϴ� :)
alter table member rename column userIP to userHostAdr;
alter table member rename column userGender to userSex;

-- ���տ� �ִ°� �߿��ϴ�. ���� ���տ� �ִ� �͵���� ��ġ������

alter table member drop (userAge); -- member��� column �ϳ��� �ƿ� ���ֹ��� �� �ִ�.
alter table member drop (userIp);

------------------------------------------------------------------------------------------------
-- ���̺��� �������ǿ� ���� �˾ƺ��� (unique , primary key ���)

-- userid column �� unique �Ӽ��� �߰��غ���.

alter table member add unique (userId); -- unique �Ӽ����� �ٲ�� �ߺ��� ���� ���� �� ������ ������.

-- unique �� ������ Ȯ�εƴ��� �˾Ƴ��� ���? 
-- �����ϱ� �ռ�..

-- Data Dictionary : Oracle �� �⺻������ ������ �ִ� ���� ���̺� 
-- ���� 3����
-- DBA_ : Database �ý��� ���� ���� �ְ� �����ڰ� �����ϴ� ���� �� �����ϴ� ��ü ���� ���� ����ϴ� ���̺�
-- ALL_ : ���� ������ ������� ���� �� ��ü ������ ������ ������ �ִ� �ٸ� ���� �������� �����ϴ� ���̺�
-- USER_ : �ش� ������ ������ ����ڵ��� ���� �� ��ü ������ ����ϴ� ���̺� -- ������ ����
-- ���� �ּ� : https://docs.oracle.com/cd/B10501_01/server.920/a96524/c05dicti.htm
-- �ְ� �����İ� �߿�

select table_name  from user_tables;

select constraint_name, constraint_type, table_name from user_constraints where table_name = 'MEMBER'; -- member�� �빮�ڷθ� �����ؾ��Ѵ�
-- U : unique , P : primary key

-- ��� ���������� ����� �ʹٸ�, CONSTRAINTS_TYPE�� drop���� ���� �� �ִ�. ������ alter�� ����°� �� ���� ���?

alter table member drop constraint SYS_C007067; -- CONSTRAINTS_NAME �� SYS_C007067�̶�� �ָ� ��������, CONSTRAINTS_NAME ���� �Է��ؾ߸� �ϴ� ��.
alter table member drop constraint SYS_C007068;

----------------------------------------------------------------------------------------------------------------------------------------------------------------

alter table member add constraint userName_uniq unique (userName);


--username_uniq �����ϱ�
alter table member drop constraint username_uniq;

--Ȯ���ϱ�
select constraint_name, constraint_type, table_name from user_constraints where table_name = 'MEMBER';


---------------------------------------------------------------------------------------------------------------------------------------------------------------
-- alter�� constraints ���� �ɼǵ� �������� �� �ְ� column�� �ڷ��� ���� �������� �� �ִٰ�.
-- ���� �����ڰ� database �������� ���δ� �ٷ��� ������, dba�� �������� �ʴ´ٸ� �����ڰ� �� ���� �������.
-- �̷μ� DDL �� : Data Definition Language, ���� ���� �Է�?


-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DCL ( Data Control Langauge ) : DB�� ���� ���� ����, ����, ���Ἲ, ���� ��� DB �����ϱ� ���� Quary
-- (���Ἲ?)
-- TCL ( Transaction Control Langauge ) : DBA �� ������ �����̱� �ϳ�, ������Ʈ�� ���� �˾ƾ��ϴ� �κ�, ��â�� ������ �츮�� ���� ���Ե� �κ��̶��
-- Transaction : �ְų� �ްų� ���� ��ȯ�ϴ� �����̳� ����, ����Ͻ�

-- Grant / revoke / (commit / rollback / savepoint : TCL )


-- khConnection �� resource �� ��¼�� �ۿ� ���, systemConnection ���� �ٲ�����Ѵ�. ������ ������ ��� ���ؼ�.

create user test identified by test; 
-- identified by?

----------------------

-- grant ���� ���� : ? = ( insert / delete / select / connect : �� ���� ���۵��� �ο����ָ� �ȴ�. ) grant ? to test;
grant connect to test; -- ���� ���Ѹ� ���� test��

-- select ���ѵ� �ຸ��
grant select on kh.employee to test;

-- kh.department �� select / insert ���� �ֱ�
grant select on kh.department to test;
grant insert on kh.department to test;

-- delete ���� �ຸ��
grant delete on kh.department to test;

-- revoke�� �غ���?
revoke insert on kh.department from test; -- revoke �ִ� ������ ���� ��. grant ~ to �� �ƴ϶� revoke from �̴�. ������ ���´� ~�κ��� ��� ���� �ǹǷ�

-- ������ ���ѵ� �ຸ�� : ����, ���� ��� ��� �͵��� �� �� �ֱ� ������ �ſ� �����ؾ��ϴ� ����
grant dba to test;
---------------------

-- DCL > TCL : Transaction Control Langauge

-- Transaction : �� �̻� �������� �ʴ� ���ڼ��� �ֱ� �����̴�? �Ѳ����� ����Ǿ�� �� �ּ��� �۾� ������ �ǹ��Ѵ�?

-- [������]? ���� ������? ����� �� �ִ�. �߸� ������ 
-- Ŀ�ǵ带 ������ ��, transaction�� ������  ������ db ��ġ�� ���� ���Ѵ�. ��? db�� ���� �������� �ʴ°ɱ�? - ������ ����
-- ���÷� delete �����غ���. delete from employee; ���¸� ���� ������� > �����ϰ� where���� ���� ���ϰ� enter�� �������ȴ�! �׷��� ��� table�� ������ �����
-- ������ transaction cancel ��ɾ ����ϸ�, ������ �����ϴ�. ������ �־��� ��ɾ ���� �����ϴ�.
-- ������ commit ��ɾ �����ݷ�; �� ����ϸ�, transaction�� ����Ǿ��� ��� ��ɾ '����ȴ�.'
-- rollback : commit �� ��ɾ �ڷ� ���� �� �ִ�. ������ �� �ִ�.
-- savepoint 3�� ����� ��׸� ������� ,5�� ����� �ֵ� -- Ÿ�̹��� ���س��� rollback �̶�� �� �� �߰������� ����

-- [���ڼ�]? ���̻� �ɰ��� �� ���� ����
-- transaction�� ���� ������, ���������� �ִ°� �ƴϴ�
-- �������̺�, ���� ������ ������ ���, ���� ��ü�� �̰� ���� �� �̰� ���� ����� ���� �� �ֵ��� ����, ���� Ȯ���� �� ����
-- �� ���̺��� ��� �� ������ �ԷµǴ� ��, �� �߿� �ϳ��� ������ �����̶���� ������ �ۼ��� ���� ������ �߻����� �ʵ���, �ƿ� �� �۾������� ���������� ��
-- ���߿� ���θ��� ����� ������ ���� ��ü�� �����ؾ��� ��� ����ؾߵǴ� �κ�.

----------------------------------------------------------------------------
-- ���� �غ���! -- commit / roll back

delete from person;
desc person;
insert into person values( 1001,'JACK',50); -- �� ���� �� �Է� -- ���� ���� X : transaction�� �����ִ� ����.
select * from person; -- �̷��� �� �Ŷ�� �׳� ������� �˷��ִ� ��Ȳ
commit; -- �� ������ �ݿ�����! ������ insert into person values(1001,'JACK',50) �� db�� ������ �ǹ����� ����� ��ɾ�

insert into person values (1002,'JANE',25); -- ���� DB�� ����Ȱ��� ���� transaction�� �ӹ����� �ִ��� �ľǽ����ִ� ��ɾ�� ������? 
select * from person;
rollback; -- transaction�� �����ִ� ������ �ݿ����� �ʰڴ�. öȸ�ϰڴ�. -- ����� '�ѹ� �Ϸ�' ��

select * from person; --�ٽ� Ȯ���� �غ��� insert into person values (1002,'JANE',25); �� �ȵǾ��ִ� ����� �ľ��� �� �ִ�!~!

-- �� �̷� ������ �߻��ϴ°�? rollback�Ѵٰ� commit �Ȱ� �Ǵ°� �ƴ�, transaction�� �Ǿ��ִ� �� öȸ�ϴ� ���̴�. �̹� db�� ����� �ֵ��� rollback���ε� öȸ�� �ȵȴ�. �̹� admit �ߴٸ� �ʾ���.

-------------------------------------------------------------------------------------------------
insert into person values(1001, 'JACK', 50); -- ��������
insert into person values(1001, 'JACK', 25); --  ������� ��� �����غ���

-- �߰��� ��������� ���޵Ǵ� ���� �ȿ���, ������ ���ٸ�? 

-- �̷� ������ �ذ��ϱ� ���ؼ� try-catch ������ ����ϸ� �ȴ�.


-- ����----------------------------------------------------------------------------------------
--try {
--insert into person values(1001, 'JACK', 50); -- �������� : transaction���� ���۵Ǵ� ��Ȳ, ���� db�� ���������� ������ �Ͼ�� �ʾ���
--insert into person values(1001, 'JACK', 25); -- ������� :  ���� �� ���ο��� ������ ���ٸ�, commit �Ǳ� ���� catch �������� �̵��ȴ�. �� �� rollback�� �Ͼ, ���������� db�� ���� �� ���� �� �ִ�. �����ڰ� ������ ������ �Ѿ��� ��ٸ��� �� ��Ȳ�� �ִ��� ������ �� �ִ�.
--commit;
--}
--catch(Exception e){
--rollback;
--}
-------------------------------------------------------------------------------------------------
-- savepoint 

insert into person values(1001, 'JACK', 50); -- �������� : transaction���� ���۵Ǵ� ��Ȳ, ���� db�� ���������� ������ �Ͼ�� �ʾ���
insert into person values(1001, 'JACK', 25); -- ������� :  ���� �� ���ο��� ������ ���ٸ�, commit �Ǳ� ���� catch �������� �̵��ȴ�. �� �� rollback�� �Ͼ, ���������� db�� ���� �� ���� �� �ִ�. �����ڰ� ������ ������ �Ѿ��� ��ٸ��� �� ��Ȳ�� �ִ��� ������ �� �ִ�.
commit;

select * from  person;


savepoint beforeDelete; -- �� �ڸ��� savepoint�� �ȴ�? (�� ������ commit�� �����ϴ� �ڸ��� �ٷ� savepoint�� �ȴ�. ) 


delete from person; -- ������. person table�� ������, �ƹ��� ���뵵 �� �ȿ� �������� �ʾƺ��δ�.

select * from person; -- Ȯ��; ���� Ȯ���غ��� ������ִ�.

rollback to beforeDelete; -- ������ rollback�� ȣ���Ͽ� 'beforeDelete'�� ����ϸ�, savepoint �� �Ǿ�, delete�� ���Ǿ��� ���� �������� �̵��ϰ� ������ش�.

-- savepoint �� ���� : ���� ���ϴ� �������� rollback�� �����ϰ� ����. �߿��� ������ ���� ������ ����ϰ� �ȴٰ�, �׷��� rollback�� ���ٸ�, ���� ���� �ֱٿ� commit �� ��Ұ� ����� ����ġ�� ã�Ƴ�����. �ǵ��ư� �� �ִ� ������ ã�Ƴ��� ���ش�. ���ϰ� ���ش�. ���Ұ��� �����̴�. ���ư� �� �ִ� ����Ʈ�� �������شٴ� ������.

-- dba �� ���� ��ߵǴ� ����̱⿡ �׵��� ���� ������, �����ڴ� ...? �������� commit ������ ��� ���α׷��� �ϼ��Ǿ��� �� ��, �ƿ� �ڵ��� �� �߸��Ǿ� ���α׷��� ����ٴ� �� ��ü�� �Ұ����ϴ�. �ֳ��ϸ� �ڵ� ������ �߸� �Ǿ���� �ƿ� ���α׷��� ��������� �� ��ü�� �Ұ����ϱ⶧���� ~  

----------------------------------------------------------------------- ���� ���� �� 

-- ���� ���� ����
-- �츮�� TCL�� ������! ���߿� �� ������ �� �� ���δٰ��Ѵ�~~~~ DDL DML DCL �� ���´�~~~
-- DB ���� �����ϴ� ��ü(object), ��𿡳� �����ϴ� ���� ��ä���� �ִٰ� �Ѵ�.
-- ���尴ü  ������ ���� ���� �͵� �ȿ� �̷� ���尴ü�� ���ٰ�, Android web ��¼�� ~~

------------------------------------------------------------------------
-- SEQUENCE , VIEW 

-- SEQUENCE ���� ��ȣ�� �ٴ´�?
-- row �ϳ��ϳ� ���� ��ȣ�� �ٿ����� ���� ����. �ֳĸ� ���� ������ ��ߵ� �� �𸣱� ����
-- insert ���� ����, ������ © ��, insert ù��° �����ʹ� 1�̶� ����. �ι�°�� 2���, ����°�� 3. ���ڸ� ����ؼ� ������Ŵ rank() over()
-- ������ ��ȣ�� ������� ����Ǵ��� �� �� ������ 380������ �ȴ� ġ��, �ٸ����� �������� ġ��, �׸��� �Ѵ����� ������������, ����� �ȳ�, ���°�� ������
-- database administrator �� ���� �Ű� �� �ʿ����, ���°�� ������ ����ϰ� ����� ��ɾ� = Sequence




create table product (
    num number,
    product_id varchar(10) primary key,
    product_name varchar(50) not null
    -- ��ǰ�� ��� ������ ����Ϸ� �Ѵ� ���� �ؾ��ϳ�? sequence ��� column �̸��� �־���� = �̳��� sequnce �ε�
    );

insert into product values(1, 1001 , '��');

alter table product modify( product_id varchar(10) primary key);

-- ���۽��� ����, ������ ���� �� �׷��� �ؾ��ϳ�? �׳� table ���������� �ٽ� �ϸ� �Ǵ°� �ƴѰ�? �׷��� �̹� ���̺� �߿䰪���� �� �ִ� ��쿡�� ��� �ؾ��ұ�?
-- �ϴ� ���� ���� �ؾߵ� �͵���..? primary key�� �����Ǿ��־ �ȵ�. �׷��� �긦 �����ؾ߰���? constraints �� �ٲ�߰���? constraints�� �ٲٴ°� ������?

select constraint_name, constraint_type, table_name from user_constraints where table_name = 'PRODUCT';
alter table product drop constraint  SYS_C007076;
desc product;

select * from product;
-- �Ȱǰ� ���� �̰� ? primary key constraints �� ���� �Ǿ����� ������?
select constraint_name, constraint_type, table_name from user_constraints where table_name = 'PRODUCT'; -- product�� ���̺��� C��� constraint type �Ѱ��� �����Ѵٴ� ���� �� �� �ִ� .������ P��� primary key constraint�� �־ 2���� ���������� �־����� Ȯ���� �� �־���.
-- ������ ������ �� primary key constraints �� ����� �ִ� ����� �� �� �ִ�. �� ���´� alter table product drop constraint constraint_name; �� ���� �� �� �ִ�.
-- ���� �ܰ��, constraint_name ���� �˱� ���ؼ�, constraint_name, constraint_type, table_name from user_constraints where table_name='PRODUCT';�� �������Ѵ�.


-- �̰� �ſ� ���� ����ϰ� ����� �� �ִ� ����� ������ ������? ���� ������ ���� �ð����� ������ ��, �ð��� �����ϴ� �͵���.. ������... ���ʿ��ϹǷ� drop table product; �� �������� ���� �־��� ������ ���� ��Ȳ, �̹� ���� ������� ������ ������ ����ִ� ���̺��̾��ٸ�? 
-- alter ��ɾ ����߾�����ߴ�. ���� ����, constraints primary key�� �ɷ��ִ� ���� � �������� �ľ��ؼ� alter table product drop constraint �� �ش� ���������� �̸��� �������Ⱦ���Ѵ�. drop ���� �����ִ� ���� �Ȱ����� �������Ǹ��� ���ų����ߴٴ� ������ ���� �ٸ���.

----------------------------------------------------------------------------
-- ���̺� primary key�� ����������, ���� ���� �־��! primary key�� �������� ������ �ߺ��� �Ұ������� 

insert into product values(1,'P_001001','�����');
insert into product values(1,'P_001002','���ĸ�');
insert into product values(2,'P_002001','������');
insert into product values(2,'P_002002','��ũ����');
insert into product values(product_seq.nextval,'P_001003','Ģ��'); -- product_seq.nextval �μ�, ���� next value�� �°� �˾Ƽ� ��ġ�� �����ȴ�.
insert into product values(product_seq.nextval,'P_002003','���ڹ�');
select * from product;

update product set num=4 where product_name = '������';
-- �� ���� Ư�� ������ �ٲ������ ���� ��쿡�� update ?1 set ?2 where ?3 = ' ?4 ' ; �� ������ �ȴ�. 
-- ?1 ����, ���̺� �̸���, ?2���� �ٲٰ� ���� �κ���, �� �̰��� �ٲٰ� ���� �κ��� ������ �ȴ�?! ��.. ?3 ���� ��� ��ġ�� �ִ� �༮���� ���ǹ��� ���ϴ� ��
------------------------------------------------------------------------------
-- sequence �� ����, NUM �̶�� ���ڿ� Ư�� ���ڵ��� �߰�, ���� �ۼ��Ǿ����� ���� �˷��ִ� �׷� �༮! �ִ밪�� �������� �� �˷��ִ� �׷� �༮

create sequence product_seq -- �������� ���Ұ��� ��� ��� �������ִ� ��ɾ�.
start with 5 -- 5���� ���� �����Ͽ�
increment by 1  -- 1�� ������ ���̴�.
nomaxvalue   -- �Ǵ� maxvalue 100���� �ۼ��� ����. (1�� 5���� ����������, 100������ ������ �����ϴ� ��� ���� �Է�)

nocache;

--------------------------------------------------------------
-- no cycle?
-- maxvalue �� nomaxvalue�� ���� ������ ����
-- ������ maxvalue�� 100���� ��ٰ� ���� ��, ����Ŭ�� ������� ������ �ڵ����� 1�� ���ư���.
-- 100�� �Ѿ�� �ٽ� 1�̵�
-- �׷��� no cycle�� �صθ�, �ٽ� 1�� ���ư��°� �ƴ϶� ������ ������.
---------------------------------------------------------------


-- ������ �����ϱ�? ����.. ��ǻ�Ͱ� ���̻� ��� ó���ؾ����� �� ���� ���� ���¸� '����'��� �� �� ���� ������? �ٽø��� ������ ���� ��� �̷��� ó���ش޶� ��� ������ 'Exception catch'�� ���������?
-- ������ �� �̻� ������ �ƴѰ� �ȴ�.
----------------------------------------------------------------
-- no cache?
-- cash�� ����? sequence��? ��ȣ ������� �߾���? 'secquence : ~������ �߾����ϴ�' ��� �˷���
-- �ϵ��ũ�� ����Ǿ��ִ� �� ������ �˷���.

-- sequence ���� '���� ���° ������ �۾��� ���¾���?' �̷��� ���� ������, ������ ����� hdd�� �����, hdd
-- cache ��� : �˷��ִ� ���?
-- caching ����� ���� ������, �� 25�������� ��ȣ�� �̹� �޸𸮿� �÷����� �����ϴ� ��ó�� ���Ѵ�? �ٷιٷ� �˷��ش�? ���� ������ �����ų� �������� ���ָ�.. cache ���� ���� ��ȣ�� 26���� �ǹ���?
-- cache�� ���� ���������δ� ������, sequence ��ȣ�� �ƿ� ���������� �ľ��Ϸ��� �о�´� ���� + �Ǿ� ��Ÿ��. caching ����� ����δ°� ������, ������ ��ȸ�ϴ� ������� �ƿ� �����°� �� �����̴�?
-- caching�� �ϴ� ����� ����? sequence ��ȣ�� ���� �������� ? jump �ڴ�???

-- cache �� ��ǻ�� �ȿ� �ִ� ���� ��ǻ�ʹ�. �ϴ� ���� sequence�� �ҷ��� �� ���� ������ hdd�� ���°�� �ִ��� �˷��ִ� ���
-- �갡 ������ ���������� �� �˷��ֹǷ� ���� ������, �߰��� ��ǻ�Ͱ� �����ų� ���۵��� ����Ű����, ������ �߻��� �� ����. �׷��Ƿ� �ƿ� ���ִ� ���� ���ٰ�
-- �Դٰ� �� sequence�� ��� ��ȸ�� ������ϴ� ��쿡�� ������.. ��... 
-----------------------------------------------------------------------
-- ����ϴ� sequence�� ������ ���� ���

drop sequence product_seq;

-- ���� Ǯ��

create table KH_MEMBER(
    MEMBER_ID number,
    MEMBER_NAME varchar2(20),
    MEMBER_AGE number,
    MEMBER_JOIN_COM number
    );
    
-- id�� join_com�� sequence�� �Ἥ ��������. �� �ΰ��� ��� �������ϳ�?

create sequence memberId_seq -- �������� ���Ұ��� ��� ��� �������ִ� ��ɾ�.
start with 500 -- 5���� ���� �����Ͽ�
increment by 10  -- 1�� ������ ���̴�.
maxvalue 10000   -- �Ǵ� maxvalue 100���� �ۼ��� ����. (1�� 5���� ����������, 100������ ������ �����ϴ� ��� ���� �Է�)
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

insert into KH_MEMBER values(memberId_seq.nextval,'ȫ�浿',20, memberJoinCom_seq.nextval);
insert into kh_member values(memberid_seq.nextval,'�踻��',30,memberjoincom_seq.nextval);
insert into kh_member values(memberid_seq.nextval,'�����',40,memberjoincom_seq.nextval);
insert into kh_member values(memberid_seq.nextval,'����',24,memberjoincom_seq.nextval);

select * from kh_member;
-----------------------------------------------------------------------------------------
-- ���ڱ� �߰���

-- increment by �� �ٽ� alter sequence�� ����? ��? �ȵȴٴ� ��?
-- sequence�� ��¥�� �����ϴ� �༮�̶� ���ֵ� ���� ����� �ʿ� ����. �׳� ����?

----------------------------------------------------------------------------------------
-- view ��ü

-- create table as �����

-- link �������� ����?
-- create table department_copy as select * from department; 
-- ���� table�� �ƴ� �ٸ� table���� ����ϴ� ��? view?

-- copy code�� ������ ����ϴٰ�? ����� ���� ������ ���ܵΰ� ������ ������ ���̵��� ����� ���� ��?

grant create view to kh;
commit;

-- transaction �̶�� ���� ��� �𿡰� ������ �ִ� ���� �ƴ�
-- truncate table; �� transaction�� ��ġ�� �ʰ� db�� �����͸� ���������� ��������. �� ������༮;
-- transaction ���� �ƴ��� ���� ���� ������ �غ����Ѵٰ� �Ѵ�.

create view emp_view as select emp_no, emp_name, email, phone from employee; -- view��.. �ٸ� ����ڰ� �� ���̺��� �Ϻ� ������ ���� ���� ���? �̷��� ���� �ϴ� ������ ������? �Ⱥ��̵��� ����� �ǰ�?
--  �� ������ create table emp_table as select emp_no, emp_name, email, phone from employee; �� �Ѵٸ� 

-- ( �ݵ�� SystemConnection ���� �ٲ������ )
select * from emp_view;

select * from kh.emp_view; 
grant select on employee to test; -- �̰� kh employee ���� ����� ����������. �׷��� kh.employee��� �ؼ��� �ȵǰ�, 
commit;

grant create view to test; -- view��°� ���ѵ� ��ɸ� �ο��ϰ��� �Ҷ�, �̷� ������ �� �� �ִ� ���̴�?
commit;

select * from employee;
update employee set emp_name = '������' where emp_id = 200;


rollback;

-- kh�� view�� �����?

update employee set emp_name = '������' where emp_id = 200;

-- test ������ �信�� ��ǥ�� �̸��� '������' �� �����ϰ�
-- kh�������� employee ���̺��� ��ȸ�Ͽ� ����� ���� Ȯ���ϼ���.


create view emp_view as select emp_no, emp_name, email, phone from kh.employee; 
select * from emp_view;

---------------
-- kh.connection �� grant ���� ���� 
grant update on kh.emp_view to test; -- 1 system���� �ִ°� �ƴ϶� kh���� �����Ƿ� �ȵƾ���, DBL resouce ����
commit; -- 2  : ������ �ַ��� �� commit �� ������ ���������� db�� ���� �������� �� �ִ�.

-- 2.5  test�� �̵�

update kh.emp_view set emp_name = '������' where emp_name = '������'; -- 3

delete from emp_view where emp_name='������';

-- select * from user_views; �ش� ������ ���̽��� �����ϴ� user�� ���� �ִ� view���� �������� �˰� ���ش�.


----------------
grant delete on kh.emp_view to test;
commit;
-- �̵�
select * from emp_view;
delete from kh.emp_view where emp_name='������';
----------------
select * from emp_view;

desc emp_view;
------
-- grant ���� commit�� ������Ѵ�? 

---------------------------------------------------------------------------
-- Index ��� ��?
-- ���� ������ �巯���� �ִ� �ƴϴ�. 
-- ��ſ� ���ɰ� ���õ� ���̴�.
-- select quary�� ���� ��û �Ŵ��� �༮�̸�? 
-- �����Ͱ� �ִ� DB���� �ҷ����� �ð��� ������ ���� �ɸ���. 

-- Index�� ���� 
-- Index�� �����ϸ� �߰����� ��������� �Ҹ��Ų��. 
-- ���� ���� �ִ� �����Ϳ� ���� ���������� ����ȴ�.
-- Index �˰��� ���÷� �� ����ȴ�.
-- �׷���, ���÷� ���ϴ� column �� ���� ������ ������ �Ƿ� �������ٰ�
-- �׷��⿡ ������ ������ ���� column�� index�� ���ִ� ���� �����ϴ�.
-- unique, primary key ���� column�鿡 �����ϴ� ���� ����.

-- �������� �����۾� (insert / update / delete)  < - ��� ����

-- Index�� ����� ���� ����
-- ������ ��Ȳ�� �������� �� �˻� �ӵ��� ���� �� �ִ�.

-- Index�� ȿ������ ���� ��Ȳ
-- �� ���̺� ���� �����Ͱ� �뷮 �� ���
-- �ߺ����� �����鼭 ������ ���� �Ͼ�� �ʴ� ���̺�( �ѹ� �Էµ� �����Ͱ� ���� ������� �ʴ� ���̺� ( unique / primary key ))

-- index�� �ִ� primary key�� ���ָ� �˻������� ���� ���� ��? primary key�� �ڵ����� index���� �����ϹǷ�(�̹� �����Ƿ�)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from user_ind_columns; -- Data Dictionary �� �����μ� user_ind_columns , index�� ����Ǿ� �ִ� columns ���� �������� �ľ��ϴ� ��ɾ�
-- �� �׷��� ��� ����ϴ°���? ���� ����ϴ°���? �� ����ϴ°���? 


------------------------------------------------------------------
-- index ������
create index emp_index on employee ( emp_name );
commit;

-- �̰� ���ζ��... ���� �ӵ� ����� ���� ����ε�?
--------------------------------------------------------------------
-- synonym : ���Ǿ�

-- ��� ǥ���Ǵ� ���� ���Ǿ�� �����ؼ� ������ ����ϴ� �� : object, ��ü�μ� �����Ѵ�. 
-- employee e ó��, e�� �ٿ���, ��ġ �ڹ��� �������� �ϴ� ��ó�� ���� ������ ����ϴ� ����� synonym�� ����. dba�� ���Ǽ��� ������ ������ ��

create synonym emp for employee; -- emp��� synonym�� ����ڴ�. �� ? employee��� ���̺���� �ʹ� ��ϱ�(���� �־���Ѵ� SystemConnection���� ���� ����)

grant create synonym to kh; -- kh���� synonym ���� �� �ִ� ������ �ش� from SystemConnection
commit; -- kh���� Ŀ�� ������.

create synonym emp for employee;
select * from user_synonyms;

select * from kh.emp; -- �̰� test���� �� �� �ִ°�, ������ �ֱ� �����ΰǰ�? ���� ������ �ֱ� �����ΰ���? view ������ �־ �ΰǰ�?

---

revoke select on kh.employee from test;
commit;

-- ������ ����ϴ� �ȿ����� ���Ǿ���(synonym�� ����� �� �ִ�.) -- ���⼭�� select ����� ���ϴ°ǰ�/ �ƿ� select �� ����������, �� ������ ����. �� ����� �ʹ� �����ϰ� �翬���̾߱�

select * from kh.emp;
-------------------------------------------------------------------
-- unique �� null ���� ����Ѵ�. not null��.. null ���� ������� ����, �ٽø��� �� �ΰ��� ����� �� column�� ��� ����, primary keyó�� �����Ѵ�.

-- ���չ���










--------------------------------------------------------------------


-- �߿��� ��? Test�� ? view�� �� �� �ִ� ������ ����.
-- kh�� grant�� ���ִ� ��.
-- resource��� �ϴ� ������ ��� ������ ���´�. grant���� ������.
-- test���� emp_view �� select �ϴ� ������ �� grant select to test;
-- �������̺�� view��� �� ����Ǿ��ִ�?
-- test�� employee�� ���ǵ帮���� view�� �� �� �����Ƿ� test�� ���� emp_view �� �ִ� �������� �ٲ��

---------------------------------------------------------------------------
-- ## ������
-- ���� �̷��� �ᰡ�鼭 �ۼ��ؾ� ���� �ϴ��� ,��� �����Ű��� ������, �ľ��� �����ϴ�. �׷����ϱ� ��ġ�ε��� ���� 100����� �ݹڿ� ������ ��, ������ ���� �޸��ذ��� ���ٴ� ����...
-- ���� ���� �ؾ��ϴ°ǰ�? �ƴ� �۷μ� �����ϴ� ���� �ξ� ���� �´�. �Ӹ����� �������� �ʰ� ���ذ� �ȴ�. �ƿ� �Ӹ������� �����ϴ� ������ 10%���Ϸ� �ٿ���������. ���� �ᰡ�� �����ϴ°� 90%�� �ɶ� ���� �� Ź��������.
-- ������� ���� �� ���� �� �ְ� �������� �������� �ʴ´�.

-- ������� ���� �����ϴ´�� Ÿ���� �ذ��鼭 ��ٺ��� Ȯ���� ���ذ� ������.
-- �� ���ַ� Ÿ�����س������ϳ�? ������� �ϴ� ���� ���� �����ϴ´�� �������� �ᳪ���ٺ��� �� �ǽ��� ������ �ʰ� ������� ���� ���´�.
-- �̷��� �ᰡ�鼭 �ϴٺ��� ,���ذ� �ߵǴ�, � �������� ���� ���� �ȵǴ� �κ� ���� �ذ��س� �� ���� �� ����.


-- ������ �е��� ��� ��ɾ �� �����Ͻô°ǰ��� �ƴϸ� �ܿ��� �Ͻô°ǰ��� �ƴϸ�

-- �ñ��� 1. ���߿� �ڹٸ� Ȱ���ϸ� ���� ��ư�� ������ gettext �� alter table member add ( string1, string2, num2 ) �̷������� ����Ǿ� �����°ǰ�? �Ʊ� try-catch���� ���� rollback �ɼ��� ��� ��ó��?
-- 2. ��׸� ��� �� ��ȭ���Ѿ��ϴ°���? ���ε���� ����ϴ°ɱ�? ���� ���� �� ���� ����... ����

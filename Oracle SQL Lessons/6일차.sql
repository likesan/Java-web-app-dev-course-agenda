-- ���� 1. ��� ������ ���� �� �ο����� ����ϱ�
-- count to_char(lpad(substr(emp_no,8,2)),1,19)-(substr(emp_no,8,2))/ group by / ������ ��

select 
-- ���̺� �ο�����.. ���̺��� �����Ѵٶ�? ���̺��� ��� ��������? count�� �ؾ��ϳ�? count()�ȿ��� ���� ����?
count(substr(emp_no,1,2)) ||'��' �ο���, -- count�� �� �ȵǾ����� ��. emp_no �� �ֹι�ȣ�� ����Ѵ�, �״��� ���� ù��°�� �� ���ڸ� ã�Ƴ���. �� ������ �� ���ڵ��� ī��Ʈ�� ã�´�? 
to_char(sysdate,'yyyy')-lpad(substr(emp_no,1,2),4,19) ||'��' ���糪��
from employee
group by substr(emp_no,1,2); -- group by�� ����Ϸ��� ������, �ٷ� ���̰��� �ǹǷ�

--------------------���� Ǯ��!!--------DBA �ƴϴ��� Ȯ���ϰ� �����ϰ� �Ѿ��!!-----------------------------------------------------------------------------------------------
-- ���� 2. �Ŵ����� �ִ� ��� ��, �޿��� ��ü ����� ����� �Ѵ� ������ ���, �̸�, �Ŵ��� �̸�, �޿� ���(�������� ���� ����) 

-- �Ŵ����� �̸�---------------------------------------------------
(select emp_name from employee 
where emp_id in (select manager_id from employee) );   -- �� �κ��� �� ���ص��� �ʴ´�? �������� manager = null �̶�°�, �����Ͽ��� �Ŵ����� ���ٴ� ���̰�, �������� �Ŵ����� ���� ���� �˷���? �װ� ���� manager id���� ���� �ִ� �ָ� ã�ƾ߰���? manager id = emp id ���߰���? join�� ��� ������ϴ°���?

-- �Ŵ��� ���̵� ������ ��������, emp_id �� �ִ� �ֵ�? �Ŵ��� ���̵�? 
select emp_name, manager_id from employee;

------------------------------------------------------------------------
select emp_name, emp_id from employee where emp_name = '������' or manager_id = 207;

select e1.emp_id, e1.emp_name "������", e1.salary, e2.emp_name "�Ŵ��� �̸�"
from employee e1,  employee e2
where e1.emp_id = e2.manager_id ;-- �Ŵ��� �̸��� ����س��� ����� ����? ��� �ؾ� �Ŵ��� �̸��� ����س� �� ������? 

-------------------------------------------------------------------------

-- �޿��� ���
select avg(salary) from employee;
-- �� 1,2 ���� �����̴�. �������� select���� ���������ຸ��

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- �Ŵ��� �̸� ���� ����غ���
select emp_name,
emp_id
from employee 
where emp_id in (select manager_id from employee); -- �Ŵ����� �ִ� �ֵ鸸 ����ϰ��� �ϴ°�? ��׸� ����س�����? ���⼭ ���� �����ε� ���⼭ �� ��� �ؾ�����? �Ʊ� �׷� ȭ���� �� ���°���? ���� ���̺��ϸ� ���� ���̺��� �Ǵ°ǰ�?

-- and (select floor(avg(salary)) from employee);


select 
distinct e1.emp_id ���,e1.emp_name �̸�,
e2.emp_name �Ŵ������̵�,
e1.salary �޿�
from employee e1, employee e2
where e2.emp_id in (select manager_id from employee) 
and e1.salary > any(select floor(avg(salary)) from employee)

-- �ƿ� ó������ �ٽ��غ���?


order by 1; 

select * from employee;


-- ��� �̻�?

--------------------------------------------------------------------------------------------------------------------

select emp_name,dept_title from employee, department where dept_code = dept_id; 
-- = ���Ʒ� �� ������ �Ȱ��� ���.
select emp_name, (select dept_title from department where dept_id = dept_code) from employee; -- subquary �� select �ȿ����� ����� �� �ִ�. 
-- �ٱ��� from employee table�κ��͵� dept_code�� where ���� �̲��� ����, �ش� �� �ȿ��� dept_id ���� ����� �� �ִ�. �̷� subquary�� �������������� �θ���.

select emp_name ,(select dept_title from department where dept_id = dept_code) from employee;
--dept_code �� employee table�� �ִ� column�̸�, dept_code�� department ���̺� �����ϴ� column�̴�. �ٽø��� subquery �� �ٱ������� 
select * from employee;

-- ����������� : �������������� �������? ��? �� from employee��� ������?
-- �������� �������� �ƴϴ�. ���� �ƴ� ����� ���ٰ�?
-- �����ڷμ� �ʿ��� �ɷ��� �̹� �����Դٰ� �Ѵ�? DBA�� �ƴ� �̻���, 0.047�� �� �����ս��� �ð��� �ľ��ϴ� ������� ���� �ִ�.
-- �� ���� ���̳� �� ���鼭 �Ϸ� ��� �������� ���� �� �� �����ϰ� �غ��߾�����ߴµ� �׷� ���� �᳻�� �ð��� �� �����߱���... ���� ����� �ð��� �����ϰų� �� �ƽ���� �Ӹ��� ȥ������������. ����� �� ������ ���������. 100% ������ �̲���� ���������. �길����  ���Եȴ�.
-- ��� ���� ��ģ���� ������ �ϸ鼭 �̷��� ���� �������� �᳻���Ѵ�. �׷��� �� ���� ������ ���·� ���� �� �����ϰ� �� �� �ִ� �غ� �Ǿ�� ����


-- ������ �̸��� ���� ���� ����ϼ���. ��� ���������� ������. ��� ���������� � ����̾���? ���ϰ��� �̿��ϴ°��� �� �Ȱ���? �㳪 �� ���̺��� ����� �� �ִٴ°���? from�� �Ѱ��� �ᵵ ������ �̰ž�?
-- ���� �̲���°ǰ�? 



select 
emp_name,
(select job_name from job j where j.job_code = e.job_code) -- ���� �����Ͽ� ���� ������ �� �ִ�.
from employee e;

-- ���� 4. �μ��� ��� �޿��� 220���� �̻��� �μ���, ��� �޿��� ��� (��� ���������� ���)
-- ��� �޿� �Ҽ��� ���� ������

select * from employee;
select * from department;

select nvl((select dept_title from department where dept_code = dept_id
),'����'), floor(avg(salary))
from employee 
group by dept_code -- ��� 220�������� ������.. �긦 ��� ����? 
having avg(salary)>2200000 -- �� having���� ���� �� �ֱ���! ����.
order by 2; -- �� 2���� ������ ��������? �� �������� ����? �𸣰���? �˷��� ��� �ؾ�����? �� ���̺��� ��� ����غ��� ���� ������? �� ���� ���Ⱑ ���ذ� ���� �ʾƼ� ������������ ������ ������?

--  �������� �������� Ǫ�°� �ٵ� �ٽ��� �� ������, ���������� ��Ȯ�� �����ؾ��ϴ� �� �ƴұ�?


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ���� å�� ���

-- ## rownum : sysdate ���� ��? ��򰡿� �����ϴ� �÷��� �ƴ����� ���� �ð��� ��Ÿ���� ��ó��, ��µǴ� ���� ��ȣ�� �ٿ��ִ� ����̶��! �� ��ȣ �ٿ��ִ� ��ü
-- ���ο� column��  ���� �� ��ŭ ���ڵ��� ��� ��� �����ȴ�
select rownum, emp_name from employee;


select rownum, emp_name, salary from employee;
-- ������ ���׹��� �Ǽ� ����, ��? ���� ������ ���� from ���� �ǰ�, select�� 5������ �ǰ� ?
-- ��������� from�� ���� ����ǹǷ�, �� from�� ���� �����ϵ��� ����. table���� �ҷ������ϸ�����, ���� align �� �Ǿ��ְ� �غ���
select rownum, emp_name, salary from (select * from employee order by salary desc );
select * from employee order by salary desc; -- ��� �׳�.. ������������ ��� �������� ���������� ��ɾ���. �� �긦 ������Ѽ� ��� �Ϸ��°���?
-- ��.. �׷��� ���� �� �𸣰پ�? �ܿ��� �˱� �ƴ°Ͱ����� ��Ȯ�� � ������ �Ǵ°���?

-- rownum�� ������ �غ�, ������ �ƿ� ��������� �� ����. �ߺ� �������� �����ϴ�..? �׸��� �ߺ������� �����Ǹ鼭 �ڿ� �з��ִ� �ֵ鵵 �� �켱���� ��������� ���
-- �̰� ���� ? 

select  emp_name , salary, rank() over(order by salary desc) ���� from employee;
-- �츮�� salary�� ���� �켱������, �������� �����ϰ� �����Ƿ�!
-- ��������, �������� ���� ǥ���������
-- ��ȣ ǥ����� ����

-- 19�� ������ / �����ش� �ƿ� 20���� �����°� �ƴ϶� ���� �ǳ� �پ����, �� ������ 20���� �ƴ϶�� ���� ǥ��������� ,�ٽø��� 20���� �ش��ϴ� �ֵ��� ���� 
-- �׷���, 21���� �پ�Ѿ�����°� �ƴ϶� 20���� ����� �ȹٸ��� ���缭 ǥ���ǰ� ����� �ʹٸ� �տ� dense_�� �ٿ������, dense �� ��׷��� ���� ���Ѵٰ�? �ٽ� ã�ƺ��� '������, £��, �е��� ����, ����, ������� ����' �̶�� ������ ���δ�. �ٽ� ���� �ǳʶٴ� �� �� ���� ���� �е��ְ� ��� ��ũ�� ǥ���ϰ� ���� �� dense�� ����.
select  emp_name , salary, dense_rank() over(order by salary desc) ���� from employee;


-- �� �ƿ� ��� column ��ü��, ���� ���ı��� ���ִµ�, rownum ó�� �ƿ� �� �¿������� ���� ����� �׳� ��� ������ ��Ÿ��������±���

-- ���߿� �Խ���, �� ���ø����̼� ����� paging �ɼ��� �ٶ� ���ȴٰ� �Ѵ�. rownum ���� ���ȴٰ� �Ѵ�.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ���� : ��� ������ ���� ������ ��(asc)���� ������ �����ؼ� ����ϼ���.
-- ���̰� ���� ���� 1�� �Դϴ�.

-- rank over�� ����ؾ߰���? ���̷�?

select to_char(sysdate,'yyyy') - ( (lpad(substr(emp_no,1,2),4,19) )) ���� from employee order by 1 desc;


select emp_name �̸�, 
(select to_char(sysdate,'yyyy') - ( (lpad(substr(emp_no,1,2),4,19) )) ���� from employee) , ------------------------- �굵 �ȵ���
dense_rank() over(order by ���� desc ) 
from employee;


---------------------------------------------------------------------------------- DDL (���̺� ���� ��ɹ�)
-- ���̺� ����� : create

-- create table  person ();   
-- �����ϸ� �������ִ� ��? �ڷ����� ������Ѵ�. 
-- column ���� �ڷ����� �����ΰ�? 
-- () constraints �������� :  �ߺ��� �� ���ٶ�� ����, �� �÷����� ���� ����ּ� �ȵȴ� �� ����� �����صδ� �� emp_id ó�� �ߺ��Ǿ �ȵǴ� ����..
 

create table  person ( -- column�� �ڷ���(�ڷ����� ����) ��������
    id varchar(20), -- 20���� �������� �ִ´�.   
    name varchar(20), -- �׳� varchar2��� ���� �������� �ʾƵ�, �۵��� varchar 2�� �۵���
    age number
) ;

-- ctrl + enter �� Table PERSON��(��) �����Ǿ����ϴ�. Ȯ��

desc person;


-- �ּ��ޱ�
-- comment on
comment on column person.id is 'ȸ�� ���� ID��';
comment on column person.name is 'ȸ���� �̸�';
comment on column person.age is ''; -- ������ �� ������


select * from all_col_comments where table_name = 'PERSON'; -- ����Ŭ���� �̹� ���� �ִ� ���,  comment ���� Ȯ���ϴ� ���, 
---------------------------------------------------------------------------------------
-- DML �����͸� �����ϴ� ��� �� ������ �Է� ����� ����� ����
-- insert into : �����͸� ����ִ� ���

insert into person values('1001', ' Jack', 20) ; -- ó������ �Էµ�
insert into person values('1002',null,null);

select * from person;

-- ��ü�� ���Ź����� ����ΰǰ�?
drop table person;

create table person( 
    id varchar(20) not null, -- �÷��� �ڷ��� ��������(constraints)
    name varchar(20) not null,
    age number
);
-- not null : null ���� �ش� ���� ���� �� ����.

insert into person values ('1001','ȫ�䵿','56');

drop table person;

create table person(
    id varchar(20) not null,
    name varchar(20) not null,
    age number,
    gender varchar(10) check (gender in('��','��')) --  '��' �Ǵ� '��' �θ� ���������� ���� �� = check ( ___ in (' ' , ' ')) -- üũ�϶�
     
);

insert into person values('1001','Jack',20,'��');

select * from person;

drop table person;
create table person(
    name varchar(15) not null,
    phone number(15),
    nationality varchar(20) not null,
    height number(15) not null,
    gender varchar(5) check (gender in('��','��'))
);

select * from person;

insert into person values ('����', 01034235555,'�ѱ�',168,'��');
--------------------------------------------------------------------------------------
desc person;

drop table person;

create table person(
     id varchar(20) primary key, -- �ְ� �Ǵ� ���̶�� �ִ� ��, Java hashmap ���� key��ó�� ���.
     name varchar(20) not null,
     age number
     
    );

-- primary key : ������ ���� ��ǥ�ϴ� �ĺ��� ������ ������ִ� ��,
-- not null + unique(�� �÷����� �� �ϳ��� �� �� �ִ� ���)


drop table person;
select * from person;

insert into person values ('32','������','29.5'); -- 2��° �õ��� : unique constraint violated ���� ��

drop table person;

create table person(
    id number(10) primary key,
    name varchar(20)
    not null,
    age number(10),
    nationality varchar(20) not null
);

insert into person values(1,'������','29.5','Republic of Korea');

select * from person;

drop table person;

create table person(
    id number(10) primary key,
    name varchar(20) not null,
    langauge varchar(20) not null,
    height number
);
---------------------------------------------------------------------------------------
-- unique : primary keyó�� �ϳ��� ���̴°� �ƴ϶� ������ ���� �� �ִ� �׷� ���?

create table member(   
    pk_id varchar(20) primary key, -- ������ row�� ��ǥ���� ��? key��, ������ ���� ��, ȸ�� ������ ȸ������ �����ϱ� ���� ����
    id varchar(20) unique -- unique constraints��� �θ�. primary key�� �ƴ�����, primary keyó�� �� �ϳ������� row�� ���� ���� �� �ִ� ��. �ߺ��� �� �� ����.
    
);

insert into member values ('21','aiden'); -- �Ѵ� ��ø���� �ʾƾ߸� ���� ����

select * from member;

drop table member;
drop table person; -- �������ٴ� ���ΰ�

create table person(
    id varchar(20) primary key,
    name varchar(20) not null,
    age number default 0 -- ���� ���ٸ� �⺻������ �׳� 0�̴�. ��� ��
);

insert into person values('1001','jack',default); -- �ƿ� �� ������ �ƴ϶� 'default'��� �Է��� �ָ� ���� �ȴ�.

select * from person;

insert into person values('1002','john',null); -- ���� null�� �־��ָ� ��� �ɱ�? �׳� null �� �����!? �̸� ���� null �� ���� 0�� ������ �����ϴ� ���� ���� �ٸ��� �ƴұ�?


--------------------------------------------------------------------------------------
-- Foreign key( �ܺ�Ű )

-- ���� ���Ἲ�� ���� ���Ǵ� ���� ����? �����ϴµ� �����ϴٰ�? �����ϴµ� �־ ������ ���ٰ�? ������ �Ǳ� ���� Table�� �Ŵ� ����̶�� �����ұ�?

create table shopping(
    buy_no number primary key, -- ��ø���� ����
    id varchar(20) references person(id), -- �ܺ� Ű������ ������  
    item_name varchar(20),
    buy_date date -- Ÿ���� �ƿ� ��¥�� ���� �����ϱ��� 'date'
);

drop table shopping;

select * from shopping;
select * from person;


insert into shopping values (1,'1001','�ڹ��� ����',sysdate); -- 1�� ������
insert into shopping values (2,'1001','Oracle�� ����',sysdate); -- 2�� ������
insert into shopping values (3, '1003',' ',sysdate); -- intergrity constraints violated -- parent key not found. parent key��, person�� column 'id'�� �Է��� 1003���� freference ���� �������� �ʱ⿡ ������ �� -- �Է��� �Ұ�����


drop table person;

drop table shopping;

----------------------------------------
-- ����

create table expert_tbl(
    member_code number primary key,
    member_id varchar(20) unique,
    member_pwd varchar(20) not null,
    member_name varchar(10) not null,
    member_addr varchar(50) not null,
    gender varchar(5) check (gender in('��','��')),
    phone varchar(20) default '000-0000-0000' -- ���¸� Ȭ����ǥ�� �� �־���� �Ǵ±���. �� ������ Ȭ����ǥ�� ���� �Ǿ��� �� ��μ� ����ȴ�. �̻��ѵ�? ��¿ ���� Ȭ����ǥ ���̵� �ǰ�, ��¿���� �־���ϰ�... ���� ������ ������ ������⵵ ������ column ������ ������..? 
);

drop table expert_tbl;

select * from expert_tbl;


insert into expert_tbl values(1001,'1','1234','������','��⵵ ���ֽ� �Ƶ��� 275-14����', '��',default);

create table expert_skill ( -- ��� ����? ��ų���� ���°ǰ�? �ϴ� column �� 2��, member_code �� skill �̶�� �γ��ΰ� �˰ڴµ� ��..
    member_code number references expert_tbl(member_code),
    skill varchar(10)
    );

select * from expert_skill;
drop table expert_skill;


insert into expert_tbl values(100, 'gildong', '1324', 'ȫ�浿', '��⵵ ȭ��','��','010-1111-2222');
insert into expert_tbl values(101, 'gaesun' ,'1432','�ɰ���','��õ ����','��','010-2222-1111');
insert into expert_tbl values(102,'samsam2','5413','�ڻ��','����� ����','��','010-4343-2958');
insert into expert_tbl values(103,'choco','pie','������','�̱�','��',default);




create table shopping(
    buy_no number primary key, -- ��ø���� ����
--    id varchar(20) references person(id), -- on delete restrict : �ƿ� refererenced column ��ü�� delete �Ұ��ϰ� ����� ��������(constraints)
--    id varchar(20) references person(id), -- on delete set null  : ������ �����ϳ�, null �����θ� �ʱ�ȭ ��Ű�� ���� ����(constraints)
--    id varchar(20) references person(id), -- on delete cascade  : ������ ����, �ƿ� �����Ǵ� �� ���� �����ǵ��� �ϴ� ��������(constraints), cascade : ��������, ���� ����, ���ӵǴ�, ���ӵǴ� �̶�� ��
    item_name varchar(20),
    buy_date date -- Ÿ���� �ƿ� ��¥�� ���� �����ϱ��� 'date'
);
-------------------------------------------------------------------------------------------------------------------------------
-- DML > INSERT Quary����ġ��


create table person(
    id varchar(20),
    name varchar(20),
    age number
);

insert into person (age)values(20); -- age��� column �� 20�̶�� ���� �ְڴ�. ���� ���߿�, 20�̶�� ���� �÷� �� �� �ȿ� ����ִ� ��� Ȯ���� �� ����

insert into person (name,age) values('jack',30); -- �� columns �� ���� ���� �ִ�. values ������ ������ ��ȣ �ȿ� ��ǥ�� ���� columns �� ���� ��ŭ, ������ ��踦 �����ָ� �ȴ�.

insert into person (id,name,age) values('susan',25); -- �̷��� ��� columns ���� values ���� ���� �� �ִ�. ������ ��� ĭ�� �� �´� values ������ �������� ���, values ���� �� columns �� �������� ������ ����������. ���� �������൵ Oracle�� �˾Ƽ� ���ش�.
-- == insert into person values('susan',25);



create table emp_part(
    emp_id varchar(30),
    emp_name varchar(30),
    salary_link varchar(20)
);

-- ���� �Ϸ��°� ��?

--insert into emp_part (select
--emp_id,
--emp_name,
--dept_title
--from employee, department
--where dept_code, dept_id);


-- - - -
select * from employee;

insert into emp_part(
select emp_name,
salary,
dense_rank() over(order by salary desc)
from employee);

drop table emp_part;
select * from emp_part;


-- Update Quary : ������ �ִ� field���� ����. 

create table department_copy as select * from department; -- department table�� �׳� �״�� ī���ؿ��� quary

select * from department_copy;

update department_copy 
set dept_title = 'IT���ߺ� ';


---------------------------------------------------------





------------------------------------------------------------------------------------------------------------------------------
-- ## ������ 
-- ����� ���� �� �� �ȵȴ�... ������ ������ �� �����Ѵ�.  �� �ٰ��´�.

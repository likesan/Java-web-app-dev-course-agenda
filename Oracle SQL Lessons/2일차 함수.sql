--[ �׳��� ���־��̴� ���ڿ� ó�� �Լ� ]


-- 1 length( column name ) : ���ڿ� �Ǵ� ���� �÷��� ����
select email, length(email) emp_name, length(emp_name) from employee;




-- 2. instr( 'ã�� ����� �Ǵ� ���ڿ� column ��ġ', 'H' , ' ���� ������ ���� index ����' , '���° H�� ã�� ���ΰ�-���'  ) : ��Ʈ�� �ȿ���, java indexOf() Ư�� ���ڰ� ���° �������� ã�� ��, 
-- ��Ʈ : �������� ���̳ʽ� =  �ڿ��� XX ��°, ���߿� ������ ���� ���δ�.

select instr('Hello World Hi High','Hi',1,1) from dual;
-- ex ) employee ���̺��� email���� @�� ��ġ�� ã�Ƽ� ����غ�����. 
-- email�� �Բ� ���




select instr('showmenthemoney','show',1) from dual;
-- return : 1

select email �̸���, instr(email, '@',1,1) "@�� index" from employee;


-- 3. LPAD / RPAD  : Left Padding / Right Padding, �츮�� ������ ���ڷ� �������� ���� �Ǵ� �������� ä��� �Լ� = (|| '��')

select lpad(email,20,'#') from employee;
-- 20ĭ���ٰ� �� �ټ�����(email char ����)�� ����ض�.

select rpad(email,20,'!') from employee;



-- 4. trim(ltrim / rtrim)
-- Default Function : ����� ���ִ� ��ĭ�� ����
select ltrim('    kh   ','  ') from dual; 
-- left ���̵忡 �ش� '   ' ��ȣ�� �����ּ���. ���� ����� ������ �� �ִ�.

select rtrim('    kh   ') from dual;


select ltrim('000123456','10') from dual;
-- ���ǻ��� : ���⼭ �������� ������� ������ '10' ��10���� �� ���ڿ��� �����°� �ƴ϶�, 1�̳� 0�̶�� ���ڷ� �� ��� �����ʹ� ���� ������ ��, '1'�� '0' �̶�� 2���� �������� ���´ٴ� ��!!!
-- ���� : 123123kh

select rtrim(ltrim('123123kh132','123'),'123') from dual;
-- ��Ʈ : �޼ҵ� ���� ���� �ʿ�. �׳� ���� ���� �ѹ� �� �ѷ��θ� �����ϴ�. �߰��� ������� return����  �ֱ� ������ ��¼�� ��¼����� ���� ���ص� ������, �׳� ������ �ѹ� �� �ѷ��θ� 1�������� ���� �Լ� ���� 2�������� ����� �� �ִٴ� ���� �ٸ��� �ʴ�.
-- ���ϰ� ���� ��������. ����� �ʴ�.

select trim('Z' from  'ZZZKHZZZ') from dual;
-- ��Ʈ : ��/������ ���� ����, from ���� �ܳɵǾ��ִ� ���ڵ�κ��� ������ ���ڸ� �����ع����� ���. ���� ������, ����

select trim(leading 'Z' from  'ZZZKHZZZ') from dual;
-- leading : ���ʿ������� ������ ���ڸ� ���� ������

select trim(trailing 'Z' from  'ZZZKHZZZ') from dual;
-- trailing : (Ʈ���Ϸ�ó�� �ڿ� ���� �ٴϴ� ��ġ) �ܳɵ� ���ڿ� �ڿ� ����ٴϴ� ���ڵ� �߿�, ������ ���ڸ� ���� ������~

select trim(both 'Z' from  'ZZZKHZZZ') from dual;
-- both :  ���ʿ��� ��� ������

-- ��Ʈ : �տ��� ���� padding ���� '����' �� ���δ�.




-- ���� : department ���̺���, dept_title�� ��� ����ϴµ�, '��'�� �����ϰ� ����ϼ���. TRIM

desc department;
select * from department;
select trim('��' from dept_title) �μ� from department;




-- ���� : hello ��� ��Ű�� '5109852058291051283985985298Hello895239528060625636' 

select  rtrim(ltrim('5109852058291051283985985298Hello895239528060625636', '0123456789'),'0123456789') from dual;
-- ��Ʈ : trim�� ���ٰ� �ؼ� ���ϴ� �� �� ���ڵ��� �Ѳ����� ������� ���� �� �ְԴ� ���� > trim �� 1 ���ڸ� ���� ���� ����



-- substring : ���ڿ����� �ٶ�� ���ڿ��� ������ ���, �˻� ������ ��-��, ���������� ���̳ʽ��� ���� ( ������ ���� ���δ�)
select substr('showmethemoney') from dual;
-- ��Ʈ : �μ� ������, 5��° �ڸ��������� ���δ� ��� �Լ�

select substr('showmethemoney',1,4) from dual;
-- ��Ʈ : ù��° ���ڿ������� 4���ڸ� ����

select substr('showmethemoney',-7,3)from dual;



-- ���� : ���� �������� ����, me �̾Ƴ���

select instr('showmethemoney','me',-1) from dual;
select substr('showmethemoney', -10,2) from dual;
select substr('��� �� �� �Ӵ�', 2) from dual;





-- ���� : employ table���� ���� �̸� ���, �̸����� ���� ���

select distinct substr(emp_name, 1,1) �� from employee order by ��;

-- order by �� ���� �����ϴ� column�� �̸� �� �����Ѵ�. 





-- ���� : employee ���̺���, ��������, �����ȣ-�����-�ֹ�-���� ���, �ֹι�ȣ ���ڸ��� *�� ���

select emp_no from employee;
select emp_id �����ȣ,  emp_name �����, rpad(substr(emp_no,1,6),15,'-1*******') �ֹι�ȣ, salary*12 ||'��' ���� from employee where emp_no like ('%-1%');


select emp_id �����ȣ,  emp_name �����, rpad(substr(emp_no,1,6),15,'-1*******') �ֹι�ȣ, salary*12 ||'��' ���� from employee where emp_id>=200 or emp_id<=221;


-- like�� ���� �ʰ� �غ��� like�� ���� �ʴ´ٸ� �ֹι�ȣ�� ��� ã�´ٴ� ���ΰ�? � �ٸ� ����� ������? �����ȣ 200 ~ 221 ���̿� �ִ� ������ �غ���? 






-- upper / lower / initcap

select upper('welcome to my Oracle world') from dual;

select lower('welcome to my Oracle world') from dual;

select initcap('welcome to my oracle world') from dual;




-- �� ���ڿ� ��ġ��

select concat('AB','CD') from dual;

select 'AB' || 'CD' from dual;



-- replace : ��ü�ϱ�

select replace(initcap('hate oracle'),'Hate','Love') from dual;

select emp_name, replace(email,'kh','iei'), emp_no from employee;







-- [ ����ó�� �Լ� ]

-- abs : absolute�� ���ڷ�, '���밪'�� ���ϴ� �Լ�, '����'

select abs(-10) from dual; -- 10



-- mod : ������ 

select mod(10,3) from dual ; --- 1




-- floor : ��� �Ҽ��� ����

select floor(10.5) from dual;



-- trunc : �Ҽ��� ����(���� �ڸ� ���� ����)

select trunc(1234.567,1) from dual; --1234.5

select trunc(123.456,2) from dual; -- 123,45

select trunc(123.456,-1) from dual; -- -1��° ��, �Ǽ��� 1��° ���� ����(<>�ݿø�), 120

select trunc(123.456,-2) from dual; -- -2��° ��, �Ǽ��� 2��° �� ����, 100




-- ceil : 'õ��', õ����� �÷���, �ݿø�

select ceil(123.456) from dual; -- �ݿø�, 124




-- round : �츮�� �����ϴ� �ڸ��� �ݿø�(5���ϸ� ���� �ȿø�, �̻��� �ø�) 

select round(123.476, 2) from dual; --123.48
select round(123.476, 0) from dual; --123
select round(123.476, 2) from dual; --123.48
select round(123.476, 2) from dual; --123.48







-- ��¥ ó�� �Լ�

select sysdate from dual; --���� 18/04/19
select current_date from dual; --���� 18/04/19
select localtimestamp from dual; --18/04/19 15:58:08.717000000
select current_timestamp from dual; --18/04/19 15:58:33.068000000 ASIA/SEOUL : ���� �ڼ��� ����



-- �߿�(���� Ȯ�� ����)  �Լ�

-- months_between : �μ��� �Ѿ�� �� �ð� ������ ���� �� 

select emp_name , hire_date, floor(months_between(sysdate,hire_date)) �ٷ��ϼ� from employee order by �ٷ��ϼ�  asc  ;



-- add_months : �μ��� �ѱ� ���ڸ�ŭ�� ������ ���� ��¥�� ����

select emp_name, hire_date, add_months(hire_date,6) from employee; -- 90/02/06 to 90/08/06

select add_months(sysdate,120) from dual;



-- ���� : ���� sysdateö���� ���뿡 ���ϴ�. �� �����Ⱓ�� 21�����̶�� �������� �� '�Դ���' '������'�� ���
-- �Ϸ� 3�� �Ļ����� �� �� ��� �Ļ�( (add_months(sysdate, 21))*3)?

select sysdate ö���Դ���, add_months(sysdate, 21) as  "������" , 30*21*3 || '��' as "�Ļ�Ƚ��" from dual;

select 'ö��' �̸�, sysdate "�Դ���(����)", add_months(sysdate, 21) as  "������" , (months_between('18/04/19', '20/01/19')*3*30) || '��' as "�Ļ�Ƚ��" from dual;
select sysdate ö���Դ���,
add_months(sysdate, 21) as  "������" ,
(months_between(add_months(sysdate, 21),sysdate ))*30*3 || '��' as "�Ļ�Ƚ��" 
from dual;


-- next_day  : ���� ��¥�κ��� ���� ����� ����

select  next_day(sysdate,'��') from dual; -- 18/04/23
-- ���÷κ��� ���� ����� Ư�� ���� ã��

select  next_day(sysdate,2) from dual; 
-- ���� : �� = 1, �� = 7



-- last_day : ������ ���� ��¥�� ���� ���� ������ ��

select last_day(sysdate) from dual; --18/04/30

-- ���� ���� ������ �� ã��




-- ���� : ������ ������ �� ã��

select last_day(add_months(sysdate,1)) from dual; -- 18/05/31
-- add_months( ���� 1 , ���� 2 ) 


-- extract : ����, ��¥�����κ��� ���ϴ� ������ ����
select extract (year from sysdate) from dual;
-- ctrl + space�� �Լ� ������ ���� Ŀ���� ���� ������ ��, ����� �� �ִ� ��ɵ��� ��Ÿ��



-- ���� : employ table���� ����� �̸�, �Ի���(yyyy/m/d ����), ����((�ش� �� �⵵-�Ի���)+ 1), �Ի��� ���� ��������

select emp_name �̸�, 
extract(year from hire_date ) || '�� ' || extract(month from hire_date) || '�� ' || extract(day from hire_date) || '�� ' as "�Ի���",
extract(year from sysdate)-extract(year from hire_date)+1 ����
from employee order by hire_date desc;

-- ��Ʈ :  ||(or) �� ���� �ȴ�. �� column �������� ���� �޼��带 ���� �����س� ������ �� ��(field)�ȿ� ���� �� �ִ�. 



-- ���� : employee ���̺���, 1 ����� �̸� / 2 �Ի��� / ������(=�Ի��� ���� �� 1��) / ������ �� 6����  /���� �� ��� - �Ի��� ���� �������� 

desc employee;
select emp_name �̸�, 
hire_date �Ի���,
last_day(hire_date)+1  ������, -- �������� �� ���� 1�� ����� ������? ��������, ���������� +1 �ȳ�
add_months(last_day(hire_date),6)+1 ���ؿ�,
extract(month from (add_months(last_day(hire_date),6)+1)) ||'��' as "������ �� 6����"
from employee order by hire_date asc;
select * from employee; -- employee ���̺� ����

select emp_name ,emp_id, phone from employee; -- ��ҹ��� ������ ����. emp_name column�� phone column ���� ��� ��Ÿ���� : ','

desc employee; -- desc : describe, employee��� ���̺��� �����ض� // varchar(3) : �������� ���ڿ�(variable charactor)�� ���� 3���� ����, ��ȣ�� �� ������ �ִ�ġ.

select emp_id,emp_name,hire_date,salary*12 from employee where emp_name='����'; --1. ���갡�� *12 2. where ___ ��ġ�� ���� �ش� �ڷḦ ��Ȯ�� ��Ÿ�� �� ���� ..�ڿ� �ڲ� ������ �ٿ������� ��
select emp_id,emp_name,hire_date,salary*12 from employee where emp_id=200 or emp_name='����';
select emp_name,salary*12 from employee where salary < 2000000; -- �̰� �������� 2000000���� ���� ������� ���ϴ� ��
select emp_name,salary*12 from employee where salary*12 < 20000000; 


/*
���� ������� ���. ����. ���ټ� ����.


- not null : varchar()��, ������ ������ �ִ�ġ�� ��������. ������� ����� ����, ��.. ������ ���ϵ� �� ����, ���� ���� �ִ� �ϸ鼭 ������ ������. �� ������ �ʿ� �ٽø��� varchar�� ��� ���� ����? not null ���̸� �Ұ���? �׷��� �׳� char�� ����?
varchar()�� ������ ���� �ִ�ġ ������ ������ ( char()�� �ȵ�, ������� ����ϳ� �����ķ� ������ �������� )

char() �ڷ��� not null
num �ڷ����� ���갡��, 
lob �ڷ��� : 4000õ���� �Ѿ�� ������ ���� clob / blob ����, clob �� 2GB �ؽ�Ʈ ���� ����(������X), blob �� �ؽ�Ʈ�� �ƴ� ����(Bynary) ���� ���� 

*/ 




-- ���� 1 : job ���̺��� job_name �׸� �� ��µǰ� ������

desc job;
select job_name from job;
select job_code from job;

-- ���� 2 : department table ���� ��ü ������ �� ����غ���

desc department;
select * from department;

-- �ǰ� ���� ���α׷� ����, ������, ���� ���

desc employee;

select emp_name, email, phone, ent_date  from employee;

--���� 3 : employ ���̺��� ������ 250���� �̻��� ����� �̸�, sal_level ����ϱ�

desc employee;
select emp_name,sal_level from employee where salary>=2500000;
select * from employee;

/*

column �� ������ �� ���������̼��� ����Ѵ�.
���ڿ��� ������ �����ÿ���(=field)  �̱� �����̼��� ����Ѵ�. �̰� �� �򰥸� �� �ִ�?
�ణ �� ����������.......?
�ƴ� �ϴ� �׷��� �츮�� �װ� �־��?
�� ����?

*/




--���� 4 : employee ���̺��� ( from employee; ), ������ 350�����̻� �̸鼭, job_code�� j3�� ����� �̸�(emp_name),��(and) ��ȭ��ȣ(phone)�� ������ּ���

select emp_name,phone from employee where salary>=3500000 or job_code='J3'; -- ��ҹ��� ������ �ȵ�, and�� ��� ��. where�� ���ǹ��̶�� �ϳ�? where �հ� �ڿ� and��� ���� �ֵ�.

--���� 5 : ���ʽ�

select bonus from employee; 

--���� 6 : employee ���̺��� ������ �̸� / ���� / ���ʽ� / ���ʽ� ����� ���� ���

select emp_name as ������, salary*12 as ����, (salary*12*bonus)+(salary*12) as "���ʽ� ����� ����", '��' "����" from employee; --'��'�� �����Ͱ��̰�, "����"�� ����̹Ƿ�

select emp_name, phone, salary from employee; -- �������� ����Ŭ�� �غ��߰ڳ�

-- as ���� : �ڿ� column header�� �̸��� �������ִ� ��ɾ�, ������ �ȴ�(but �ִ°� �������� ����).


--���� 7 : �̸�,����,�Ѽ��ɾ�(���ʽ�����),�Ǽ��ɾ� : �Ѽ��ɾ� - (����*����3%)

select emp_name as �̸�, 
salary*12 as ����, 
(salary*12)+(salary*bonus*12) as �Ѽ��ɾ�, 
((salary+(salary*bonus))-(salary*0.03))*12 

as �Ǽ��ɾ� from employee;



select sysdate as �Ի��� from employee; --sysdate : ����ð��� date������ ��Ÿ���� ��ü = �ڹ� current.timemillies()

select sysdate from dual; --dual : test�� ���̺��̴�?

select hire_date as �����, sysdate from employee; 

-- ��¥ ����

select sysdate - hire_date as �ٹ��ϼ� from employee;

select sysdate -49 from dual;

--���� 8 : employee ���̺��� �̸��� �ٹ��� �� ���

select hire_date from employee ;

select emp_name �̸�, floor(sysdate-hire_date) --floor : �Ҽ��� ���� ���
as "�ٹ��� ��" from employee;

-- ���� 9 : employee ���̺���, �̸� , ����, ���ʽ��� ���, �ϴµ� �ٹ���� 20��(hire_date - sysdate)�� �Ѿ�� ����� �ϰ��ϱ�

select emp_name �̸�,
salary ����, 
nvl(bonus,0) ���ʽ�, -- null value( A , B ) : value�� A�ξֵ��� B������ �ٲ��ش�.
floor((sysdate-hire_date)/365) �ټ��ϼ� 
from employee where (sysdate-hire_date)/365>=20;



select distinct job_code from employee; --distinct : �ߺ� ���� �ڵ�, �ش� column �� �ߺ�value�� �ִ� ���, �̸� �������ش�? �Ǵ� �� ���� ����ϰ� ���ش�.


select emp_name �̸�, salary || '��' ���� from employee; -- || : java's 'or' boolean operator �� ����, �ش� column �ȿ��� �־���


-- ���� 10 : employee ���̺���, �޿��� 300���� �̻�, �׸��� 500���� ���� �޴� ������� �̸�

select emp_name �̸�, phone ��ȭ��ȣ, salary || '��' �޿� from employee where salary>3000000 and salary<5000000;

select emp_name �̸�, salary �޿�, phone ��ȭ��ȣ from employee
where salary between 3000000 and 5000000; --between : 300���� 500���� ��� �����ϴ�(inclusive) ��. 5000000 >= Value >= 3000000


select * from employee where hire_date not between '09/09/01' and '17/03/01'; -- 1. ��¥�� ���� 2. not between : �ش��ϴ� ������ �ƴ� ���鸸 ����Ѵ�.

select emp_name �̸� from employee where emp_name like '��%'; -- where ���� ���� �־��ְ� ���� ����, ���̰� ���� �ش� ���� ������ ���Ҷ� ����. Ž���� ���簢�� ������?
-- like %(percentage) : �־ �ǰ� ��� �ȴ�. 

select emp_name �̸� from employee where emp_name like '%��%';

select emp_name �̸� from employee where emp_name like '%��';



-- like _(underbar) : _ ���� ǥ��� �ڸ� ���� �ݵ�� � ���� �ִ� value�� �߰� ����
select emp_name �̸� from employee where emp_name like '__��';

select emp_name �̸� from employee where emp_name like '_��_';

select emp_name �̸� from employee where emp_name like '��__'; 
--�տ� ���̶�� �ؽ�Ʈ�� ����, �ڿ� ����ٿ� ���� ���� ���� �ִ� value�� ��Ÿ����. �߿��� ��, ����ٴ� �����Ͱ��� �ڸ����� �˰� ������ ����� �����ϴ�. ������ '%' ǥ���� �ڸ����� ���� ������ �� �� �ִ�.


-- ���� 11 : employee ���̺��� �̸��� '��' �ڷ� ������ �е��� ���

select emp_name �̸� from employee where emp_name like '%��';
select emp_name �̸� from employee where emp_name like '__��';


-- ���� 12 : ��ȭ��ȣ�� 010 ���� �������� �ʴ�(not like) ����� �̸��� ��ȭ��ȣ�� ���

select emp_name �̸�, phone ��ȭ��ȣ from employee where  phone not like '010%';


-- ���� 13 : employee ���̺��� �����ּҿ� s ���ڰ� ����(and) dept_code�� d9�Ǵ�(or) d6 �̰�(and) �޿��� 270���� �̻��̰�(2700000<a) , �Ի����� 90/01/01 ~ 00/12/01 ���̿� �ִ� ���
select * from employee;


select * from employee 
where 
email like '%s%' 
and (dept_code = 'D9' or dept_code = 'D6')   -- ��ȣ ( ) ������ �켱���� :  �ָ��� �κ�
and salary>=2700000
and hire_date between '1990/01/01' and '2000/12/01';

--���� 14 : employee ���̺���, ������ ������ �е��� �̸��� ����ϼ���.

select emp_name from employee where emp_no not like '_______1______';



-- ��� ������ ���̶�, �۰� �� ���� �ѱ����� �߶󳻷����鼭 �����ϸ� ���� ���´�


/*
"������ ���ϰ� ������?" ���� Ȯ�� > select�� ���� ã��(����� ���� �߿��ϰ� �����ϴ� ���� ���� �� �տ� ������ �Ͱ� �ſ� ����ϱ���)
�� �̷��� ���������� ����� �Ȱ��ٴ°� �ʹ��� ����ϳ�.
*/






/*

�ϸ� �� ���� �ʹ��� ��մµ�? �� �̷��� ���� ����� ���� �Ǵ°���? ��� �̷��� �ʹ��� ���ϱ� ���� ��������

*/



desc employee;

select emp_id from employee;

-- �� ��ȯ �Լ� : ����ȯ �����ϴ�

-- ���� ���� �Լ��� �����Ǿ� �ִ�. number date


---

-- to_char : ��¥�� �����͸� ���ڿ� ��ȯ or ���� �����͸� ���ڿ� ��ȯ to string�� ����ѵ�

-- sysdate, hire_date > ���ڿ�, ������ ��������Ѵ�. simple data format ó�� , �ڹ��� toString ���, to_char, ���ڰ��� 2�� ����.
-- �ϳ��� �ٲٰ� ���� ��¥, �ϳ��� ���ϴ� ����

-- * sysdate �� �� �� �� �� �� ���� �� ���� �ִ�.

select to_char(sysdate, 'yyyy "��" mm "��" dd "��" ') from dual; -- �ѱ۷� �ϰ� ���� ��� ��Ŭ �����̼� " " �� ������ ��־��ָ� �ȴ�. ��? 3����Ʈ �����̶� �ٸ���.

select to_char(sysdate, 'yyyy-mm-dd-day') from dual; -- �ڿ� ���� ���̰� ���� ��� day

select to_char(sysdate, 'yyyy-mm-dd-dy') from dual; -- ������ '��' �Ǵ� '��'���� �Ӹ��� ��Ÿ���� ���� ��� dy

select to_char(sysdate, 'yyyy-month-dd-day') from dual; -- ������� ��Ÿ������ month

select to_char(sysdate, 'yyyy-month-dd-day hh:mi:ss') from dual; -- ���� minuit ���� mi�� ����Ѵ�. minuit ��

select to_char(sysdate, 'yyyy-month-dd-day hh24:mi:ss') from dual; -- 24�ð� �������� ��Ÿ���� �ʹٸ� hh24�� ������. ���� �����ϸ鼭�� �Ǹ��غ��δ�.

select to_char(sysdate, 'FMyyyy-mm-dd-day hh24:mi:ss') from dual; -- �տ� �������� 0�̶�� ���ڸ� ��� ���ְ� ���� ���, FM�̶�� ǥ�⸦ �⵵ �տ� ���̸� �ȴ�.

---

select emp_name ������, to_char(hire_date, 'fmyyyy-mm-dd-day') �Ի��� from employee order by 1; -- order by�� '�Ի���' �Ӹ��� �ƴ϶�, column ��°�� ��� �ȴ�.

select emp_name ������, to_char(hire_date, 'yy"��" month dd"��" dy') �Ի��� from employee order by 2; 

select emp_name ������, to_char(hire_date, 'yyyy/mm/dd (dy)') as "�Ի���" from employee order by 2;  -- ���� 1

-- ����� �߰�

desc employee;
select ent_date from employee ;

select emp_name ������, to_char(hire_date, 'yyyy/mm/dd (dy)') as "�Ի���", nvl(to_char(ent_date, 'yyyy/mm/dd (dy)'), '���� ��') ����� from employee order by 3; -- ���� 1.5 ����� �߰�, null - '���� ��'




---

select to_char(1000000,'000,000,000') from dual;

select to_char(1000000,'999,999,999') from dual; -- ���� 0 ����. �� ������ ��Ȯ��?

select to_char(1000000,'999,999') from dual; -- format�� �� �˳��ϰ� ū ������� ��������Ѵ�. If not  = #######���� ������

select to_char(1000000,'999,999,999.000') from dual; -- �Ҽ����� ��Ÿ���� ���� ���, �ڿ� .000�� �ٿ�����!

select to_char(1000000,'L999,999,999.000') from dual; -- ���� ��ȭ ǥ�⸦ �ϰ� �ʹٸ� �ڿ� L�� ������! ( ��ڱ�� ), ����Ŭ ������ �̱����� �ٲٸ� ��ȭ�� �ٲ��.

select to_char(1000000,'999,999,999.000$') from dual; -- Dollar�� ǥ���ϰ� �ʹٸ�, �տ� $ ������ �ڿ� �ٿ��� �ȴ�.


---

-- to_date : ���� �Ǵ� ���ڸ� ��¥������ ��ȯ

select to_char(to_date(20000101),'yyyy-mm-dd') from dual; -- to_date�� ��¥Ÿ������ �ٲ� ��, ������ �ٲٴ� ����� ����. ��¥�� ��µǴ� Ÿ���� �ٲ��ְ� ���� ��� to_char�� ����������

select to_date('20190101') from dual; 

select to_date('110101', 'mm/yy/dd') from dual; -- yy�� mm�� ��ġ�� ���氡��


---

-- to_number : ��¥�� ����(����ó�� ���̴�)�� ���ڷ� ��ȯ(number format)

select to_number('1000000000') from dual; --������ ���ڿ� to ���ڿ�

select to_number('100a0000') from dual; --  number format exception error �߻�. java integer.parseint �� ���

select to_number('1,000,000', '9,999,999') from dual; -- �߿� : �츮�� ���� ���ڿ��� �޸�',' �� �ִ� ��� ������ ���, �׷��Ƿ� �ڿ� ���ڿ� �������� ��Ÿ���ָ� numberize ����!, �޸� ��ü�� ���ڷ� �ν��Ѵ�. �޸��� ó���� �� �ִ� �� ���ڸ� �־����� ������, ����

---

-- decode(=Java.switch) : �������� ��쿡 ������ �� �ִ� ��� ���� ( '~�� ���ٸ� '=' ���ǿ��� ���� �� ����, ũ�ų� �۴ٴ� ǥ�� �Ұ��� ) , �����μ� �Լ� (�μ����� �þ��� �پ��� �����ϰ� ���� �� �ִ� �Լ����)

select emp_name �̸�, substr(emp_no, 8, 1) ���� from employee;  -- substr ���� �ֹι�ȣ 1 �Ǵ� 2 ���� ����. '8��° �ڸ�����  �� �ڸ��� ���ڴ�.'

select emp_name �̸�, decode(substr(emp_no, 8, 1),1,'��',2,'��' )���� from employee;  -- ���� ���� ����, 1 �̶�� '����', 2��� '����' ���� �ְڴ�. == �����μ� �Լ�

---

-- case(=Java.if) : decode���� ������ ���. '�ʵ��� ���� �۰ų� ũ�ų� ���ٸ�~' ���� ����. ������ �������� ��츦 ���� ����, ������ �� ���.

select emp_name �̸�, 
case 
when substr(emp_no, 8, 1) = 1 then '��' -- when : (=���� : ~ �ϴٸ� ), �޸� ���� �� ��!
when substr(emp_no, 8, 1 ) = 2 then '��' 
end ����
from employee;

 ---
 
select emp_name �̸�, 
case 
when substr(emp_no, 8, 1) = 1 then '��' --  'ũ�ٸ�' ����
when substr(emp_no, 8, 1 ) = 2 then '��' 
else '2000�� �Ŀ� �¾�̱���'
end ����
from employee;

---

select emp_name �̸�, 
case 
when substr(emp_no, 8, 1) = 1 then '��' --  'ũ�ٸ�' ����
else '��'
end ����
from employee;

---

-- ���� : employee ���̺���, 70��� ���� / ���� ����

select emp_name ����, emp_no �ֹι�ȣ,
case
when substr(emp_no, 1, 2) > 70 then '70��� ����' -- emp_no ���� 1��° ���� �������� 2���� ���� 70���� ũ�ٸ�, (=�ֹι�ȣ ���ڸ� �ΰ��� 70���� ũ�ٸ�) then '70��� ����'��� ǥ���ϰ� �Ѵ�.
else '70��� ����' -- �װ� �ƴϸ� 70��� �����̶�� ǥ���Ѵ�.
end ���
from employee
order by ��� desc;

---
select emp_name ����, emp_no �ֹι�ȣ,
case
when substr(emp_no, 1, 2) >= 70 then '��' -- emp_no ���� 1��° ���� �������� 2���� ���� 70���� ũ�ٸ�, (=�ֹι�ȣ ���ڸ� �ΰ��� 70���� ũ�ٸ�) then '70��� ����'��� ǥ���ϰ� �Ѵ�.
else '��' -- �װ� �ƴϸ� 70��� �����̶�� ǥ���Ѵ�.
end "70��� ����"
from employee
order by "70��� ����" desc;

-- Quary �ۼ� �� : �� - �Ʒ��� ��� ���̵��� ���°� ������ UpupUp! 


---

-- ���� ���� �� ���� ����Ǵ� �Լ�
select length(email) from employee;


-- Group �Լ� : ���� ����Ƽ� ����� �����Ű�� �Լ�

-- ### sum : ����� �հ�
select to_char(sum(salary),'L999,999,999') "�޿� ���" from employee;


select emp_name �̸�, to_char(sum(salary),'L999,999,999') "�޿���" from employee; -- ���� : �� ���� ����, ��? emp_name�� ������ ���� ��Ÿ���� ��ɹ�. to_char(sum())�� �ϳ��� �ุ�� ��Ÿ���� ��ɹ�. ���� ���� �ȸ¾� ����

-- ���� : ������ �޿� �հ�(sum(salary)) where substr(emp_no,8,1)=1;

select to_char(sum(salary),'L999,999,999') "������ �޿� �� ��" from employee 
where substr(emp_no,8,1)=1;

-- ���� : ������ �޿� �հ�(sum(salary)) where substr(emp_no,8,1)=2;

select to_char(sum(salary),'L999,999,999') "������ �޿� �� ��" from employee 
where substr(emp_no,8,1)=2; -- ��20,336,240

-- ���� : D5�μ�dept_code='D5'�� �޿�substr(sum(salary),'L999,999,999') �հ�

select to_char(sum(salary),'L999,999,999') as "D5 �μ� �޿� �� ��" from employee
where dept_code='D5'; -- field���� �����ϰ� ���� ���, �׳� ����ǥ�� ����. 'D5' not "D5" or 'd5'

-- ���� : D5�μ�dept_code='D5'�� ���� �ΰǺ� substr(sum(salary)*12,'L999,999,999') �հ�

select to_char(sum(salary)*12,'L999,999,999') as "D5 �����ΰǺ�" from employee
where dept_code='D5'; -- field���� �����ϰ� ���� ���, �׳� ����ǥ�� ����. 'D5' not "D5" or 'd5'


---

-- ### avg : ����� ���

select to_char(avg(salary),'L999,999,999') "�޿� ���" from employee;

select to_char(avg(salary),'l999,999,999') "D5 ��� �޿�" -- local currency : L or l �Ѵ� ����
from employee
where dept_code='D5';

---

-- ### count : ������ �����ϴ� ���� ���� (null ���� ���), �ߺ� ���� null ���� �տ� distinct ���̱�

select count(*)
from employee; -- * ���� ���� ���� ����

select count(dept_code)
from employee;

select count(distinct dept_code) from employee; -- distinct �� null �� ����

select count(emp_no)
from employee;


---

-- MAX/MIN : �ִ�/�� �� ã�� 

select to_char(max(salary),'l999,999,999')
from employee;

select max(salary), min(salary) from employee;
select max(hire_date), min(hire_date) from employee; -- ��¥�� ��� �� ����, ��¥ ���� 



-- ���� ���� 1. ������/�̸��� ���� ���(length(emp_name) ������, length(email) �̸��� from employee)

select length(emp_name) ������, length(email) �̸��� from employee;

-- ���� ���� 2. ������ �̸�, �̸��� �ּ��� @ �տ� �κи� ����ϼ���. substr�� ����ϳ�?

select emp_name �̸�, 
rtrim(email,'@kh.or.kr' ) �ּ� from employee; -- �̸��Ͽ��� @kh.or.kr�� ��������


-- ���� 3 . 60����case(substr(emp_no),1,2)=60 �������� �̸�(emp_name), ���(emp_no), ���ʽ� ��� / ���ʽ� null �̸� 0���� ��ȯ(nvl(bonus,0))

select emp_name �̸�,
emp_no ���,
nvl(bonus,'0') ���ʽ�
from employee
where substr(emp_no,1,1)=6;



select emp_name �̸�,
case 
when substr(emp_no, 1, 2) > 60 then '60���'
end ���,
bonus ���ʽ�
from employee;


-- ���� 4. 010���� �ڵ��� ��ȣ�� ������� �ʴ� ������� ��( �긦 ���� ã��? 

-- ���� ��� �ؾ�����? substr���� ��κ� �� ã������, �� �׷���? substr�� ������?

select count(phone) ||'��' ���� 
from employee 
where substr(phone,1,3) not like '010';


-- ���� 5. ������ �̸�, �Ի��� ���

select emp_name �̸�, to_char(hire_date, 'fmyyyy"��" mm"��" dd"��"') �Ի���
from employee
order by hire_date;

-- ���� 6. �̸�, �ֹι�ȣ

select emp_name �̸�,
emp_no �ֹι�ȣ 
from employee;

-- ���� 7. ���� �̸�, �����ڵ�, ����(��) ���
-- ���� = ���ʽ� 1��ġ �޿�
-- ��� ���� ��,000,000,000 ǥ��

select * from employee;

select emp_name �̸�, 
job_code �����ڵ�,
to_char(nvl(bonus,0),'0.0') ||'%' ���ʽ�,
to_char((salary+((nvl(bonus,0))*salary))*12,'l999,999,999') ||'��' ���� -- to_char �� ���� �ٲ� �� ����. ������? ���ڰ� ��� ǥ��Ǳ� �ٶ���� ������ �����ϴ�. �ٽø��� ���ڸ� ���� ���ϴ� ���·� ǥ���ϰ� ���� �� �ִ�.
from employee;


-- ���� 8. �μ��ڵ�(dept_code='D5' and 'D9')�� D5, D9 ���� �� count(emp_name)
-- 2004�⵵ �Ի� ���� �� �˻�

select hire_date
from employee;

select 
count(emp_name) 
from employee
where substr(hire_date,1,2)='04';


-- ���� 9 : ���� �̸�, �Ի���, ���ñ��� �ٹ��ϼ� ���

select emp_name �̸�,
to_char(hire_date,'yyyy/mm/dd') �Ի���,
floor(sysdate-hire_date) ||'��' �ٹ��ϼ�
from employee
order by hire_date asc;

-- ���� 10: ���� ���� ���� ���, ���� ��� ��� - ����( ����⵵ : to_char(sysdate,'yy') �⵵�� ���) - (�ֹγ⵵ substr(emp_no,1,2))�� ���

select max(substr(emp_no,1,2)) ||'��' "�ְ����",
min(substr(emp_no,1,2)) ||'��' "�ֿ�����"
from employee;

select substr(emp_no,1,2) "����⵵ ���ڸ�",
to_char(sysdate,'yyyy') ���س⵵,
lpad(substr(emp_no,1,2),4,'19') ����⵵,
to_char(sysdate,'yyyy')-lpad(substr(emp_no,1,2),4,'19') ����,
emp_name �̸�
from employee
order by ���� asc;


-- ���� 11. �μ� �ڵ� D5, D6, D9 ���� = �߱�, �� �ܿ��� �߱� ���� ���
-- ��µǴ� ��, �̸�/�μ��ڵ�(��������)/�߱�����
-- �μ��ڵ� null = �߱� ����

select emp_name �̸�,
nvl(dept_code,'����') �μ��ڵ�,
case 
when dept_code='D5' then '��'
when dept_code='D9' then '��'
when dept_code='D6' then '��'
else  '��' 
end �߱�����
from employee
order by dept_code;

---

-- Group by : ������(field)�� �׷����� ��� ó���ϱ�, �׷� ���谡 ������ �Լ���(sum/avg/count/max/min)�� �Բ� ���� �� �ִ�.

select dept_code from employee group by dept_code;

select dept_code �μ��ڵ�,
to_char(sum(salary),'l999,999,999') �����հ�,
to_char(floor(avg(salary)),'l999,999,999') �������,
count(*) ||'��' �μ����ο�
from employee group by dept_code;


-- ���̺� ������ �μ��ڵ�, �μ����� ���ʽ��� ���޹޴� ����� ���� ��ȸ�ϰ� �ʹ�.
-- �̰� ���Ѱ���? �׷�ȭ ��Ű�°��� �׳�

select dept_code, 
count(bonus) 
from employee
group by dept_code
order by 1;

---
-- ���̺� ������ �������� �޿� ȯ��

select decode(substr(emp_no,8,1),1,'��',2,'��') ����, -- ������ �߰��ϱ� ���� �ڿ� group by�� ��Ÿ���� �͵��� �� �ø��� ������? group by�� ... grouping �Ѵٴ� ��, by �� ���ؼ�. �̰Ϳ� ���� � group�̵� Ȯ�����ų� �������� �� ����
count(*) �ο���, -- �ο��� �߰�
to_char(sum(salary),'l999,999,999') �޿�
from employee
group by decode(substr(emp_no,8,1),1,'��',2,'��'); -- group by ���θ� �ƿ� decode�� �� �� ����, case�� ���� �ʴ´ܴ�. decode(��� , 1�̸�,����,2��,����)


-- ���� : emp_table '���޺� = group by job_code' ������ ����, ����� count(*), ���޺� ��� �޿� ����

select job_code ����,
count(*) �����, -- count�� ������� ���ڸ� ��Ÿ��
to_char(sum(salary),'l999,999,999') "��ձ޿�" -- to_char �� charactor�� �ٲ۴ٴ� ��. �ٽø��� 
from employee
group by job_code
order by 1;

-- ���� �߰�(���ǹ��� �߰��Ǹ� ������ where) : ���� J1 �� ����, decode(job_code,'J1',null) �̰� �� ��� �ؾ�����?���ܽ�Ų��? is not like?  decode�� j1 �� �ƴ� �ֵ鸸?

select job_code ����,
count(*) �����, -- count�� ������� ���ڸ� ��Ÿ��
to_char(sum(salary),'l999,999,999') "��ձ޿�" -- to_char �� charactor�� �ٲ۴ٴ� ��. �ٽø��� 
from employee
where job_code!='J1'
group by job_code
order by 1;


-- ���� : employee ���̺���, �Ի� �⵵��(��������) hire_date
-- �� �ο��� ��ȸ, 
-- J1 ���� ���� ���
-- �Ի�⵵, �ο��� ���

select 
count(*) ||'��' �ο���,
to_char(hire_date,'yyyy') ||'��' as �Ի�⵵ 
from employee
where job_code!='J1'
group by hire_date -- �̷��� �ϸ� 1994�� 1��, 1������ 2������ �������� ��µ�. ������? �׷� ���� ���� �ʾ� �浹���� ��
order by �Ի�⵵  asc;


-- �ùٸ� ǥ��

select 
count(*) ||'��' �ο���,
to_char(hire_date,'yyyy') ||'��' as �Ի�⵵ 
from employee
where job_code!='J1'
group by to_char(hire_date,'yyyy') ||'��' -- �̷��� �ϸ� 1994�� 1��, 1������ 2������ �������� ��µ�. ������? �׷� ���� ���� �ʾ� �浹���� ��
order by �Ի�⵵  asc;

-- ����� ��


---

select 
extract(year from hire_Date) ||'��' �Ի�⵵,
job_code,
count(*) ||'��' as �ο���
from employee
group by extract(year from hire_Date) ||'��', job_code -- �갡 ���� ��� �Ǿ�� �ִ°ǰ�? group�� §��? group ���� 
order by 2 ;


---

select dept_code ,
job_code
from employee 
group by dept_code, job_code
order by 1; -- �׷�ȭ�� �̸� �����ε� �ϰ� ����. �ϳ��� �̸��� �ϳ��� �׷�����, �׷�ȭ��� �� ���ο� row�� �ϳ� ����ٴ� ��ó�� ���̱⵵ �Ѵ�. �����Ѵٴ� ��


-- �μ����� �׷�ȭ , �������� �׷�ȭ / ��� = �μ�/����/�ο�

select dept_code �μ�,
decode(substr(emp_no,8,1),1,'��',2,'��') ����, -- decode �� ���� ������? if��, if 1�̸� ����, 2�� ���ڷ��ؼ� ���� �� �ְ� ����°���. ��? 1�� 2�� �׷�ȭ ���� �� �ֵ��� �ϴ°ž�.
count(*) �ο�
from employee
group by dept_code, decode(substr(emp_no,8,1),1,'��',2,'��')
order by �μ�;


---

-- having : group by �׷�����

select to_char(sum(salary),'l999,999,999') �μ����޿��հ�,
dept_code �μ�
from employee
--where sum(salary) > 10000000 -- where �� �ȿ��� sum/max/min/count �� ���� �׷����� ���� ���� �׷��Լ��� ���� �� ����. where ���� �׷��Լ� ������. ��������� ��������. ó������ from���� ���� ã�´�, �� �� where�ε�, salary>10000000�ϸ� 
group by dept_code
having sum(salary)>10000000 -- �μ��� �հ谡 1õ���� �̻��� �μ��� ã�� �ʹ�!
order by 1;



-- ���� : �޿� ����� 3�鸸�� �̻��� �μ�, �޿� ��հ� ���

select to_char(floor(avg(salary)),'l999,999,999') "�μ������(300���̻�)",
dept_code �μ��ڵ�
from employee
group by dept_code
having avg(salary) > 3000000;

-- having �� where�� ����? ������ �� �ʿ��� ��?


---

-- �˾ƾ��� ��
/*
���� ����

From 1
Where 2
Group by 3
Having 4
Select 5
Order by 6

*/




---

-- ������

-- �پ��ϰ� �غ��� ���� �ڵ��� �ݹ� �ø� �� �ִ� ���� ����̶�� ���� �ǻ����. ���� �ڲ� �ᳪ���鼭, ���� ���� ������ �ϴ��� �ľ��س����鼭 ���� ���ٺ��� ���� ȿ�������� �帧�� ���� �ʰ� �ڵ��� �����ϴ�.

-- ��ǻ�Ͱ� �� �ڵ��� ��� �ҷ������� �ǽð����� ������ �ʴ´�. 

-- �������� �� Ǯ���� �͵� ������ ������ ����? �����ϰų� �Ӹ������� �򰥸����� ������ ������. �׸��� ���� ���ϴ� ������ ��ǻ�� ���� ��� ǥ������ �� �ľǸ� �صθ� �� �Ǵ� ��

-- �����ð����� subquary ���� �Ӹ� ���� ���ư��ٰ� 



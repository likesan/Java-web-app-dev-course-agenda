-- ��Ǯ�� ���� 1 : �μ��ڵ� D2�� �������� �����, ���޸�, �μ���, �ٹ��������� ���

select * from employee;
select * from job;
select * from department;
select * from location;

select e.emp_name �����,
j.job_name ���޸�,
e.dept_code �μ���,
l.local_name �ٹ�������
from employee e, job j, department d, location l
where
e.job_code = j.job_code
and d.location_id = l.local_code 
and e.dept_code = d.dept_id 
and e.dept_code = 'D2';

-- ���ʽ� ����Ʈ�� ���� ������ ��, ���� ����� ����� �������� �����, ���޸�, �޿� ���

select * from employee;
select * from job;

select emp_name �����,
job_name ���޸�,
bonus ���ʽ�,
to_char(salary,'l999,999,999') �޿�
from employee e,job j
where bonus is null
and (job_name = '����' or job_name='���')
and e.job_code = j.job_code;

-- ���� 3 : ������(���� ������� ���� ���=ent_date!=null)�� ������ �����(ent_date) ������ ��(count()) ���
-- �긦 ��� �ؾߵǴ°���? �� ��ü���� count��� ��ɾ ���°� �˰ڴµ�?
-- ent_date�� null �̸� �������ΰɷ�? end_date�� null�� �ƴϸ� ������ΰɷ�? case�� �ؾ��� ��?
select * from employee;


select
-- ����� �������ζ�� �ݷ��� �ϳ� ������� ��� ����? �׸��� row���� ������ �ַ���?

case 
when ent_date is null then '���'
when ent_date is not null then '����'
end ��������
,
case
when ent_yn = 'N' then count('N')
when ent_yn = 'Y' then count('Y')
end �ο���
from employee
group by ent_date,ent_yn; -- �׷����� ��Ȯ�� ��� �ϴ°���? �׳� �� �ϸ� �ǳ�? �� ������ ��Ÿ���� �ֵ��̴ϱ�


-- ���� ���� ���� : SubQuary , ���� ��ٷο� ��. �ѹ��� �ΰ��� �ᳪ���� ������ ��ư� ������ �� �ִ� ��Ʈ
-- ���� �ȿ� ������ �� �ִ� ��


-- - - -
select * from employee;

select emp_name from (select emp_id, emp_name from employee);

-- �������� : ��ȣ �ۿ� �ִ� ��
-- �������� : Quary �ȿ��� �����ִ� �༮

-- �˱� �˰ڴٸ� �� ������ ���� ���°ǰ�? ����..



-- ���� 1 : ������ ������ �Ŵ��� ID �˾Ƴ���


select manager_id from employee where emp_name = '������';

-- ���� 1.5 : ������ ������ �Ŵ��� �̸� �˾Ƴ���

select emp_name from employee where emp_id = 214;


-- ���� 1.75 :  �긦 ���� ������ ǥ��
select emp_name from employee where emp_id = ( select manager_id from employee where emp_name ='������ ') ; -- ��� �� �ȵ���?


-- ����� field�� �巯�� ���� return ���̴�. �̰� ���� ������ ������ �� ���� return�Ǿ� ���´�.

-- `���� 1 : �� ������ ��� avg �޿� ���ϱ�`

--```
select to_char(floor(avg(salary)),'l999,999,999') as "�� ���� ��� �޿�" from employee; 
--```

-- ���� 1.5 : �� ��� �޿����� ���� �޴� ������ ��� ��� ( where���� �غ���)

-- ```
select
emp_name "����̻�޿�������", 
to_char(salary,'l999,999,999') "�޿�" ,
(select to_char(floor(avg(salary)),'l999,999,999') as "�� ���� ��� �޿�" from employee) "��ձ޿�"
from employee 
where salary > (select floor(avg(salary)) as "�� ���� ��� �޿�" from employee ); -- `to_char�� �س��� ���¿����� ���ڿ� ����� �Ұ����ϴ�. to_char�� ������� ����������.`
-- ```

-- ���ϰ� �������� : �������� �� �ϳ��� row�� ������ ��� = ���ϰ� ��������, field ��ĭ�� ���� ��� ���� �� 
-- ������ �������� : ��(row) �ϳ��� ������ row�� �Ҿ� �����Ǵ� ��
-- ���߿� �������� : column �������� �� �����Ǵ� ��� ���� �ϳ��� ��츸 ���ϴ°ǰ�?
-- ������ ���߿� �������� : ��� ���� �������� ��������

-- ���� 1. ������ ������ �޿��� ���� ������� ã������. ã�� �� �� ������� �����ȣ, �����, �޿� ���

select * from employee;

select salary �����ر޿�
from employee
where emp_name = '������';

select emp_id �����ȣ,
emp_name �����,
to_char(salary,'l999,999,999') �޿�
from employee
where salary = (select salary �����ر޿� from employee where emp_name = '������') 
and emp_name!='������'; 

-- != Ȱ���� ���� ������ ��Ͽ��� ���ֱ�. where������ �ؾ� �ƿ� ����� �ȵǰ� �����. 
-- ���ǿ��� �����ع����Ƿ�. select���� ������ �غ��� nvl �Ǵ� case/decode ���� �б⹮���δ� �ᱹ null ���� ����ϰ� ��, 
-- ��� ��ü�� ���ַ��� where������ �����ؾ��Ѵ�. �ƿ� �������� ���� ���� ���̹Ƿ�.


-- ���� 2. �⺻�޿��� ���� ���� ���(max(salary))�� ���� ���� ���(min(salary)�� ������ ����ϼ���. �� ��°? 
-- ���, �����, �޿�

-- ���������� ���� ���ϱ�, ���� ���� �Ͱ� ���߿� ���� �͵��� ã�ƾ��Ѵ�. ���?
-- ���� ���� �ʿ�� �Ǿ����� ������ �˾ƾ����� ������?

select 
max(salary) �޿��ְ��
from employee;

select
min(salary) �޿�������
from employee;


select emp_id ���,
emp_name �����,
salary
from employee
where 
(salary=(select max(salary) �޿��ְ�� from employee)) 
or 
(salary=(select min(salary) �޿������� from employee));


-- ���� 3 : D1, D2 �μ��� �ٹ� ��� ��
-- �⺻ �޿��� D5 �μ� �������� ��� ���޺��� ���� ����鿡 ����
-- �μ���, �����ȣ , �����, �޿� ���

select * from 
employee;
select * from
department;

select
d.dept_title �μ���,
emp_no �����ȣ,
emp_name �����,
salary �޿�
from employee,department d
where
dept_code in ('D1' , 'D2')
and dept_code = d.DEPT_ID
and salary > (select floor(avg(salary)) from employee where dept_code='D5');




select emp_name -- �⺻ �޿��� (D5�μ� �������� ��� ���� avg(salary))���� ���� �����
from employee
where salary>=(select floor(avg(salary))
from employee
where dept_code='D5');


select floor(avg(salary)) -- 
from employee
where dept_code='D5'; -- D5�μ� �������� ��� ���� avg(salary)

-- �ٽ� �о������ �� ������?

-- ���� ���� ���� �������� ã�ƾ��Ѵ�. ���� ���� ���������� ��� �Ǵ°���?



-- - - -
-- ������ ��������
-- ������ In / Not in / any / all/ exist ��밡��

-- ������ �Ǵ� �ڳ������� ���Ե� �μ� �ڵ� ���

select 
emp_name ,
dept_code �μ��ڵ�
from employee
where emp_name in ('������' , '�ڳ���') ; -- ������ ���


-- ������ �Ǵ� �ڳ��󾾰� ���Ե� �μ��� ������ ���� ���

select * from employee where dept_code = (select 
emp_name ,
dept_code �μ��ڵ�
from employee
where emp_name in ('������' , '�ڳ���')); -- ����

select * from employee 
where dept_code in 
(select 
dept_code �μ��ڵ�
from employee
where emp_name in ('������' , '�ڳ���')); 

-- ���� ���� ���� ���� where �÷��� = �� �ƴ϶�, where �÷��� in (subquary) �� ���� �ȴ�.


-- ���� 1 : ���¿��� ������where emp_name in ('���¿�','������')�� �޿� ���(sal_level ���� ã��)�� ������ ��� ���� ������� ���޸� / ����� ���
-- ���޸� �����


select 
sal_level �޿����
from employee
where emp_name in ('���¿�','������');


-- - - -
select * from employee;


select 
sal_level ���޸�,
emp_name �����
from sal_grade;





select emp_name �����,
job_code ���޸�
from employee
where sal_level in (
select 
sal_level �޿����
from employee
where emp_name in ('���¿�','������'))
order by 2;


-- - - -
-- ���� 2. �Ѹ� �̻��� ������ ���ؼ� ������ ������ ����(??)�ϴ� (  null!= ���� �ƴϸ� ?? ��� �϶�°���? �ϳ� �̻������� > 1�ε�ȣ�� �ؾ��ϳ�? group by �� �����ؾ��ϳ�? group by ���� �ǳ�?������ �ƴ��� �������?
-- ������ ���, �̸�, ���޸��� ����ϼ���~

select * from employee;
select * from job;

-- self join�� �� ���°���? ���̺� �ڱ� �ڽ��� ���� 2�� ȣ���ϴ� ����� �������� �ʱ� ���� �ƴѰ�

select emp_id ���,
emp_name �̸�,
job_name ���޸�
from employee e,  job j
where
emp_id in (select manager_id from employee) -- �긦 ��� �����ؾ��ұ�? manager id�� ���� �ִ� �ֵ� = ������. �ٽø���, �Ŵ��� ���̵� ���� �ִ� ����� = �Ѹ� �̻��� ������ ���� ������ ������ �����ϴ� �����.
and e.job_code = j.job_code
;

select 
distinct manager_id from employee; -- ��װ� �Ŵ�����? �� ? �Ŵ��� ���̵� ���� ������?  �Ŵ��� ���̵� ���� ������ ��~ 

-- distinct = �ߺ� ����, select �ȿ��� �۵���


-- ���� 3 : ������ ��ǥ(job name !=��ǥ, �λ���)�� �ƴ� ��� ������ �̸�, �μ���, �����ڵ� ���

select e.emp_name �̸�,
d.dept_title �μ���,
j.job_name ������,
s.sal_level �����ڵ�
from employee e, department d, job j,sal_grade s
where job_name != '��ǥ' and job_name !='�λ���'
and (e.dept_code = d.dept_id)
and (e.job_code = j.job_code)
and (e.sal_level = s.sal_level)
order by 2;


-- - - - 


-- ANY() �� �߿� �ƹ��ų� ������ �����Ѵٸ� true��

select emp_name, salary from employee where salary > any(2000000, 3000000, 5000000); --  �� �߿� �ƹ��ų� 2�鸸���� ū ��

-- �������� ������ �� �� �ִ�.

select salary from employee where job_code = 'J3';  --3400000 , 3900000, 3500000 ���� ���ϵ� , select �� salary �̹Ƿ� return ���� salary

select emp_name, salary from employee where salary < any(
select salary from employee where job_code = 'J3');

-- salary > any();
-- salary ���� any �׷� �ȿ� �����ִ� ���� �� / �ּҰ� ���� ũ�� ��

-- salary < any ();
-- salary ���� any �׷� �ȿ� �����ִ� ���� �� �ִ밪 ���� ������ ��. 

-- any ���� ���� �� ���縸 �Ѵٸ� ���� �Ǵ°�?

-- ���� :  D1 �Ǵ� D5 �μ� ������� �޿� �߿��� ���� ���� �޿����� ���� ��� ������� �̸� �޿� �μ��ڵ� ���

select 
salary
from employee
where dept_code in ('D1','D5');



select 
emp_name �����,
salary �޿�,
dept_code �μ��ڵ�
from employee
where salary < any(select salary from employee where dept_code in ('D1','D5'))
order by 2;


-- ���� : �μ���  ��� �޿��� �������� ��
-- ���� ���� �μ��� �޿����� ���ų�, ���� 
-- ��� ������� �̸� / �޿� / �μ��� ���

select avg(salary)
from employee
group by dept_code; -- group by �� dept_code�� �����⿡ ������ ���������� ������� ��Ÿ����. �׷����� �ұ��ϰ� 

select emp_name �̸�,
salary �޿�, 
dept_title �μ���
from employee e, department d
where salary >= any (select avg(salary) from employee group by dept_code) -- ���� �����ΰ�? salary? �ֵ��� ���� �ִ� �� = salary, dept_code�� grouping �� �μ����� ��� �޿���= any()
and e.dept_code = d.dept_id
order by 2 desc;

-- ## All : �� ��� �߿��� ���� ū���� ������ �Ѵ�? 
select emp_name, salary from employee where salary > all(2000000,3000000,5000000);
-- salary �� ũ�ٸ�?��� ������ �� ���� ū���� ������ �Ѵ�?

select emp_name, salary from employee where salary < all(2000000,3000000,5000000);
-- all�� �����ִ� ���ڵ� �� ���� ���� ������ salary �� �۴ٸ�

-- ���� 6 : D2 �μ��� ��� ������� (all(select emp_name from employee where dept_code = 'D2')  
-- ���� �޿� salary < �������� ����, �ٽø��� ���� ������ ������ ���� �ֵ�, �ε�ȣ�δ� <
-- �� �޴� ����� �̸� �� �޿� ���

(select salary from employee where dept_code = 'D2'); -- 1550000, 2490000, 2480000

select emp_name, salary from employee order by 2; -- ���� ���� �޿� �̹Ƿ� 1550000 - �ӽ�ȯ �� �ش�ȵ�, �� ���� ������ �����ϹǷ�

select emp_name �̸�, 
to_char(salary,'l999,999,999') �޿�
from employee 
where salary < all(select salary from employee where dept_code = 'D2');


-- ���� 7 :   \\ select (max(substr(emp_no,1,2)) from employee where dept_code = 'D1' 
--  D1 �μ����� ���� ���̰� ���� ��� ���� �� ���̰� ���� D2 �μ��� ���� ,              \\ ���� ��� �񱳰���? < max(substr(emp_no,1,2)) from employee where dept_code = 'D2'
-- �� �̸�      emp_name �� ����substr((emp_no),1,2)�� ������ּ���.

select emp_name �̸�, 
dept_code �μ���ȣ,
substr(emp_no,1,2) ����
from employee
where dept_code = 'D2'
and substr(emp_no,1,2) < all ( select 
substr(emp_no,1,2) ���� 
from employee 
where dept_code = 'D1') ;  --66/77/80 D1 �μ��� ���� ���� ���� ���� / �긦 D2�� ���ؾ��Ѵ�?

select 
substr(emp_no,1,2) ���� 
from employee 
where dept_code = 'D1' ;





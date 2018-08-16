select * from employee;

select rtrim(email,'@kh.or.kr') from employee; 


select dept_code, 
to_char(sum(salary),'l999,999,999')  
from employee 
group by dept_code 
having sum(salary) >10000000
order by 1;

-- ���� �ð� ����

-- Group�� ���ؼ��� where ���� ����� �� ����. �� ? quary�� ���� ������ ���� ������ ����.
-- ���� ���� 1. From > 2. Where  > 3. Group by  > 4. Having  > 5. Select  > 6. Order by 
-- �ϱ��ϱ�, �׷��� ���߿� �м� ����, ������� ���󰡴� ��� ������ ������� �ľ��ϰ� �ȴٰ�.  FWGHSO

select dept_code, 
to_char(sum(salary),'l999,999,999')  
from employee 
group by dept_code 
having sum(salary) >10000000
order by 1;


-- roll up / cube �Լ� : �׷�ȭ ������ ���� ���� �Լ� ( group by ������ �� ) 

select dept_code �μ��ڵ�, 
sum(salary) �μ����޿��հ�
from employee 
group by rollup(dept_code) -- roll up : ���� �Լ�, ��� �μ��� �� �հ赵 ��Ÿ���� ����. ���� ��� �ٲ���? 
order by 1;


select dept_code �μ��ڵ�, 
sum(salary) �μ����޿��հ�
from employee 
group by cube(dept_code) -- cube :  
order by 1;

-- roll up vs cube : �׷��� �ϳ��� �������Ŀ� ���� ������� �޶���

select 
dept_code,
job_code �����ڵ�,
sum(salary)
from employee
group by  rollup(dept_code), job_code -- �Ѿ����� �� ������, �μ��� ������� ��Ÿ������. ��� ���� �� �ֳ�? �μ����� ������ ��� ���� ��Ÿ�������� �� ȭ�鿡 ��Ÿ���� ������. �׷��� �� �̸��� rollup����? ���� �Ⱦ������? ���� �ø��ٶ�� �ǰ�?
order by 2;

-- roll up : �׷�ȭ �� �ڷḦ �հ�� ���� ��ɾ�, �׷������� group by �ȿ����� ���� �� �ִٰ�.  �׷��� �� �ϳ����� �Ǵ°���? �� job_code �� ������ ���� �Ǵ°ž�? �� dept_code�� ���������� ��Ÿ���� �ʴ°ǰ�? ��������δ� �� �� �͵� ������ �� �ȵǴ°��� �� ���̰� �ִ°���?
-- �̻��Ѱ� dept_code�� �Ѿ��� �ɾ��µ� �� ����� ���ä��� �ȳ�����?

select 
dept_code �μ��ڵ�
,  job_code �����ڵ�
,  sum(salary)  �μ����޿��հ�
from employee 
group by cube(dept_code,job_code) order by 1;

-- rollup ���� : �μ��� ���޺� 
-- cube :  �°� ������ �׳� ���踦(�μ��� �հ� / ���޺� �հ� / ��� �μ��� ����) ��� ������ִ� ��ɾ�

-- rollup �� cube�� ���� ? rollup�� ... ���ϴ� �� ���踦 �����ϴ°����� cube�� ��� ������ ��Ÿ����?



select dept_code �μ���, sum(salary) �Ѱ� from employee group by cube(dept_code) order by 1; -- dept_code �� ���� ������ ���� 
select nvl(dept_code,'Intern') �μ���, sum(salary) �Ѱ� from employee group by rollup(dept_code) order by 1; 
select grouping(dept_code) �μ���, sum(salary) �Ѱ� from employee group by rollup(dept_code) order by 1;

-- grouping? ���� �Լ�(rollup / cube)�� ���� ��Ÿ�� ��(���ϵ� ��)�� null ���� 1�� �ȴ�? ��� Ư���� Ȱ���Ͽ�, �����Լ� ���� �ƴ��� 0�� 1�� ����Ͽ� �������� ������ִ� �Լ�
-- 1�̸� '����'�̶�� ����ض� ��� �Լ��� ���� ������? ���ϴ� ������ �ٲٰ� ����� ��? = decode / case �б⹮
 
select grouping(dept_code) �μ���, sum(salary) �Ѱ� from employee group by rollup(dept_code) order by 1;

-- �б⹮? decoding / case 


-- select decode(grouping(dept_code), 0, nvl(dept_code,'����'),1,'����') �μ�,
select decode(grouping(dept_code), 0, nvl(dept_code,'����'),'����') �μ�, -- �� : �б⹮(decode/case �Լ�) 2��° ���ڸ� �־����� �ʾƵ� �۵��� �Ѵ�?
job_code �����ڵ�,
sum(salary) �����Ѱ�
from employee
group by rollup(dept_code, job_code)
order by 1,2;

-- �̰� ����, ����(�μ����� ���� �������� �ʴ� null������ ���� �ִ� �μ�)���� ǥ���ϰ�, rollup�� ���� ���ϴ� �μ����� ���ո��� ��Ÿ������.
-- ������ ��, 1) rollup �Ǵ� cube�� ���� ���հ踦 ��Ÿ���� �Լ��� return ��(1)�� ���´�. �� 1�� ����, �ƿ� �ƹ����Ե� ���� �����Ǿ� ���� �ʾ� null ���� ���� �ִ� column�� �������� �� �ֲ� �ȴ�. 
-- �ֳ��ϸ� �� null������ ���� �ִ� column�� ���ϰ��� 0�̹Ƿ�, ��ſ� ����(rollup/cube �� ���� �Լ����� return ������ ��Ÿ�� �� ������ 
-- �߿��Ѱ� roll up�� cube�� ���� ���� ����ϴ��İ� ���� �� �ʹ��� �ʴ´�? rollup(dept_code)�� �ϤŤ��� �� ������ �� �ϱ� �������ϱ� cube�� �����ϴ°ǰ�?


-- ���� , �μ��� �ο�(count(dept_code)) �� ��� �μ��� �� �ο��� ������ּ���.
-- cube

select 
decode(grouping(dept_code),0,nvl(dept_code,'������(����)'),1,'�� �ο�') �μ�, -- �μ��� null�̴�? �μ��� ���� �������� �ʾҴ�? intern�̴�? �̰� nvl��.. ���⼭ �������°Ŵϱ� �׷�����? grouping dept_code��... ���ϴ°���? �׷�ȭ �س��°�? grouping �� ���ϴ� ������?
count(dept_code) "�μ��� �ο�"
from employee
group by cube(dept_code)
order by 1;


-- ����, �μ��� ���� �ڵ带 �׷�ȭ ���Ѽ� rollup

select nvl(decode(grouping(dept_code),0,dept_code,1,'�հ�'),'����') �μ��ڵ�,
case
when grouping(job_code) = '0' then job_code
when grouping(job_code) = 1 and grouping(dept_code) =1 then '�հ�'
when grouping(job_code) = '1' then '�μ����հ�'
end �����ڵ�, -- ��� �ؾ��ϳ� ��׸� �ٽ� �� 0�� 1�� ���̴�. �̰� ��� �̿��Ѵ�? �̸� �̿��ϱ� ���ؼ� decode�� ��߰���? �μ��ڵ��� ������ '�հ�'���, �� ���� null�� '�հ�'�� �Ѵٴ� ��ɾ ������ ���ڴµ� �װ� ����?
sum(salary) �μ����޿��հ� 
from employee
group by rollup(dept_code, job_code) 
order by 1,2;

-- �ƴ�. 1�� 1�� ��Ȳ�̴ϱ� case �� ����� �� ����, when �������� ������ �߿��ϳ�. �׳� case�� �ϸ� �Ǵ°ſ���. case������ �پ��� ��Ȳ�� ���� �� �����ϱ�? decode�δ� �ȵǴ°ǰ�? decode������ �̰� �����ϰ� ����°� �������� �𸣰ڳ�.

-- ����Կ��� ����� decode��� �ɷδ� and�� or ��, ���ÿ� ������ų �� �ִ� ���ǹ��� ����� ���� �Ұ����ϴٰ� �Ѵ�.
-- �����ϴ� �� �Ⱦ��ϸ� coding�� �� �� ���� �� ����. �ֳ��ϸ� �� ������ �����ϴϱ�. �� �������� �����ϰ� Ǯ��� ���� ��ü�� coding�ε� �̰� �Ⱦ��ϴ� ����̶�� ...�ݴ�� �̰� ������ ���ϱ� ���ؼ� ������ Ǯ����� ��µ��� �س������Ѵ�. 
-- ��� �����Ϸ��� �õ����� ��� �� �˾ƾ��Ѵ�. �׷��� ���ؼ�, �� �����ο��� '�� �ڵ��� ����Ѵ�.' 
-- '�� ������ ���� �� ��Ȳ�� �����ϰ� ������ �ʴ´�.' 
-- '�� ������ �ذ��ϱ� ���� ���ȣ��� ������ ����� �̿��Ͽ� ������ Ǯ���� ����ϰڴ�.'' ��� ��µ��� �ؾ��Ѵ�.
-- ���� ����� ���� ��� ������ ������ ���� �ð�� ������ �ٰ� Ǯ����� ����� ȸ���� ���� �ִ�. Ư���� �����ε��� �̷��� ������ ������ �����ϰ� ���� ���� �ִ�.
-- ���̶�� �� ���ϰ� ������ �ɾƼ� �� �� ��μ� �������� �����ϰ� ���� ��Ƴ� �� �����ϱ�. ���� ���ϴ°� ���������� ���̰� �ƹ��͵� ���� �ʴ� ������.


-- - - - 

-- ���������� �ʿ����� ������? ������ ������ ������? ������ �ѹ� �� ����� �ٲٰ� �ѹ� �� ����� �ٲٰ� �ؾߵǼ� ���� ��. ��� ���������� �����Ѵٸ� �Ǹ������� ��

-- ���� : �Ʒ� ������ ť�굵 �ѹ� Ǯ���. 1) grouping���� 1�� 0���� ��Ÿ������ 2)nvl �� case�� ����غ���.

select 
case grouping(dept_code)
when grouping(dept_code) = 1  then '�հ�'
end "���ڵ�",  -- �׷��� grouping�� �ϴµ� �� 0�� 1�� �����°ɱ�? 0�� 1��θ� grouping �Ѵٴ� �ǰ�? ��... 0�� 1�� �����Ѵٴ� ��������...
job_code, 
sum(salary)
from employee
group by cube(dept_code, job_code)
order by 2;

-- db �������� ����� ȿ������ �ʿ�� �Ѵٰ�

-- - - - ### ���� ��� ����
-- Join  : (������Ų��? �ִ´�? �Բ��Ѵ�? ���� ������?) �ϳ� �̻��� ���̺��� ������ ������ ��� �ϳ��� ���� ���̺�� ������ִ� ���, index join�� ������ ���߿� �� ������ ���
 
-- �������� (Inner join) : ����/�ڿ�/���� ���� 

-- �������� : ���� ���� �� 
-- �ڿ����� : ??
-- �������� : �������� / �Ǽ����� ���� ��

-- �ڱ����� (Self join)

desc job;
select * from job;

desc department;
select * from department;


-- for �� �ȿ�  for ���� �ֵ��� for�� �ΰ��� �������� ������ �Ͱ� ���ٴ� �� �����ϴ°� �߿��� ��, �ϳ��� ��µǰ�, �� J1 ���� ��� �� ������ �ϴ� �� = ��������, �������εǾ� ���� ������ 'īƼ�� ���δ�Ʈ(Cartesian product)'��� �Ѵ�?
select * from department, job;
-- ���� ���ְų� �߸����� �� �̷��� �ȴٰ� ? carte�� ī���ε� �� Decarte�� ���� ī�װ�ȭ �� ������ �ִ� �� ����. 
-- ���� �̸� ��µǱ� ���� ������� ���� �� �ľ��ϱ� ����, �̸� �˾Ƶδ°� �ʿ��ϴٰ� �Ѵ�.

select job_code, job_code_1 from employee, job; -- ���� ��, job_code_1
select job_code from employee, job; -- Ambigious ����, '��ȣ�� ����', '�����̺�(employee,job) �� ��Ȯ�� � column �� ����ϰ��� �ϴ°ǰ���? �𸣰ڳ׿�?'
select employee.job_code , job.job_code from employee , job ; -- ��ȣ�� ���� �ذ� ���� table.�� �־��ش�.


select employee.job_code , job.job_code from employee e, job j; -- �г����� �� �� �ִٰ�  -- having �� where�� ���̰� ���ڱ� �ñ�������.

-- ���� ���� �ִ� ���� ������ �Ǵ� �� ���� ���强�� �����Ѵ�.

select e.emp_name �̸�, e.job_code, j.job_name from employee e, job j; -- �ǹ̾��� �������ε� ����� ��Ÿ��

-- �������� : where ����, ������ �ִµ�(���� ���� ����Ǿ� ��µǵ��� ������), 

select e.emp_name �̸�, e.job_code, j.job_name from employee e, job j where e.job_code = j.job_code;  -- �ǹ̾��� ���� ���ε� �������, e.job_code �� j.job_code�� ���� ������ ��µǰ� ����



-- ���� 1 : employee ���̺��� �������� �̸� / �μ��ڵ� / �μ� �̸� ��� - ��� �ؾߵǳ�?

select * from employee;
select * from department;
select * from location;

select emp_name �̸�, 
dept_code �μ��ڵ�,
department.dept_title �μ��̸�
from employee, department
where employee.dept_code = department.DEPT_ID -- ���� ���� �μ������� ������ָ�, ������ ���� ���εǸ�, �̸� ���������̶�� �Ѵ�. ����, �Բ� ����ϰ� ����� ��, �� �� �̻��� ���̺��� �Բ� ��Ÿ������ �ϴ� ��
order by 2;


-- ���� 2 : �� department ���̺��� �� �μ��� ��� ����(dep_location)�� ��ġ�ϴ��� location ���̺��� ã�� ���


select dept_id,
dept_title,
local_name
from department d, location l -- from���� �������� ����
where d.location_id= l.local_code; -- �� ���̺��� �����ϰ� �ʹٸ�, field ���� �Ȱ��� �ֵ鸸 �̾��ָ� �ȴ�. �̾���� ���� ���� �ֵ鸸 ��� �� ���̹Ƿ�


select e.emp_name, 
e.dept_code, 
d.dept_title
from employee e, department d;
-- �μ��ڵ忡 ���� �μ���

---
-- �� ���̺��� ���������ϱ�

select e.emp_name, d.dept_title �μ�, l.local_name ����, d.dept_title
from department d, location l, employee e;

select * from department;
select * from location;
select * from national;
-- �μ���ġ ���̵� ���� ���� �̸�



-- ���� ���� ���� 1 : �μ��� �ڵ� / �̸� / local_name �� national_name ���

select 
d.dept_id,
d.dept_title,
l.local_name,
n.national_name 
from department d,  location l, national n
where l.local_code = d.location_id and l.national_code = n.national_code; -- �׳� �ߺ��Ǵ� ���鳢�� �����ָ�, '='������ ����������� ���� �׳� �ߺ��Ǵ� ���� ��������� where�� ���ǹ��� �Ǿ�, ���� �ߺ��Ǵ� ���� ��µǰ� ���ش�.



-- Self Join : �������� ���� ���̺� �ִ� ��? - from �ȿ��� table�� ����� ���� ���̺������� �ٸ� ���̺���� ������  �����Ѵ�.
-- ��� ���� : 
select * from employee e1, employee e2;

select emp_name, 
manager_id 
from employee;


-- self join�� ���� �ʰ� , �Ŵ����� �̸�(emp id = emp name)�� ����غ���

select 
case emp_id
when emp_id=manager_id then emp_id,
emp_name,
manager_id
from employee;


select e1.emp_id, e2.emp_id, e1.emp_name, e2.emp_name
from employee e1, employee e2
where e1.manager_id = e2.emp_id; --where �� �Ȱ��� ������� �� ��Ÿ������ �ش޶�� ���̴ϱ�, �� where�� ���� ���� �͸� ��µǰ� �ش޶�� ���̺��� join���ѳ�����, ������ ���� ���� �����Ǵ� field�� ����� ��. ���ΰ� �����ϰ� ¦�� �´� �ڷḸ ����� �� ���̹Ƿ� �� ���̺� �߿��� �����ϴ� ���� ������ �ȴٰ�.



-- ������ �̸�, �������� �̸�, �������� �޿�, �������� ���� ���

select * from employee;

select
e2.emp_name as "��� �̸�",
e1.emp_name "�Ŵ��� �̸�",
e1.salary "��� �޿�",
e1.job_code "��� �ڵ�"
from employee e1, employee e2
where e1.manager_id = e2.emp_id
order by 1;



-- ���� 1 : 2020�� 12�� 25���� ���� �������� ���

select to_char(to_date('2020/12/25'),'dy') from dual;



-- ���� 2 : �̸��� '��'�ڰ� ���� �������� ��� ����� �μ��� ��� instr? ( �̰� )

select * from employee;

select 
emp_name, -- �� �� ��� �ؾ��ϴ°���?
emp_id ���,
dept_code �μ���
from employee
where (emp_name like '��%' -- �� 3���� ����� ���� �� �س��� �Ǵ°���? ��... �ϱ�� �̸��� �����ڴϱ� �׷��� �׳� ��% �ص� ã�������ϴ°� �ƴѰ�?
or emp_name like '%��'
or emp_name like '%��%'); -- grouping �� �ؾ��ϳ�? ���⼭ ���� �� �ϸ� �� �� ������? �ش� �ο츸 ������ ����°� ��������?


-- ���� 3 : 1970��� ���̸鼭 ������ ����substr(emp_no,8,1)='2', ���� ����('instr(1,1)='��')�� ����� �����, �ֹι�ȣ, �μ���, ���޸� ���

select * from employee;
select * from job;
select * from department;

select 
e.emp_name,
e.emp_no,
d.dept_title,
j.job_name
from employee e, job j, department d
where (substr(emp_no,1,2) > 70 and substr(emp_no,1,2) < 80)
and (substr(emp_no,8,1)='2' and emp_name like '��%')
and (e.job_code = j.job_code)
and (d.dept_id = e.dept_code);

-- �긦 ��Ʈ�� �Ἥ �غ���

select 
e.emp_name,
e.emp_no,
d.dept_title,
j.job_name
from employee e, job j, department d
where (substr(emp_no,1,2) between 70 and  80)
and (substr(emp_no,8,1)='2' and emp_name like '��%')
and (e.job_code = j.job_code)
and (d.dept_id = e.dept_code);



-- ���� 4 : �ؿܿ����ο� �ٹ��ϴ� ����� , ���޺�, �μ��ڵ�, �μ����� ���


select * from employee;
select * from job;
select * from department;

select e.emp_name, 
j.job_name,
d.dept_id,
d.dept_title
from employee e, department d, job j
where (d.dept_title = '�ؿܿ���1��' or
d.dept_title = '�ؿܿ���2��' or
d.dept_title = '�ؿܿ���3��' )
and d.dept_id = e.dept_code
and e.job_code = j.job_code
order by 4;


select emp_name
from employee
where dept_code='D5';

select * from employee;
select * from job;
select * from department;
select * from location;
select * from national;
-- ���� 5 : ���ʽ� ����Ʈ�� �޴� ���� ���� ����� / ���ʽ� ����Ʈ / �μ��� / �ٹ������� ���

select emp_name �����,
bonus ���ʽ�
from employee;

select emp_name �����,
bonus "���ʽ� ����Ʈ",
dept_title �μ���,
national_name
from department d,employee e, national n, location l
where bonus is not null
and e.dept_code = d.dept_id -- ��� �ؾ� �ϵ�� ������ �� �� ������? �ϵ����� �ȳ����� ������ ����? dept_code�� null �̶�? �׷��� null���̶� �������� �������ϳ�? �װ� ��� ��? ���ʽ��� �ޱ� �޴µ� �� �׷���?
and d.location_id = l.local_code
and l.national_code = n.national_code; -- �ߺ��Ǵ� column �� �����ֱ�


-- ���� 6  : ���ʽ��� ����� �޿���, �ڽ��� ��� max_sal �ִ��ѵ��� �Ѿ�� ������ ã������. ��� ���� = ������, ���ʽ� ����� �޿� �Ѿ�, �޿� �ѵ�, ���޸�

select * from sal_grade;
select * from job;
select * from employee;

select 
emp_name ������,
salary,
bonus,
(salary+(salary*bonus)) "�޿�(���ʽ�)",
max_sal "�޿� �ѵ�",
job_name ���޸�
from employee e, sal_grade s, job j
where ((salary+(salary*bonus))>max_sal)  -- where �ٽ� �ϴ� �ǳ�? ������ ����?
and e.sal_level = s.sal_level 
and e.job_code = j.job_code; 

-- ���� 7 : �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� ����� , �μ��� , ������, ������ ���

select * from employee;
select * from department;
select * from location;
select * from national;

select emp_name �����,
dept_title �μ�,
local_name ����,
national_name ����
from employee e, location l, department d, national n
where e.dept_code = d.dept_id
and d.location_id = l.local_code
and l.national_code = n.national_code
and (n.national_code = 'KO' or n.national_code = 'JP')
order by 3;






-- - - - 

-- ���� ��

-- ���� �����͸� ������ �� �� ������ ���̽��� ���� ���� ������?
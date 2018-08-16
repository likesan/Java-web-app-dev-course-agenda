-- 2����

select email from employee;

-- ���� 1 : ����� �տ� ���ڰ� 3������ �ֵ鸸 email�� �̱�

select email from employee where email like  '___#_%' escape '#';

-- escape : ���ϴ� ��ȣ�� ������ �Ǹ�,  like�� ���� ���� ����ؾߵ� �����(_) �� �߰������� �� �� �ְ� �����.


-- ���� 2 : null ���� ���� �ִ� �ֵ��� �̾Ƴ���

select * from employee where dept_code is not null;

-- ���� 1 : employee ���̺��� ������(??) manager_ID is null �� ����, �μ��� ��ġ���� ���� ����(dept_code) is null ���� �̸� name�� ����ϼ���.

select emp_name, dept_code, manager_id from employee where dept_code is null
and (manager_id is null);

select emp_name, dept_code, manager_id from employee where dept_code is not null
and (manager_id is not null);


-- ���� 2 : employee ���̺���, �μ� ��ġ�� ���� �ʾ����� dept_code is null, ���ʽ��� ���޵Ǵ� bonus is not null /  ������ �̸� select name�� ����ϼ���.

select emp_name ������, nvl(dept_code,'�ȵ�') �μ���ġ, bonus ���ʽ� from employee where (dept_code is null)
and bonus is not null;

 --��Ʈ 1 :  field�� null���� Ư�� ������ �ٲٰ� ���� ��� nvl(�ش� column,'���ڿ�') �� select ���� ������ �ٲ��ָ� �ȴ�.



-- ���� 3 : D6 �μ��� D8 �μ� ������� �̸� name, �μ��ڵ�, �޿��� ����ϼ���.

select emp_name �̸�, dept_code �μ��ڵ�,salary || '��' as "����" from employee where dept_code = 'D6' or dept_code ='D8';

-- �̰� �� �����ϰ� ������ �� �ִ�.

select emp_name �̸�, dept_code �μ��ڵ�,salary || '��' as "����" from employee where dept_code in( 'D6' ,'D8');

-- in : where �ȿ��� ���ǹ� ������, �پ��� field�� ���� �������� �ְ� ���� ���, �׸��� �� ������ ���� �ִ� �ٸ� ������ ����ϰ� ���� ��� in�� ���� ���� �� ��Ÿ�� �� �ִ�.


desc employee;

-- ���� 3 : employee ���̺���(from employee) �����ڵ尡 j7�̰ų� j2�̰�, �޿��� 200���� �ʰ��� ������ �̸��� �޿�, �����ڵ带 ����ϼ���.

select emp_name �̸�, salary || '��' �޿�, job_code �����ڵ� from employee where salary>2000000 
and job_code in ('J7','J2');

-- ��Ʈ 2 : ���ǹ� where �� in �ڵ� ����, ��ȣ�� ��ҹ��ڸ� ��������.
-- ��Ʈ 3 : ������ �켱������ �Ű澲��. ��ȣ �� ��� ó��������Ѵ�.


select emp_name from employee order by emp_name ;

-- order by :  ���� ���� ���� ( �������� : asc(Ascending(��������)) , �������� desc ) , default = asc 
-- Ascending : 1. ������, �������; ���� ���� , e.g. ascending powers [����] �¸�(���), ������
-- descendant : 2.  

-- ���� 4 : �Ի����� ������ ������ �����ϱ�

select emp_name ������, hire_date ����� from employee order by hire_date;

select emp_name ������, hire_date ����� from employee order by hire_date desc;


-- ���� 5 : �Ի����� 5�� �̻�, 10�� ������ ������ �̸��� �ֹι�ȣ, �޿�, �Ի��� ���

-- �߿��� :  �Ի���(hire_date-sysdate�� 5�� �̻�((365*5)-sysdate), 10�� ����  �Ի����� ���Ϸ���, hire_date �ϸ� �Ǵ°� �ƴѰ�?

select emp_name �̸�, emp_id �ֹι�ȣ, salary || '��' �޿�, hire_date �Ի��� from employee
where (sysdate-hire_date>=365*5) and (sysdate-hire_date<=365*10);


-- ��Ʈ 1 : ��¥������ ���� ����(�㳪 ��¥ �����θ� �ȴ�. ���� 5�� �Է��ϸ�, 5���� ���ٴ� ��. �ٽø��� �̸� ������ �ٲٰ� �ʹٸ� 365�� 1������ �����ϸ� �� �� )
-- �߰� �ñ��� : �����, �ʴ���, �д����� ����ϰ� ����� ��ɾ�� ����?

--  �ݼ� : 1��� �� ��� �ؾ��ϴ°���? ���� ���Ϸ��°� �Ի����� ���ؾ����ݾ�? �׷��� �� ���ǹ��� �־ ��� ��µǰ� ������?
-- �� ���� �� ����? �Ի����� 5��Ǿ���? �̰� ��� ���� �� ����? ���� �� ���� �ð����� ���� �ð��� ���߰��� �׷��� ū ���� �����״�
-- �� �� ���ذ� ���� �ʾ���? ��.. ���� �������� ���� �߾�����ߴµ� �� ������ ������ �����ΰ�? �ϴ� ���� ���� �޾��� ����� �ϸ� �� �ȵǴ� �� ���� ��ü��. �Ǵ� ������ �ϸ� Ȯ���� �� �ߵǴ� ���� ���ݴ´�.
-- ����� �ʿ��߱���.. ������ �ʿ��ߴ�. �������� õõ�� �����ϴ� ����.

--���ϸ����� �����̱�

-- ���� 6 : employee ���̺��� �������� �ƴ� ������ �̸�, �μ��ڵ�, �ٹ��ϼ�, ������� ����ϼ���.

select emp_name �̸�,  dept_code �μ��ڵ�, floor(ent_date-hire_date) || '��' �ٹ��ϼ�, ent_date �����, hire_date �Ի��� ,  ent_yn ��������  from employee where ent_date is not null;

-- ��Ʈ 1 : �׻� ���� �ð��� ���� ū ���� ��Ÿ����. ���ſ� �н��ʰ� �� �߰� �����״�..

-- ��Ʈ 2 : ���� �ű��ϴ�


-- ���� 7 : employee ���̺��� from employee/  �ټӿ����� 10�� �̻� (��.. sysdate-hire_date>=10) / �� ������ �˻��ϼ���. [ �ټӿ��� = �Ҽ���X, ��������, �޿��� 50%�λ�� �޿�(*0.5*salary ]

select emp_name �̸�, floor((sysdate-hire_date)/365) || '��' �ټӿ���, (salary+(0.5*salary)) || '��' �޿� from employee where ((sysdate-hire_date)/365)>=10  order by floor((sysdate-hire_date)/365) asc;

-- �ڳ��� �ټӿ���

select ((sysdate-hire_date)/365) "�ڳ���ٹ� ���" from employee where emp_name='�ڳ���';


-- ���� 8 : �Ի����� 99/01/01 - 10/01/01 �� ��� ��(between(hire_date='99/01/01')and(hire_date='10/01/01') ����, �޿��� 2�鸸�� ������ ���(salary<2000000), �̸�, �ֹι�ȣ, �̸���, ����ȣ, �޿� ���

select emp_name �̸�,emp_id �ֹι�ȣ,email �ּ�,phone ����ó,salary ||'��' ���� from employee where hire_date between '99/01/01' and '10/01/01' order by salary asc;

-- ��Ʈ :  between ��ɾ ����, where �ٷ� ������ �־���Ѵٴ°� �߿�


-- ���� 9 : �޿��� 200-300���� ���� ������ ��, 4�� �������� ����� �˻�, �̸�-�ֹ�-�޿�-�μ��ڵ� ��� ( �ֹ�-������ / �μ��ڵ� null = '����'��� )
select * from employee;

select emp_name �̸�,emp_no ��ȣ,salary ||'��' �޿�,nvl(dept_code,'����') �μ��ڵ� from employee where (salary between 2000000 and 3000000) and emp_id not like ('%-1%')
and emp_no like ('___4%');
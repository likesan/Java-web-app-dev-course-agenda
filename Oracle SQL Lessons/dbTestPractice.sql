select * from employee;

-- ���� 1 : ������ ������ �Ŵ��� ID �˾Ƴ���

select manager_id from employee where emp_name = (select emp_id from employee where '������' ;




select emp_name, manager_id  from employee where emp_name = '������';

-- ���� 1.5 : ������ ������ �Ŵ��� �̸� �˾Ƴ���

select emp_name, emp_id, manager_id from employee where emp_id = (select manager_id from employee where emp_name='������');



--------------------------------------------------------------------------------------------------------------------------

-- ���� 1 : �� ������ ��� avg �޿� ���ϱ�

select to_char(floor(avg(salary)),'l999,999,999') ��������ձ޿� from employee;

-- ���� 1.5 : �� ��� �޿����� ���� �޴� ������ ��� ��� ( where���� �غ���)

select emp_name from employee group by salary > floor(avg(salary);


-- ���� ������ϴ� �� avg salary ���� ���̳� ���� ���� �ȸ°� �Ǿ����� �� group by �� ���ų� �ϴ� �༮������. �� �̻��ϴܸ��̾� ��� �����ؾ��Ѵٴ°ž�?

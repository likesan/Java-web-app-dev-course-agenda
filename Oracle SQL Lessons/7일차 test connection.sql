select * from employee; -- ��ã��

select * from kh.employee; -- kh. ����൵ ��ã��

------------------------------------------------------------------
-- 7����.sql ����, grant select on kh.employee to test; �� �ں��� , select * from kh.employee; �� �� �۵���. ��? select ������ �ο� �޾����Ƿ�. select ����� ����� �� �ִ�.
-- ���� ������ db���� �ٸ� table�� ����ϰ� �ʹٸ�, �ش�Ǵ� db�� ������ �ο�������Ѵ�.
------------------------------------------------------------------
-- insert �� �Ǵ��� ����!
select * from kh.department order by 3; 

insert into kh.department values ( 'D0' ,'������ȹ��','L3');

select constraint_name, constraint_type, table_name from user_constraints where table_name = 'MEMBER';


-- delete �غ���
DELETE FROM kh.department
WHERE dept_id = 'D'; -- ���� �ʿ�

-- dept_id �� D10�� ���� �� �ְ� �غ���

select constraint_name, constraint_type, table_name from user_constraints where table_name = ' kh.department ';

------------------------------------------------------------------ 

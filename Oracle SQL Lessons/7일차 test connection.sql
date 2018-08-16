select * from employee; -- 못찾음

select * from kh.employee; -- kh. 찍어줘도 못찾음

------------------------------------------------------------------
-- 7일차.sql 에서, grant select on kh.employee to test; 한 뒤부터 , select * from kh.employee; 는 잘 작동함. 왜? select 권한을 부여 받았으므로. select 기능을 사용할 수 있다.
-- 새로 생성한 db에서 다른 table을 사용하고 싶다면, 해당되는 db에 권한을 부여해줘야한다.
------------------------------------------------------------------
-- insert 도 되는지 보자!
select * from kh.department order by 3; 

insert into kh.department values ( 'D0' ,'전략기획부','L3');

select constraint_name, constraint_type, table_name from user_constraints where table_name = 'MEMBER';


-- delete 해보자
DELETE FROM kh.department
WHERE dept_id = 'D'; -- 권한 필요

-- dept_id 에 D10도 넣을 수 있게 해보자

select constraint_name, constraint_type, table_name from user_constraints where table_name = ' kh.department ';

------------------------------------------------------------------ 

select * from employee;

-- 문제 1 : 전지연 직원의 매니저 ID 알아내기

select manager_id from employee where emp_name = (select emp_id from employee where '전지연' ;




select emp_name, manager_id  from employee where emp_name = '전지연';

-- 문제 1.5 : 전지연 직원의 매니저 이름 알아내기

select emp_name, emp_id, manager_id from employee where emp_id = (select manager_id from employee where emp_name='전지연');



--------------------------------------------------------------------------------------------------------------------------

-- 문제 1 : 전 직원의 평균 avg 급여 구하기

select to_char(floor(avg(salary)),'l999,999,999') 전직원평균급여 from employee;

-- 문제 1.5 : 그 평균 급여보다 많이 받는 직원들 목록 출력 ( where에서 해보자)

select emp_name from employee group by salary > floor(avg(salary);


-- 내가 어려워하는 건 avg salary 같이 행이나 열이 서로 안맞게 되어있을 때 group by 를 쓰거나 하는 녀석들이지. 좀 이상하단말이야 어떻게 이해해야한다는거야?

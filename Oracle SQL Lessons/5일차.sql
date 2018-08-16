-- 몸풀기 문제 1 : 부서코드 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 출력

select * from employee;
select * from job;
select * from department;
select * from location;

select e.emp_name 사원명,
j.job_name 직급명,
e.dept_code 부서명,
l.local_name 근무지역명
from employee e, job j, department d, location l
where
e.job_code = j.job_code
and d.location_id = l.local_code 
and e.dept_code = d.dept_id 
and e.dept_code = 'D2';

-- 보너스 포인트가 없는 직원들 중, 직급 차장과 사원인 직원들의 사원명, 직급명, 급여 출력

select * from employee;
select * from job;

select emp_name 사원명,
job_name 직급명,
bonus 보너스,
to_char(salary,'l999,999,999') 급여
from employee e,job j
where bonus is null
and (job_name = '차장' or job_name='사원')
and e.job_code = j.job_code;

-- 문제 3 : 재직중(아직 퇴사하지 않은 사람=ent_date!=null)인 직원과 퇴사한(ent_date) 직원의 수(count()) 출력
-- 얘를 어떻게 해야되는거지? 이 전체에서 count라는 명령어를 쓰는건 알겠는데?
-- ent_date가 null 이면 재직중인걸로? end_date가 null이 아니면 퇴사자인걸로? case로 해야할 듯?
select * from employee;


select
-- 저기다 재직여부라는 콜롬을 하나 만들려면 어떻게 하지? 그리고 row값도 저렇게 주려면?

case 
when ent_date is null then '퇴사'
when ent_date is not null then '재직'
end 재직여부
,
case
when ent_yn = 'N' then count('N')
when ent_yn = 'Y' then count('Y')
end 인원수
from employee
group by ent_date,ent_yn; -- 그룹핑을 정확히 어떻게 하는거지? 그냥 막 하면 되나? 아 총합을 나타내는 애들이니까


-- 오늘 수업 시작 : SubQuary , 가장 까다로운 놈. 한번에 두개씩 써나가기 때문에 어렵게 느껴질 수 있는 파트
-- 쿼리 안에 쿼리를 또 넣는 것


-- - - -
select * from employee;

select emp_name from (select emp_id, emp_name from employee);

-- 메인쿼리 : 괄호 밖에 있는 애
-- 서브쿼리 : Quary 안에서 묶여있는 녀석

-- 알긴 알겠다만 왜 저렇게 까지 쓰는건가? 흐음..



-- 문제 1 : 전지연 직원의 매니저 ID 알아내기


select manager_id from employee where emp_name = '전지연';

-- 문제 1.5 : 전지연 직원의 매니저 이름 알아내기

select emp_name from employee where emp_id = 214;


-- 문제 1.75 :  얘를 더블 쿼리로 표현
select emp_name from employee where emp_id = ( select manager_id from employee where emp_name ='전지연 ') ; -- 얘는 왜 안되지?


-- 결과로 field에 드러난 값이 return 값이다. 이걸 서브 쿼리로 넣으면 그 값이 return되어 나온다.

-- `문제 1 : 전 직원의 평균 avg 급여 구하기`

--```
select to_char(floor(avg(salary)),'l999,999,999') as "전 직원 평균 급여" from employee; 
--```

-- 문제 1.5 : 그 평균 급여보다 많이 받는 직원들 목록 출력 ( where에서 해보자)

-- ```
select
emp_name "평균이상급여수급자", 
to_char(salary,'l999,999,999') "급여" ,
(select to_char(floor(avg(salary)),'l999,999,999') as "전 직원 평균 급여" from employee) "평균급여"
from employee 
where salary > (select floor(avg(salary)) as "전 직원 평균 급여" from employee ); -- `to_char을 해놓은 상태에서는 숫자와 계산이 불가능하다. to_char을 벗겨줘야 가능해진다.`
-- ```

-- 단일값 서브쿼리 : 서브쿼리 값 하나만 row에 나오는 경우 = 단일값 서브쿼리, field 한칸에 값이 모두 들어가는 것 
-- 다중행 서브쿼리 : 행(row) 하나에 여러의 row에 쫘악 나열되는 것
-- 다중열 서브쿼리 : column 여러개가 쫙 나열되는 경우 행이 하나인 경우만 말하는건가?
-- 다중행 다중열 서브쿼리 : 행과 열이 여러개인 서브쿼리

-- 문제 1. 윤은혜 직원과 급여가 같은 사원들을 찾으세요. 찾은 뒤 그 사람들의 사원번호, 사원명, 급여 출력

select * from employee;

select salary 윤은해급여
from employee
where emp_name = '윤은해';

select emp_id 사원번호,
emp_name 사원명,
to_char(salary,'l999,999,999') 급여
from employee
where salary = (select salary 윤은해급여 from employee where emp_name = '윤은해') 
and emp_name!='윤은해'; 

-- != 활용을 통해 윤은해 목록에서 없애기. where절에서 해야 아예 출력이 안되게 만든다. 
-- 조건에서 제거해버리므로. select에서 수정을 해봐야 nvl 또는 case/decode 같은 분기문으로는 결국 null 값만 출력하게 됨, 
-- 출력 자체를 없애려면 where절에서 수정해야한다. 아예 선택조차 하지 않을 것이므로.


-- 문제 2. 기본급여가 제일 많은 사람(max(salary))과 제일 적은 사람(min(salary)의 정보를 출력하세요. 얠 우째? 
-- 사번, 사원명, 급여

-- 서브쿼리를 먼저 구하기, 먼저 구할 것과 나중에 구할 것들을 찾아야한다. 어떻게?
-- 뭐가 먼저 필요로 되어지는 것인지 알아야하지 않을까?

select 
max(salary) 급여최고액
from employee;

select
min(salary) 급여최저액
from employee;


select emp_id 사번,
emp_name 사원명,
salary
from employee
where 
(salary=(select max(salary) 급여최고액 from employee)) 
or 
(salary=(select min(salary) 급여최저액 from employee));


-- 문제 3 : D1, D2 부서에 근무 사원 중
-- 기본 급여가 D5 부서 직원들의 평균 월급보다 많은 사람들에 대해
-- 부서명, 사원번호 , 사원명, 급여 출력

select * from 
employee;
select * from
department;

select
d.dept_title 부서명,
emp_no 사원번호,
emp_name 사원명,
salary 급여
from employee,department d
where
dept_code in ('D1' , 'D2')
and dept_code = d.DEPT_ID
and salary > (select floor(avg(salary)) from employee where dept_code='D5');




select emp_name -- 기본 급여가 (D5부서 직원들의 평균 월급 avg(salary))보다 많은 사람들
from employee
where salary>=(select floor(avg(salary))
from employee
where dept_code='D5');


select floor(avg(salary)) -- 
from employee
where dept_code='D5'; -- D5부서 직원들의 평균 월급 avg(salary)

-- 다시 읽어봐야할 것 같은데?

-- 가장 작은 서브 쿼리부터 찾아야한다. 가장 작은 서브쿼리가 어디가 되는거지?



-- - - -
-- 다중행 서브쿼리
-- 연산자 In / Not in / any / all/ exist 사용가능

-- 송종기 또는 박나리씨가 포함된 부서 코드 출력

select 
emp_name ,
dept_code 부서코드
from employee
where emp_name in ('송종기' , '박나라') ; -- 다중행 결과


-- 송종기 또는 박나라씨가 포함된 부서의 직원들 정보 출력

select * from employee where dept_code = (select 
emp_name ,
dept_code 부서코드
from employee
where emp_name in ('송종기' , '박나라')); -- 에러

select * from employee 
where dept_code in 
(select 
dept_code 부서코드
from employee
where emp_name in ('송종기' , '박나라')); 

-- 다중 행이 나올 때는 where 컬럼명 = 이 아니라, where 컬럼명 in (subquary) 로 들어가면 된다.


-- 문제 1 : 차태연과 전지연where emp_name in ('차태연','전지연')의 급여 등급(sal_level 먼저 찾기)과 동일한 등급 가진 사원들의 직급명 / 사원명 출력
-- 직급명 사원명


select 
sal_level 급여등급
from employee
where emp_name in ('차태연','전지연');


-- - - -
select * from employee;


select 
sal_level 직급명,
emp_name 사원명
from sal_grade;





select emp_name 사원명,
job_code 직급명
from employee
where sal_level in (
select 
sal_level 급여등급
from employee
where emp_name in ('차태연','전지연'))
order by 2;


-- - - -
-- 문제 2. 한명 이상의 직원에 대해서 관리자 역할을 수행(??)하는 (  null!= 널이 아니면 ?? 어떻게 하라는거지? 하나 이상인지는 > 1부등호로 해야하나? group by 로 접근해야하나? group by 뭐가 되나?많은지 아닌지 어찌알지?
-- 직원의 사번, 이름, 직급명을 출력하세요~

select * from employee;
select * from job;

-- self join을 왜 쓰는거지? 테이블 자기 자신의 값을 2번 호출하는 기능은 존재하지 않기 때문 아닌가

select emp_id 사번,
emp_name 이름,
job_name 직급명
from employee e,  job j
where
emp_id in (select manager_id from employee) -- 얘를 어떻게 이해해야할까? manager id를 갖고 있는 애들 = 관리자. 다시말해, 매니저 아이디를 갖고 있는 사원들 = 한명 이상의 직원에 대해 관리자 역할을 수행하는 사람들.
and e.job_code = j.job_code
;

select 
distinct manager_id from employee; -- 얘네가 매니저다? 왜 ? 매니저 아이디를 갖고 있응께?  매니저 아이디를 갖고 있으면 아~ 

-- distinct = 중복 제거, select 안에서 작동함


-- 문제 3 : 직급이 대표(job name !=대표, 부사장)이 아닌 모든 직원을 이름, 부서명, 직급코드 출력

select e.emp_name 이름,
d.dept_title 부서명,
j.job_name 직위명,
s.sal_level 직급코드
from employee e, department d, job j,sal_grade s
where job_name != '대표' and job_name !='부사장'
and (e.dept_code = d.dept_id)
and (e.job_code = j.job_code)
and (e.sal_level = s.sal_level)
order by 2;


-- - - - 


-- ANY() 이 중에 아무거나 조건을 만족한다면 true다

select emp_name, salary from employee where salary > any(2000000, 3000000, 5000000); --  이 중에 아무거나 2백만보다 큰 것

-- 동적으로 쿼리가 들어갈 수 있다.

select salary from employee where job_code = 'J3';  --3400000 , 3900000, 3500000 값이 리턴됨 , select 가 salary 이므로 return 값은 salary

select emp_name, salary from employee where salary < any(
select salary from employee where job_code = 'J3');

-- salary > any();
-- salary 값이 any 그룹 안에 묶여있는 값들 중 / 최소값 보다 크면 참

-- salary < any ();
-- salary 값이 any 그룹 안에 묶여있는 값들 중 최대값 보다 작으면 참. 

-- any 안의 범위 에 존재만 한다면 참이 되는거?

-- 문제 :  D1 또는 D5 부서 사원들의 급여 중에서 가장 높은 급여보다 작은 모든 사원들의 이름 급여 부서코드 출력

select 
salary
from employee
where dept_code in ('D1','D5');



select 
emp_name 사원명,
salary 급여,
dept_code 부서코드
from employee
where salary < any(select salary from employee where dept_code in ('D1','D5'))
order by 2;


-- 문제 : 부서별  평균 급여를 조사했을 때
-- 가장 낮은 부서의 급여보다 높거나, 같은 
-- 모든 사원들의 이름 / 급여 / 부서명 출력

select avg(salary)
from employee
group by dept_code; -- group by 로 dept_code를 묶었기에 다중행 서브쿼리로 결과값이 나타났다. 그런데도 불구하고 

select emp_name 이름,
salary 급여, 
dept_title 부서명
from employee e, department d
where salary >= any (select avg(salary) from employee group by dept_code) -- 뭐가 기준인가? salary? 애들이 갖고 있는 값 = salary, dept_code로 grouping 한 부서들의 평균 급여값= any()
and e.dept_code = d.dept_id
order by 2 desc;

-- ## All : 이 모두 중에서 가장 큰놈이 나오게 한다? 
select emp_name, salary from employee where salary > all(2000000,3000000,5000000);
-- salary 가 크다면?모두 묶었을 때 가장 큰놈이 나오게 한다?

select emp_name, salary from employee where salary < all(2000000,3000000,5000000);
-- all로 묶여있는 인자들 중 가장 작은 값보다 salary 가 작다면

-- 문제 6 : D2 부서의 모든 사원보다 (all(select emp_name from employee where dept_code = 'D2')  
-- 적은 급여 salary < 샐러리가 적대, 다시말해 서브 쿼리의 값보다 작은 애들, 부등호로는 <
-- 를 받는 사원의 이름 및 급여 출력

(select salary from employee where dept_code = 'D2'); -- 1550000, 2490000, 2480000

select emp_name, salary from employee order by 2; -- 보다 적은 급여 이므로 1550000 - 임시환 은 해당안됨, 그 밑의 방명수만 가능하므로

select emp_name 이름, 
to_char(salary,'l999,999,999') 급여
from employee 
where salary < all(select salary from employee where dept_code = 'D2');


-- 문제 7 :   \\ select (max(substr(emp_no,1,2)) from employee where dept_code = 'D1' 
--  D1 부서에서 가장 나이가 많은 사람 보다 더 나이가 많은 D2 부서의 직원 ,              \\ 보다 라면 비교겠지? < max(substr(emp_no,1,2)) from employee where dept_code = 'D2'
-- 의 이름      emp_name 및 나이substr((emp_no),1,2)를 출력해주세요.

select emp_name 이름, 
dept_code 부서번호,
substr(emp_no,1,2) 나이
from employee
where dept_code = 'D2'
and substr(emp_no,1,2) < all ( select 
substr(emp_no,1,2) 나이 
from employee 
where dept_code = 'D1') ;  --66/77/80 D1 부서의 가장 나이 많은 나이 / 얘를 D2와 비교해야한다?

select 
substr(emp_no,1,2) 나이 
from employee 
where dept_code = 'D1' ;





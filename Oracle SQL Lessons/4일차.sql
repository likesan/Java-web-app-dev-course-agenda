select * from employee;

select rtrim(email,'@kh.or.kr') from employee; 


select dept_code, 
to_char(sum(salary),'l999,999,999')  
from employee 
group by dept_code 
having sum(salary) >10000000
order by 1;

-- 지난 시간 복습

-- Group에 대해서는 where 절을 사용할 수 없다. 왜 ? quary의 시작 순서에 따라 오류가 난다.
-- 실행 순서 1. From > 2. Where  > 3. Group by  > 4. Having  > 5. Select  > 6. Order by 
-- 암기하기, 그래야 나중에 분석 가능, 순서대로 따라가다 어디서 문제가 생기는지 파악하게 된다고.  FWGHSO

select dept_code, 
to_char(sum(salary),'l999,999,999')  
from employee 
group by dept_code 
having sum(salary) >10000000
order by 1;


-- roll up / cube 함수 : 그룹화 데이터 집계 수행 함수 ( group by 없으면 땡 ) 

select dept_code 부서코드, 
sum(salary) 부서별급여합계
from employee 
group by rollup(dept_code) -- roll up : 집계 함수, 모든 부서의 총 합계도 나타나게 만듦. 쟤를 어떻게 바꾸지? 
order by 1;


select dept_code 부서코드, 
sum(salary) 부서별급여합계
from employee 
group by cube(dept_code) -- cube :  
order by 1;

-- roll up vs cube : 그룹이 하나냐 여러개냐에 따라 결과값이 달라짐

select 
dept_code,
job_code 직급코드,
sum(salary)
from employee
group by  rollup(dept_code), job_code -- 롤업으로 다 묶으면, 부서별 집계까지 나타내버림. 어디에 쓰일 수 있나? 부서별로 총합이 어떤지 까지 나타내버리지 한 화면에 나타내기 좋겠지. 그런데 왜 이름이 rollup이지? 팔을 걷어붙힌다? 말아 올린다라는 건가?
order by 2;

-- roll up : 그룹화 된 자료를 합계로 내는 명령어, 그래서인지 group by 안에서만 쓰일 수 있다고.  그런데 왜 하나에만 되는거지? 왜 job_code 로 묶였을 때만 되는거야? 왜 dept_code로 묶였을때는 나타나지 않는건가? 상식적으로는 다 될 것도 같은데 왜 안되는거지 뭔 차이가 있는거지?
-- 이상한게 dept_code에 롤업을 걸었는데 왜 결과가 저ㅓㅎ게 안나오지?

select 
dept_code 부서코드
,  job_code 직급코드
,  sum(salary)  부서별급여합계
from employee 
group by cube(dept_code,job_code) order by 1;

-- rollup 사용시 : 부서의 직급별 
-- cube :  온갖 종류의 그냥 집계를(부서별 합계 / 직급별 합계 / 모든 부서의 총합) 모두 만들어주는 명령어

-- rollup 과 cube의 차이 ? rollup은 ... 원하는 한 집계를 선택하는거지만 cube는 모든 총합을 나타낸다?



select dept_code 부서명, sum(salary) 총계 from employee group by cube(dept_code) order by 1; -- dept_code 로 묶인 값들의 총합 
select nvl(dept_code,'Intern') 부서명, sum(salary) 총계 from employee group by rollup(dept_code) order by 1; 
select grouping(dept_code) 부서명, sum(salary) 총계 from employee group by rollup(dept_code) order by 1;

-- grouping? 집계 함수(rollup / cube)에 의해 나타난 값(리턴된 값)의 null 값은 1이 된다? 라는 특성을 활용하여, 집계함수 인지 아닌지 0과 1을 출력하여 구분짓게 만들어주는 함수
-- 1이면 '총합'이라고 출력해라 라는 함수는 뭐가 있을까? 원하는 값으로 바꾸게 만드는 것? = decode / case 분기문
 
select grouping(dept_code) 부서명, sum(salary) 총계 from employee group by rollup(dept_code) order by 1;

-- 분기문? decoding / case 


-- select decode(grouping(dept_code), 0, nvl(dept_code,'인턴'),1,'총합') 부서,
select decode(grouping(dept_code), 0, nvl(dept_code,'인턴'),'총합') 부서, -- 팁 : 분기문(decode/case 함수) 2번째 인자를 넣어주지 않아도 작동은 한다?
job_code 직업코드,
sum(salary) 월급총계
from employee
group by rollup(dept_code, job_code)
order by 1,2;

-- 이건 지금, 인턴(부서명이 아직 정해지지 않는 null값으로 갖고 있는 부서)으로 표기하고, rollup을 통해 원하는 부서들의 총합만을 나타내게함.
-- 깨달은 것, 1) rollup 또는 cube와 같은 총합계를 나타내는 함수는 return 값(1)을 갖는다. 이 1을 통해, 아예 아무렇게도 값이 지정되어 있지 않아 null 값을 갖고 있는 column을 구분지을 수 있께 된다. 
-- 왜냐하면 이 null값으로 갖고 있는 column은 리턴값이 0이므로, 대신에 총합(rollup/cube 와 같은 함수들은 return 값으로 나타낼 수 있으니 
-- 중요한건 roll up과 cube를 언제 언제 써야하느냐가 아직 잘 와닿지 않는다? rollup(dept_code)를 하ㅕㅁㄴ 아 일일이 다 하기 귀찮으니까 cube가 존재하는건가?


-- 예제 , 부서별 인원(count(dept_code)) 및 모든 부서의 총 인원을 출력해주세요.
-- cube

select 
decode(grouping(dept_code),0,nvl(dept_code,'미지정(인턴)'),1,'총 인원') 부서, -- 부서가 null이다? 부서가 아직 정해지지 않았다? intern이다? 이걸 nvl아.. 저기서 정해지는거니까 그렇구나? grouping dept_code는... 뭘하는거지? 그룹화 해놓는것? grouping 이 뭘하는 놈이지?
count(dept_code) "부서별 인원"
from employee
group by cube(dept_code)
order by 1;


-- 예제, 부서와 직급 코드를 그룹화 시켜서 rollup

select nvl(decode(grouping(dept_code),0,dept_code,1,'합계'),'인턴') 부서코드,
case
when grouping(job_code) = '0' then job_code
when grouping(job_code) = 1 and grouping(dept_code) =1 then '합계'
when grouping(job_code) = '1' then '부서별합계'
end 직급코드, -- 어떻게 해야하나 얘네를 다시 다 0과 1의 차이다. 이걸 어떻게 이용한다? 이를 이용하기 위해선 decode를 써야겠지? 부서코드의 내용이 '합계'라면, 그 열의 null은 '합계'로 한다는 명령어가 있으면 좋겠는데 그게 뭘까?
sum(salary) 부서별급여합계 
from employee
group by rollup(dept_code, job_code) 
order by 1,2;

-- 됐다. 1과 1인 상황이니까 case 를 써야할 것 같고, when 내에서도 순서가 중요하네. 그냥 case로 하면 되는거였어. case에서는 다양한 상황을 넣을 수 있으니까? decode로는 안되는건가? decode에서는 이걸 가능하게 만드는게 가능한지 모르겠네.

-- 강사님에게 물어보니 decode라는 걸로는 and나 or 등, 동시에 만족시킬 수 있는 조건문을 만드는 것은 불가능하다고 한다.
-- 생각하는 걸 싫어하면 coding을 할 수 없는 것 같다. 왜냐하면 늘 문제를 제시하니까. 이 문제들을 제시하고 풀어가는 과정 자체가 coding인데 이걸 싫어하는 사람이라면 ...반대로 이걸 굉장히 잘하기 위해선 문제를 풀어보려는 노력들을 해나가야한다. 
-- 적어도 생각하려는 시도조차 즐길 줄 알아야한다. 그러기 위해선, 내 스스로에게 '난 코딩을 사랑한다.' 
-- '난 문제가 있을 때 상황을 직시하고 피하지 않는다.' 
-- '이 문제를 해결하기 위해 명상호흡과 몰입의 방법을 이용하여 문제를 풀도록 노력하겠다.'' 라는 노력들을 해야한다.
-- 물론 뇌라는 것이 평소 에너지 절약을 위해 올곧게 문제만 줄곧 풀어내려는 노력을 회피할 수도 있다. 특히나 현대인들은 이러한 문제를 굉장히 불편하게 여길 수도 있다.
-- 몸이라는 게 편하게 가만히 앉아서 쉴 때 비로소 에너지를 저축하고 생을 살아낼 수 있으니까. 몸이 원하는건 게을러지는 것이고 아무것도 하지 않는 것이지.


-- - - - 

-- 도전정신이 필요하지 않을까? 너저분 하지만 뭐랄까? 하지만 한번 더 벗기고 바꾸고 한번 더 벗기고 바꾸고 해야되서 좋은 것. 계속 긍정적으로 생각한다면 훌륭해지는 것

-- 문제 : 아래 문제의 큐브도 한번 풀어보자. 1) grouping으로 1와 0으로 나타내보자 2)nvl 과 case를 사용해보자.

select 
case grouping(dept_code)
when grouping(dept_code) = 1  then '합계'
end "잡코드",  -- 그런데 grouping을 하는데 왜 0과 1로 나뉘는걸까? 0과 1들로만 grouping 한다는 건가? 음... 0과 1로 정렬한다는 말일지도...
job_code, 
sum(salary)
from employee
group by cube(dept_code, job_code)
order by 2;

-- db 전문가는 기능의 효율까지 필요로 한다고

-- - - - ### 조인 기능 개념
-- Join  : (참여시킨다? 넣는다? 함께한다? 둘이 모은다?) 하나 이상의 테이블에서 연관된 정보를 모아 하나의 가상 테이블로 만들어주는 명령, index join을 넣으면 나중에 더 강력한 기능
 
-- 내부조인 (Inner join) : 동등/자연/교차 조인 

-- 동등조인 : 가장 많이 씀 
-- 자연조인 : ??
-- 교차조인 : 에러형태 / 실수에서 많이 씀

-- 자기조인 (Self join)

desc job;
select * from job;

desc department;
select * from department;


-- for 문 안에  for 문이 있듯이 for문 두개가 곱해져서 나오는 것과 같다는 걸 이해하는게 중요한 듯, 하나가 출력되고, 그 J1 들이 모두 다 나오게 하는 것 = 교차조인, 교차조인되어 나온 값들을 '카티션 프로덕트(Cartesian product)'라고 한다?
select * from department, job;
-- 값을 안주거나 잘못줬을 때 이렇게 된다고 ? carte는 카드인데 아 Decarte가 쓰던 카테고리화 와 관련이 있는 것 같다. 
-- 값이 미리 출력되기 전에 어떤식으로 나올 지 파악하기 위해, 이를 알아두는게 필요하다고 한다.

select job_code, job_code_1 from employee, job; -- 에러 남, job_code_1
select job_code from employee, job; -- Ambigious 에러, '모호성 오류', '두테이블(employee,job) 중 정확히 어떤 column 을 출력하고자 하는건가요? 모르겠네요?'
select employee.job_code , job.job_code from employee , job ; -- 모호성 오류 해결 위해 table.을 넣어준다.


select employee.job_code , job.job_code from employee e, job j; -- 닉네임을 줄 수 있다고  -- having 과 where의 차이가 갑자기 궁금해졌다.

-- 내가 갖고 있는 가장 약점이 되는 게 나의 시장성을 결정한다.

select e.emp_name 이름, e.job_code, j.job_name from employee e, job j; -- 의미없이 교차조인된 결과만 나타남

-- 동등조인 : where 절에, 제한을 주는데(같은 값만 연결되어 출력되도록 말이지), 

select e.emp_name 이름, e.job_code, j.job_name from employee e, job j where e.job_code = j.job_code;  -- 의미없이 교차 조인된 결과에서, e.job_code 와 j.job_code가 서로 같으면 출력되게 만듬



-- 문제 1 : employee 테이블에서 직원들의 이름 / 부서코드 / 부서 이름 출력 - 어떻게 해야되나?

select * from employee;
select * from department;
select * from location;

select emp_name 이름, 
dept_code 부서코드,
department.dept_title 부서이름
from employee, department
where employee.dept_code = department.DEPT_ID -- 서로 같은 부서명으로 출력해주면, 동등한 값만 조인되며, 이를 동등조인이라고 한다. 조인, 함께 출력하게 만드는 것, 두 개 이상의 테이블이 함께 나타나도록 하는 것
order by 2;


-- 문제 2 : 각 department 테이블의 각 부서가 어느 지역(dep_location)에 위치하는지 location 테이블에서 찾아 출력


select dept_id,
dept_title,
local_name
from department d, location l -- from에서 변수선언 가능
where d.location_id= l.local_code; -- 두 테이블을 연결하고 싶다면, field 값이 똑같은 애들만 이어주면 된다. 이어줘야 값이 같은 애들만 출력 될 것이므로


select e.emp_name, 
e.dept_code, 
d.dept_title
from employee e, department d;
-- 부서코드에 따른 부서명

---
-- 세 테이블을 동등조인하기

select e.emp_name, d.dept_title 부서, l.local_name 지역, d.dept_title
from department d, location l, employee e;

select * from department;
select * from location;
select * from national;
-- 부서위치 아이디에 따른 지역 이름



-- 다중 조인 문제 1 : 부서별 코드 / 이름 / local_name 과 national_name 출력

select 
d.dept_id,
d.dept_title,
l.local_name,
n.national_name 
from department d,  location l, national n
where l.local_code = d.location_id and l.national_code = n.national_code; -- 그냥 중복되는 값들끼리 엮어주면, '='이퀄로 묶어줘버리면 서로 그냥 중복되는 값만 출력해줘라는 where절 조건문이 되어, 서로 중복되는 값만 출력되게 해준다.



-- Self Join : 스스로의 값을 테이블에 넣는 것? - from 안에서 table을 선언시 같은 테이블이지만 다른 테이블명을 갖도록  선언한다.
-- 사용 이유 : 
select * from employee e1, employee e2;

select emp_name, 
manager_id 
from employee;


-- self join을 쓰지 않고 , 매니저의 이름(emp id = emp name)을 출력해보자

select 
case emp_id
when emp_id=manager_id then emp_id,
emp_name,
manager_id
from employee;


select e1.emp_id, e2.emp_id, e1.emp_name, e2.emp_name
from employee e1, employee e2
where e1.manager_id = e2.emp_id; --where 가 똑같은 결과값만 잘 나타나도록 해달라는 뜻이니까, 그 where을 서로 같은 것만 출력되게 해달라고 테이블을 join시켜놓으면, 동일한 값을 갖는 교차되는 field만 출력이 됨. 서로가 동일하게 짝이 맞는 자료만 출력이 될 것이므로 두 테이블 중에서 공유하는 값만 나오게 된다고.



-- 관리자 이름, 부하직원 이름, 부하직원 급여, 부하직원 직급 출력

select * from employee;

select
e2.emp_name as "사원 이름",
e1.emp_name "매니저 이름",
e1.salary "사원 급여",
e1.job_code "사원 코드"
from employee e1, employee e2
where e1.manager_id = e2.emp_id
order by 1;



-- 문제 1 : 2020년 12월 25일이 무슨 요일인지 출력

select to_char(to_date('2020/12/25'),'dy') from dual;



-- 문제 2 : 이름에 '형'자가 들어가는 직원들의 사번 사원병 부서명 출력 instr? ( 미결 )

select * from employee;

select 
emp_name, -- 음 뭘 어떻게 해야하는거지?
emp_id 사번,
dept_code 부서명
from employee
where (emp_name like '형%' -- 왜 3가지 경우의 수를 다 해내야 되는거지? 음... 하기야 이름은 세글자니까 그런데 그냥 형% 해도 찾아져야하는거 아닌가?
or emp_name like '%형'
or emp_name like '%형%'); -- grouping 을 해야하나? 여기서 뭔가 더 하면 될 것 같은데? 해당 로우만 나오게 만드는게 뭐였더라?


-- 문제 3 : 1970년대 생이면서 성별이 여자substr(emp_no,8,1)='2', 성이 전씨('instr(1,1)='전')인 사람의 사원명, 주민번호, 부서명, 직급명 출력

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
and (substr(emp_no,8,1)='2' and emp_name like '전%')
and (e.job_code = j.job_code)
and (d.dept_id = e.dept_code);

-- 얘를 비트윈 써서 해보자

select 
e.emp_name,
e.emp_no,
d.dept_title,
j.job_name
from employee e, job j, department d
where (substr(emp_no,1,2) between 70 and  80)
and (substr(emp_no,8,1)='2' and emp_name like '전%')
and (e.job_code = j.job_code)
and (d.dept_id = e.dept_code);



-- 문제 4 : 해외영업부에 근무하는 사원명 , 직급병, 부서코드, 부서명을 출력


select * from employee;
select * from job;
select * from department;

select e.emp_name, 
j.job_name,
d.dept_id,
d.dept_title
from employee e, department d, job j
where (d.dept_title = '해외영업1부' or
d.dept_title = '해외영업2부' or
d.dept_title = '해외영업3부' )
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
-- 문제 5 : 보너스 포인트를 받는 직원 들의 사원명 / 보너스 포인트 / 부서명 / 근무지역명 출력

select emp_name 사원명,
bonus 보너스
from employee;

select emp_name 사원명,
bonus "보너스 포인트",
dept_title 부서명,
national_name
from department d,employee e, national n, location l
where bonus is not null
and e.dept_code = d.dept_id -- 어떻게 해야 하동운도 나오게 할 수 있을까? 하동운이 안나오는 이유는 뭐지? dept_code가 null 이라서? 그러면 null값이라도 나오도록 만들어야하나? 그걸 어떻게 해? 보너스도 받긴 받는데 왜 그렇지?
and d.location_id = l.local_code
and l.national_code = n.national_code; -- 중복되는 column 들 묶어주기


-- 문제 6  : 보너스가 적용된 급여가, 자신의 등급 max_sal 최대한도를 넘어가는 직원을 찾으세요. 출력 내용 = 직원명, 보너스 적용된 급여 총액, 급여 한도, 직급명

select * from sal_grade;
select * from job;
select * from employee;

select 
emp_name 직원명,
salary,
bonus,
(salary+(salary*bonus)) "급여(보너스)",
max_sal "급여 한도",
job_name 직급명
from employee e, sal_grade s, job j
where ((salary+(salary*bonus))>max_sal)  -- where 다시 하니 되네? 이유가 뭐지?
and e.sal_level = s.sal_level 
and e.job_code = j.job_code; 

-- 문제 7 : 한국(KO)와 일본(JP)에 근무하는 직원들의 사원명 , 부서명 , 지역명, 국가명 출력

select * from employee;
select * from department;
select * from location;
select * from national;

select emp_name 사원명,
dept_title 부서,
local_name 지역,
national_name 국가
from employee e, location l, department d, national n
where e.dept_code = d.dept_id
and d.location_id = l.local_code
and l.national_code = n.national_code
and (n.national_code = 'KO' or n.national_code = 'JP')
order by 3;






-- - - - 

-- 느낀 점

-- 많은 데이터를 관리할 때 이 데이터 베이스를 쓰게 되지 않을까?
-- 2일차

select email from employee;

-- 예제 1 : 언더바 앞에 글자가 3글자인 애들만 email로 뽑기

select email from employee where email like  '___#_%' escape '#';

-- escape : 원하는 기호를 적으면 되며,  like를 쓰기 위해 사용해야될 언더바(_) 를 추가적으로 쓸 수 있게 만든다.


-- 예제 2 : null 값을 갖고 있는 애들을 뽑아내기

select * from employee where dept_code is not null;

-- 문제 1 : employee 테이블에서 관리자(??) manager_ID is null 도 없고, 부서도 배치받지 않은 직원(dept_code) is null 들의 이름 name만 출력하세요.

select emp_name, dept_code, manager_id from employee where dept_code is null
and (manager_id is null);

select emp_name, dept_code, manager_id from employee where dept_code is not null
and (manager_id is not null);


-- 문제 2 : employee 테이블에서, 부서 배치는 받지 않았지만 dept_code is null, 보너스가 지급되는 bonus is not null /  직원의 이름 select name만 출력하세요.

select emp_name 직원명, nvl(dept_code,'안됨') 부서배치, bonus 보너스 from employee where (dept_code is null)
and bonus is not null;

 --노트 1 :  field의 null값을 특정 값으로 바꾸고 싶은 경우 nvl(해당 column,'문자열') 로 select 구문 내에서 바꿔주면 된다.



-- 예제 3 : D6 부서와 D8 부서 사람들의 이름 name, 부서코드, 급여를 출력하세요.

select emp_name 이름, dept_code 부서코드,salary || '원' as "월급" from employee where dept_code = 'D6' or dept_code ='D8';

-- 이걸 더 간단하게 수정할 수 있다.

select emp_name 이름, dept_code 부서코드,salary || '원' as "월급" from employee where dept_code in( 'D6' ,'D8');

-- in : where 안에서 조건문 설정시, 다양한 field를 조건 사항으로 넣고 싶은 경우, 그리고 그 값들을 갖고 있는 다른 값들을 출력하고 싶은 경우 in을 통해 묶어 더 나타낼 수 있다.


desc employee;

-- 문제 3 : employee 테이블에서(from employee) 직급코드가 j7이거나 j2이고, 급여가 200만원 초과인 직원의 이름과 급여, 직급코드를 출력하세요.

select emp_name 이름, salary || '원' 급여, job_code 직급코드 from employee where salary>2000000 
and job_code in ('J7','J2');

-- 노트 2 : 조건문 where 서 in 코드 사용시, 괄호와 대소문자를 잊지말기.
-- 노트 3 : 연산자 우선순위를 신경쓰자. 괄호 잘 묶어서 처리해줘야한다.


select emp_name from employee order by emp_name ;

-- order by :  정렬 기준 설정 ( 오름차순 : asc(Ascending(오름차순)) , 내림차순 desc ) , default = asc 
-- Ascending : 1. 오르는, 상승적인; 위를 향한 , e.g. ascending powers [수학] 승멱(昇冪), 오름차
-- descendant : 2.  

-- 문제 4 : 입사일이 오래된 순으로 정렬하기

select emp_name 직원명, hire_date 고용일 from employee order by hire_date;

select emp_name 직원명, hire_date 고용일 from employee order by hire_date desc;


-- 문제 5 : 입사일이 5년 이상, 10년 이하인 직원의 이름과 주민번호, 급여, 입사일 출력

-- 중요점 :  입사일(hire_date-sysdate이 5년 이상((365*5)-sysdate), 10년 이하  입사일을 구하려면, hire_date 하면 되는거 아닌가?

select emp_name 이름, emp_id 주민번호, salary || '원' 급여, hire_date 입사일 from employee
where (sysdate-hire_date>=365*5) and (sysdate-hire_date<=365*10);


-- 노트 1 : 날짜끼리도 연산 가능(허나 날짜 단위로만 된다. 숫자 5를 입력하면, 5일을 뺀다는 뜻. 다시말해 이를 연도로 바꾸고 싶다면 365를 1년으로 이해하면 될 듯 )
-- 추가 궁금증 : 년단위, 초단위, 분단위로 계산하게 만드는 명령어는 없나?

--  반성 : 1잠깐만 뭘 어떻게 해야하는거지? 지금 구하려는게 입사일을 구해야하잖아? 그래야 저 조건문에 넣어서 어떻게 출력되게 만들지?
-- 그 다음 할 일은? 입사일이 5년되었다? 이건 어떻게 구할 수 있지? 현재 아 현재 시간에서 과거 시간을 빼야겠지 그래야 큰 값이 나올테니
-- 왜 잘 이해가 되지 않았지? 음.. 역시 생각부터 먼저 했었어야했는데 그 과정이 없었기 때문인가? 일단 먼저 쉽게 메쓰를 대려고 하면 잘 안되는 것 같다 대체로. 또는 몰입을 하면 확실히 더 잘되는 것을 깨닫는다.
-- 명상이 필요했구나.. 몰입이 필요했다. 논리적으로 천천히 생각하는 버릇.

--매일매일이 도전이군

-- 문제 6 : employee 테이블에서 재직중이 아닌 직원의 이름, 부서코드, 근무일수, 퇴사일을 출력하세요.

select emp_name 이름,  dept_code 부서코드, floor(ent_date-hire_date) || '일' 근무일수, ent_date 퇴사일, hire_date 입사일 ,  ent_yn 재직여부  from employee where ent_date is not null;

-- 노트 1 : 항상 현재 시간이 가장 큰 값을 나타낸다. 과거에 분시초가 더 추가 됐을테니..

-- 노트 2 : 뭔가 신기하다


-- 문제 7 : employee 테이블에서 from employee/  근속연수가 10년 이상 (음.. sysdate-hire_date>=10) / 인 직원을 검색하세요. [ 근속연수 = 소수점X, 오름차순, 급여는 50%인상된 급여(*0.5*salary ]

select emp_name 이름, floor((sysdate-hire_date)/365) || '년' 근속연수, (salary+(0.5*salary)) || '원' 급여 from employee where ((sysdate-hire_date)/365)>=10  order by floor((sysdate-hire_date)/365) asc;

-- 박나라 근속연수

select ((sysdate-hire_date)/365) "박나라근무 년수" from employee where emp_name='박나라';


-- 문제 8 : 입사일이 99/01/01 - 10/01/01 인 사람 중(between(hire_date='99/01/01')and(hire_date='10/01/01') 에서, 급여가 2백만원 이하인 사람(salary<2000000), 이름, 주민번호, 이메일, 폰번호, 급여 출력

select emp_name 이름,emp_id 주민번호,email 주소,phone 연락처,salary ||'원' 월급 from employee where hire_date between '99/01/01' and '10/01/01' order by salary asc;

-- 노트 :  between 명령어를 사용시, where 바로 다음에 넣어야한다는게 중요


-- 문제 9 : 급여가 200-300만원 사이 여직원 중, 4월 생일자인 사람만 검색, 이름-주민-급여-부서코드 출력 ( 주민-내림차 / 부서코드 null = '없음'출력 )
select * from employee;

select emp_name 이름,emp_no 번호,salary ||'원' 급여,nvl(dept_code,'없음') 부서코드 from employee where (salary between 2000000 and 3000000) and emp_id not like ('%-1%')
and emp_no like ('___4%');
desc employee;

select emp_id from employee;

-- 형 변환 함수 : 형변환 가능하다

-- 많이 쓰는 함수는 고정되어 있다. number date


---

-- to_char : 날짜형 데이터를 문자열 변환 or 숫자 데이터를 문자열 변환 to string과 비슷한듯

-- sysdate, hire_date > 문자열, 형식을 정해줘야한다. simple data format 처럼 , 자바의 toString 기능, to_char, 인자값이 2개 들어간다.
-- 하나는 바꾸고 싶은 날짜, 하나는 원하는 형식

-- * sysdate 는 연 월 일 분 초 까지 다 갖고 있다.

select to_char(sysdate, 'yyyy "년" mm "월" dd "일" ') from dual; -- 한글로 하고 싶은 경우 더클 쿼테이션 " " 을 단위에 써넣어주면 된다. 왜? 3바이트 형식이라 다르다.

select to_char(sysdate, 'yyyy-mm-dd-day') from dual; -- 뒤에 요일 붙이고 싶은 경우 day

select to_char(sysdate, 'yyyy-mm-dd-dy') from dual; -- 요일을 '금' 또는 '목'인지 머리만 나타내고 싶은 경우 dy

select to_char(sysdate, 'yyyy-month-dd-day') from dual; -- 몇월인지 나타내려면 month

select to_char(sysdate, 'yyyy-month-dd-day hh:mi:ss') from dual; -- 분은 minuit 으로 mi를 써야한다. minuit 분

select to_char(sysdate, 'yyyy-month-dd-day hh24:mi:ss') from dual; -- 24시간 기준으로 나타내고 싶다면 hh24를 붙이자. 뭔가 간결하면서도 훌륭해보인다.

select to_char(sysdate, 'FMyyyy-mm-dd-day hh24:mi:ss') from dual; -- 앞에 쓸데없는 0이라는 숫자를 모두 없애고 싶은 경우, FM이라는 표기를 년도 앞에 붙이면 된다.

---

select emp_name 직원명, to_char(hire_date, 'fmyyyy-mm-dd-day') 입사일 from employee order by 1; -- order by서 '입사일' 뿐만이 아니라, column 번째를 적어도 된다.

select emp_name 직원명, to_char(hire_date, 'yy"년" month dd"일" dy') 입사일 from employee order by 2; 

select emp_name 직원명, to_char(hire_date, 'yyyy/mm/dd (dy)') as "입사일" from employee order by 2;  -- 예제 1

-- 퇴사일 추가

desc employee;
select ent_date from employee ;

select emp_name 직원명, to_char(hire_date, 'yyyy/mm/dd (dy)') as "입사일", nvl(to_char(ent_date, 'yyyy/mm/dd (dy)'), '재직 중') 퇴사일 from employee order by 3; -- 예제 1.5 퇴사일 추가, null - '재직 중'




---

select to_char(1000000,'000,000,000') from dual;

select to_char(1000000,'999,999,999') from dual; -- 앞쪽 0 빼기. 뭔 차이지 정확히?

select to_char(1000000,'999,999') from dual; -- format은 늘 넉넉하게 큰 사이즈로 정해줘야한다. If not  = #######으로 에러남

select to_char(1000000,'999,999,999.000') from dual; -- 소숫점을 나타내고 싶은 경우, 뒤에 .000을 붙여보자!

select to_char(1000000,'L999,999,999.000') from dual; -- 지역 통화 표기를 하고 싶다면 뒤에 L을 붙이자! ( 대박기능 ), 오라클 설정을 미국으로 바꾸면 미화로 바뀐다.

select to_char(1000000,'999,999,999.000$') from dual; -- Dollar로 표기하고 싶다면, 앞에 $ 붙이자 뒤에 붙여도 된다.


---

-- to_date : 숫자 또는 문자를 날짜항으로 변환

select to_char(to_date(20000101),'yyyy-mm-dd') from dual; -- to_date는 날짜타입으로 바꿀 뿐, 형식을 바꾸는 기능은 없다. 날짜가 출력되는 타입을 바꿔주고 싶은 경우 to_char을 덧씌워주자

select to_date('20190101') from dual; 

select to_date('110101', 'mm/yy/dd') from dual; -- yy와 mm의 위치도 변경가능


---

-- to_number : 날짜나 문자(숫자처럼 보이는)를 숫자로 변환(number format)

select to_number('1000000000') from dual; --숫자형 문자열 to 숫자열

select to_number('100a0000') from dual; --  number format exception error 발생. java integer.parseint 와 비슷

select to_number('1,000,000', '9,999,999') from dual; -- 중요 : 우리가 얻은 문자열에 콤마',' 가 있는 경우 오류가 출력, 그러므로 뒤에 인자에 단위값을 나타내주면 numberize 가능!, 콤마 자체도 문자로 인식한다. 콤마를 처리할 수 있는 뒷 인자를 넣어주지 않으면, 오류

---

-- decode(=Java.switch) : 여러가지 경우에 선택할 수 있는 기능 제공 ( '~와 같다면 '=' 조건에만 쓰일 수 있음, 크거나 작다는 표현 불가능 ) , 가변인수 함수 (인수값이 늘었다 줄었다 유연하게 변할 수 있는 함수기능)

select emp_name 이름, substr(emp_no, 8, 1) 성별 from employee;  -- substr 으로 주민번호 1 또는 2 추출 가능. '8번째 자리에서  한 자리만 뜯어내겠다.'

select emp_name 이름, decode(substr(emp_no, 8, 1),1,'남',2,'여' )성별 from employee;  -- 무한 지정 가능, 1 이라면 '남자', 2라면 '여자' 값을 넣겠다. == 가변인수 함수

---

-- case(=Java.if) : decode보다 강력한 기능. '필드의 값이 작거나 크거나 같다면~' 으로 가능. 복잡한 여러가지 경우를 통제 가능, 구문이 좀 길다.

select emp_name 이름, 
case 
when substr(emp_no, 8, 1) = 1 then '남' -- when : (=시점 : ~ 하다면 ), 콤마 찍지 말 것!
when substr(emp_no, 8, 1 ) = 2 then '여' 
end 성별
from employee;

 ---
 
select emp_name 이름, 
case 
when substr(emp_no, 8, 1) = 1 then '남' --  '크다면' 가능
when substr(emp_no, 8, 1 ) = 2 then '여' 
else '2000년 후에 태어나셨군요'
end 성별
from employee;

---

select emp_name 이름, 
case 
when substr(emp_no, 8, 1) = 1 then '남' --  '크다면' 가능
else '여'
end 성별
from employee;

---

-- 퀴즈 : employee 테이블에서, 70년생 이전 / 이후 구분

select emp_name 성함, emp_no 주민번호,
case
when substr(emp_no, 1, 2) > 70 then '70년생 이후' -- emp_no 에서 1번째 값을 시작으로 2개의 값이 70보다 크다면, (=주민번호 앞자리 두개가 70보다 크다면) then '70년생 이후'라고 표기하게 한다.
else '70년생 이전' -- 그게 아니면 70년대 이전이라고 표현한다.
end 년생
from employee
order by 년생 desc;

---
select emp_name 성함, emp_no 주민번호,
case
when substr(emp_no, 1, 2) >= 70 then '후' -- emp_no 에서 1번째 값을 시작으로 2개의 값이 70보다 크다면, (=주민번호 앞자리 두개가 70보다 크다면) then '70년생 이후'라고 표기하게 한다.
else '전' -- 그게 아니면 70년대 이전이라고 표현한다.
end "70년생 기준"
from employee
order by "70년생 기준" desc;

-- Quary 작성 팁 : 위 - 아래로 길게 보이도록 쓰는게 가독성 UpupUp! 


---

-- 여태 배운건 한 열에 적용되는 함수
select length(email) from employee;


-- Group 함수 : 행을 싸잡아서 기능을 적용시키는 함수

-- ### sum : 행들의 합계
select to_char(sum(salary),'L999,999,999') "급여 평균" from employee;


select emp_name 이름, to_char(sum(salary),'L999,999,999') "급여합" from employee; -- 에러 : 행 구조 깨짐, 왜? emp_name은 수많은 행을 나타내는 명령문. to_char(sum())은 하나의 행만을 나타내는 명령문. 서로 구조 안맞아 깨짐

-- 퀴즈 : 남직원 급여 합계(sum(salary)) where substr(emp_no,8,1)=1;

select to_char(sum(salary),'L999,999,999') "남직원 급여 총 합" from employee 
where substr(emp_no,8,1)=1;

-- 퀴즈 : 여직원 급여 합계(sum(salary)) where substr(emp_no,8,1)=2;

select to_char(sum(salary),'L999,999,999') "여직원 급여 총 합" from employee 
where substr(emp_no,8,1)=2; -- ￦20,336,240

-- 퀴즈 : D5부서dept_code='D5'의 급여substr(sum(salary),'L999,999,999') 합계

select to_char(sum(salary),'L999,999,999') as "D5 부서 급여 총 합" from employee
where dept_code='D5'; -- field값을 지정하고 싶은 경우, 그냥 따옴표를 쓴다. 'D5' not "D5" or 'd5'

-- 퀴즈 : D5부서dept_code='D5'의 연간 인건비 substr(sum(salary)*12,'L999,999,999') 합계

select to_char(sum(salary)*12,'L999,999,999') as "D5 연간인건비" from employee
where dept_code='D5'; -- field값을 지정하고 싶은 경우, 그냥 따옴표를 쓴다. 'D5' not "D5" or 'd5'


---

-- ### avg : 행들의 평균

select to_char(avg(salary),'L999,999,999') "급여 평균" from employee;

select to_char(avg(salary),'l999,999,999') "D5 평균 급여" -- local currency : L or l 둘다 가능
from employee
where dept_code='D5';

---

-- ### count : 조건을 만족하는 행의 갯수 (null 값도 계산), 중복 제거 null 값은 앞에 distinct 붙이기

select count(*)
from employee; -- * 별이 가장 많이 쓰임

select count(dept_code)
from employee;

select count(distinct dept_code) from employee; -- distinct 로 null 값 제거

select count(emp_no)
from employee;


---

-- MAX/MIN : 최대/소 값 찾기 

select to_char(max(salary),'l999,999,999')
from employee;

select max(salary), min(salary) from employee;
select max(hire_date), min(hire_date) from employee; -- 날짜도 대소 비교 가능, 날짜 조차 



-- 종합 문제 1. 직원명/이메일 길이 출력(length(emp_name) 직원명, length(email) 이메일 from employee)

select length(emp_name) 직원명, length(email) 이메일 from employee;

-- 종합 문제 2. 직원의 이름, 이메일 주소중 @ 앞엔 부분만 출력하세요. substr을 써야하나?

select emp_name 이름, 
rtrim(email,'@kh.or.kr' ) 주소 from employee; -- 이메일에서 @kh.or.kr로 떼버리기


-- 문제 3 . 60년대생case(substr(emp_no),1,2)=60 직원들의 이름(emp_name), 년생(emp_no), 보너스 출력 / 보너스 null 이면 0으로 변환(nvl(bonus,0))

select emp_name 이름,
emp_no 년생,
nvl(bonus,'0') 보너스
from employee
where substr(emp_no,1,1)=6;



select emp_name 이름,
case 
when substr(emp_no, 1, 2) > 60 then '60년생'
end 년생,
bonus 보너스
from employee;


-- 문제 4. 010으로 핸드폰 번호를 사용하지 않는 사람들의 수( 얘를 뭘로 찾지? 

-- 무얼 어떻게 해야하지? substr으로 대부분 다 찾아지네, 왜 그렇지? substr이 뭐였지?

select count(phone) ||'명' 숫자 
from employee 
where substr(phone,1,3) not like '010';


-- 문제 5. 직원의 이름, 입사년월 출력

select emp_name 이름, to_char(hire_date, 'fmyyyy"년" mm"월" dd"일"') 입사년월
from employee
order by hire_date;

-- 문제 6. 이름, 주민번호

select emp_name 이름,
emp_no 주민번호 
from employee;

-- 문제 7. 직원 이름, 직급코드, 연봉(원) 출력
-- 연봉 = 보너스 1년치 급여
-- 출력 형태 원,000,000,000 표시

select * from employee;

select emp_name 이름, 
job_code 직급코드,
to_char(nvl(bonus,0),'0.0') ||'%' 보너스,
to_char((salary+((nvl(bonus,0))*salary))*12,'l999,999,999') ||'원' 연봉 -- to_char 을 쓰면 바꿀 수 있음. 무엇을? 숫자가 어떻게 표기되길 바라는지 선택이 가능하다. 다시말해 숫자를 내가 원하는 형태로 표현하게 만들 수 있다.
from employee;


-- 문제 8. 부서코드(dept_code='D5' and 'D9')가 D5, D9 직원 수 count(emp_name)
-- 2004년도 입사 직원 수 검색

select hire_date
from employee;

select 
count(emp_name) 
from employee
where substr(hire_date,1,2)='04';


-- 문제 9 : 직원 이름, 입사일, 오늘까지 근무일수 출력

select emp_name 이름,
to_char(hire_date,'yyyy/mm/dd') 입사일,
floor(sysdate-hire_date) ||'일' 근무일수
from employee
order by hire_date asc;

-- 문제 10: 가장 나이 많은 사람, 적은 사람 출력 - 나이( 현재년도 : to_char(sysdate,'yy') 년도만 출력) - (주민년도 substr(emp_no,1,2))만 출력

select max(substr(emp_no,1,2)) ||'세' "최고령자",
min(substr(emp_no,1,2)) ||'세' "최연소자"
from employee;

select substr(emp_no,1,2) "출생년도 뒷자리",
to_char(sysdate,'yyyy') 올해년도,
lpad(substr(emp_no,1,2),4,'19') 출생년도,
to_char(sysdate,'yyyy')-lpad(substr(emp_no,1,2),4,'19') 나이,
emp_name 이름
from employee
order by 나이 asc;


-- 문제 11. 부서 코드 D5, D6, D9 인팀 = 야근, 그 외에는 야근 없음 출력
-- 출력되는 값, 이름/부서코드(오름차순)/야근유무
-- 부서코드 null = 야근 없음

select emp_name 이름,
nvl(dept_code,'미정') 부서코드,
case 
when dept_code='D5' then '유'
when dept_code='D9' then '유'
when dept_code='D6' then '유'
else  '무' 
end 야근유무
from employee
order by dept_code;

---

-- Group by : 데이터(field)를 그룹으로 묶어서 처리하기, 그룹 집계가 가능한 함수들(sum/avg/count/max/min)과 함께 쓰일 수 있다.

select dept_code from employee group by dept_code;

select dept_code 부서코드,
to_char(sum(salary),'l999,999,999') 월급합계,
to_char(floor(avg(salary)),'l999,999,999') 월급평균,
count(*) ||'명' 부서별인원
from employee group by dept_code;


-- 테이블 내에서 부서코드, 부서별로 보너스를 지급받는 사원의 수를 조회하고 싶다.
-- 이게 뭐한거지? 그룹화 시키는거지 그냥

select dept_code, 
count(bonus) 
from employee
group by dept_code
order by 1;

---
-- 테이블 내에서 성별별로 급여 환산

select decode(substr(emp_no,8,1),1,'남',2,'여') 성별, -- 성별을 추가하기 위해 뒤에 group by에 나타나는 것들을 다 올리는 이유는? group by는 ... grouping 한다는 뜻, by 에 의해서. 이것에 따라 어떤 group이든 확정짓거나 결정지을 수 있음
count(*) 인원수, -- 인원수 추가
to_char(sum(salary),'l999,999,999') 급여
from employee
group by decode(substr(emp_no,8,1),1,'남',2,'여'); -- group by 내부를 아예 decode로 할 수 있음, case는 되지 않는단다. decode(대상 , 1이면,남자,2면,여자)


-- 문제 : emp_table '직급별 = group by job_code' 내에서 직급, 사원수 count(*), 직급별 평균 급여 산출

select job_code 직급,
count(*) 사원수, -- count는 사원들의 숫자를 나타냄
to_char(sum(salary),'l999,999,999') "평균급여" -- to_char 은 charactor로 바꾼다는 뜻. 다시말해 
from employee
group by job_code
order by 1;

-- 조건 추가(조건문이 추가되면 무조건 where) : 직급 J1 은 제외, decode(job_code,'J1',null) 이거 뭘 어떻게 해야하지?제외시킨다? is not like?  decode로 j1 이 아닌 애들만?

select job_code 직급,
count(*) 사원수, -- count는 사원들의 숫자를 나타냄
to_char(sum(salary),'l999,999,999') "평균급여" -- to_char 은 charactor로 바꾼다는 뜻. 다시말해 
from employee
where job_code!='J1'
group by job_code
order by 1;


-- 문제 : employee 테이블에서, 입사 년도별(오름차순) hire_date
-- 로 인원수 조회, 
-- J1 직급 빼고 출력
-- 입사년도, 인원수 출력

select 
count(*) ||'명' 인원수,
to_char(hire_date,'yyyy') ||'년' as 입사년도 
from employee
where job_code!='J1'
group by hire_date -- 이렇게 하면 1994가 1명, 1명으로 2행으로 나눠져서 출력됨. 이유는? 그룹 명이 같지 않아 충돌나는 듯
order by 입사년도  asc;


-- 올바른 표현

select 
count(*) ||'명' 인원수,
to_char(hire_date,'yyyy') ||'년' as 입사년도 
from employee
where job_code!='J1'
group by to_char(hire_date,'yyyy') ||'년' -- 이렇게 하면 1994가 1명, 1명으로 2행으로 나눠져서 출력됨. 이유는? 그룹 명이 같지 않아 충돌나는 듯
order by 입사년도  asc;

-- 강사님 답


---

select 
extract(year from hire_Date) ||'년' 입사년도,
job_code,
count(*) ||'명' as 인원수
from employee
group by extract(year from hire_Date) ||'년', job_code -- 얘가 지금 어떻게 되어가고 있는건가? group을 짠다? group 별로 
order by 2 ;


---

select dept_code ,
job_code
from employee 
group by dept_code, job_code
order by 1; -- 그룹화를 이름 순으로도 하게 만듦. 하나의 이름이 하나의 그룹으로, 그룹화라는 건 새로운 row를 하나 만든다는 뜻처럼 보이기도 한다. 집계한다는 말


-- 부서별로 그룹화 , 성별별로 그룹화 / 출력 = 부서/성별/인원

select dept_code 부서,
decode(substr(emp_no,8,1),1,'남',2,'여') 성별, -- decode 를 쓰는 이유는? if문, if 1이면 남자, 2면 여자로해서 갈릴 수 있게 만드는거지. 왜? 1과 2로 그룹화 지을 수 있도록 하는거야.
count(*) 인원
from employee
group by dept_code, decode(substr(emp_no,8,1),1,'남',2,'여')
order by 부서;


---

-- having : group by 그룹지정

select to_char(sum(salary),'l999,999,999') 부서별급여합계,
dept_code 부서
from employee
--where sum(salary) > 10000000 -- where 문 안에는 sum/max/min/count 와 같이 그룹지어 답을 내는 그룹함수는 사용될 수 없다. where 에는 그룹함수 못쓴다. 실행순서를 참조하자. 처음에는 from에서 먼저 찾는다, 그 뒤 where인데, salary>10000000하면 
group by dept_code
having sum(salary)>10000000 -- 부서별 합계가 1천만원 이상한 부서만 찾고 싶다!
order by 1;



-- 문제 : 급여 평균이 3백만원 이상의 부서, 급여 평균값 출력

select to_char(floor(avg(salary)),'l999,999,999') "부서별평균(300만이상)",
dept_code 부서코드
from employee
group by dept_code
having avg(salary) > 3000000;

-- having 과 where의 차이? 정리가 좀 필요할 듯?


---

-- 알아야할 것
/*
실행 순서

From 1
Where 2
Group by 3
Having 4
Select 5
Order by 6

*/




---

-- 느낀점

-- 다양하게 해보는 것이 코딩을 금방 늘릴 수 있는 좋은 방법이라는 것을 되새긴다. 글을 자꾸 써나가면서, 내가 무슨 생각을 하는지 파악해나가면서 글을 쓰다보면 보다 효과적으로 흐름을 잃지 않고 코딩이 가능하다.

-- 컴퓨터가 내 코딩을 어떻게 불러들일지 실시간으로 보이지 않는다. 

-- 생각보다 잘 풀리는 것도 같은데 이유가 뭐지? 복잡하거나 머릿속으로 헷갈리지만 않으면 괜찮다. 그리고 내가 원하는 구문을 컴퓨터 언어로 어떻게 표현할지 잘 파악만 해두면 잘 되는 듯

-- 다음시간부터 subquary 들어가면 머리 핑핑 돌아간다고 



select * from employee; -- employee 테이블 보기

select emp_name ,emp_id, phone from employee; -- 대소문자 구분이 없다. emp_name column과 phone column 라인 모두 나타나게 : ','

desc employee; -- desc : describe, employee라는 테이블을 조사해라 // varchar(3) : 가변적인 문자열(variable charactor)에 값이 3개가 들어간다, 괄호는 값 수량의 최대치.

select emp_id,emp_name,hire_date,salary*12 from employee where emp_name='방명수'; --1. 연산가능 *12 2. where ___ 위치를 쓰면 해당 자료를 정확히 나타낼 수 있음 ..뒤에 자꾸 조건을 붙여나가는 것
select emp_id,emp_name,hire_date,salary*12 from employee where emp_id=200 or emp_name='방명수';
select emp_name,salary*12 from employee where salary < 2000000; -- 이건 샐러리가 2000000보다 작은 사람들을 말하는 듯
select emp_name,salary*12 from employee where salary*12 < 20000000; 


/*
완전 영어문법과 비슷. 좋음. 접근성 높네.


- not null : varchar()는, 데이터 수량의 최대치를 조절해줌. 입출력이 빈번한 경우는, 엄.. 성능이 저하될 수 있음, 자주 뺐다 넣다 하면서 성능이 떨어짐. 음 재정리 필요 다시말해 varchar는 계속 수정 가능? not null 붙이면 불가능? 그러면 그냥 char은 뭐지?
varchar()만 데이터 수량 최대치 조절이 가능함 ( char()는 안됨, 입출력이 빈번하냐 마느냐로 결정이 가능해짐 )

char() 자료형 not null
num 자료형은 연산가능, 
lob 자료형 : 4000천글자 넘어가는 데이터 저장 clob / blob 나뉨, clob 은 2GB 텍스트 저장 가능(흔하지X), blob 은 텍스트가 아닌 파일(Bynary) 값도 저장 

*/ 




-- 문제 1 : job 테이블에서 job_name 항목만 다 출력되게 만들어보자

desc job;
select job_name from job;
select job_code from job;

-- 문제 2 : department table 에서 전체 내용을 다 출력해보자

desc department;
select * from department;

-- 되게 좋은 프로그램 같다, 직관적, 언어와 비슷

desc employee;

select emp_name, email, phone, ent_date  from employee;

--문제 3 : employ 테이블에서 월급이 250만원 이상인 사람의 이름, sal_level 출력하기

desc employee;
select emp_name,sal_level from employee where salary>=2500000;
select * from employee;

/*

column 명 설정시 은 더블쿼테이션을 써야한다.
문자열형 데이터 설정시에는(=field)  싱글 쿼테이션을 써야한다. 이게 좀 헷갈릴 수 있다?
약간 좀 귀찮아지네.......?
아니 일단 그러면 우리집 그걸 넣어볼까?
돈 계산기?

*/




--문제 4 : employee 테이블에서 ( from employee; ), 월급이 350만원이상 이면서, job_code가 j3인 사람의 이름(emp_name),과(and) 전화번호(phone)만 출력해주세요

select emp_name,phone from employee where salary>=3500000 or job_code='J3'; -- 대소문자 구분이 안됨, and를 써야 됨. where을 조건문이라고 하나? where 앞과 뒤에 and라고 붙은 애들.

--문제 5 : 보너스

select bonus from employee; 

--문제 6 : employee 테이블에서 직원의 이름 / 연봉 / 보너스 / 보너스 적용된 연봉 출력

select emp_name as 직원명, salary*12 as 연봉, (salary*12*bonus)+(salary*12) as "보너스 적용된 연봉", '원' "단위" from employee; --'원'은 데이터값이고, "단위"는 헤더이므로

select emp_name, phone, salary from employee; -- 집에가서 오라클로 해봐야겠네

-- as 구문 : 뒤에 column header의 이름을 설정해주는 명령어, 생략도 된다(but 있는게 가독성에 좋음).


--문제 7 : 이름,연봉,총수령액(보너스포함),실수령액 : 총수령액 - (월급*세금3%)

select emp_name as 이름, 
salary*12 as 연봉, 
(salary*12)+(salary*bonus*12) as 총수령액, 
((salary+(salary*bonus))-(salary*0.03))*12 

as 실수령액 from employee;



select sysdate as 입사일 from employee; --sysdate : 현재시간을 date형으로 나타내는 객체 = 자바 current.timemillies()

select sysdate from dual; --dual : test용 테이블이다?

select hire_date as 고용일, sysdate from employee; 

-- 날짜 연산

select sysdate - hire_date as 근무일수 from employee;

select sysdate -49 from dual;

--문제 8 : employee 테이블에서 이름과 근무일 수 출력

select hire_date from employee ;

select emp_name 이름, floor(sysdate-hire_date) --floor : 소수점 제거 기능
as "근무일 수" from employee;

-- 문제 9 : employee 테이블에서, 이름 , 월급, 보너스율 출력, 하는데 근무년수 20년(hire_date - sysdate)을 넘어가는 사람만 하게하기

select emp_name 이름,
salary 월급, 
nvl(bonus,0) 보너스, -- null value( A , B ) : value가 A인애들은 B값으로 바꿔준다.
floor((sysdate-hire_date)/365) 근속일수 
from employee where (sysdate-hire_date)/365>=20;



select distinct job_code from employee; --distinct : 중복 제거 코드, 해당 column 에 중복value가 있는 경우, 이를 제거해준다? 또는 한 개만 출력하게 해준다.


select emp_name 이름, salary || '원' 월급 from employee; -- || : java's 'or' boolean operator 를 쓰면, 해당 column 안에서 넣어줌


-- 문제 10 : employee 테이블에서, 급여를 300만원 이상, 그리고 500만원 이하 받는 사람들의 이름

select emp_name 이름, phone 전화번호, salary || '원' 급여 from employee where salary>3000000 and salary<5000000;

select emp_name 이름, salary 급여, phone 전화번호 from employee
where salary between 3000000 and 5000000; --between : 300만과 500만을 모두 포함하는(inclusive) 값. 5000000 >= Value >= 3000000


select * from employee where hire_date not between '09/09/01' and '17/03/01'; -- 1. 날짜도 가능 2. not between : 해당하는 조건이 아닌 값들만 출력한다.

select emp_name 이름 from employee where emp_name like '전%'; -- where 에는 그저 넣어주고 싶은 조건, 줄이고 싶은 해당 값의 범위를 정할때 쓴다. 탐정이 수사각을 좁히듯?
-- like %(percentage) : 있어도 되고 없어도 된다. 

select emp_name 이름 from employee where emp_name like '%전%';

select emp_name 이름 from employee where emp_name like '%전';



-- like _(underbar) : _ 으로 표기된 자릿 값에 반드시 어떤 값이 있는 value만 뜨게 만듬
select emp_name 이름 from employee where emp_name like '__전';

select emp_name 이름 from employee where emp_name like '_전_';

select emp_name 이름 from employee where emp_name like '전__'; 
--앞에 전이라는 텍스트를 갖고, 뒤에 언더바에 무언가 값을 갖고 있는 value만 나타낸다. 중요한 건, 언더바는 데이터값의 자릿수를 알고 있을때 사용이 적합하다. 하지만 '%' 표현은 자릿수를 몰라도 적용을 할 수 있다.


-- 문제 11 : employee 테이블에서 이름이 '연' 자로 끝나는 분들을 출력

select emp_name 이름 from employee where emp_name like '%연';
select emp_name 이름 from employee where emp_name like '__연';


-- 문제 12 : 전화번호가 010 으로 시작하지 않는(not like) 사원의 이름과 전화번호를 출력

select emp_name 이름, phone 전화번호 from employee where  phone not like '010%';


-- 문제 13 : employee 테이블에서 메일주소에 s 글자가 들어가며(and) dept_code가 d9또는(or) d6 이고(and) 급여가 270만원 이상이고(2700000<a) , 입사일이 90/01/01 ~ 00/12/01 사이에 있는 사람
select * from employee;


select * from employee 
where 
email like '%s%' 
and (dept_code = 'D9' or dept_code = 'D6')   -- 괄호 ( ) 연산자 우선순위 :  애매한 부분
and salary>=2700000
and hire_date between '1990/01/01' and '2000/12/01';

--문제 14 : employee 테이블에서, 성별이 여성인 분들의 이름만 출력하세요.

select emp_name from employee where emp_no not like '_______1______';



-- 길고 복잡한 것이라도, 작게 한 구절 한구절씩 잘라내려가면서 정리하면 답이 나온다


/*
"무엇을 구하고 싶은가?" 먼저 확인 > select로 먼저 찾기(영어에서 가장 중요하게 생각하는 뜻이 문장 맨 앞에 나오는 것과 매우 흡사하구나)
와 이렇게 직관적으로 영어와 똑같다는게 너무나 편안하네.
*/






/*

하면 할 수록 너무나 재밌는데? 왜 이렇게 쉽게 계산이 팍팍 되는거지? 사실 이런걸 너무나 원하긴 했지 ㅎㅎㅎㅎ

*/



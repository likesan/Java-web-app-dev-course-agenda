--[ 그나마 자주쓰이는 문자열 처리 함수 ]


-- 1 length( column name ) : 문자열 또는 지정 컬럼의 길이
select email, length(email) emp_name, length(emp_name) from employee;




-- 2. instr( '찾을 대상이 되는 문자열 column 위치', 'H' , ' 문장 내에서 시작 index 순서' , '몇번째 H를 찾을 것인가-대상'  ) : 스트링 안에서, java indexOf() 특정 글자가 몇번째 숫자인지 찾는 것, 
-- 노트 : 시작지점 마이너스 =  뒤에서 XX 번째, 나중에 은근히 많이 쓰인다.

select instr('Hello World Hi High','Hi',1,1) from dual;
-- ex ) employee 테이블의 email에서 @의 위치를 찾아서 출력해보세요. 
-- email도 함께 출력




select instr('showmenthemoney','show',1) from dual;
-- return : 1

select email 이메일, instr(email, '@',1,1) "@의 index" from employee;


-- 3. LPAD / RPAD  : Left Padding / Right Padding, 우리가 지정한 문자로 데이터의 왼쪽 또는 오른쪽을 채우는 함수 = (|| '원')

select lpad(email,20,'#') from employee;
-- 20칸에다가 열 다섯글자(email char 갯수)를 출력해라.

select rpad(email,20,'!') from employee;



-- 4. trim(ltrim / rtrim)
-- Default Function : 허공에 떠있는 빈칸을 제거
select ltrim('    kh   ','  ') from dual; 
-- left 사이드에 해당 '   ' 기호를 지워주세요. 제거 대상을 지정할 수 있다.

select rtrim('    kh   ') from dual;


select ltrim('000123456','10') from dual;
-- 주의사항 : 여기서 지워야할 대상으로 선정한 '10' 은10으로 된 문자열을 지우라는게 아니라, 1이나 0이라는 문자로 된 모든 데이터는 각각 지우라는 뜻, '1'과 '0' 이라는 2개의 지정값을 갖는다는 점!!!
-- 문제 : 123123kh

select rtrim(ltrim('123123kh132','123'),'123') from dual;
-- 노트 : 메소드 개념 이해 필요. 그냥 남는 값에 한번 더 둘러싸면 가능하다. 중간에 강사님이 return값이  있기 때문에 어쩌구 저쩌구라는 말이 이해도 되지만, 그냥 저렇게 한번 더 둘러싸면 1차적으로 계산된 함수 값을 2차적으로 계산할 수 있다는 말과 다르지 않다.
-- 편하고 쉽게 이해하자. 어렵지 않다.

select trim('Z' from  'ZZZKHZZZ') from dual;
-- 노트 : 왼/오른쪽 구분 없이, from 으로 겨냥되어있는 글자들로부터 선택한 문자를 제거해버리는 기능. 보다 포괄적, 유용

select trim(leading 'Z' from  'ZZZKHZZZ') from dual;
-- leading : 왼쪽에서부터 선택한 문자를 전부 지워줘

select trim(trailing 'Z' from  'ZZZKHZZZ') from dual;
-- trailing : (트레일러처럼 뒤에 끌고 다니는 위치) 겨냥된 문자열 뒤에 따라다니는 문자들 중에, 선택한 문자를 전부 지워줘~

select trim(both 'Z' from  'ZZZKHZZZ') from dual;
-- both :  양쪽에서 모두 지워줘

-- 노트 : 앞에서 쓰인 padding 보다 '조금' 더 쓰인다.




-- 문제 : department 테이블에서, dept_title을 모두 출력하는데, '부'를 제거하고 출력하세요. TRIM

desc department;
select * from department;
select trim('부' from dept_title) 부서 from department;




-- 문제 : hello 출력 시키기 '5109852058291051283985985298Hello895239528060625636' 

select  rtrim(ltrim('5109852058291051283985985298Hello895239528060625636', '0123456789'),'0123456789') from dual;
-- 노트 : trim을 쓴다고 해서 원하는 저 긴 숫자들이 한꺼번에 사라지게 만들 수 있게는 못함 > trim 은 1 문자만 지정 삭제 가능



-- substring : 문자열에서 바라는 문자열을 빼내는 기능, 검색 방향은 왼-우, 시작지점은 마이너스값 가능 ( 굉장히 많이 쓰인다)
select substr('showmethemoney') from dual;
-- 노트 : 인수 생략시, 5번째 자리에서부터 전부다 라는 함수

select substr('showmethemoney',1,4) from dual;
-- 노트 : 첫번째 글자에서부터 4문자를 빼줘

select substr('showmethemoney',-7,3)from dual;



-- 문제 : 음수 방향으로 시작, me 뽑아내기

select instr('showmethemoney','me',-1) from dual;
select substr('showmethemoney', -10,2) from dual;
select substr('쇼우 미 더 머니', 2) from dual;





-- 문제 : employ table에서 직원 이름 출력, 이름에서 성만 출력

select distinct substr(emp_name, 1,1) 성 from employee order by 성;

-- order by 는 실제 존재하는 column의 이름 이 들어가야한다. 





-- 문제 : employee 테이블에서, 남직원만, 사원번호-사원명-주민-연봉 출력, 주민번호 뒷자리는 *로 출력

select emp_no from employee;
select emp_id 사원번호,  emp_name 사원명, rpad(substr(emp_no,1,6),15,'-1*******') 주민번호, salary*12 ||'원' 연봉 from employee where emp_no like ('%-1%');


select emp_id 사원번호,  emp_name 사원명, rpad(substr(emp_no,1,6),15,'-1*******') 주민번호, salary*12 ||'원' 연봉 from employee where emp_id>=200 or emp_id<=221;


-- like를 쓰지 않고 해보라 like를 쓰지 않는다면 주민번호를 어떻게 찾는다는 말인가? 어떤 다른 방법이 있을까? 사원번호 200 ~ 221 사이에 있는 놈으로 해보자? 






-- upper / lower / initcap

select upper('welcome to my Oracle world') from dual;

select lower('welcome to my Oracle world') from dual;

select initcap('welcome to my oracle world') from dual;




-- 두 문자열 합치기

select concat('AB','CD') from dual;

select 'AB' || 'CD' from dual;



-- replace : 대체하기

select replace(initcap('hate oracle'),'Hate','Love') from dual;

select emp_name, replace(email,'kh','iei'), emp_no from employee;







-- [ 숫자처리 함수 ]

-- abs : absolute의 약자로, '절대값'을 구하는 함수, '변위'

select abs(-10) from dual; -- 10



-- mod : 나머지 

select mod(10,3) from dual ; --- 1




-- floor : 모든 소숫점 지움

select floor(10.5) from dual;



-- trunc : 소숫점 버림(버릴 자리 지정 가능)

select trunc(1234.567,1) from dual; --1234.5

select trunc(123.456,2) from dual; -- 123,45

select trunc(123.456,-1) from dual; -- -1번째 값, 실수의 1번째 값을 버림(<>반올림), 120

select trunc(123.456,-2) from dual; -- -2번째 값, 실수의 2번째 값 버림, 100




-- ceil : '천장', 천장까지 올려라, 반올림

select ceil(123.456) from dual; -- 반올림, 124




-- round : 우리가 지정하는 자리수 반올림(5이하면 정말 안올림, 이상은 올림) 

select round(123.476, 2) from dual; --123.48
select round(123.476, 0) from dual; --123
select round(123.476, 2) from dual; --123.48
select round(123.476, 2) from dual; --123.48







-- 날짜 처리 함수

select sysdate from dual; --현재 18/04/19
select current_date from dual; --현재 18/04/19
select localtimestamp from dual; --18/04/19 15:58:08.717000000
select current_timestamp from dual; --18/04/19 15:58:33.068000000 ASIA/SEOUL : 가장 자세히 나옴



-- 중요(응용 확률 높음)  함수

-- months_between : 인수로 넘어온 두 시간 사이의 개월 수 

select emp_name , hire_date, floor(months_between(sysdate,hire_date)) 근로일수 from employee order by 근로일수  asc  ;



-- add_months : 인수로 넘긴 숫자만큼의 개월을 더한 날짜를 리턴

select emp_name, hire_date, add_months(hire_date,6) from employee; -- 90/02/06 to 90/08/06

select add_months(sysdate,120) from dual;



-- 문제 : 오늘 sysdate철수는 군대에 갑니다. 군 복무기간이 21개월이라고 가정했을 때 '입대일' '제대일'을 출력
-- 하루 3번 식사했을 때 총 몇번 식사( (add_months(sysdate, 21))*3)?

select sysdate 철수입대일, add_months(sysdate, 21) as  "제대일" , 30*21*3 || '번' as "식사횟수" from dual;

select '철수' 이름, sysdate "입대일(오늘)", add_months(sysdate, 21) as  "제대일" , (months_between('18/04/19', '20/01/19')*3*30) || '번' as "식사횟수" from dual;
select sysdate 철수입대일,
add_months(sysdate, 21) as  "제대일" ,
(months_between(add_months(sysdate, 21),sysdate ))*30*3 || '번' as "식사횟수" 
from dual;


-- next_day  : 기준 날짜로부터 가장 가까운 요일

select  next_day(sysdate,'월') from dual; -- 18/04/23
-- 오늘로부터 가장 가까운 특정 요일 찾기

select  next_day(sysdate,2) from dual; 
-- 기준 : 일 = 1, 토 = 7



-- last_day : 지정한 기준 날짜가 속한 달의 마지막 날

select last_day(sysdate) from dual; --18/04/30

-- 고용된 날의 마지막 날 찾기




-- 문제 : 다음달 마지막 날 찾기

select last_day(add_months(sysdate,1)) from dual; -- 18/05/31
-- add_months( 인자 1 , 인자 2 ) 


-- extract : 추출, 날짜값으로부터 원하는 단위를 추출
select extract (year from sysdate) from dual;
-- ctrl + space를 함수 선언자 위에 커서를 놓고 실행할 시, 사용할 수 있는 기능들이 나타남



-- 문제 : employ table에서 사원의 이름, 입사일(yyyy/m/d 형태), 연차((해당 해 년도-입사일)+ 1), 입사일 기준 오른차순

select emp_name 이름, 
extract(year from hire_date ) || '년 ' || extract(month from hire_date) || '월 ' || extract(day from hire_date) || '일 ' as "입사일",
extract(year from sysdate)-extract(year from hire_date)+1 연차
from employee order by hire_date desc;

-- 노트 :  ||(or) 를 쓰면 된다. 한 column 내에서도 여러 메서드를 통해 추출해낸 값들을 한 셀(field)안에 넣을 수 있다. 



-- 문제 : employee 테이블에서, 1 사원의 이름 / 2 입사일 / 기준일(=입사일 다음 달 1일) / 기준일 후 6개월  /기준 월 출력 - 입사일 기준 오름차순 

desc employee;
select emp_name 이름, 
hire_date 입사일,
last_day(hire_date)+1  기준일, -- 기준일의 일 수를 1롤 만들고 싶은데? 기준일은, 마지막날의 +1 된날
add_months(last_day(hire_date),6)+1 기준월,
extract(month from (add_months(last_day(hire_date),6)+1)) ||'월' as "기준일 후 6개월"
from employee order by hire_date asc;
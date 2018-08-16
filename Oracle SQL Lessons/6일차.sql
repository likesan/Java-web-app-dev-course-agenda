-- 문제 1. 모든 직원의 나이 별 인원수를 출력하기
-- count to_char(lpad(substr(emp_no,8,2)),1,19)-(substr(emp_no,8,2))/ group by / 오름차 순

select 
-- 나이별 인원수라.. 나이별로 정리한다라? 나이별로 어떻게 정리하지? count로 해야하나? count()안에는 뭐가 들어가지?
count(substr(emp_no,1,2)) ||'명' 인원수, -- count가 잘 안되었었을 뿐. emp_no 로 주민번호를 출력한다, 그다음 값의 첫번째의 두 숫자를 찾아낸다. 그 다음에 그 숫자들의 카운트를 찾는다? 
to_char(sysdate,'yyyy')-lpad(substr(emp_no,1,2),4,19) ||'세' 현재나이
from employee
group by substr(emp_no,1,2); -- group by로 출력하려는 기준이, 바로 나이값이 되므로

--------------------문제 풀자!!--------DBA 아니더라도 확실하게 이해하고 넘어가자!!-----------------------------------------------------------------------------------------------
-- 문제 2. 매니저가 있는 사원 중, 급여가 전체 사원의 평균을 넘는 직원의 사번, 이름, 매니저 이름, 급여 출력(만원단위 이하 절삭) 

-- 매니저의 이름---------------------------------------------------
(select emp_name from employee 
where emp_id in (select manager_id from employee) );   -- 이 부분이 잘 이해되지 않는다? 선동일의 manager = null 이라는건, 선동일에게 매니저가 없다는 뜻이고, 송종기의 매니저가 누구 인지 알려면? 그가 가진 manager id값을 갖고 있는 애를 찾아야겠지? manager id = emp id 여야겠지? join은 어떻게 들어가줘야하는거지?

-- 매니저 아이디 값들을 가져오고, emp_id 에 있는 애들? 매니저 아이디값? 
select emp_name, manager_id from employee;

------------------------------------------------------------------------
select emp_name, emp_id from employee where emp_name = '하이유' or manager_id = 207;

select e1.emp_id, e1.emp_name "직원명", e1.salary, e2.emp_name "매니저 이름"
from employee e1,  employee e2
where e1.emp_id = e2.manager_id ;-- 매니저 이름만 출력해내는 방법이 뭘까? 어떻게 해야 매니저 이름만 출력해낼 수 있을까? 

-------------------------------------------------------------------------

-- 급여를 출력
select avg(salary) from employee;
-- 저 1,2 번이 조건이다. 나머지는 select에서 충족시켜줘보자

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 매니저 이름 부터 출력해보자
select emp_name,
emp_id
from employee 
where emp_id in (select manager_id from employee); -- 매니저가 있는 애들만 출력하고자 하는것? 얘네를 출력해내려면? 여기서 뭔가 문제인데 여기서 뭘 어떻게 해야하지? 아까 그런 화면이 왜 나온거지? 이중 테이블하면 교차 테이블이 되는건가?

-- and (select floor(avg(salary)) from employee);


select 
distinct e1.emp_id 사번,e1.emp_name 이름,
e2.emp_name 매니저아이디,
e1.salary 급여
from employee e1, employee e2
where e2.emp_id in (select manager_id from employee) 
and e1.salary > any(select floor(avg(salary)) from employee)

-- 아예 처음부터 다시해볼까?


order by 1; 

select * from employee;


-- 평균 이상?

--------------------------------------------------------------------------------------------------------------------

select emp_name,dept_title from employee, department where dept_code = dept_id; 
-- = 위아래 두 문장이 똑같은 기능.
select emp_name, (select dept_title from department where dept_id = dept_code) from employee; -- subquary 는 select 안에서도 사용할 수 있다. 
-- 바깥의 from employee table로부터도 dept_code를 where 절로 이끌어 오고, 해당 절 안에서 dept_id 역시 끌어올 수 있다. 이런 subquary를 상관서브쿼리라고 부른다.

select emp_name ,(select dept_title from department where dept_id = dept_code) from employee;
--dept_code 는 employee table에 있는 column이며, dept_code는 department 테이블에 존재하는 column이다. 다시말해 subquery 문 바깥에서도 
select * from employee;

-- 상관서브쿼리 : 메인쿼리에서도 끌어오고? 뭘? 아 from employee라는 것으로?
-- 가독성이 좋은편이 아니다. 쓸줄 아는 사람만 쓴다고?
-- 개발자로서 필요한 능력은 이미 지나왔다고 한다? DBA가 아닌 이상은, 0.047초 등 퍼포먼스의 시간을 파악하는 사람들은 따로 있다.
-- 아 나는 글이나 좀 쓰면서 하루 어떻게 보낼지에 대해 좀 더 영민하게 준비했었어야했는데 그런 글을 써내는 시간이 좀 부족했구나... 글을 적어내는 시간이 부족하거나 좀 아쉬우면 머리가 혼란스러워진다. 제대로 된 집중이 힘들어진다. 100% 역량을 이끌어내기 어려워진다. 산만함이  남게된다.
-- 고로 나는 미친듯이 긍정을 하면서 이렇게 글을 파파파팍 써내야한다. 그래야 내 뇌가 정돈된 상태로 뭔가 잘 이해하고 얻어낼 수 있는 준비가 되어가기 때문


-- 직원의 이름과 직급 명을 출력하세요. 상관 서브쿼리로 만들어보자. 상관 서브쿼리는 어떤 기능이엇지? 리턴값을 이용하는거지 뭐 똑같이? 허나 한 테이블에서 끌어올 수 있다는거지? from을 한개만 써도 괜찮다 이거야?
-- 둘이 이끌어내는건가? 



select 
emp_name,
(select job_name from job j where j.job_code = e.job_code) -- 나는 디테일에 전부 집중할 수 있다.
from employee e;

-- 문제 4. 부서별 평균 급여가 220만원 이상인 부서명, 평균 급여를 출력 (상관 서브쿼리로 출력)
-- 평균 급여 소수점 숫자 버리기

select * from employee;
select * from department;

select nvl((select dept_title from department where dept_code = dept_id
),'인턴'), floor(avg(salary))
from employee 
group by dept_code -- 평균 220만원보다 낮으면.. 얘를 어떻게 하지? 
having avg(salary)>2200000 -- 아 having에서 줄일 수 있구나! 뜨하.
order by 2; -- 왜 2개로 나오지 교차조인? 왜 교차조인 되지? 모르겠음? 알려면 어떻게 해야하지? 두 테이블을 모두 출력해보면 되지 않을가? 아 내가 여기가 이해가 되지 않아서 문제였나보다 위위에 문제도?

--  교차조인 문제들을 푸는게 다들 핵심인 것 같은데, 교차조인을 정확히 이해해야하는 것 아닐까?


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 순위 책정 기능

-- ## rownum : sysdate 같은 것? 어딘가에 존재하는 컬럼은 아니지만 현재 시간을 나타내는 것처럼, 출력되는 행의 번호를 붙여주는 기능이라고! 행 번호 붙여주는 객체
-- 새로운 column에  행의 수 만큼 숫자들이 담긴 행들 생성된다
select rownum, emp_name from employee;


select rownum, emp_name, salary from employee;
-- 순서가 뒤죽박죽 되서 나옴, 왜? 실행 순서에 따라 from 부터 되고, select는 5순위로 되고 ?
-- 실행순서가 from이 먼저 실행되므로, 이 from을 먼저 수정하도록 하자. table에서 불러오도록만들자, 먼저 align 잘 되어있게 해보자
select rownum, emp_name, salary from (select * from employee order by salary desc );
select * from employee order by salary desc; -- 얘는 그냥.. 내림차순으로 모든 샐러리를 내려보내는 명령어임. 아 얘를 적용시켜서 어떻게 하려는거지?
-- 음.. 그런데 뭔가 잘 모르겟어? 외워서 알긴 아는것같은데 정확히 어떤 원리로 되는거지?

-- rownum의 단점을 극복, 순서를 아예 맞춰버리는 게 있음. 중복 순위까지 조정하는..? 그리고 중복순위가 수정되면서 뒤에 밀려있던 애들도 다 우선순위 맞춰버리는 기능
-- 이게 뭐지 ? 

select  emp_name , salary, rank() over(order by salary desc) 순위 from employee;
-- 우리는 salary를 통해 우선순위들, 순서들을 정렬하고 싶으므로!
-- 내림차순, 오름차순 까지 표기해줘야함
-- 번호 표기까지 해줌

-- 19위 정형돈 / 윤은해는 아예 20위로 나누는게 아니라 서로 건너 뛰어버림, 그 누구도 20위가 아니라는 것을 표기해줘버림 ,다시말해 20위에 해당하는 애들은 그저 
-- 그런데, 21위로 뛰어넘어버리는게 아니라 20위로 제대로 똑바르게 맞춰서 표현되게 만들고 싶다면 앞에 dense_를 붙여줘야함, dense 는 찌그러진 것을 말한다고? 다시 찾아보니 '밀집된, 짙은, 밀도가 높은, 많은, 무더기와 같은' 이라는 뜻으로 쓰인다. 다시 말해 건너뛰는 것 행 없이 아주 밀도있게 모든 랭크를 표현하고 싶을 때 dense를 쓴다.
select  emp_name , salary, dense_rank() over(order by salary desc) 순위 from employee;


-- 아 아예 어느 column 자체를, 순서 정렬까지 해주는데, rownum 처럼 아예 다 태워버리네 아주 제대로 그냥 모든 순위를 나타내줘버리는구만

-- 나중에 게시판, 웹 어플리케이션 만들어 paging 옵션을 줄때 사용된다고 한다. rownum 역시 사용된다고 한다.
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 문제 : 모든 직원의 나이 오름차 순(asc)으로 순위를 지정해서 출력하세요.
-- 나이가 많은 쪽이 1위 입니다.

-- rank over를 사용해야겠지? 나이로?

select to_char(sysdate,'yyyy') - ( (lpad(substr(emp_no,1,2),4,19) )) 나이 from employee order by 1 desc;


select emp_name 이름, 
(select to_char(sysdate,'yyyy') - ( (lpad(substr(emp_no,1,2),4,19) )) 나이 from employee) , ------------------------- 얘도 안됐음
dense_rank() over(order by 나이 desc ) 
from employee;


---------------------------------------------------------------------------------- DDL (테이블 생성 명령문)
-- 테이블 만들기 : create

-- create table  person ();   
-- 부족하면 축약시켜주는 놈? 자료형도 써줘야한다. 
-- column 에서 자료형이 무엇인가? 
-- () constraints 제약조건 :  중복될 수 없다라는 조건, 이 컬럼에는 값을 비워둬선 안된다 등 기능을 설정해두는 것 emp_id 처럼 중복되어선 안되는 값들..
 

create table  person ( -- column명 자료형(자료형의 길이) 제약조건
    id varchar(20), -- 20글자 안쪽으로 넣는다.   
    name varchar(20), -- 그냥 varchar2라고 굳이 선언하지 않아도, 작동시 varchar 2로 작동됨
    age number
) ;

-- ctrl + enter 로 Table PERSON이(가) 생성되었습니다. 확인

desc person;


-- 주석달기
-- comment on
comment on column person.id is '회원 고유 ID값';
comment on column person.name is '회원의 이름';
comment on column person.age is ''; -- 수정은 이 곳에서


select * from all_col_comments where table_name = 'PERSON'; -- 오라클에서 이미 갖고 있는 기능,  comment 들을 확인하는 기능, 
---------------------------------------------------------------------------------------
-- DML 데이터를 관리하는 기능 중 데이터 입력 기능을 사용할 예정
-- insert into : 데이터를 집어넣는 기능

insert into person values('1001', ' Jack', 20) ; -- 처음부터 입력됨
insert into person values('1002',null,null);

select * from person;

-- 객체를 떨궈버리는 기능인건가?
drop table person;

create table person( 
    id varchar(20) not null, -- 컬럼명 자료형 제약조건(constraints)
    name varchar(20) not null,
    age number
);
-- not null : null 값은 해당 열에 넣을 수 없다.

insert into person values ('1001','홍긴동','56');

drop table person;

create table person(
    id varchar(20) not null,
    name varchar(20) not null,
    age number,
    gender varchar(10) check (gender in('남','여')) --  '남' 또는 '여' 로만 정해지도록 제약 둠 = check ( ___ in (' ' , ' ')) -- 체크하라
     
);

insert into person values('1001','Jack',20,'남');

select * from person;

drop table person;
create table person(
    name varchar(15) not null,
    phone number(15),
    nationality varchar(20) not null,
    height number(15) not null,
    gender varchar(5) check (gender in('남','여'))
);

select * from person;

insert into person values ('김삼순', 01034235555,'한국',168,'여');
--------------------------------------------------------------------------------------
desc person;

drop table person;

create table person(
     id varchar(20) primary key, -- 주가 되는 값이라고 주는 것, Java hashmap 에서 key값처럼 기능.
     name varchar(20) not null,
     age number
     
    );

-- primary key : 각각의 행을 대표하는 식별자 값으로 만들어주는 값,
-- not null + unique(각 컬럼에서 단 하나만 줄 수 있는 기능)


drop table person;
select * from person;

insert into person values ('32','윤승진','29.5'); -- 2번째 시도시 : unique constraint violated 에러 뜸

drop table person;

create table person(
    id number(10) primary key,
    name varchar(20)
    not null,
    age number(10),
    nationality varchar(20) not null
);

insert into person values(1,'윤승진','29.5','Republic of Korea');

select * from person;

drop table person;

create table person(
    id number(10) primary key,
    name varchar(20) not null,
    langauge varchar(20) not null,
    height number
);
---------------------------------------------------------------------------------------
-- unique : primary key처럼 하나만 쓰이는게 아니라 여러개 만들 수 있는 그런 기능?

create table member(   
    pk_id varchar(20) primary key, -- 각각의 row의 대표적인 값? key값, 운전대 같은 값, 회사 내에서 회원들을 관리하기 위한 값들
    id varchar(20) unique -- unique constraints라고 부름. primary key는 아니지만, primary key처럼 단 하나만으로 row를 구분 지을 수 있는 값. 중복이 될 수 없다.
    
);

insert into member values ('21','aiden'); -- 둘다 중첩되지 않아야만 값이 가능

select * from member;

drop table member;
drop table person; -- 놔버린다는 뜻인가

create table person(
    id varchar(20) primary key,
    name varchar(20) not null,
    age number default 0 -- 값이 없다면 기본적으로 그냥 0이다. 라는 뜻
);

insert into person values('1001','jack',default); -- 아예 빈 공백이 아니라 'default'라는 입력을 주면 저리 된다.

select * from person;

insert into person values('1002','john',null); -- 만약 null을 넣어주면 어떻게 될까? 그냥 null 이 생긴다!? 이를 통해 null 과 숫자 0이 실제로 존재하는 것은 정말 다른게 아닐까?


--------------------------------------------------------------------------------------
-- Foreign key( 외부키 )

-- 참조 무결성을 위해 사용되는 제약 조건? 참조하는데 무결하다고? 참조하는데 있어서 문제가 없다고? 참조가 되기 위한 Table에 거는 기능이라고 봐야할까?

create table shopping(
    buy_no number primary key, -- 중첩되지 않음
    id varchar(20) references person(id), -- 외부 키값으로 선언함  
    item_name varchar(20),
    buy_date date -- 타입이 아예 날짜형 값이 존재하구나 'date'
);

drop table shopping;

select * from shopping;
select * from person;


insert into shopping values (1,'1001','자바의 정석',sysdate); -- 1번 구매자
insert into shopping values (2,'1001','Oracle의 정석',sysdate); -- 2번 구매자
insert into shopping values (3, '1003',' ',sysdate); -- intergrity constraints violated -- parent key not found. parent key인, person의 column 'id'에 입력한 1003번이 freference 값이 존재하지 않기에 에러가 남 -- 입력이 불가능함


drop table person;

drop table shopping;

----------------------------------------
-- 문제

create table expert_tbl(
    member_code number primary key,
    member_id varchar(20) unique,
    member_pwd varchar(20) not null,
    member_name varchar(10) not null,
    member_addr varchar(50) not null,
    gender varchar(5) check (gender in('남','여')),
    phone varchar(20) default '000-0000-0000' -- 형태를 홑따옴표를 꼭 넣어줘야 되는구나. 그 형식이 홑따옴표로 선언 되었을 때 비로소 적용된다. 이상한데? 어쩔 때는 홑따옴표 없이도 되고, 어쩔때는 있어야하고... 물론 값으로 들어갈때는 상관없기도 하지만 column 명으로 들어갈때는..? 
);

drop table expert_tbl;

select * from expert_tbl;


insert into expert_tbl values(1001,'1','1234','윤윤윤','경기도 파주시 아동동 275-14번지', '남',default);

create table expert_skill ( -- 얘는 뭐지? 스킬값을 갖는건가? 일단 column 은 2개, member_code 와 skill 이라는 두놈인건 알겠는데 음..
    member_code number references expert_tbl(member_code),
    skill varchar(10)
    );

select * from expert_skill;
drop table expert_skill;


insert into expert_tbl values(100, 'gildong', '1324', '홍길동', '경기도 화성','남','010-1111-2222');
insert into expert_tbl values(101, 'gaesun' ,'1432','꽃개선','인천 가좌','여','010-2222-1111');
insert into expert_tbl values(102,'samsam2','5413','박삼삼','서울시 구로','남','010-4343-2958');
insert into expert_tbl values(103,'choco','pie','빅초코','미국','여',default);




create table shopping(
    buy_no number primary key, -- 중첩되지 않음
--    id varchar(20) references person(id), -- on delete restrict : 아예 refererenced column 자체가 delete 불가하게 만드는 제약조건(constraints)
--    id varchar(20) references person(id), -- on delete set null  : 삭제는 가능하나, null 값으로만 초기화 시키는 제약 조건(constraints)
--    id varchar(20) references person(id), -- on delete cascade  : 삭제도 가능, 아예 참조되는 값 전부 삭제되도록 하는 제약조건(constraints), cascade : 연쇄적인, 작은 폭포, 연속되는, 종속되는 이라는 뜻
    item_name varchar(20),
    buy_date date -- 타입이 아예 날짜형 값이 존재하구나 'date'
);
-------------------------------------------------------------------------------------------------------------------------------
-- DML > INSERT Quary파헤치기


create table person(
    id varchar(20),
    name varchar(20),
    age number
);

insert into person (age)values(20); -- age라는 column 에 20이라는 값을 넣겠다. 셀에 나중에, 20이라는 값이 컬럼 한 줄 안에 들어있는 모습 확인할 수 있음

insert into person (name,age) values('jack',30); -- 두 columns 에 넣을 수도 있다. values 다음에 나오는 괄호 안에 쉼표를 통해 columns 의 갯수 만큼, 값들의 경계를 나눠주면 된다.

insert into person (id,name,age) values('susan',25); -- 이렇게 모든 columns 에도 values 들을 넣을 수 있다. 하지만 모든 칸에 딱 맞는 values 값들을 넣으려는 경우, values 들이 들어갈 columns 이 무엇인지 생략도 가능해진다. 굳이 안적어줘도 Oracle이 알아서 해준다.
-- == insert into person values('susan',25);



create table emp_part(
    emp_id varchar(30),
    emp_name varchar(30),
    salary_link varchar(20)
);

-- 지금 하려는게 뭐?

--insert into emp_part (select
--emp_id,
--emp_name,
--dept_title
--from employee, department
--where dept_code, dept_id);


-- - - -
select * from employee;

insert into emp_part(
select emp_name,
salary,
dense_rank() over(order by salary desc)
from employee);

drop table emp_part;
select * from emp_part;


-- Update Quary : 기존에 있던 field값을 수정. 

create table department_copy as select * from department; -- department table을 그냥 그대로 카피해오는 quary

select * from department_copy;

update department_copy 
set dept_title = 'IT개발부 ';


---------------------------------------------------------





------------------------------------------------------------------------------------------------------------------------------
-- ## 느낀점 
-- 편법을 쓰면 늘 잘 안된다... 막히는 순간이 꼭 존재한다.  꼭 다가온다.

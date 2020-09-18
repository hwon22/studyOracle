select department_id, job_id, sum(salary) from employees where department_id is not null group by cube(department_id,job_id);
-- 총합이 맨위
select department_id, job_id, sum(salary) from employees where department_id is not null group by rollup(department_id,job_id);
-- 총합이 맨밑
select * from employees;
select department_id, job_id, manager_id, sum(salary) from employees group by cube(department_id,job_id,manager_id);
--부서번호 업무 매니저번호 급여합 조회시 cube를 사용하여 부서내 업무담당 매니저별 집계, 총 집계 조회

--GROUPING SETS
select department_id, job_id, sum(salary) from employees group by grouping sets(department_id,job_id);
--group by department_id랑 job_id

select department_id, NULL job_id, sum(salary) from employees group by department_id
union all
select NULL department_id, job_id, sum(salary) from employees group by job_id;
--union all로 select 문 결합 -> 결과는 같음

SELECT department_id, job_id, manager_id, AVG(salary) FROM employees 
GROUP BY GROUPING SETS((department_id, job_id, manager_id), department_id, job_id);

SELECT department_id, job_id, manager_id, AVG(salary) FROM employees GROUP BY (department_id, job_id, manager_id) 
UNION ALL 
SELECT department_id, NULL job_id, NULL manager_id, AVG(salary) FROM employees GROUP BY department_id 
UNION ALL
SELECT NULL department_id, job_id, NULL manager_id, AVG(salary) FROM employees GROUP BY job_id;


SELECT department_id, job_id, manager_id, SUM(salary) FROM employees
GROUP BY ROLLUP(department_id, (job_id, manager_id));
--UNION ALL로 변환하는 거 연습

--NON-EQUI JOIN
--급여가 최소급여와 최대급여 사이인 사원의 사원번호, 사원명, 업무코드, 급여, 업무명,최소급여, 최대급여를 업무코드 순으로 조회
SELECT emp.employee_id, emp.first_name, emp.job_id, emp.salary, job.job_title,
job.min_salary, job.max_salary 
FROM employees emp, jobs job 
WHERE emp.job_id = job.job_id AND emp.salary>=job.min_salary AND emp.salary<=job.max_salary 
--WHERE emp.salary between job.min_salary AND job.max.salary
order by job_id;

--OUTER JOIN
select * from employees;
SELECT * FROM EMPLOYEES ORDER BY department_id;
SELECT * FROM departments;
select * from employees,departments where employees.employee_id=department.department_id;

SELECT EMPLOYEE_ID, FIRST_NAME,EMP.JOB_ID,EMP.DEPARTMENT_ID,DEPT.DEPARTMENT_ID, DEPARTMENT_NAME FROM EMPLOYEES EMP, DEPARTMENTS DEPT
WHERE EMP.DEPARTMENT_ID(+)=DEPT.DEPARTMENT_ID; --126개 결과/dept가 기준임
--employees 테이블과 departments 테이블에서 departments 테이블 에 있는 모든 자료를 기준으로 사원번호, 이름, 업무코드, 부서번호 (employees 테이블), 부서번호(departments 테이블), 부서명 조회
SELECT * FROM EMPLOYEES EMP, DEPARTMENTS DEPT
WHERE EMP.DEPARTMENT_ID=DEPT.DEPARTMENT_ID(+); --111개 결과/empt가 기준임
select * from locations;
select * from departments;
select dept.department_id,dept.department_name,loc.city from departments dept, locations loc where dept.location_id=loc.location_id(+);
--9 departments 테이블, location 테이블을 이용하여 부서번호, 부서명, 해당 부서의 city 정보를 조회(근무도시가 지정되지 않은 부서번호,부서명도 표시)조회
select dept.department_id,dept.department_name,loc.city from departments dept, locations loc where dept.location_id(+)=loc.location_id;
--기준 테이블이 locations 테이블

--FULL OUTER JOIN인데 에러남
select dept.department_id,dept.department_name,loc.city from departments dept, locations loc where dept.location_id(+)=loc.location_id(+);

--union을 이용해 full outer join 실행
select dept.department_id,dept.department_name,loc.city from departments dept, locations loc where dept.location_id(+)=loc.location_id
UNION
select dept.department_id,dept.department_name,loc.city from departments dept, locations loc where dept.location_id=loc.location_id(+);

SELECT * FROM EMPLOYEES EMP, DEPARTMENTS DEPT WHERE EMP.DEPARTMENT_ID(+)=DEPT.DEPARTMENT_ID
union
SELECT * FROM EMPLOYEES EMP, DEPARTMENTS DEPT WHERE EMP.DEPARTMENT_ID=DEPT.DEPARTMENT_ID(+); --127개 뜸

select emp.first_name,emp.salary,dept.department_id,dept.department_name from employees emp, departments dept where salary(+)>2000 and emp.department_id(+)=dept.department_id;
--8. 급여를 2000보다 많이 받는 사원들의 이름, 급여, 부서번호, 부서명 조회 (모든 부서테이블 조회)+ null값이라도 나와야한다면 salary(+)를 해줘야한다. 

select emp.employee_id 사원번호,emp.first_name 사원명,emp.manager_id 관리자번호,man.first_name 관리자이름 from employees emp, employees man where emp.first_name='Ellen' and emp.manager_id=man.employee_id;
select emp.employee_id,emp.first_name,man.employee_id,man.first_name from employees emp, employees man where emp.manager_id=man.employee_id(+) order by 1;

select emp.first_name||'의 관리자는 ' 사원,nvl(man.first_name,'없음') 관리자 from employees emp, employees man where emp.manager_id=man.employee_id(+) order by 1;
--6. 사원명의 관리자는 관리자이름 단, Stevn의 관리자는 null이 나와야 함

--ANSI JOIN
select * from employees NATURAL JOIN departments;
select * from employees;
select * from employees, departments where employees.department_id=departments.department_id;

select * from employees join departments using (department_id);
--조인을 department_id랑만 하고 싶어
select * from employees join departments on employees.department_id=departments.department_id;
select * from employees, departments where employees.department_id=departments.department_id;

select * from employees right outer join departments on employees.department_id=departments.department_id;
--오른쪽이 기준이다
select * from employees left outer join departments on employees.department_id=departments.department_id;
select * from employees full outer join departments on employees.department_id=departments.department_id;

--cross join /카티시안 곱을 유도
select employee_id,department_name from employees emp cross join departments dept;

--natural join
select * from employees;
select * from departments;
--department_id, manager_id를 기준 두개로 조인 가능하다
select * from jobs natural join job_history;

--employees,departments 사원명 부서번호 부서명을 natural join을 이용하여 조회 (사원명 순으로 조회
select * from employees natural join departments order by first_name; --맨앞에 공통 나머지것들
select first_name,department_id, department_name from employees natural join departments order by first_name;

select * from locations;
select department_id, department_name, location_id, city from departments natural join locations where department_id =30 or department_id=10;
--10 departments, locations 테이블을 natural join 하여 부서번호, 부서명, 지역코드, 근무도시 조회 (단 10번 30번 부서만 조회)
select emp.first_name 사원명, emp.salary 급여, department_id 부서번호, dept.department_name 부서명, loc.city 근무도시 from employees emp natural join departments dept natural join locations loc order by first_name;
--사원명 급여 , 부서명 근무도시를 natural join을 이용하여 조회 사원명 순으로 정렬

--natural join 테스트
create table test_join(test varchar2(20), no number(2));
create table test_natural_join(job_id varchar2(10),job_title varchar(25) not null, test number(10));
select * from tab;
insert into test_join values('1000',20);
insert into test_natural_join values('10','TEST_JOB',1000);
select * from test_join natural join test_natural_join;
--타입이 중요하지 않고 열명이 중요함 /이름같고 형식만 비슷하면
insert into test_join values('ABC',20);
--이렇게 하면 오류남

--join ~ using
select first_name,department_id,department_name from employees join departments using (department_id);
select first_name,department_id,department_name from employees join departments using (department_id,manager_id);
--manager_id추가하면 natural 조인이랑 같음
select department_id, department_name, location_id, city from departments join locations using (location_id) where department_id in (20,50,80,110) order by department_id;
--10 departments, locations 테이블을 이용해 부서번호, 부서명, 지역코드, 도시 정보를 using 절을 이용해서 조회(단 부서번호 20,50,80,110만 부서번호 순으로 조회)
select first_name, department_name,city from departments join locations using (location_id) join employees using (department_id);
--7. 사원명, 부서명, 근무도시 정보 조회 (using 절 사용)

--join on
select emp.first_name,emp.salary,man.first_name,man.salary from employees emp join employees man on emp.employee_id=man.manager_id;
select first_name, department_name, city from employees emp join departments dept on emp.department_id=dept.department_id join locations loc on dept.location_id = loc.location_id where first_name not like '%A%' and first_name not like '%a%' order by first_name ;
--이름에 A,a가 없는 사원의 사원명, 부서명, 근무도시 정보 조회 (사원명 순으로 정렬)

--outer join
select dept.department_name, dept.location_id, loc.location_id, city from departments dept left outer join locations loc on (dept.location_id=loc.location_id);
--department테이블의 부서명, 지역코드와 location 테이블의 지역코드, 도시명 조회 (근무지역이 설정되지 않은 부서명도 조회)
select dept.department_name, dept.location_id, loc.location_id, city from departments dept right outer join locations loc on (dept.location_id=loc.location_id);
select dept.department_name, dept.location_id, loc.location_id, city from departments dept full outer join locations loc on (dept.location_id=loc.location_id);


--subquery
--<단일행서브쿼리>
select job_id from employees where employee_id=120;
select job_id from employees where job_id=(select job_id from employees where employee_id=120);
select first_name, salary from employees where employee_id=150;
select first_name,salary from employees where salary>(select salary from employees where employee_id=150) order by salary desc;
--9.150번 사원보다 급여가 많은 사원의 이름과 급여를 급여가 많은 순으로 조회
select first_name, department_id,salary,hire_date from employees where salary =(select max(salary) from employees);
select employee_id, first_name,job_id,salary,department_id from employees where salary<(select avg(salary) from employees);
--급여가 평균 급여보다 적은 사원의 사원번호, 이름, 업무코드, 급여, 부서번호 조회
select employee_id,first_name,job_title,hire_date,salary from employees, jobs where employees.job_id=jobs.job_id and employees.job_id=(select employees.job_id from employees where employee_id=162) and salary>(select salary from employees where first_name='Clara');
--사원번호가 162인 사원과 업무가 같고, 급여가 Clara보다 많은 사원의 사원번호, 이름, 담당업무명, 입사일자, 급여 조회
select department_id,min(salary) from employees group by department_id having min(salary)>(select min(salary) from employees where department_id=80) order by department_id;

--<다중 행 서브쿼리>
--in(결과중하나랑동일) any(<any 최댓값보다 작음 <MAX),(>any 최솟값보다 큼),(=any in) all(모두 참인결과) 등호자리에 씀
select employee_id,first_name,salary,department_id from employees where salary=(select max(salary) from employees group by department_id) order by department_id; --에러(ERR/단일쿼리는 하나의 결과 이상 반환한다)
select employee_id,first_name,salary,department_id from employees where salary in (select max(salary) from employees group by department_id) order by department_id;

select * from employees;
select * from departments;
select * from jobs;

select first_name, salary, job_id from employees where salary>any(
select salary from jobs, employees emp where emp.job_id=jobs.job_id and job_title like 'Sales%') order by salary;
--업무가 sales인 최소 한 명 이상의 사원보다 급여를 많이 받는 사원의 이름, 급여, 업무코드를 급여 순으로 조회
select salary from jobs, employees emp where emp.job_id=jobs.job_id and job_title like 'Sales%' order by salary;

select first_name, salary, job_id from employees where job_id not in ('SA_MAN','SA_REP') and salary>all(select salary from employees where job_id in ('SA_MAN','SA_REP')) order by salary asc;
--업무가 sales인 모든 사원보다 급여를 많이 밥ㄷ는 사원의 이름,급여, 업무코드를 급여 순으로 조회

--<다중 열 서브쿼리>
--10번 부서의 salary 세트로 동시에 비교
select * from departments;
select * from employees;
select manager_id,department_id from employees where first_name in ('Diana','Adam');

select first_name, manager_id, department_id from employees where first_name not in ('Diana','Adam') and (manager_id,department_id)
in (select manager_id,department_id from employees where first_name in ('Diana','Adam'));
--Diana,Adam과 관리자 및 부서가 같은 사원의 이름, 관리자번호, 부서번호 조회

select department_id, employee_id, first_name, salary from employees 
where (department_id,salary) in (select department_id,min(salary) from employees group by department_id)
or (department_id,salary) in (select department_id,max(salary) from employees group by department_id) 
order by department_id;
--각 부서별로 최대 급여를 받는 사원과 최소급여를 받는 사원의 부서번호, 사원번호, 사원이름, 급여 조회
select department_id, employee_id, first_name, salary from employees 
where (department_id,salary) in (select department_id,min(salary) from employees group by department_id
union select department_id,max(salary) from employees group by department_id) 
order by department_id;
--or대신 union사용하는 방법

--<상호 연관 서브쿼리>
select first_name, salary, department_id, hire_date, job_id from employees emp where salary>(select avg(salary) from employees where department_id=emp.department_id group by department_id);
--소속 부서의 평균 급여보다 많은 급여를 받는 사원의 이름, 급여, 부서번호, 입사일, 업무코드 조회 (상호연관서브쿼리)
--<FROM절 서브쿼리>
select emp.first_name,emp.salary,emp.department_id,emp.hire_date,emp.job_id,emp_view.avgsal from employees emp,
(select department_id,avg(salary) avgsal from employees group by department_id) emp_view where emp.department_id=emp_view.department_id and emp.salary>emp_view.avgsal order by department_id;
--소속 부서의 평균 급여보다 많은 급여를 받는 사원의 이름, 급여, 부서번호, 입사일, 업무코드 조회 (from절 서브쿼리) -> inline view 성능상 더 좋음
--<TOP-N 서브쿼리>
--급여가 가장 작은 5명의 이릅, 급여 조회
select * from employees order by salary;
select rownum,first_name,salary from (select first_name, salary from employees order by salary) emp where rownum<6;
select rownum,first_name,salary from (select first_name, salary from employees order by salary desc nulls last) emp where rownum<6;
--<SCALAR서브쿼리>
select employee_id, first_name,(case when department_id=(select department_id from departments where location_id=1400)
then 'IT' else 'NON_IT' end) "IT구분" from employees;
select employee_id, department_id, salary, (select avg(salary) from employees where emp.department_id=department_id) "평균급여" from employees emp order by department_id;
--사원이름, 부서번호, 급여, 소속부서의 평균급여를 부서번호 순으로 조회
select employee_id, first_name, department_id, hire_date from employees emp order by (select department_name from departments dept where emp.department_id=dept.department_id);
--사원번호, 이름, 부서번호, 입사일자를 부서명 순으로 조회
select employee_id, first_name, department_id, hire_date,(select department_name from departments dept where emp.department_id=dept.department_id) wow from employees emp order by wow;
select employee_id, first_name,department_id, department_name,hire_date from employees emp join departments dept using(department_id) order by (select department_name from departments where department_id=emp.department_id);
--오류발생 join-using을 사용하면 이렇게 못써 테이블명을 붙이면 안되거든 emp.department_id 불가능해

--exists 연산자(존재하면 true, 없으면 false--
select department_id, department_name from departments dept where exists (select 'A' from employees where department_id=dept.department_id);
--사원의 번호가 부서의 번호에 존재하면 소속사원이 존재한다 그러면 'A'를 찍고 exists로 a가 찍힌거 true이고 그 부서를 찍는다
--소속사원이 존재하는 부서의 부서번호, 부서명 조회
select employee_id, first_name, hire_date, salary, department_id from employees emp where exists (select 'A' from employees where manager_id=emp.employee_id);
select employee_id, first_name, hire_date, salary, department_id from employees emp where employee_id in (select manager_id from employees);
--관리자의 사원번호, 이름, 입사일자, 급여, 부서번호 조회(관리자는 사원임)
select employee_id, first_name, hire_date, salary, department_id from employees emp where not exists (select 'A' from employees where manager_id=emp.employee_id);
select employee_id, first_name, hire_date, salary, department_id from employees emp where employee_id not in (select manager_id from employees where manager_id is not null);
--not in문에서 where 절 안쓰면 안나와 not in에서 null값을 다 걸러내가지고 안나옴.????/몬소리야 낫인낫널 이정도..?
--관리자가 아닌 사원의 사원번호, 이름, 입사일자, 급여, 부서번호 조회(not exists)

--with 구문
--부서별 급여 합계의 평균보다 큰 급여 합계를 가지는 부서의 부서번호와 부서별 급여의 합계 조회
select department_id, sum(salary) from employees emp group by department_id having sum(salary)>(select avg(sum(salary)) from employees group by department_id);
with test as (select department_id, sum(salary) as sum from employees group by department_id) select * from test where sum>(select avg(sum) from test);
--with절 여러개 선언가능/이전 with절 참조 가능/순서중요

--데이터사전
select * from dict;
select * from user_catalog;
--프로시저(리턴X,매개변수가 cnt number이런식)
create or replace procedure add_data(v_employee_id employees.employee_id%type, v_first_name employees.first_name%type, v_last_name employees.last_name%type,
v_email employees.email%type, v_phone_number employees.phone_number%type, v_hire_date employees.hire_date%type, v_job_id employees.job_id%type,
v_salary employees.salary%type, v_commission_pct employees.commission_pct%type, v_manager_id employees.manager_id%type,
v_department_id employees.department_id%type)
is
begin
insert into employees values(v_employee_id, v_first_name,v_last_name, v_email, v_phone_number, v_hire_date,v_job_id, v_salary,
v_commission_pct, v_manager_id, v_department_id);
end;
/
--펑션과의 차이는 리턴이없다
exec add_data(211,'Princess','Mirim','MIN','590.123.4567','12/07/16','IT_PROG',5000,'',103,60);

create or replace procedure add_data(v_employee_id employees.employee_id%type, v_first_name employees.first_name%type, v_last_name employees.last_name%type,
v_email employees.email%type, v_phone_number employees.phone_number%type, v_hire_date employees.hire_date%type, v_job_id employees.job_id%type,
v_salary employees.salary%type, v_commission_pct employees.commission_pct%type, v_manager_id employees.manager_id%type,
v_department_id employees.department_id%type)
is
cnt number:=0;
begin
SELECT count(*) into cnt from employees where employee_id like v_employee_id;
if(cnt=1) then update employees set phone_number =v_phone_number where employee_id like v_employee_id;
else insert into employees values(v_employee_id, v_first_name,v_last_name, v_email, v_phone_number, v_hire_date,v_job_id, v_salary,
v_commission_pct, v_manager_id, v_department_id);
end if;
end;
/
exec add_data(211,'Princess','Mirim','MIN','590.987.6543','12/07/16','IT_PROG',5000,'',103,60);
exec add_data(212,'Prince','Marin','MON','591.988.6544','11/08/15','IT_PROG',5000,'',104,10);

create table oratest(
    rank number not null,
    id varchar2(50) not null,
    pw varchar2(50) not null,
    name varchar2(50),
    constraint oratest_pk primary key
    (rank)
    enable);

create or replace procedure add_data(v_rank oratest.rank%type, v_id oratest.id%type, v_pw oratest.pw%type, v_name oratest.name%type)
is
begin
insert into oratest values(v_rank, v_id, v_pw, v_name);
end;
/
exec add_data(1,'aaa',111,'강아지');
exec add_data(2,'bbb',222,'고양이');
exec add_data(3,'ccc',333,'망아지');
exec add_data(4,'ddd',111,'송아지');


create or replace procedure add_data(v_rank oratest.rank%type, v_id oratest.id%type, v_pw oratest.pw%type, v_name oratest.name%type)
is
cnt number:=0;
begin
select count(*) into cnt from oratest where rank like v_rank;
if(cnt=1) then update oratest set pw = v_pw where rank like v_rank;
else insert into oratest values(v_rank, v_id, v_pw, v_name);
end if;
end;
/
exec add_data(1,'aaa',123,'강아지');
exec add_data(5,'eee',555,'병아리');
--oratest 테이블에 데이터 삽입하기(데이터가 있으면 비밀번호 update, 그렇지 않으면 데이터 삽입)

--<사용자 정의 함수>
--업무에 맞게 개발자가 직접 만든 함수
--1~n까지의 합 구하기
create or replace function fnSum(n in number)
return number
is
tot number:=0;
begin
for i in 1..n loop tot:=tot+1; end loop;
return tot;
end;
/
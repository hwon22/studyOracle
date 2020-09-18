select department_id, job_id, sum(salary) from employees where department_id is not null group by cube(department_id,job_id);
-- ������ ����
select department_id, job_id, sum(salary) from employees where department_id is not null group by rollup(department_id,job_id);
-- ������ �ǹ�
select * from employees;
select department_id, job_id, manager_id, sum(salary) from employees group by cube(department_id,job_id,manager_id);
--�μ���ȣ ���� �Ŵ�����ȣ �޿��� ��ȸ�� cube�� ����Ͽ� �μ��� ������� �Ŵ����� ����, �� ���� ��ȸ

--GROUPING SETS
select department_id, job_id, sum(salary) from employees group by grouping sets(department_id,job_id);
--group by department_id�� job_id

select department_id, NULL job_id, sum(salary) from employees group by department_id
union all
select NULL department_id, job_id, sum(salary) from employees group by job_id;
--union all�� select �� ���� -> ����� ����

SELECT department_id, job_id, manager_id, AVG(salary) FROM employees 
GROUP BY GROUPING SETS((department_id, job_id, manager_id), department_id, job_id);

SELECT department_id, job_id, manager_id, AVG(salary) FROM employees GROUP BY (department_id, job_id, manager_id) 
UNION ALL 
SELECT department_id, NULL job_id, NULL manager_id, AVG(salary) FROM employees GROUP BY department_id 
UNION ALL
SELECT NULL department_id, job_id, NULL manager_id, AVG(salary) FROM employees GROUP BY job_id;


SELECT department_id, job_id, manager_id, SUM(salary) FROM employees
GROUP BY ROLLUP(department_id, (job_id, manager_id));
--UNION ALL�� ��ȯ�ϴ� �� ����

--NON-EQUI JOIN
--�޿��� �ּұ޿��� �ִ�޿� ������ ����� �����ȣ, �����, �����ڵ�, �޿�, ������,�ּұ޿�, �ִ�޿��� �����ڵ� ������ ��ȸ
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
WHERE EMP.DEPARTMENT_ID(+)=DEPT.DEPARTMENT_ID; --126�� ���/dept�� ������
--employees ���̺�� departments ���̺��� departments ���̺� �� �ִ� ��� �ڷḦ �������� �����ȣ, �̸�, �����ڵ�, �μ���ȣ (employees ���̺�), �μ���ȣ(departments ���̺�), �μ��� ��ȸ
SELECT * FROM EMPLOYEES EMP, DEPARTMENTS DEPT
WHERE EMP.DEPARTMENT_ID=DEPT.DEPARTMENT_ID(+); --111�� ���/empt�� ������
select * from locations;
select * from departments;
select dept.department_id,dept.department_name,loc.city from departments dept, locations loc where dept.location_id=loc.location_id(+);
--9 departments ���̺�, location ���̺��� �̿��Ͽ� �μ���ȣ, �μ���, �ش� �μ��� city ������ ��ȸ(�ٹ����ð� �������� ���� �μ���ȣ,�μ��� ǥ��)��ȸ
select dept.department_id,dept.department_name,loc.city from departments dept, locations loc where dept.location_id(+)=loc.location_id;
--���� ���̺��� locations ���̺�

--FULL OUTER JOIN�ε� ������
select dept.department_id,dept.department_name,loc.city from departments dept, locations loc where dept.location_id(+)=loc.location_id(+);

--union�� �̿��� full outer join ����
select dept.department_id,dept.department_name,loc.city from departments dept, locations loc where dept.location_id(+)=loc.location_id
UNION
select dept.department_id,dept.department_name,loc.city from departments dept, locations loc where dept.location_id=loc.location_id(+);

SELECT * FROM EMPLOYEES EMP, DEPARTMENTS DEPT WHERE EMP.DEPARTMENT_ID(+)=DEPT.DEPARTMENT_ID
union
SELECT * FROM EMPLOYEES EMP, DEPARTMENTS DEPT WHERE EMP.DEPARTMENT_ID=DEPT.DEPARTMENT_ID(+); --127�� ��

select emp.first_name,emp.salary,dept.department_id,dept.department_name from employees emp, departments dept where salary(+)>2000 and emp.department_id(+)=dept.department_id;
--8. �޿��� 2000���� ���� �޴� ������� �̸�, �޿�, �μ���ȣ, �μ��� ��ȸ (��� �μ����̺� ��ȸ)+ null���̶� ���;��Ѵٸ� salary(+)�� ������Ѵ�. 

select emp.employee_id �����ȣ,emp.first_name �����,emp.manager_id �����ڹ�ȣ,man.first_name �������̸� from employees emp, employees man where emp.first_name='Ellen' and emp.manager_id=man.employee_id;
select emp.employee_id,emp.first_name,man.employee_id,man.first_name from employees emp, employees man where emp.manager_id=man.employee_id(+) order by 1;

select emp.first_name||'�� �����ڴ� ' ���,nvl(man.first_name,'����') ������ from employees emp, employees man where emp.manager_id=man.employee_id(+) order by 1;
--6. ������� �����ڴ� �������̸� ��, Stevn�� �����ڴ� null�� ���;� ��

--ANSI JOIN
select * from employees NATURAL JOIN departments;
select * from employees;
select * from employees, departments where employees.department_id=departments.department_id;

select * from employees join departments using (department_id);
--������ department_id���� �ϰ� �;�
select * from employees join departments on employees.department_id=departments.department_id;
select * from employees, departments where employees.department_id=departments.department_id;

select * from employees right outer join departments on employees.department_id=departments.department_id;
--�������� �����̴�
select * from employees left outer join departments on employees.department_id=departments.department_id;
select * from employees full outer join departments on employees.department_id=departments.department_id;

--cross join /īƼ�þ� ���� ����
select employee_id,department_name from employees emp cross join departments dept;

--natural join
select * from employees;
select * from departments;
--department_id, manager_id�� ���� �ΰ��� ���� �����ϴ�
select * from jobs natural join job_history;

--employees,departments ����� �μ���ȣ �μ����� natural join�� �̿��Ͽ� ��ȸ (����� ������ ��ȸ
select * from employees natural join departments order by first_name; --�Ǿտ� ���� �������͵�
select first_name,department_id, department_name from employees natural join departments order by first_name;

select * from locations;
select department_id, department_name, location_id, city from departments natural join locations where department_id =30 or department_id=10;
--10 departments, locations ���̺��� natural join �Ͽ� �μ���ȣ, �μ���, �����ڵ�, �ٹ����� ��ȸ (�� 10�� 30�� �μ��� ��ȸ)
select emp.first_name �����, emp.salary �޿�, department_id �μ���ȣ, dept.department_name �μ���, loc.city �ٹ����� from employees emp natural join departments dept natural join locations loc order by first_name;
--����� �޿� , �μ��� �ٹ����ø� natural join�� �̿��Ͽ� ��ȸ ����� ������ ����

--natural join �׽�Ʈ
create table test_join(test varchar2(20), no number(2));
create table test_natural_join(job_id varchar2(10),job_title varchar(25) not null, test number(10));
select * from tab;
insert into test_join values('1000',20);
insert into test_natural_join values('10','TEST_JOB',1000);
select * from test_join natural join test_natural_join;
--Ÿ���� �߿����� �ʰ� ������ �߿��� /�̸����� ���ĸ� ����ϸ�
insert into test_join values('ABC',20);
--�̷��� �ϸ� ������

--join ~ using
select first_name,department_id,department_name from employees join departments using (department_id);
select first_name,department_id,department_name from employees join departments using (department_id,manager_id);
--manager_id�߰��ϸ� natural �����̶� ����
select department_id, department_name, location_id, city from departments join locations using (location_id) where department_id in (20,50,80,110) order by department_id;
--10 departments, locations ���̺��� �̿��� �μ���ȣ, �μ���, �����ڵ�, ���� ������ using ���� �̿��ؼ� ��ȸ(�� �μ���ȣ 20,50,80,110�� �μ���ȣ ������ ��ȸ)
select first_name, department_name,city from departments join locations using (location_id) join employees using (department_id);
--7. �����, �μ���, �ٹ����� ���� ��ȸ (using �� ���)

--join on
select emp.first_name,emp.salary,man.first_name,man.salary from employees emp join employees man on emp.employee_id=man.manager_id;
select first_name, department_name, city from employees emp join departments dept on emp.department_id=dept.department_id join locations loc on dept.location_id = loc.location_id where first_name not like '%A%' and first_name not like '%a%' order by first_name ;
--�̸��� A,a�� ���� ����� �����, �μ���, �ٹ����� ���� ��ȸ (����� ������ ����)

--outer join
select dept.department_name, dept.location_id, loc.location_id, city from departments dept left outer join locations loc on (dept.location_id=loc.location_id);
--department���̺��� �μ���, �����ڵ�� location ���̺��� �����ڵ�, ���ø� ��ȸ (�ٹ������� �������� ���� �μ��� ��ȸ)
select dept.department_name, dept.location_id, loc.location_id, city from departments dept right outer join locations loc on (dept.location_id=loc.location_id);
select dept.department_name, dept.location_id, loc.location_id, city from departments dept full outer join locations loc on (dept.location_id=loc.location_id);


--subquery
--<�����༭������>
select job_id from employees where employee_id=120;
select job_id from employees where job_id=(select job_id from employees where employee_id=120);
select first_name, salary from employees where employee_id=150;
select first_name,salary from employees where salary>(select salary from employees where employee_id=150) order by salary desc;
--9.150�� ������� �޿��� ���� ����� �̸��� �޿��� �޿��� ���� ������ ��ȸ
select first_name, department_id,salary,hire_date from employees where salary =(select max(salary) from employees);
select employee_id, first_name,job_id,salary,department_id from employees where salary<(select avg(salary) from employees);
--�޿��� ��� �޿����� ���� ����� �����ȣ, �̸�, �����ڵ�, �޿�, �μ���ȣ ��ȸ
select employee_id,first_name,job_title,hire_date,salary from employees, jobs where employees.job_id=jobs.job_id and employees.job_id=(select employees.job_id from employees where employee_id=162) and salary>(select salary from employees where first_name='Clara');
--�����ȣ�� 162�� ����� ������ ����, �޿��� Clara���� ���� ����� �����ȣ, �̸�, ��������, �Ի�����, �޿� ��ȸ
select department_id,min(salary) from employees group by department_id having min(salary)>(select min(salary) from employees where department_id=80) order by department_id;

--<���� �� ��������>
--in(������ϳ�������) any(<any �ִ񰪺��� ���� <MAX),(>any �ּڰ����� ŭ),(=any in) all(��� ���ΰ��) ��ȣ�ڸ��� ��
select employee_id,first_name,salary,department_id from employees where salary=(select max(salary) from employees group by department_id) order by department_id; --����(ERR/���������� �ϳ��� ��� �̻� ��ȯ�Ѵ�)
select employee_id,first_name,salary,department_id from employees where salary in (select max(salary) from employees group by department_id) order by department_id;

select * from employees;
select * from departments;
select * from jobs;

select first_name, salary, job_id from employees where salary>any(
select salary from jobs, employees emp where emp.job_id=jobs.job_id and job_title like 'Sales%') order by salary;
--������ sales�� �ּ� �� �� �̻��� ������� �޿��� ���� �޴� ����� �̸�, �޿�, �����ڵ带 �޿� ������ ��ȸ
select salary from jobs, employees emp where emp.job_id=jobs.job_id and job_title like 'Sales%' order by salary;

select first_name, salary, job_id from employees where job_id not in ('SA_MAN','SA_REP') and salary>all(select salary from employees where job_id in ('SA_MAN','SA_REP')) order by salary asc;
--������ sales�� ��� ������� �޿��� ���� �䤧�� ����� �̸�,�޿�, �����ڵ带 �޿� ������ ��ȸ

--<���� �� ��������>
--10�� �μ��� salary ��Ʈ�� ���ÿ� ��
select * from departments;
select * from employees;
select manager_id,department_id from employees where first_name in ('Diana','Adam');

select first_name, manager_id, department_id from employees where first_name not in ('Diana','Adam') and (manager_id,department_id)
in (select manager_id,department_id from employees where first_name in ('Diana','Adam'));
--Diana,Adam�� ������ �� �μ��� ���� ����� �̸�, �����ڹ�ȣ, �μ���ȣ ��ȸ

select department_id, employee_id, first_name, salary from employees 
where (department_id,salary) in (select department_id,min(salary) from employees group by department_id)
or (department_id,salary) in (select department_id,max(salary) from employees group by department_id) 
order by department_id;
--�� �μ����� �ִ� �޿��� �޴� ����� �ּұ޿��� �޴� ����� �μ���ȣ, �����ȣ, ����̸�, �޿� ��ȸ
select department_id, employee_id, first_name, salary from employees 
where (department_id,salary) in (select department_id,min(salary) from employees group by department_id
union select department_id,max(salary) from employees group by department_id) 
order by department_id;
--or��� union����ϴ� ���

--<��ȣ ���� ��������>
select first_name, salary, department_id, hire_date, job_id from employees emp where salary>(select avg(salary) from employees where department_id=emp.department_id group by department_id);
--�Ҽ� �μ��� ��� �޿����� ���� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ, �Ի���, �����ڵ� ��ȸ (��ȣ������������)
--<FROM�� ��������>
select emp.first_name,emp.salary,emp.department_id,emp.hire_date,emp.job_id,emp_view.avgsal from employees emp,
(select department_id,avg(salary) avgsal from employees group by department_id) emp_view where emp.department_id=emp_view.department_id and emp.salary>emp_view.avgsal order by department_id;
--�Ҽ� �μ��� ��� �޿����� ���� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ, �Ի���, �����ڵ� ��ȸ (from�� ��������) -> inline view ���ɻ� �� ����
--<TOP-N ��������>
--�޿��� ���� ���� 5���� �̸�, �޿� ��ȸ
select * from employees order by salary;
select rownum,first_name,salary from (select first_name, salary from employees order by salary) emp where rownum<6;
select rownum,first_name,salary from (select first_name, salary from employees order by salary desc nulls last) emp where rownum<6;
--<SCALAR��������>
select employee_id, first_name,(case when department_id=(select department_id from departments where location_id=1400)
then 'IT' else 'NON_IT' end) "IT����" from employees;
select employee_id, department_id, salary, (select avg(salary) from employees where emp.department_id=department_id) "��ձ޿�" from employees emp order by department_id;
--����̸�, �μ���ȣ, �޿�, �ҼӺμ��� ��ձ޿��� �μ���ȣ ������ ��ȸ
select employee_id, first_name, department_id, hire_date from employees emp order by (select department_name from departments dept where emp.department_id=dept.department_id);
--�����ȣ, �̸�, �μ���ȣ, �Ի����ڸ� �μ��� ������ ��ȸ
select employee_id, first_name, department_id, hire_date,(select department_name from departments dept where emp.department_id=dept.department_id) wow from employees emp order by wow;
select employee_id, first_name,department_id, department_name,hire_date from employees emp join departments dept using(department_id) order by (select department_name from departments where department_id=emp.department_id);
--�����߻� join-using�� ����ϸ� �̷��� ���� ���̺���� ���̸� �ȵǰŵ� emp.department_id �Ұ�����

--exists ������(�����ϸ� true, ������ false--
select department_id, department_name from departments dept where exists (select 'A' from employees where department_id=dept.department_id);
--����� ��ȣ�� �μ��� ��ȣ�� �����ϸ� �Ҽӻ���� �����Ѵ� �׷��� 'A'�� ��� exists�� a�� ������ true�̰� �� �μ��� ��´�
--�Ҽӻ���� �����ϴ� �μ��� �μ���ȣ, �μ��� ��ȸ
select employee_id, first_name, hire_date, salary, department_id from employees emp where exists (select 'A' from employees where manager_id=emp.employee_id);
select employee_id, first_name, hire_date, salary, department_id from employees emp where employee_id in (select manager_id from employees);
--�������� �����ȣ, �̸�, �Ի�����, �޿�, �μ���ȣ ��ȸ(�����ڴ� �����)
select employee_id, first_name, hire_date, salary, department_id from employees emp where not exists (select 'A' from employees where manager_id=emp.employee_id);
select employee_id, first_name, hire_date, salary, department_id from employees emp where employee_id not in (select manager_id from employees where manager_id is not null);
--not in������ where �� �Ⱦ��� �ȳ��� not in���� null���� �� �ɷ��������� �ȳ���.????/��Ҹ��� ���γ��� ������..?
--�����ڰ� �ƴ� ����� �����ȣ, �̸�, �Ի�����, �޿�, �μ���ȣ ��ȸ(not exists)

--with ����
--�μ��� �޿� �հ��� ��պ��� ū �޿� �հ踦 ������ �μ��� �μ���ȣ�� �μ��� �޿��� �հ� ��ȸ
select department_id, sum(salary) from employees emp group by department_id having sum(salary)>(select avg(sum(salary)) from employees group by department_id);
with test as (select department_id, sum(salary) as sum from employees group by department_id) select * from test where sum>(select avg(sum) from test);
--with�� ������ ���𰡴�/���� with�� ���� ����/�����߿�

--�����ͻ���
select * from dict;
select * from user_catalog;
--���ν���(����X,�Ű������� cnt number�̷���)
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
--��ǰ��� ���̴� �����̾���
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
exec add_data(1,'aaa',111,'������');
exec add_data(2,'bbb',222,'�����');
exec add_data(3,'ccc',333,'������');
exec add_data(4,'ddd',111,'�۾���');


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
exec add_data(1,'aaa',123,'������');
exec add_data(5,'eee',555,'���Ƹ�');
--oratest ���̺� ������ �����ϱ�(�����Ͱ� ������ ��й�ȣ update, �׷��� ������ ������ ����)

--<����� ���� �Լ�>
--������ �°� �����ڰ� ���� ���� �Լ�
--1~n������ �� ���ϱ�
create or replace function fnSum(n in number)
return number
is
tot number:=0;
begin
for i in 1..n loop tot:=tot+1; end loop;
return tot;
end;
/
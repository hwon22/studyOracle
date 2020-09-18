@C:\Users\Mirim\Documents\examMT_data_ORG.sql

drop index idx_emp_ename_3209;
drop view player_view_3209;
drop table dept_name;

Select * from tab;  --1번

create index idx_emp_ename_3209 on emp(ename);  --2번

SELECT * FROM emp where ename='JAMES';  --3번

create view PLAYER_VIEW_3209
as
    select player_id,player_name,nickname from player;   --4번

select * from PLAYER_VIEW_3209; --5번

update player_view_3209 set nickname='고종고종' where player_name='고종수'; --6번

select * from PLAYER_VIEW_3209 order by player_name; --7번

select player_name 선수명,team_name 팀명 from player, team where player.team_id=team.team_id order by team_name, player_name;  --8번

select team_name 팀명 ,region_name 연고지,player_name 선수명 from player join team on player.team_id=team.team_id order by team_name, player_name;  --9번

select player_name 선수명,back_no 백넘버, player.team_id 팀ID, team_name 팀명, region_name 연고지 from player,team where  player.team_id=team.team_id  and team.region_name in ('부산','포항','울산'); --10번

select player_name 선수명,back_no 백넘버, region_name 연고지,team_name 팀명 from player,team where  player.team_id=team.team_id and player.position='GK' order by back_no; --11번

select team.region_name 연고지, team.team_name 팀명, stadium.stadium_id 전용구장ID, stadium.stadium_name 전용구장명, stadium.seat_count 좌석수 from team,stadium where team.stadium_id=stadium.stadium_id order by region_name;  --12번

select team.region_name 연고지, team.team_name 팀명, stadium.stadium_id 전용구장ID, stadium.stadium_name 전용구장명, stadium.seat_count 좌석수 from team,stadium where team.stadium_id=stadium.stadium_id and seat_count>=30000 order by stadium.seat_count desc;  --13번

select player.player_name 선수명, player.position 포지션, team.region_name 연고지,team.team_name 팀명, stadium.stadium_name 전용구장명 from team join stadium using(stadium_id) join player using (team_id) order by player_name;  --14번

select player_name 선수명, position 포지션, region_name 연고지, stadium_name 전용구장명 from team,stadium natural join player order by region_name;  --15번

select stadium_name 선수명,team_name 팀명, region_name 연고지 from  stadium left outer join team on stadium.stadium_id=team.stadium_id order by region_name; --16번

select empno 사원번호, ename 사원명,deptno 소속부서코드,dname 소속부서이름 from emp join dept using(deptno) order by emp.ename;  --17번

select empno 사원번호, ename 사원명,emp.deptno 소속부서코드,dept.dname 소속부서이름,city 도시 from emp, dept, locations where emp.deptno=dept.deptno and dept.loc_code=locations.loc_code order by city; --18번

select empno 사원번호, ename 사원명, deptno 소속부서코드, dname 소속부서이름,city 도시 from emp natural join dept,locations order by dept.dname; --19번

select emp.deptno 소속부서코드, empno 사원번호, ename 사원명, job 일, mgr 담당자번호, hiredate 입사일, sal 급여, comm 보너스, dept.dname 소속부서이름,dept.loc_code 지역코드 from emp, dept where emp.deptno=dept.deptno;  --20번

create table dept_name
as
    select * from dept;   
select * from dept_name;
    --21번

select player_name 선수명, team_name 팀명, stadium_name 전용구장명 from player,team, stadium where player.team_id=team.team_id and team.stadium_id=stadium.stadium_id and player_name like '서%'; --22번

update dept set dname = 'RD' where dname='RESEARCH';
update dept set dname = 'MARKETING' where dname = 'SALES';
select * from dept;  --23번

select team_name 팀명, player_name 선수명, position 포지션, back_no 백넘버 from player, team where player.team_id=team.team_id and team_name=
(select team_name from player, team where player.team_id=team.team_id and player_name='정주영') order by player_name;  --24번

select player_name 선수명, position 포지션, back_no 백넘버, height 키 from player 
where height>=(select avg(height) from player) order by height desc;  --25번

select count(player_name) 몸무게평균이하선수들 from player where weight<=(select avg(weight) from player);  --26번

select join_yyyy 입단년도, player_name 선수명, birth 생년월일, team_name 팀명, region_name 연고지 from player, team where player.team_id=team.team_id and join_yyyy=(select min(join_yyyy) from player);  --27번

select orig_yyyy 창단년도, team_name 팀명, region_name 연고지, stadium_name 전용구장명 from team, stadium where team.stadium_id=stadium.stadium_id and orig_yyyy=(select max(orig_yyyy) from team);  --28번

select team_name 팀명, player_name 선수명, position 포지션, back_no 백넘버, height 키 from player,team  where player.team_id=team.team_id and length(eeam_name)=(select max(length(eeam_name)) from team);  --29번

select team_name "시티즌보다 젊은 팀", max(birth) "가장 젊은 선수" from player, team where player.team_id=team.team_id and birth>(select max(birth) from player, team where player.team_id=team.team_id and team.team_name='시티즌') group by team_name;  --30번

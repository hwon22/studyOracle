@C:\Users\Mirim\Documents\examMT_data_ORG.sql

drop index idx_emp_ename_3209;
drop view player_view_3209;
drop table dept_name;

Select * from tab;  --1��

create index idx_emp_ename_3209 on emp(ename);  --2��

SELECT * FROM emp where ename='JAMES';  --3��

create view PLAYER_VIEW_3209
as
    select player_id,player_name,nickname from player;   --4��

select * from PLAYER_VIEW_3209; --5��

update player_view_3209 set nickname='��������' where player_name='������'; --6��

select * from PLAYER_VIEW_3209 order by player_name; --7��

select player_name ������,team_name ���� from player, team where player.team_id=team.team_id order by team_name, player_name;  --8��

select team_name ���� ,region_name ������,player_name ������ from player join team on player.team_id=team.team_id order by team_name, player_name;  --9��

select player_name ������,back_no ��ѹ�, player.team_id ��ID, team_name ����, region_name ������ from player,team where  player.team_id=team.team_id  and team.region_name in ('�λ�','����','���'); --10��

select player_name ������,back_no ��ѹ�, region_name ������,team_name ���� from player,team where  player.team_id=team.team_id and player.position='GK' order by back_no; --11��

select team.region_name ������, team.team_name ����, stadium.stadium_id ���뱸��ID, stadium.stadium_name ���뱸���, stadium.seat_count �¼��� from team,stadium where team.stadium_id=stadium.stadium_id order by region_name;  --12��

select team.region_name ������, team.team_name ����, stadium.stadium_id ���뱸��ID, stadium.stadium_name ���뱸���, stadium.seat_count �¼��� from team,stadium where team.stadium_id=stadium.stadium_id and seat_count>=30000 order by stadium.seat_count desc;  --13��

select player.player_name ������, player.position ������, team.region_name ������,team.team_name ����, stadium.stadium_name ���뱸��� from team join stadium using(stadium_id) join player using (team_id) order by player_name;  --14��

select player_name ������, position ������, region_name ������, stadium_name ���뱸��� from team,stadium natural join player order by region_name;  --15��

select stadium_name ������,team_name ����, region_name ������ from  stadium left outer join team on stadium.stadium_id=team.stadium_id order by region_name; --16��

select empno �����ȣ, ename �����,deptno �ҼӺμ��ڵ�,dname �ҼӺμ��̸� from emp join dept using(deptno) order by emp.ename;  --17��

select empno �����ȣ, ename �����,emp.deptno �ҼӺμ��ڵ�,dept.dname �ҼӺμ��̸�,city ���� from emp, dept, locations where emp.deptno=dept.deptno and dept.loc_code=locations.loc_code order by city; --18��

select empno �����ȣ, ename �����, deptno �ҼӺμ��ڵ�, dname �ҼӺμ��̸�,city ���� from emp natural join dept,locations order by dept.dname; --19��

select emp.deptno �ҼӺμ��ڵ�, empno �����ȣ, ename �����, job ��, mgr ����ڹ�ȣ, hiredate �Ի���, sal �޿�, comm ���ʽ�, dept.dname �ҼӺμ��̸�,dept.loc_code �����ڵ� from emp, dept where emp.deptno=dept.deptno;  --20��

create table dept_name
as
    select * from dept;   
select * from dept_name;
    --21��

select player_name ������, team_name ����, stadium_name ���뱸��� from player,team, stadium where player.team_id=team.team_id and team.stadium_id=stadium.stadium_id and player_name like '��%'; --22��

update dept set dname = 'RD' where dname='RESEARCH';
update dept set dname = 'MARKETING' where dname = 'SALES';
select * from dept;  --23��

select team_name ����, player_name ������, position ������, back_no ��ѹ� from player, team where player.team_id=team.team_id and team_name=
(select team_name from player, team where player.team_id=team.team_id and player_name='���ֿ�') order by player_name;  --24��

select player_name ������, position ������, back_no ��ѹ�, height Ű from player 
where height>=(select avg(height) from player) order by height desc;  --25��

select count(player_name) ������������ϼ����� from player where weight<=(select avg(weight) from player);  --26��

select join_yyyy �Դܳ⵵, player_name ������, birth �������, team_name ����, region_name ������ from player, team where player.team_id=team.team_id and join_yyyy=(select min(join_yyyy) from player);  --27��

select orig_yyyy â�ܳ⵵, team_name ����, region_name ������, stadium_name ���뱸��� from team, stadium where team.stadium_id=stadium.stadium_id and orig_yyyy=(select max(orig_yyyy) from team);  --28��

select team_name ����, player_name ������, position ������, back_no ��ѹ�, height Ű from player,team  where player.team_id=team.team_id and length(eeam_name)=(select max(length(eeam_name)) from team);  --29��

select team_name "��Ƽ�𺸴� ���� ��", max(birth) "���� ���� ����" from player, team where player.team_id=team.team_id and birth>(select max(birth) from player, team where player.team_id=team.team_id and team.team_name='��Ƽ��') group by team_name;  --30��

# 
use sakila ;



#이름이 j로 시작하고 성은 D로 시작하는 사람들의 합집합

select c.first_name,c.last_name
from customer c
where c.first_name like 'J%' and c.last_name like 'D%'
union all 
select a.first_name,a.last_name
from actor a
where a.first_name like 'j%' and a.last_name like 'D%';


select c.first_name,c.last_name
from customer c
where c.first_name like 'J%' and c.last_name like 'D%'
union  
select a.first_name,a.last_name
from actor a
where a.first_name like 'j%' and a.last_name like 'D%';  

#UNION은 중복을 제거해서 행이 한개 덜 나왔다.


#intersect 사용(교집합)

select c.first_name,c.last_name
from customer c
where c.first_name like 'J%' and c.last_name like 'D%'
intersect
select a.first_name,a.last_name
from actor a
where a.first_name like 'j%' and a.last_name like 'D%'; 
#내부조인으로 동일한 결과를 얻을 수 있다.
select c.first_name,c.last_name
from customer as c
	inner join actor as a
	on(c.first_name=a.first_name) and (c.last_name=a.last_name)
where a.first_name  like 'J%' and a.last_name like 'D%';



#EXCEPT 사용(차집합)

#A EXCEPT B:A의 결과에 포함된 B의 내용 제거



#복합 쿼리의 결과 정렬

#열이름 정의는 복합 쿼리의 첫번째 쿼리에 있는 열의 이름을 사용해야 함

#집합 연산의 순서

# 복합 쿼리는 위에서 아래의 순서대로 실행
--  예외:intersect는 다른 연산자보다 우선순위가 높음


#실습 6-3

select first_name,last_name
from actor a 
where last_name like 'L%'
union
select first_name,last_name 
from customer
where last_name like 'L%'
order by last_name;






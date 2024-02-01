use sakila;

select * from language;

select name from language;

#select 절에 추가할 숭 ㅣㅆ는 항목
#- 숫자 또는 문자열
#- 표현식
# 내장 함수 호출 및 사용자 정의 함수 호출

select language_id,
'COMMON' language_usage,
language_id * 3.14 lang_pi_value,
upper(name) language_name
from language;

select actor_id from film_actor order by actor_id;

select distinct actor_id from film_actor order by actor_id;

#from 절 역할
#------------------------------
#쿼리에 사용되는 테이블을 명시
# 테이블을 연결하는 수단

#테이블 유형:from 절에 포함
# 영구 테이블(permanent table)
# create table 문으로 생성된 테이블로 실제 데이터 베이스에 존재

#파생 테이블
# 하위 쿼리에서 반환하고 메모리에 보관된 행

#임시 테이블
#메모리에 저장된 휘발성 데이터
#가상 테이블 
#create view문으로 생성



#파생 테이블

select concat(cust.last_name,', ',cust.first_name) full_name
from
	(select first_name,last_name,email
	from customer 
	where first_name='JESSIE')
as cust;


#임시 테이블

create temporary table actors_j
	(actor_id smallint(5),
	first_name varchar(45),
	last_name varchar(45));
desc actors_j;

insert into actors_j
	select actor_id,first_name,last_name
	from actor where last_name like 'J%';

select * from actors_j;

#가상테이블 view

create view cust_vw as
	select customer_id,first_name,last_name,active
	from customer;

select * from cust_vw;


#테이블 연결 
#join(inner join)
#두 개 이상의 테이블을 묶어서 하나의 결과 집합을 만들어 내는 것
select customer.first_name,customer.last_name,
time(rental.rental_date) as rental_table
from customer inner join rental
	on customer.customer_id=rental.customer_id 
where date(rental.rental_date) = '2005-06-14'; #date=날짜만 나오게 하는 함수



#두개의 테이블은 customer_id 로 연결되어 있음

select c.first_name ,c.last_name,
	time(r.rental_date) as rental_time
from customer as c inner join rental as r
	on c.customer_id=r.customer_id
where date(r.rental_date)='2005-06-14';

#where 절 
#필터 조건:조건에 맞는 행의 뎅터만 가져오

# AND,OR,NOT 연산자 사용

select title
from film
where rating='G' and rental_duration >=7;


select title,rating,rental_duration
from film
where (rating='G' and rental_duration >=7)
	or (rating='PG-13' and rental_duration <4);

#GROUP by 절과 having절

#group by

#열의 데이터를 그룹화

#having
#특정열을 그룹화한 결과에 필터링 조건을 설정


select c.first_name,c.last_name,count(*)
from customer as c 
	inner join rental as r
	on c.customer_id  =r.customer_id 
group by c.first_name,c.last_name
having count(*) >= 40
order by count(*) desc;




#order by 절
# 지정된 컬럼 열을 기준으로 결과를 정렬(다중 컬럼인 경우 왼쪽부터 정렬)
#오름차순(ASC): 기본 정렬 값,  내림차순(DESC)

select c.first_name,c.last_name,
	time(r.rental_date) as rental_time
from customer as c inner join rental as r
	on c.customer_id=r.customer_id 
where date(r.rental_date)='2005-06-14'
order by c.last_name,c.first_name asc;



 #순서를 통한 정렬 
# order by 다음에 정렬 기준이 되는 컬럼의 순서(index)를 사용



#실습 3.1

# actor 테이블에서 모든 배우의 actor_id,first_name,last_name을 검색하고 last_name,first_name을 기준으로 오름 차순 정렬

select actor_id,first_name,last_name
from actor order by last_name,first_name asc;


#실습 3.2

#성이 'WILLIAMS'또는 'DAVIS'인 모든 배우의 ACTOR_ID,FIRST_NAME,LAST_NAME을 검색

select actor_id,first_name,last_name
from actor
where last_name='WILLIAMS' or last_name='DAVIS';


#실습 3.3 
#rental 테이블에서 2005년 7월 5일 영화를 대여한 고객  id를 반환하는 쿼릴를 작성하고, DATE()함수로 시간 요소를 무시

select distinct customer_id
from rental
where date(rental_date)='2005-07-05';


#실습 3.4
#결과 참조 문제

select c.store_id,c.email,r.rental_date,r.return_date
	from customer as c
		inner join rental as r
		on c.customer_id=r.customer_id
where date(r.rental_date)='2005-06-14'
order by return_date desc;   

#and 또는 or 연산자 하나 이상의 조건을 포함

where not (first_name='STEVE' or last_name='YOUNG')
and create_date > '2006-01-01'


#not 연산자로 <>사용

where first_name <> 'STEVE' or last_name <>'YOUNG')
and create_date > '2006-01-01'


#조건 유형

#동등 조건

select c.email
from customera s c
	inner join rental as r
	on c.customer_id=r.customer_id
where date(r.rental_date) <> '2005-06-14';

 # 동등/부등 조건 사용 예
# 데이터를 수정할 때 사용


#범위 조건

#해당식이 특정 범위 내에 있는지 확인

select customer_id,rental_date
from rental
where rental_date<'2005-05-25';

#해당 날짜만 검색:date(rental_date)='2005-05-25'

select customer_id,rental_date
from rental r where rental_date<='2005-06-16'
	and rental_date>='2005-06-14';






ㄴㄴ










#join

use sakila;

#다중 테이블 쿼리

#대부분의 쿼리는 여러 테이블을 필요로 함
#외래키: 여러 테이블을 연결할 연결수단

#데카르트 곱:교차 조인

#두개의 테이블에서 한 테이블의 모든 행들과 다른 테이블의 모든 행을 결합
# joinㅡ의 조건이 없이 모든 행을 결합

#select(조회 컬럼)
#from 테이블명1 cross join ...


#전체 갯수 n*n개 예: 3행 *3행 =9


#2) 내부조인

-- 가장 일반적인 join유형
-- 일치하지 않는 데이터는 검색하지 않음


select c.first_name,c.last_name,a.address
from customer as c inner join address as a
on c.address_id =a.address_id;

select count(*)
from customer as c inner join address as a
on c.address_id=a.address_id;


#3) 외부조인

-- 한쪽테이블에만 존재하는 데이터들을 다른 테이블에 결합



#4) ANSI문법 표기
-- 이전 문법 표기

select c.first_name,c.last_name,a.address
from customer as c join address as a
where c.address_id=a.address_id and a.postal_code=52137;


#조인 조건과 필터조건을 구분하기 어려움

#sql92 문법 표기

select c.first_name,c.last_name,a.address,a.postal_code
from customer as c join address as a
	on c.address_id=a.address_id 
where a.postal_code =52137;



#5) 세개 이상 테이블 조인

#고객이 사는 도시를 반환하는 쿼리작성
desc city; 
#키 타입이 멀티 타입이다. 

#join 과정에서 from 절의 테이블의 순서는 중요하지 않다

select c.first_name,c.last_name,ct.city,a.address,a.district,a.postal_code
from customer as c
inner join address as a
on c.address_id=a.address_id 
inner join city as ct
on a.city_id=ct.city_id;


#서브 쿼리 사용
# 캘리포니아에 거주하는 모든 고객들의 이름,성,주소,도시,지역을 검색
select c.first_name,c.last_name,addr.address,addr.city,addr.district
from customer as c
	inner join
	(select a.address_id,a.address,ct.city,a.district
	from address as a
	inner join city as ct
	on a.city_id=ct.city_id
	where a.district='California'
	) as addr
on c.address_id=addr.address_id;



#테이블 재사용

#여러 테이블을 조인 할 경우 같은 테이블을 두 번 이상 join 할 수 있음

select f.title,a.first_name ,a.last_name 
from film as f
	inner join film_actor as fa
	on f.film_id=fa.film_id 
	inner join actor a
	on fa.actor_id =a.actor_id 
where((a.first_name='CATE' and a.last_name='MCQUEEN')
	or (a.first_name='CUBA' and a.last_name='BIRCH'));



#두 배우가 같이 출연한 영화만 검색

#같은 테이블을 여러번 사용하기 때문에 테이블 별칭 사용

#뒤에 있는 거 확인 하기

select f.title,f.film_id,a1.first_name,a1.last_name
from film as f
	inner join film_actor as fa1
	on f.film_id=fa1.film_id
	inner join actor a1
	on fa1.actor_id=a1.actor_id
where(a1.first_name='CATE' and a1.last_name='MCQUEEN');

#and

select f.title,f.film_id,a2.first_name,a2.last_name
from film as f
	inner join film_actor as fa2
	on f.film_id=fa2.film_id
	inner join actor a2
	on fa2.actor_id=a2.actor_id
where(a2.first_name='CUBA' and a2.last_name='BIRCH');



# 합쳐진 것

select f.title
from film as f
	inner join film_actor as fa1
	on f.film_id=fa1.film_id
	inner join actor a1
	on fa1.actor_id=a1.actor_id
	inner join film_actor as fa2
	on f.film_id=fa2.film_id
	inner join actor a2
	on fa2.actor_id=a2.actor_id
where (a1.first_name='CATE' and a1.last_name='MCQUEEN')
	and (a2.first_name='CUBA' and a2.last_name='BIRCH');



# 셀프 조인(self-join)

use sqlclass_db;


use sqlclass_db;
create table customer 
(customer_id smallint unsigned,
first_name varchar(20),
last_name varchar(20),
birth_date date,
spouse_id smallint unsigned,
constraint primary key(customer_id));

desc customer;


# customer 테이블에 데이터 추가

insert into customer (customer_id,first_name,last_name,birth_date,spouse_id)
values
(1,'John','Mayer','1983-05-12',2),
(2,'Mary','Mayer','1990-07-30',1),
(3,'Lisa','Ross','1989-04-15',5),
(4,'Anna','Timothy','1988-12-26',6),
(5,'Tim','Ross','1957-08-15',3),
(6,'Steve','Donell','1967-07-09',4);

insert into customer (customer_id,first_name,last_name,birth_date)
values(7,'Donna','Trapp','1978-06-23');
select* from customer;



#self- join 예제
select
cust.customer_id,
cust.first_name,
cust. last_name,
cust.birth_date,
cust.spouse_id,
spouse.first_name as spouse_firstname,
spouse.last_name as spouse_lastname
from customer as cust
	join customer as spouse
	on cust.spouse_id=spouse.customer_id;



#같은 도시에 있는 모든 주소를 반환하는 쿼리 작성






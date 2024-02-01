use sakila;


#범위 조건

#해당식이 특정 범위 내에 있는지 확인

#범위 조건

#해당식이 특정 범위 내에 있는지 확인

select customer_id,rental_date
from rental
where rental_date<'2005-05-25';

#해당 날짜만 검색:date(rental_date)='2005-05-25'

select customer_id,rental_date
from rental r where rental_date<='2005-06-16'
	and rental_date>='2005-06-14';
	

-- 2005sus 6월 14일 부터 6월 16일 까지의 데이터를 출력하기 위해
-- date(rental_date)를 사용: 정확한 날짜만 추출

select customer_id,rental_date
from rental 
where date(rental_date)<='2005-06-16'
	and date(rental_date)>='2005-06-14';
	
#between 연산자
select customer_id, rental_date
from rental
where date(rental_date) between '2005-06-14' and '2005-06-16';

#숫자 범위 사용(하한값과 상한값이 범위에 포함)
select customer_id,payment_date,amount
from payment
where amount between 10.0and 11.99;

-- last name이 'FA'와 FRB로 시작하는 데이터 리턴

select last_name, first_name
from customer
where last_name between 'FA' and 'FRB';



#IN()연  연산

select TITLE,RATING
from film 
where rating='G' or rating='PG';


select title,rating
from film 
where rating in ('G','PG') ;




##select title rating
select title,rating
from film
where rating in (select rating from film where title like '%PET%');



#
select title,rating from film where title like '%PET%';


#not in 사용

#표현식 집합 내에 존재하지 않음

select  title,rating
from film
where rating not in ('PG-13','R','NC-17');


#NOT IN ('....')
#영화 등급이 괄호 이하가 아닌 모느 친구 찾기




#일치 조건 
-- left,mid,right

-- mid(문자열,시작위치,n)


#와일드 카드
-- '-':정확히 한 문자(underscore)
-- '%':개수에 상관없이 모든 문자 포함


# 와일드 카드 사용시, Like 연산자를 사용
select last_name,first_name
from customer
where last_name like '_A_T%S';

#두번쨰 위치에 'A',네번째 위치에 'T'를 포함하며 마지막은 'S'로 끝나는 문자열


select last_name,first_name
from customer
where last_name like 'Q%'or last_name like 'Y%';



# 정규 표현식 사용
#'^[QY]':Q 또는 Y로 시작하는 단어 검색

select last_name,first_name
from customer
where last_name regexp '^[QY]';   #regexp= 정규표현식 표현


#Null 확인 방법

#null과 조건 조합

# 반납이 되지 않은 경우, 반납 날짜의 값이 NULL(is null 사용)
# 또는 반납 날짜가 2005년 5월~ 2005년 8월 사이가 아닌 경우


select rental_id,customer_id,return_date
from rental
where return_date is null
or date(return_date) not between '2005-05-01' and '2005-09-01';


#4.5 서브셋 조건 설정

select payment_id,customer_id,amount,date(payment_date) as payment_date  # select문에도 내장함수 쓰는 거 가능 as써서 원래 이름으로 준다
from payment
where (payment_id between 101 and 120);
#----------------------------------------------------





#실습 4-1

-- customer_id가 5가 아니고
--  amount가 8보다 크거나 payment_date가 2005년 8월 23일 인경우
 
 
 
 
 #실습 4-2
 
--  customer_id가 5이고
--  amount 가 6보다 크거나 payment_date가 2005년 6월 19일 이 아닌 payment_id
 
 
 


#실습 4-3 
payments 테이블에서 금액이 1.98,...
















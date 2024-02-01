show databases;
use sakila;

select now();

create database testdb;

use testdb;
# person 테이블 생성
# CONSTRAINT pk_person: 제약조건의 이름 설정
drop table if exists person; # person이 잘못생성되었을때 지우고 싶을때....
create TABLE person
	(person_id SMALLINT UNSIGNED,
	 fname VARCHAR(20),
	 lname VARCHAR(20),
	 eye_color ENUM('BR','BL','GR'),
	 birth_date DATE,
	 street VARCHAR(30),
	 city VARCHAR(20),
	 state	VARCHAR(20),
	 country VARCHAR(20),
	 postal_code VARCHAR(20),
	 CONSTRAINT pk_person primary KEY(person_id)
	 );
	 
#person 테이블 확인	
desc person; 

#favorite food 테이블 생성
create table favorite_food
	(person_id SMALLINT unsigned,
	food VARCHAR(20),
	constraint pk_favorite_food PRIMARY KEY (person_id,food),
	constraint fk_fav_food_person_id FOREIGN key (person_id) references person(person_id)
	);


#2.5 테이블 수정


set foreign_key_checks=0;  # 제약조건 비활성화
alter table person modify person_id smallint unsigned auto_increment;  #테이블 수정
set foreign_key_checks=1; #제약 조건 활성화
desc person

#person 테이블에 데이터 추가
#데이터 추가:INSERT 문 

insert into person 
	(person_id,fname,lname,eye_color,birth_date)
values(null,'William','Turner','BR','1972-05-27');   #null=auto_increment 속성덕분에 자동 숫자 증가

select *from person;

#person_id,fname,lname,birth_date열 출력
select person_id,fname,lname,birth_date from person;

#lname의 값이 'Turner'인 데이터에서 person_id,fname,lname,birth_date 열만 출력
select person_id,fname,lname,birth_date
from person where lname='Turner';   #where 이하의 코드는 조건문이다.


#favorite_food 테이블에 데이터 추가
# 한 행씩 추가




#한 번에 여러 행 추가

delete from  favorite_food where person_id=1; #person_id값이 1인 데이터 삭제

insert into favorite_food(person_id,food )
values(1,'pizza'),
	  (1,'cookie'),
	  (1,'nachos');
	 

#테이블 데이터 확인

-- order by 컬럼이름:컬럼의 값을 알파벳 순서로 정렬
	 
select food from favorite_food  
where person_id =1 order by food;


#person테이블에 다른 데이터 추가
alter table person
add city varchar(100);

insert into person 
(person_id,fname,lname,eye_color,birth_date,
street,city,state,country,postal_code)
VALUES(null,'Susan','Smith','BL','1975-11-02',
'23 Maple St.','Arlington','VA','USA','20220');
#데이터 수정:update문

#william turner의 정보 추가
#william turner의 자료 입력 과정에서 주소 정보는 입력하지 않았음
#update 문을 이용하여 주소 정보를 추가

update person
set street='1225 Tremon ST',
city='Boston',
state='MA',
country ='USA',
postal_code='02138'
where person_id =1;

select*from person;


#데이터 삭제:DELETE 문

delete from person where person_id=2;
select *from person;

#테이블 삭제:drop table 문

#오류 구문들
# 현재 person 테이블의 데이터
select * from person;


#drop table perosn:
set foreign_key_checks=0; #제약조건 비활성화
delete from person wher person_id=3;
set foreign_key_checks=1; #제약조건 비활성화
#perosn 테이블에 데이터 추가
insert into person (person_id,fname,lname) values(null,'Kevin','Kern');

select *from favorite_food;
-- delet from favorite_food where food='lasagna';
insert into favorite_food (person_id,food) values(3,'lasgna');


#잘못된 날짜 변환

# 기본 날짜 형식=YYYY-MM-DD

update PERSON set VIRTH_DATE='DEC=21-1980' where person_id=1;



#str_to_date(str,format)함수:7장

# 문자열을 format(형식 문자열)을 사용하여 DATETIME 값으로 변환 후 반환

UPDATE person SET birth_date = str_to_date('DEC-21-1980', '%b-%d-%Y')
WHERE person_id=1;

select * from person ;




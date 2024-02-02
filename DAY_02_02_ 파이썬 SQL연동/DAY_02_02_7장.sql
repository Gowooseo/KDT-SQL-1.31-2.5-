# char
#고정 길이 문자열 자료형
# 지정한 크기보다 문자열이 작으면 나머지 공간을 공백으로 채움



#varchar
#가변 길이 문자열 자료형
#크기 만큼 데이터가 들어오지 않으면 그 크기에 맞춰 공간 할당
#헤더에 길이 정보가 포함
#MySQL 최대 65,536 글자 허용


use testdb;

create table string_tbl
(char_fld CHAR(30),
vchar_fld VARCHAR(30),
text_fld TEXT
);

insert into string_tbl (char_fld,vchar_fld,text_fld)
values('This is char data','This is vachar data','This is text data');

select*from string_tbl ;

#vchar_fld의 길이보다 길어서 에러 발생
update string_tbl 
set vchar_fld='This is a piece of extremely long varchar data';

# ANSI 모드 선택

#할 필요 x

# 작은 따옴표 포함

# 문자열 내부에 작은 따옴표를 포함하는 경우


#1) 작은 따옴표를 하나 더 추가
update  string_tbl 
set text_fld='This string didn''t work, but it does now'
;

#2) 백슬래시('\) 문자 추가
update  string_tbl 
set text_fld='This string didn\'t work, but it does now'
;

select text_fld  from string_tbl st ;


#3) quore() 내장 함수
#전체 문자열을 따옴표로 묶고, 문자열 내부의 작은 따옴표에 escape 문자 추가

select quote(text_fld)
from string_tbl;  #특수기호도 붙는다...



#7.1.2 문자열 조작

#length()함수 :문자열의 개수를 반환

delete from string_tbl ;

insert into string_tbl (char_fld,vchar_fld,text_fld)
values ('This string is 28 characters',
'This string is 28 characters',
'This string is 28 characters');

select length(char_fld) as char_length,
length(vchar_fld) as char_length,
length(text_fld)  as text_length
from string_tbl;



#position() 함수
#부분 문자열의 위치를 반환
#MySQL의 문자열 인덱스:1부터 시작
#부분 문자열을 찾을 수 없는 경우,0을 반환함

SELECT position('characters' in vchar_fld), vchar_fld 
FROM string_tbl;




#locate('문자열',열이름,시작위치) 함수

#시작위치부터 검색, 처음 발견되는 인덱스 리턴

select locate('is',vchar_fld,5)
from string_tbl st ;


select locate('is',vchar_fld,1)
from string_tbl;


#string_tbl 삭제 후 새로운 데이터 추가

delete from string_tbl ;

insert into string_tbl(vchar_fld)
values('abcd'),
('xyz'),
('QRSTUB'),
('qrstuv'),
('12345');

select * from string_tbl st ;


#vchar_fld의 값을 오름차순 정렬
select  vchar_fld from string_tbl st order by vchar_fld;


#strcmp 예제

SELECT strcmp('12345', '12345') 12345_12345,
strcmp('abcd', 'xyz') abcd_xyz, #앞글자 부터 비교
strcmp('abcd', 'QRSTUV') abcd_QRSTUV,
strcmp('qrstuv', 'QRSTUV') qrstuv_QRSTUV,  #대소문자 구분 안함
strcmp('12345', 'xyz') 12345_xyz,
strcmp('xyz', 'qrstuv') xyz_qrstuv;

#문자열 조작(문자열 비교)
#like 또는 regexp 연산자 사용
#select 절에 like 연산자나 regexp 연산자를 사용
#0또는 1의 값을 반환


use sakila;

#y로 끝나면 1을 반환,아니면 0을 반환
select name,name like '%y' as ends_in_y
from category;

select name,name regexp 'Y$' as ends_in_y  #regexp:정규식,ends_in_y라는 새 컬럼을 하나 만듦
from category;


#'y$':name컬럼의 값이 'y'로 끝나면 1을 반환

#string_tbl리셋
use testdb;
delete from string_tbl ;

insert into string_tbl(text_fld)
VALUES('This string was 29 characters');



-- concat() 문자열 추가 함수
-- 
-- concat() 함수를 사용 하여 string_tbl의 text_fld열에 저장된 문자열 수정
#기존 문자열에 ',but now it is longer' 문자열 추가

update string_tbl 
set text_fld =concat(text_fld,',but now it is longer');

select text_fld from string_tbl st ;

#각 데이터 조각을 합쳐서 하나의 문자열 생성

#concat 함수 내부에서 date(create_date)를 문자열로 변환

use sakila;
#concat() 함수 사용#2
select  concat(first_name,' ',last_name,
' has been a customer since ',date(create_date)) as cust_narrative
from customer;


#insert() 함수 

#4개의 인수로 구성
# insert(문자열, 시작위치,길이,새로운 문자열(추가할 문자열)
#세번째 인수값(길이)=0: 새로운 문자열이 삽입
select INSERT('goodbye world',9,0,'cruel ') as string;

#세번쨰 인수값(길이)>0: 해당 문자열로 대치
select INSERT('goodbye world',1,7,'hello') as string;  
# 이때 세번쨰 인수값은 대체할 문자열의 길이가 된다(goodbye의 길이)


#7.1.2 문자열 조작

#replace() 함수

select  replace('goodbye world','goodbye','hello') as replace_str;

#substr 또는 substring() 함수
#replace(문자열, 기존문자열, 새로운 문자열)
#substr(문자열,시작위치,개수)
#문자열에서 시작 위치에서 개수만큼 추출
select substr('goodbye cruel world',9,5); 

#추출한 단어만 나온다......



										
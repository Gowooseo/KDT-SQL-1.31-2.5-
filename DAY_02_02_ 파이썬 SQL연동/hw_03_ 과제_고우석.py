#(1) 아래 2개의 테이블을 생성하고, 주어진 문제에 대한 sql문장을 작성하시오.
def fetchprint(cur,select):
    cur.execute(select)
    rows = cur.fetchall()
    header = [name[0] for name in cur.description]
    print(header)
    for row in rows:
        print(row)

import pymysql

def create_table(conn,cur):
    try:
        deletequery1 = 'drop table if exists user_table'
        query1 = '''
        create table user_table
        (userID Char(8) not null,
        userName Varchar(10) not null, 
        birthYear INT not null,
        addr char(2) not null,
        mobile1 char(3),
        mobile2 char(8),
        height SMALLINT,
        mDate DATE,
        constraint pk_user_table PRIMARY KEY(userID)
        )
        '''
        deletequery2 = 'drop table if exists buy_table'
        query2='''
        create table buy_table
        (num int auto_increment not null,
        userID Char(8) not null, 
        prodName char(6) not null,
        groupName char(4),
        price INT not null,
        amount smallint not null,
        constraint pk_buy_table PRIMARY KEY(num),
        constraint pk_buy_table FOREIGN KEY(userID)references user_table(userID)
        )
        '''
        insertquery1='''
        insert into user_table values
        ('KHD', '강호동', 1970, '경북', '011', '22222222', 182, '2007-07-07'),
        ('KJD', '김제동', 1974, '경남', NULL, NULL, 173, '2013-03-03'),
        ('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, '2009-09-09'),
        ('KYM', '김용만', 1967, '서울', '010', '44444444', 177, '2015-05-05'),
        ('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, '2006-04-04'),
        ('LKK', '이경규', 1960, '경남', '018', '99999999', 170, '2004-12-12'),
        ('NHS', '남희석', 1971, '충남', '016', '66666666', 180, '2017-04-04'),
        ('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, '2012-05-05'),
        ('SDY', '신동엽', 1971, '경기', NULL, NULL, 176, '2008-10-10'),
        ('YJS', '유재석', 1972, '서울', '010', '11111111', 178, '2008-08-08')
        '''

        insertquery2='''
        insert into buy_table values
        (1, 'KHD', '운동화', NULL, 30, 2),
        (2, 'KHD', '노트북', '전자', 1000, 1),
        (3, 'KYM', '모니터', '전자', 200, 1),
        (4, 'PSH', '모니터', '전자', 200, 5),
        (5, 'KHD', '청바지', '의류', 50, 3),
        (6, 'PSH', '메모리', '전자', 80, 10),
        (7, 'KJD', '책', '서적', 15, 5),
        (8, 'LHJ', '책', '서적', 15, 2),
        (9, 'LHJ', '청바지', '의류', 50, 1),
        (10, 'PSH', '운동화', NULL, 30, 2),
        (11, 'LHJ', '책', '서적', 15, 1),
        (12, 'PSH', '운동화', NULL, 30, 2)
        '''

        cur.execute(deletequery1)
        cur.execute(query1)
        cur.execute(deletequery2)
        cur.execute(query2)
        cur.execute(insertquery1)
        cur.execute(insertquery2)
        conn.commit()
        print('Table 생성 완료')

    except Exception as e:
        print(e)

def main():
    #데이터베이스(sqlclass_db) 연결
    conn = pymysql.connect(host='localhost', user='root',
                           password='1234',
                           db='shoppingmall', charset='utf8')
    #select 함수 넣기
    selectquery1 = '''
            select ut.username,bt.prodName,ut.addr,concat(ut.mobile1,ut.mobile2) 연락처
from buy_table as bt 
inner join user_table as ut
on bt.userID =ut.userID ;
            '''
    selectquery2 = '''
select ut.userID,ut.userName,bt.prodName,ut.addr,concat(ut.mobile1,ut.mobile2) as 연락처
from buy_table as bt
inner join user_table ut 
on bt.userID=ut.userID 
where ut.userID ='KYM';
                    '''
    selectquery3 = '''
    select ut.userID,ut.userName,bt.prodName,ut.addr,concat(ut.mobile1,ut.mobile2)as 연락처
from buy_table as bt
inner join user_table ut 
on bt.userID=ut.userID 
order by userID
    '''

    selectquery4 = '''
    select distinct ut.userID,ut.userName,ut.addr
from buy_table as bt
inner join user_table ut 
on bt.userID=ut.userID
order by userID
    '''

    selectquery5 = '''
    select ut.userID,ut.userName,ut.addr,concat(ut.mobile1,ut.mobile2)as 연락처
from buy_table as bt
inner join user_table ut 
on bt.userID=ut.userID
where addr='경북' or addr='경남'
order by userID;
    '''
    #cursor 객체 생성
    cur=conn.cursor()

    #테이블 생성 함수 호출
    create_table(conn,cur)
    #fetch문
    fetchprint(cur,selectquery1)
    print('-----------------------------------------')
    fetchprint(cur, selectquery2)
    print('-----------------------------------------')
    fetchprint(cur, selectquery3)
    print('-----------------------------------------')
    fetchprint(cur, selectquery4)
    print('-----------------------------------------')
    fetchprint(cur, selectquery5)
    #연결 종료
    cur.close()
    conn.close()
    print('Database 연결 종료')

main()




#2. 두 테이블을 내부 조인(buy_table.useID와 user_table.userID)한 다음, 아래의 결과와
#같이 출력이 되도록 SQL 쿼리를 작성하시오.

#1)








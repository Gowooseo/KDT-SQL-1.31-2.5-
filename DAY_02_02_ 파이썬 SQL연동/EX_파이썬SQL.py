import pymysql
import pandas as pd
conn=pymysql.connect(host='localhost',
user='root',password='1234',db='sakila',charset='utf8')


cur=conn.cursor()
cur.execute('select * from language')
rows=cur.fetchall() #모든 데이터를 가져옴
print(rows)
language_df=pd.DataFrame(rows) #DataFrame 형태로 변환
print(language_df)

cur.close()
conn.close() #데이터베이스 연결 종료



print('---------------------------------------------')


#복잡한 쿼리 실행
import pymysql
import pandas as pd
conn=pymysql.connect(host='localhost',
user='root',password='1234',db='sakila',charset='utf8')

cur=conn.cursor()
query="""
select c.email
from customer as c
    inner join rental as r
    on c.customer_id=r.customer_id
where date(r.rental_date)=(%s)"""

cur.execute(query,('2005-06-14')) #%s에 들어갈 값을 지정
rows=cur.fetchall() #모든 데이터를 가져옴
for row in rows:
    print(row)

cur.close()
conn.close()

print('---------------------------------------------')

import pymysql
def create_table(conn,cur):
    try:
        query="""
        create table customer
        (name varchar(10),
        category smallint,
        region varchar(10))
        """
        cur.execute(query)
        conn.commit()
        print('Table 생성 완료')

    except Exception as e:
        print(e)



def main():
    # 데이터베이스(sqlclass_db) 연결
    conn = pymysql.connect(host='localhost',
                           user='root', password='1234', db='sakila', charset='utf8')

    #cursor 객체 생성
    cur=conn.cursor()

    #테이블 생성 함수 호출
    create_table(conn,cur)

    #연결 종료
    cur.close()
    conn.close()
    print('Database 연결 종료')

main()

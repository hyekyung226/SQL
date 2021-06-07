use EDU

select *
 from [Member]
 where gender='man'
 
select addr
		,count(mem_no) [회원수집계] --count the number of rows
 from [Member]
 where gender='man'
 group by addr

select addr, gender
	   ,count(mem_no)[회원수집계]
 from [Member]
 where gender='man'
 group by addr, gender

select gender, addr
	  ,count(mem_no)[회원수집계]
 from [Member]
 group by gender, addr

select addr
	   ,count(mem_no) [회원수집계]
 from [Member]
 where gender='man'
 group by addr
 having count(mem_no)>50

select addr
	   ,count(mem_no) [회원수집계]
 from [Member]
 where gender='man'
 group by addr
 having count(mem_no)>50
 order by count(mem_no) desc --내림차순 <-> asc 오름차순

--inner join (공통 값 매칭 데이터만 조회)
select *
 from [Member] A
 inner join [Order] B
  on A.mem_no=B.mem_no --공통 값(mem_no) join

select *
 from [Member]
 inner join [Order]
  on [Member].mem_no=[Order].mem_no

--outer join -> left join (left+공통) right join (right+공통) full join (left+right)
select * 
 from [Member] A
 left join [Order] B
  on A.mem_no=B.mem_no --left join: registration(criteria) + no purchas(null) possible

select *
 from [Member] A
 right join [Order] B
  on A.mem_no=B.mem_no --right join: purchase(criteria) + registration -> null impossible

select *
 from [Member] A
 full join [Order] B
  on A.mem_no=B.mem_no 

select *
 from [Member] A
 cross join [Order] B --행 결합(A table 행 m개 x B table n개 -> m x n)
  where A.mem_no='1000001' --need to specify mem_no from which table

select *
 from [Member] A, [Member] B --행 결합(A table 행 m개 x A table 행 m개 -> m x m)
 where A.mem_no='1000001'

select *
	   ,(select gender
		   from [Member] B
		  where A.mem_no=B.mem_no) gender
 from [Order] A
 order by count(gender) desc

select *
 from (select mem_no, sum(sales_amt) tot_amt
		 from [Order]
	group by mem_no) A

select *
 from (select mem_no, sum(sales_amt) tot_amt
		 from [Order]
	group by mem_no) A
left join [Member] B
	on A.mem_no=B.mem_no

select *
 from [Order]
 where mem_no = (select mem_no from [Member] where mem_no='1000005')

 select mem_no
  from [Member]
  where mem_no='1000005'

select *
 from [Order]
 where mem_no in (select mem_no from [Member] where gender='man')

select mem_no
 from [Member]
 where gender='man'

 --final check
select *
from [Order]

select *
from [Order]
where shop_code>=30

select mem_no, sum(sales_amt) tot_amt
 from [Order]
 where shop_code>=30
 group by mem_no --don't forget!!

 select *
 from (select mem_no, sum(sales_amt) tot_amt 
		from [Order]
		group by mem_no) A --without where shop_code>=30, same as below
		 
select mem_no, sum(sales_amt) tot_amt
 from [Order]
 where shop_code>=30
 group by mem_no
 having sum(sales_amt)>=100000 --grammar order!!
 
select mem_no, sum(sales_amt) tot_amt
 from [Order]
 where shop_code>=30
 group by mem_no
 having sum(sales_amt)>=100000
 order by sum(sales_amt) desc --연산자 check

select *
 from [Order] A --standard table
 left join [Member] B
 on A.mem_no=B.mem_no

select B.gender, sum(sales_amt) tot_amt
 from [Order] A
 left join [Member] B
 on A.mem_no=B.mem_no
 group by B.gender

select B.gender, B.addr, sum(sales_amt) tot_amt
 from [Order] A
 left join [Member] B
 on A.mem_no=B.mem_no
 group by B.gender, B.addr

select mem_no, sum(sales_amt) tot_amt
 from [Order]
 group by mem_no

select *
 from (select mem_no, sum(sales_amt) tot_amt
		from [Order]
		 group by mem_no) A --grammar order!! same as above

select *
	from (select mem_no, sum(sales_amt) tot_amt
			from [Order]
			group by mem_no) A
 left join [Member] B
 on A.mem_no=B.mem_no

select B.gender, B.addr, sum(tot_amt) 합계 --double check!!
 from (select mem_no, sum(sales_amt) tot_amt
		from [Order]
		group by mem_no) A
 left join [Member] B
 on A.mem_no=B.mem_no
 group by B.gender, B.addr
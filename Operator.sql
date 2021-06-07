select *
 from [Member]
 where addr<>'seoul'

select *
 from [Member]
 where gender='man' and ageband=20

select *
 from [Member]
 where (gender='man' and ageband=20) or addr='seoul' --don't forget ()

select *
 from [Member]
 where ageband between 20 and 40

select *
 from [Member]
 where addr like '%ae%'

select *, sales_amt*0.1 as fees --double check
 from [Order]

select *, sales_amt-(sales_amt*0.1) as Excluding_fees 
 from [Order]

select *,
	   sales_amt*0.1 as fees,
	   sales_amt-sales_amt*0.1 as Excluding_fees
 from [Order]

select cast('100' as int) + cast('100' as int)
select cast('100' as varchar) + cast('100' as varchar)
select cast(1.56 as int)
select cast(1.56 as numeric)
select cast(getdate() as date)
select cast(getdate() as datetime)

--case when: conditional, if not NULL
select *,
	case when ageband between 20 and 30 then '2030세대'
		 when ageband between 40 and 50 then '4050세대'
		 end as ageband_seg
 from [Member]

--case when(+else), if not else
select *,
	case when ageband between 20 and 30 then '2030세대'
		 when ageband between 40 and 50 then '4050세대'
		 else 'OTHER세대'
		 end as ageband_seg
 from [Member]

select count(order_no) 주문수,
	   sum(sales_amt) 주문금액,
	   avg(sales_amt) 평균주문금액,
	   max(order_date) 최근구매일자,
	   min(order_date) 최초구매일자,
	   stdev(sales_amt) 주문금액_표준편차,
	   var(sales_amt) 주문금액_분산
 from [Order]

select mem_no,
	   count(order_no) 주문수,
	   sum(sales_amt) 주문금액,
	   avg(sales_amt) 평균주문금액,
	   max(order_date) 최근구매일자,
	   min(order_date) 최초구매일자,
	   stdev(sales_amt) 주문금액_표준편차,
	   var(sales_amt) 주문금액_분산
 from [Order]
 group by mem_no

select year(order_date) as 연도,
	   channel_code as 채널코드,
	   sum(sales_amt) as 주문금액
 from [Order]
 group by year(order_date),
		  channel_code

select year(order_date) as 연도,
	   channel_code as 채널코드,
	   sum(sales_amt) as 주문금액
 from [Order]
 group by year(order_date),
		  channel_code
 with rollup --총계 및 소계
  order by 1 desc, 2 asc

select year(order_date) as 연도,
	   channel_code as 채널코드,
	   sum(sales_amt) as 주문금액
 from [Order]
 group by year(order_date),
		  channel_code
 with cube --모든 경우의 수 grouping
  order by 1 desc, 2 asc

select year(order_date) as 연도,
	   channel_code as 채널코드,
	   sum(sales_amt) as 주문금액
 from [Order]
 group by grouping sets(year(order_date), channel_code) --group by 항목 개별 grouping

select year(order_date) as 연도,
	   grouping(year(order_date)) 연도_grouping,
	   channel_code as 채널코드,
	   grouping(channel_code) 채널코드_grouping,
	   sum(sales_amt) as 주문금액 
 from [Order]
 group by year(order_date),
		  channel_code
 with rollup
  order by 1 desc, 2 asc

select cast(year(order_date) as varchar) as 연도, --conver number to character
	   cast(channel_code as varchar) as 채널코드,
	   sales_amt
 from [Order]

 select year(order_date) year, channel_code, sales_amt from [Order]

select case when grouping(연도)=1 then '총계'
			 else 연도 end as 연도_총계,
		case when grouping(연도)=1 then '총계'
			 when grouping(채널코드)=1 then '소계'
			 else 채널코드 end as 채널코드_총소계,
			 sum(sales_amt) as 주문금액
 from (select cast(year(order_date) as varchar) 연도,
			  cast(channel_code as varchar) 채널코드,
			  sales_amt
		from [Order]) A
 group by 연도, 채널코드
 with rollup
 order by 1 desc, 2 asc

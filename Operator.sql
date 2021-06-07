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
	case when ageband between 20 and 30 then '2030����'
		 when ageband between 40 and 50 then '4050����'
		 end as ageband_seg
 from [Member]

--case when(+else), if not else
select *,
	case when ageband between 20 and 30 then '2030����'
		 when ageband between 40 and 50 then '4050����'
		 else 'OTHER����'
		 end as ageband_seg
 from [Member]

select count(order_no) �ֹ���,
	   sum(sales_amt) �ֹ��ݾ�,
	   avg(sales_amt) ����ֹ��ݾ�,
	   max(order_date) �ֱٱ�������,
	   min(order_date) ���ʱ�������,
	   stdev(sales_amt) �ֹ��ݾ�_ǥ������,
	   var(sales_amt) �ֹ��ݾ�_�л�
 from [Order]

select mem_no,
	   count(order_no) �ֹ���,
	   sum(sales_amt) �ֹ��ݾ�,
	   avg(sales_amt) ����ֹ��ݾ�,
	   max(order_date) �ֱٱ�������,
	   min(order_date) ���ʱ�������,
	   stdev(sales_amt) �ֹ��ݾ�_ǥ������,
	   var(sales_amt) �ֹ��ݾ�_�л�
 from [Order]
 group by mem_no

select year(order_date) as ����,
	   channel_code as ä���ڵ�,
	   sum(sales_amt) as �ֹ��ݾ�
 from [Order]
 group by year(order_date),
		  channel_code

select year(order_date) as ����,
	   channel_code as ä���ڵ�,
	   sum(sales_amt) as �ֹ��ݾ�
 from [Order]
 group by year(order_date),
		  channel_code
 with rollup --�Ѱ� �� �Ұ�
  order by 1 desc, 2 asc

select year(order_date) as ����,
	   channel_code as ä���ڵ�,
	   sum(sales_amt) as �ֹ��ݾ�
 from [Order]
 group by year(order_date),
		  channel_code
 with cube --��� ����� �� grouping
  order by 1 desc, 2 asc

select year(order_date) as ����,
	   channel_code as ä���ڵ�,
	   sum(sales_amt) as �ֹ��ݾ�
 from [Order]
 group by grouping sets(year(order_date), channel_code) --group by �׸� ���� grouping

select year(order_date) as ����,
	   grouping(year(order_date)) ����_grouping,
	   channel_code as ä���ڵ�,
	   grouping(channel_code) ä���ڵ�_grouping,
	   sum(sales_amt) as �ֹ��ݾ� 
 from [Order]
 group by year(order_date),
		  channel_code
 with rollup
  order by 1 desc, 2 asc

select cast(year(order_date) as varchar) as ����, --conver number to character
	   cast(channel_code as varchar) as ä���ڵ�,
	   sales_amt
 from [Order]

 select year(order_date) year, channel_code, sales_amt from [Order]

select case when grouping(����)=1 then '�Ѱ�'
			 else ���� end as ����_�Ѱ�,
		case when grouping(����)=1 then '�Ѱ�'
			 when grouping(ä���ڵ�)=1 then '�Ұ�'
			 else ä���ڵ� end as ä���ڵ�_�ѼҰ�,
			 sum(sales_amt) as �ֹ��ݾ�
 from (select cast(year(order_date) as varchar) ����,
			  cast(channel_code as varchar) ä���ڵ�,
			  sales_amt
		from [Order]) A
 group by ����, ä���ڵ�
 with rollup
 order by 1 desc, 2 asc

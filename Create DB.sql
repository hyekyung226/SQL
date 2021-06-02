USE EDU

CREATE TABLE[회원테이블] (
[회원번호]VARCHAR(20) PRIMARY KEY,
[이름]VARCHAR(20),
[성별]VARCHAR(2),
[나이]INT,
[가입금액]MONEY,
[가입일자]DATE NOT NULL,
[수신동의] BIT
)

--add [몸무게] column to [회원테이블]에 [몸무게], data format: REAL
ALTER TABLE [회원테이블] ADD[몸무게] REAL

--alter data format into INT from [몸무게] of [회원테이블]
ALTER TABLE[회원테이블] ALTER COLUMN[몸무게] INT

--rename column [몸무게] from [회원테이블] to [몸무게(kg)]
SP_RENAME '[회원테이블].[몸무게]', '몸무게(kg)'

--rename table [회원테이블] to [MEMBER]
SP_RENAME '[회원테이블]', 'MEMBER'

--delete all row data (행 데이터) and 테이블 공간
TRUNCATE TABLE[MEMBER]

--delete table
DROP TABLE[MEMBER] 

insert into [회원테이블] values ('A10001', '모원서', '남', 33, 100000, '2020-01-01', 1);
insert into [회원테이블] values ('A10002', '김영화', '여', 29, 200000, '2020-01-02', 0);
insert into [회원테이블] values ('A10003', '홍길동', '남', 29, 300000, '2020-01-03',  null);

--PRIMARY KEY 제약 조건 위반 (중복 키로 인한 실행 불가)
insert into [회원테이블] values ('A10001', '홍길동', '남', 29, 300000, '2020-01-03', null);

--NOT NULL 제약 조건 위반 ([가입일자] data does not exist)
insert into [회원테이블] values ('A10005', '홍길동', '남', 29, 300000, null, 1);

--view all columns from [회원테이블]
select * -- all colums
from [회원테이블]

--view specific column name from [회원테이블] & alter coㅣumn name temporarily
select [회원번호]
	   ,[이름] AS [성명] -- can delete AS
	   ,[가입일자] -- can switch column order
	   ,[나이]
 from [회원테이블]

--change all data from [나이] column into 30 unconditionally
update [회원테이블]
   set [나이]=30 --set column/value to change

--view [회원테이블] to check changes
select *
from [회원테이블]

--change [나이] data into 34 of [회원번호] A10001
update [회원테이블]
   set [나이]=34
 where [회원번호]='A10001'

--delet all row data (only) from [회원테이블] 
delete
from [회원테이블]
where [회원번호]='A10001'

--authorise [회원테이블] to user MWS | with grant option -> MWS can authorise others
grant select, insert, update, delete on [회원테이블] to MWS with grant option

--unauthorise | cascade -> unauthorise related others
revoke select, insert, update, delete on [회원테이블] to MWS cascade

--begin tran->delete->commit (commit command is irreversible)
/* --not to execute (not to lose data)
use EDU
begin tran -- begin TCL(Transaction Control Language)
delete from [회원테이블] --delet all row data from [회원테이블]
commit --execute delete all row data 
*/

--rollback -> cancel DML(Data Manipulation Language) commands | excute per command
/*
use EDU
begin tran
select from [회원테이블] --before deleting all row data from [회원테이블]
delete from [회원테이블] -- delete all row data from [회원테이블]
select from [회원테이블] -- after deleting all row data from [회원테이블]
rollback -- cancel deleting all row data from [회원테이블]
select * from [회원테이블] --after canceling deletion of all row data from [회원테이블]
*/

--savepoint(임시 저장) for rollback tran(지정 취소)
/*
use EDU
begin tran
save tran S1
 insert into [회원테이블] values ('A10001', '모원서', '남', 33, 100000, '2020-01-01', 1);

save tran S2
 update [회원테이블] set [나이]=34 where [회원번호]='A10001'

save tran S3
 delete from [회원테이블] where [회원번호]='A10003'

select * from [회원테이블] -- check savepoint

rollback tran S3; --rollback
select * from [회원테이블] --to check rollback

rollback tran S2;
select * from [회원테이블]

rollback tran S1;
select * from [회원테이블]
*/
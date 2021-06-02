USE EDU

CREATE TABLE[ȸ�����̺�] (
[ȸ����ȣ]VARCHAR(20) PRIMARY KEY,
[�̸�]VARCHAR(20),
[����]VARCHAR(2),
[����]INT,
[���Աݾ�]MONEY,
[��������]DATE NOT NULL,
[���ŵ���] BIT
)

--add [������] column to [ȸ�����̺�]�� [������], data format: REAL
ALTER TABLE [ȸ�����̺�] ADD[������] REAL

--alter data format into INT from [������] of [ȸ�����̺�]
ALTER TABLE[ȸ�����̺�] ALTER COLUMN[������] INT

--rename column [������] from [ȸ�����̺�] to [������(kg)]
SP_RENAME '[ȸ�����̺�].[������]', '������(kg)'

--rename table [ȸ�����̺�] to [MEMBER]
SP_RENAME '[ȸ�����̺�]', 'MEMBER'

--delete all row data (�� ������) and ���̺� ����
TRUNCATE TABLE[MEMBER]

--delete table
DROP TABLE[MEMBER] 

insert into [ȸ�����̺�] values ('A10001', '�����', '��', 33, 100000, '2020-01-01', 1);
insert into [ȸ�����̺�] values ('A10002', '�迵ȭ', '��', 29, 200000, '2020-01-02', 0);
insert into [ȸ�����̺�] values ('A10003', 'ȫ�浿', '��', 29, 300000, '2020-01-03',  null);

--PRIMARY KEY ���� ���� ���� (�ߺ� Ű�� ���� ���� �Ұ�)
insert into [ȸ�����̺�] values ('A10001', 'ȫ�浿', '��', 29, 300000, '2020-01-03', null);

--NOT NULL ���� ���� ���� ([��������] data does not exist)
insert into [ȸ�����̺�] values ('A10005', 'ȫ�浿', '��', 29, 300000, null, 1);

--view all columns from [ȸ�����̺�]
select * -- all colums
from [ȸ�����̺�]

--view specific column name from [ȸ�����̺�] & alter co��umn name temporarily
select [ȸ����ȣ]
	   ,[�̸�] AS [����] -- can delete AS
	   ,[��������] -- can switch column order
	   ,[����]
 from [ȸ�����̺�]

--change all data from [����] column into 30 unconditionally
update [ȸ�����̺�]
   set [����]=30 --set column/value to change

--view [ȸ�����̺�] to check changes
select *
from [ȸ�����̺�]

--change [����] data into 34 of [ȸ����ȣ] A10001
update [ȸ�����̺�]
   set [����]=34
 where [ȸ����ȣ]='A10001'

--delet all row data (only) from [ȸ�����̺�] 
delete
from [ȸ�����̺�]
where [ȸ����ȣ]='A10001'

--authorise [ȸ�����̺�] to user MWS | with grant option -> MWS can authorise others
grant select, insert, update, delete on [ȸ�����̺�] to MWS with grant option

--unauthorise | cascade -> unauthorise related others
revoke select, insert, update, delete on [ȸ�����̺�] to MWS cascade

--begin tran->delete->commit (commit command is irreversible)
/* --not to execute (not to lose data)
use EDU
begin tran -- begin TCL(Transaction Control Language)
delete from [ȸ�����̺�] --delet all row data from [ȸ�����̺�]
commit --execute delete all row data 
*/

--rollback -> cancel DML(Data Manipulation Language) commands | excute per command
/*
use EDU
begin tran
select from [ȸ�����̺�] --before deleting all row data from [ȸ�����̺�]
delete from [ȸ�����̺�] -- delete all row data from [ȸ�����̺�]
select from [ȸ�����̺�] -- after deleting all row data from [ȸ�����̺�]
rollback -- cancel deleting all row data from [ȸ�����̺�]
select * from [ȸ�����̺�] --after canceling deletion of all row data from [ȸ�����̺�]
*/

--savepoint(�ӽ� ����) for rollback tran(���� ���)
/*
use EDU
begin tran
save tran S1
 insert into [ȸ�����̺�] values ('A10001', '�����', '��', 33, 100000, '2020-01-01', 1);

save tran S2
 update [ȸ�����̺�] set [����]=34 where [ȸ����ȣ]='A10001'

save tran S3
 delete from [ȸ�����̺�] where [ȸ����ȣ]='A10003'

select * from [ȸ�����̺�] -- check savepoint

rollback tran S3; --rollback
select * from [ȸ�����̺�] --to check rollback

rollback tran S2;
select * from [ȸ�����̺�]

rollback tran S1;
select * from [ȸ�����̺�]
*/
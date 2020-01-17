--EXEC sp_enum_oledb_providers;
--sp_configure 'show advanced options', 1;
--   RECONFIGURE;
--	GO
--   sp_configure 'Ad Hoc Distributed Queries', 1;
--   RECONFIGURE;
--	GO

use Sasha

--SELECT * into Payments FROM OPENROWSET
--   (
--    'Microsoft.ACE.OLEDB.12.0',
--    'Excel 12.0;
--     Database=D:\Install\test.xlsm',
--    'SELECT * FROM [Payments$]'
--   );

--select * from Loans
--select * from UserTypes
--select * from Payments

--alter table Payments alter column Amount int
--********************************************************************
--********************************************************************
--********************************************************************

-- First quest
select count(*) ���_�����, sum(Amount) ����_�����, avg(Amount) ����_����_�����, avg(Term) ����_����_����� from Loans;

-- Second quest
 Select (select sum(p1.Amount) from Payments p1) �����������, sum(p.Amount) ��������10����
	from Payments p JOIN Loans l on l.LoanId = p.LoanId 
		and DATEDIFF(dd,l.DisbursmentDate,p.PaidDate) <= 10
		
	
-- Third quest
select l.LoanId, sum(l.Amount) ����_�����, sum(p.Amount) ����_����, sum(p.Amount - l.Amount) ������
	from Loans l, Payments p 
		where l.LoanId = p.loanId and p.Amount > l.Amount
	group by l.LoanId order by l.LoanId
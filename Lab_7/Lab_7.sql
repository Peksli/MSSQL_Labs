USE LibraryDB

--1.������� �������������, ���������� ��� ������������, �������� ������������, 
--	��� ������� � ����������  ���� ������� ������������.
--  � ������� ���������� �������������, ���������� ������������, ����� �������� ��  
--  ��������� � ������� ����.
--GO
--CREATE VIEW BooksView_Z1
--AS SELECT*
--FROM [Books]

GO
SELECT [Publisher Code]
FROM BooksView_Z1
WHERE [Year Of Admission] < YEAR(GETDATE()) - 1 


--2.������� �������������, ���������� ��� ��������, ����� ������������� ������,
--	������� ��������,  �����, ����������� � �������� � ���� �� �����.
--  � ������� ���������� �������������  ��������� ������ ���������, � ������� ���������� 
--  ����� ����.
--GO
--CREATE VIEW ReadersView_Z2
--AS SELECT [Readers].[Reader Code],
--		  [Readers].[Library Card Number],
--		  [Readers].[Surname],
--		  [Books].[Book Code],
--		  [Book Issuance Journal].[Return Deadline]
--FROM [Book Issuance Journal]
--INNER JOIN [Readers] ON [Book Issuance Journal].[Reader Code] = [Readers].[Reader Code]
--INNER JOIN [Books] ON [Book Issuance Journal].[Book Code] = [Books].[Book Code]
--WHERE [Book Issuance Journal].[Return Deadline] < [Book Issuance Journal].[Date Of Return]


--3.������� �������������, ���������� ������ ���������� � �������� ������ � ������� �� ���������.
--GO
--CREATE VIEW ReadersBooksView_Z3
--AS SELECT [Readers].[Reader Code],
--		  [Books].[Book Code],
--		  [Books].[Author],
--		  [Books].[Title],
--		  [Books].[Year Of Admission]
--FROM [Book Issuance Journal]
--INNER JOIN [Readers] ON [Book Issuance Journal].[Reader Code] = [Readers].[Reader Code]
--INNER JOIN [Books] ON [Book Issuance Journal].[Book Code] = [Books].[Book Code]


--� ������� ���������� ������������� ���������� ��������, �������� �� ����� ������������ ���������� ���� � ����� ����� ���� ����.
GO
SELECT TOP 1 [Reader Code], MAX([Date Of Return]) as [Date Of Return], COUNT([Book Code]) as [Having books]
FROM [Book Issuance Journal]
GROUP BY [Reader Code]
ORDER BY [Having books] DESC


--4.������� �������������, ���������� ������ ������ ����, � �������  ���������� ������ ���������� � ������ � ���������.
--GO
--CREATE VIEW ReadersBooksView_Z4
--AS SELECT [Readers].[Reader Code],
--		  [Books].[Book Code],
--		  [Books].[Author],
--		  [Books].[Title],
--		  [Books].[Year Of Admission]
--FROM [Book Issuance Journal]
--INNER JOIN [Readers] ON [Book Issuance Journal].[Reader Code] = [Readers].[Reader Code]
--INNER JOIN [Books] ON [Book Issuance Journal].[Book Code] = [Books].[Book Code]

--� ������� ���������� ������������� ���������� �������� ���������� ����� � �������� ������������ ������������ ���������� ����.
GO
SELECT [Book Code] as [Main used book code], [Reader Code] as [Main reader]
FROM [Book Issuance Journal] 
WHERE [Reader Code] IN (
	SELECT TOP 1 [Reader Code] as [Main reader code]
	FROM [Book Issuance Journal]
	GROUP BY [Reader Code]
	ORDER BY COUNT([Reader Code]) DESC
)
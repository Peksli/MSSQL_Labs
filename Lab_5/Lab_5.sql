USE LibraryDB

--��������� �������� ���������� ������ ��������� ��������� �������:
--1. ��������� ������ �������� � ��������� � ������, ������� �� ���� ��������. 
--   ������� ������ ���������� � ��������� � ������.
SELECT Readers.[Reader Code], 
	   Books.[Book Code], 
	   [Inventory Number], 
	   [Author], 
	   [Title]
FROM [Book Issuance Journal]
INNER JOIN Books ON [Book Issuance Journal].[Book Code] = [Books].[Book Code]
INNER JOIN Readers ON [Book Issuance Journal].[Reader Code] = [Readers].[Reader Code]


--2. ������� ������ ���������� � ������, ������� �������� �� ������ ���������
SELECT [Readers].[Reader Code],
	   [Books].[Book Code],
	   [Inventory Number],
	   [Author],
	   [Title],
	   [Year Of Publication],
	   [Publisher Code],
	   [Number Of Copies]
FROM [Book Issuance Journal]
INNER JOIN [Readers] ON [Book Issuance Journal].[Reader Code] = [Readers].[Reader Code]
INNER JOIN [Books] ON [Book Issuance Journal].[Book Code] = [Books].[Book Code]


--3. ������� ������ ���������� � ���������, ������� ����� �����, �������� � ��������� ����.
SELECT [Books].[Book Code],
	   [Readers].[Reader Code],
	   Readers.[Address],
	   Readers.[First Name],
	   Readers.[Library Card Number]
FROM [Book Issuance Journal]
INNER JOIN [Readers] ON [Book Issuance Journal].[Reader Code] = [Readers].[Reader Code]
INNER JOIN [Books] ON [Book Issuance Journal].[Book Code] = [Books].[Book Code]
WHERE [Books].[Year Of Publication] = 2024


--4. ��������� ������ ��������� �� ����������� ����.
SELECT [Book Issuance Journal].[Issuance Code],
	   [Readers].[Reader Code],
	   [Book Issuance Journal].[Book Code],
	   [Book Issuance Journal].[Date Of Issuance],
	   [Book Issuance Journal].[Return Deadline],
	   [Book Issuance Journal].[Date Of Return]
FROM [Book Issuance Journal]
INNER JOIN [Readers] ON [Book Issuance Journal].[Reader Code] = [Readers].[Reader Code]
WHERE [Date Of Return] IS NULL

 
--��������� �������� UNION, EXCEPT, INTERSECT ��������� ��������� �������:
--1. �������� ����� ����� ������ ������� ��������������.
SELECT [Book Code], [Publisher Code]
FROM Books
WHERE [Publisher Code] IN (
	SELECT [Publisher Code] FROM Books
	INTERSECT
	SELECT [Publisher Code] FROM Publishers
)


--2. ���������� ���� �� ����� ��������� � ������� ������������
SELECT [Surname] FROM Readers
WHERE [Surname] IN (
	SELECT [Surname] FROM [Readers] 
	INTERSECT
	SELECT [Author] FROM [Books]
)


--3. �������� �����, ������� � ������� ���� ��� �� ����� ��������.
SELECT [Book Code],
	   [Author],
	   [Publisher Code]
FROM Books
WHERE [Book Code] IN (
	SELECT [Book Code] FROM Books
	EXCEPT
	SELECT [Book Code] FROM [Book Issuance Journal]
)
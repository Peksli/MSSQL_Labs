USE LibraryDB


--1. ������� ����� ������� ��������� � � ������� ������� ������ � ��� ������ � ���������, 
--	 � ������� ����� ���� ����� ����. ������� ������� ���������
CREATE TABLE [��������]
(	[Reader Code] INT,
	[Surname] NVARCHAR(50), 
	[Name] NVARCHAR(50), 
	[Phone Number] NVARCHAR(50)
)

INSERT INTO [��������]
SELECT [Reader Code],
	   [First Name],
	   [Surname],
	   [Phone]
FROM Readers
WHERE [Reader Code] IN (
	SELECT [Reader Code]
	FROM [Book Issuance Journal]
	WHERE [Date Of Return] > [Return Deadline]
)


--2. � ������� ������  �������� ���� ���� ������������ � � ������� ������� ������ � ��� ���� ������,
--	 ������, ��� ����� ����������� �������� ��������� ����� ���� ������� ���. ������� ������� ������.
ALTER TABLE Books
ADD [Year Of Admission] INT NULL

UPDATE Books
SET [Year Of Admission] = [Year Of Publication] + 1
WHERE [Year Of Admission] IS NULL -- ������ ������� �� ������ �����


--3. ���������������� ������� ������ �� ����� ��������� � ������.
CREATE INDEX IX_Books_Title_Author
ON Books ([Title], [Author]);


--4. ������� �� ������� ������ ������ � ������ ������ 40 ���.
DELETE FROM Books
WHERE YEAR(GETDATE()) - [Year Of Admission] > 40


--5. ������� �� ������� ���������, ���������, ������� �� ����� ���� ����� 3-� ���.
DELETE FROM Readers
WHERE [Reader Code] IN (
	SELECT [Reader Code]
	FROM [Book Issuance Journal]
	WHERE YEAR(GETDATE()) - YEAR([Date Of Issuance]) > 3
)
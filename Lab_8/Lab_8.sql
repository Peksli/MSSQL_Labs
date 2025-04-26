USE LibraryDB


--1.������������ ������ ����, ��� ������� ��������� �������� ��������.
GO
CREATE PROCEDURE GetBooksByAge
	@Age INT
AS
BEGIN 
	SELECT [Book Code]
	FROM Books
	WHERE YEAR(GETDATE()) - [Year Of Publication] > @Age
END;

GO
EXEC GetBooksByAge @Age = 10;


--2.������������ ������ ���������, �� ��������� ����� �������.
GO
CREATE PROCEDURE ReadersWhoDidnotReturnBooksInTime
AS
BEGIN
	SELECT [Readers].[Reader Code] as [Reader Code who did not return book in time],
		   [Readers].[First Name],
		   [Readers].[Surname],
		   [Readers].[Patronymic],
		   [Readers].[Phone]
	FROM [Book Issuance Journal]
	INNER JOIN [Readers] ON [Book Issuance Journal].[Reader Code] = [Readers].[Reader Code]
	WHERE [Date Of Return] > [Return Deadline]
END;

EXEC ReadersWhoDidnotReturnBooksInTime;


--3.������������ ������ ��������� � ��������� ��������, � ������� �� ����� ��������� ���������� ����, 
--����������� �������� ��������. ����� ���������� ����� ���� ������ �������� ����������.
GO
CREATE PROCEDURE ReaderWithRequiredCountOfBooks
	@RequiredCountOfBooks INT
AS 
BEGIN
	SELECT [Reader Code], [Phone] 
	FROM [Readers]
	WHERE [Reader Code] IN(
		SELECT [Reader Code]
		FROM [Book Issuance Journal]
		GROUP BY [Reader Code]
		HAVING COUNT([Reader Code]) > @RequiredCountOfBooks
	)
END;

GO
EXEC ReaderWithRequiredCountOfBooks @RequiredCountOfBooks = 0;

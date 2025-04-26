USE LibraryDB


--1.Сформировать список книг, чей возраст превышает заданный параметр.
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


--2.Сформировать список читателей, не вернувших книги вовремя.
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


--3.Сформировать список читателей с указанием телефона, у которых на руках находится количество книг, 
--превышающее заданный параметр. Общее количество таких книг задать выходным параметром.
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

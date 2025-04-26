--1.	—оздать скал€рную функцию дл€ вычислени€ возраста книги по вводимому коду книги. 
--CREATE FUNCTION dbo.GetBookByAge_Lab9Z1
--(
--    @BookCode INT
--)
--RETURNS INT
--AS
--BEGIN
--    DECLARE @BookAge INT;

--    SELECT @BookAge = YEAR(GETDATE()) - [Year Of Publication]
--    FROM Books
--    WHERE [Book Code] = @BookCode;

--    RETURN @BookAge;
--END;


GO
SELECT dbo.GetBookByAge_Lab9Z1(1) AS BookAge;


--2.	—оздать табличную  функцию дл€ вывода списка читателей, которые должны вернуть книгу не позже вводимой даты.
--GO
--CREATE FUNCTION dbo.GetReadersByReturnDate
--(
--    @ReturnDate DATE
--)
--RETURNS TABLE
--AS
--RETURN
--(
--    SELECT 
--        [Readers].[Reader Code], 
--        [Readers].[Surname], 
--        [Readers].[First Name], 
--        [Book Issuance Journal].[Return Deadline]
--    FROM [Book Issuance Journal]
--    INNER JOIN [Readers] ON [Book Issuance Journal].[Reader Code] = Readers.[Reader Code]
--    WHERE [Book Issuance Journal].[Return Deadline] <= @ReturnDate
--);
--GO

SELECT * 
FROM dbo.GetReadersByReturnDate('2025-04-30');


--3.	—оздать многострочную табличную функцию дл€ формировани€ списка читателей, 
--не вернувших книги воврем€ по указанной дате с указанием названий и авторов книг
GO
CREATE FUNCTION dbo.GetOverdueReadersWithBooks
(
    @Date DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        [Readers].[Reader Code], 
        [Readers].[Surname], 
        [Readers].[First Name], 
        [Books].[Title],
        [Books].[Author], 
        [Book Issuance Journal].[Return Deadline],
        DATEDIFF(DAY, [Book Issuance Journal].[Date Of Return], @Date) AS OverdueDays
    FROM [Book Issuance Journal]
    INNER JOIN [Readers] ON [Book Issuance Journal].[Reader Code] = [Readers].[Reader Code]
    INNER JOIN [Books] ON [Book Issuance Journal].[Book Code] = [Books].[Book Code]
    WHERE [Book Issuance Journal].[Date Of Return] <> @Date

);
GO


SELECT * 
FROM dbo.GetOverdueReadersWithBooks('2025-04-30');
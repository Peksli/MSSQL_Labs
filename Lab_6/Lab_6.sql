USE LibraryDB


--1. Создать новую таблицу «Должники» и с помощью запроса внести в нее данные о читателях, 
--	 у которых истек срок сдачи книг. Вывести таблицу «Должники»
CREATE TABLE [Должники]
(	[Reader Code] INT,
	[Surname] NVARCHAR(50), 
	[Name] NVARCHAR(50), 
	[Phone Number] NVARCHAR(50)
)

INSERT INTO [Должники]
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


--2. В таблицу «Книги»  добавить поле «Год поступления» и с помощью запроса внести в это поле данные,
--	 считая, что годом поступления является следующий после года издания год. Вывести таблицу «Книги».
ALTER TABLE Books
ADD [Year Of Admission] INT NULL

UPDATE Books
SET [Year Of Admission] = [Year Of Publication] + 1
WHERE [Year Of Admission] IS NULL -- строки берутся на основе этого


--3. Проиндексировать таблицу «Книги» по полям «Название» и «Автор».
CREATE INDEX IX_Books_Title_Author
ON Books ([Title], [Author]);


--4. Удалить из таблицы «Книги» данные о книгах старше 40 лет.
DELETE FROM Books
WHERE YEAR(GETDATE()) - [Year Of Admission] > 40


--5. Удалить из таблицы «Читатели», читателей, которые не брали книг более 3-х лет.
DELETE FROM Readers
WHERE [Reader Code] IN (
	SELECT [Reader Code]
	FROM [Book Issuance Journal]
	WHERE YEAR(GETDATE()) - YEAR([Date Of Issuance]) > 3
)
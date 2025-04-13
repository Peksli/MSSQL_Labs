USE LibraryDB

--Count the number of readers whose patronymic is "Ivanovich".
GO
SELECT Patronymic as [Group Of Patronymics], COUNT(Patronymic) as [Total count in group]
FROM Readers
GROUP BY Patronymic
HAVING Patronymic = 'Ivanovich'



--Count the number of books assigned to each reader.
GO
SELECT [Reader Code], COUNT([Issuance Code]) as [Books Issuanced]
FROM [Book Issuance Journal]
GROUP BY [Reader Code]



--Determine the reader code of the reader who borrowed the maximum number of books.
GO
SELECT TOP 1 [Reader Code], COUNT([Issuance Code]) as [Books Issuanced]
FROM [Book Issuance Journal]
GROUP BY [Reader Code]
ORDER BY [Books Issuanced] DESC


--Determine the publisher code with the maximum number of books.
GO
SELECT TOP 1 [Publisher Code], SUM([Number Of Copies]) as [Created Copies]
FROM Books
GROUP BY [Publisher Code]
ORDER BY [Created Copies] DESC



--Calculate the average number of books currently borrowed by readers.
GO
SELECT
	COUNT([Book Code]) / COUNT(DISTINCT [Reader Code]) as [Average borrowed]
FROM [Book Issuance Journal]



--Determine the year of publication of books with the maximum number in the library.
GO
SELECT TOP 1 [Year Of Publication], SUM([Number Of Copies]) AS [Total Copies]
FROM Books
GROUP BY [Year Of Publication]
ORDER BY [Total Copies] DESC;



--Determine the date on which the maximum number of books was issued.
GO
SELECT TOP 1 [Date Of Issuance] as [Date Of Issuance], COUNT([Issuance Code]) as [Issuance Count]
FROM [Book Issuance Journal]
GROUP BY [Date Of Issuance]
ORDER BY [Issuance Count] DESC
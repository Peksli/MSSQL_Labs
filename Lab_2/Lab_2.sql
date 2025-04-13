USE LibraryDB
GO

--Display the entire table "Book Issuance Journal".
SELECT * 
FROM [Book Issuance Journal]


--Display a list of readers whose patronymic is "Ivanovich".
SELECT * 
FROM Readers 
WHERE Patronymic = 'Ivanovich'


--Display a list of readers who have a book with code 2 issued to them last month.
SELECT *
FROM [Book Issuance Journal]
WHERE [Book Code] = 2 
AND MONTH([Date Of Issuance]) >= MONTH(GETDATE()) - 1


--Display a list of books published in 1980, 1990, and 2000.
SELECT *
FROM Books
WHERE [Year Of Publication] IN (1980, 1990, 2000)


--Display the codes of readers who borrowed books in the previous month.
SELECT [Reader Code]
FROM [Book Issuance Journal]
WHERE MONTH([Date Of Issuance]) >= MONTH(GETDATE()) - 1


--Display a list of readers who do not have a phone number.
SELECT *
FROM Readers
WHERE Phone IS NULL


--Display a list of books whose titles begin with the letter "V".
SELECT *
FROM Books
WHERE Title LIKE 'V%'
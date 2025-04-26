USE LibraryDB

-- 1. List of readers who currently have books checked out.
GO
SELECT DISTINCT [Reader Code] as [Reader Codes who didn't return books yet]
FROM [Book Issuance Journal]
WHERE [Reader Code] IN (
	SELECT [Reader Code]
	FROM [Book Issuance Journal]
	WHERE [Date Of Return] IS NULL
)


-- 2. List of readers who have overdue books (past the return deadline).
SELECT DISTINCT [Reader Code] as [Reader Codes didn't return in time]
FROM [Book Issuance Journal]
WHERE [Reader Code] IN (
	SELECT [Reader Code] as [Reader Codes whos date ot return expired]
	FROM [Book Issuance Journal]
	WHERE [Date Of Return] > [Return Deadline]
)

-- 3. List of publishers whose books were added last year.
SELECT DISTINCT [Publisher Code] as [Publisher Codes who added books last year]
FROM [Books]
WHERE [Publisher Code] IN (
	SELECT [Publisher Code]
	FROM [Books]
	WHERE [Year Of Publication] = YEAR(GETDATE()) - 1
)


-- 4. Surnames of the readers with the longest overdue period for book return.
SELECT DISTINCT [Surname] as [Surnames of persons with the longest overdue period]
FROM [Readers]
WHERE [Reader Code] IN (
	SELECT TOP 10 [Reader Code]
	FROM [Book Issuance Journal]
	ORDER BY DATEDIFF(DAY, [Date Of Return], [Date Of Issuance])
)


-- 5. Surnames of readers who need to return books within the next 14 days.
SELECT DISTINCT [Surname] as [Surname who should return book within the next 14 days]
FROM [Readers]
WHERE [Reader Code] IN (
	SELECT [Reader Code]
	FROM [Book Issuance Journal]
	WHERE DATEDIFF(DAY, [Date Of Issuance], [Return Deadline]) = 14
)
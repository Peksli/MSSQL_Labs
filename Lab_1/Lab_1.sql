
--«Library»
USE LibraryDB



-- Publishers (Publisher Code, Publisher).
GO
CREATE TABLE Publishers
	([Publisher Code]	INT	PRIMARY KEY IDENTITY(1, 1),
	 [Publisher]		NVARCHAR(50)	NOT NULL);



-- Readers (Reader Code, Library Card Number, Surname, First Name, Patronymic, Phone, Address).
GO
CREATE TABLE Readers
	([Reader Code]			INT PRIMARY KEY IDENTITY(1, 1),
	 [Library Card Number]	INT				NOT NULL,
	 [Surname]				NVARCHAR(50)	NOT NULL,
	 [First Name]			NVARCHAR(50)	NOT NULL,
	 [Patronymic]			NVARCHAR(50)	NULL,
	 [Phone]				NVARCHAR(17)	NOT NULL,
	 [Address]				NVARCHAR(50)	NULL);



-- Books (Book Code, Inventory Number, Author, Title, 
--   Year of Publication, Publisher Code, Number of Copies).
GO
CREATE TABLE Books
	([Book Code] INT PRIMARY KEY IDENTITY(1, 1),
	 [Inventory Number]		INT				NOT NULL,
	 [Author]				NVARCHAR(50)	NOT NULL,
	 [Title]				NVARCHAR(50)	NOT NULL,
	 [Year Of Publication]	INT				NOT NULL,
	 [Publisher Code]		INT				NOT NULL,
	 [Number Of Copies]		INT				NULL,
	 FOREIGN KEY ([Publisher Code]) REFERENCES Publishers([Publisher Code]));



-- Book Issuance Journal (Issuance Code, Reader Code, Book Code,
--   Date of Issuance, Return Deadline, Date of Return).
GO
CREATE TABLE [Book Issuance Journal]
	([Issuance Code]		INT PRIMARY KEY IDENTITY(1, 1),
	 [Reader Code]			INT		NOT NULL,
	 [Book Code]			INT		NOT NULL,
	 [Date Of Issuance]		DATE	NOT NULL,
	 [Return Deadline]		DATE	NOT NULL,
	 [Date Of Return]		DATE	NULL,
	 FOREIGN KEY ([Reader Code])  REFERENCES  Readers([Reader Code]),
	 FOREIGN KEY ([Book Code])	  REFERENCES  Books([Book Code]));

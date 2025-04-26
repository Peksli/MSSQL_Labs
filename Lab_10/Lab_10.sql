USE LibraryDB

--CREATE TABLE AuditLog (
--    AuditID INT IDENTITY(1,1) PRIMARY KEY,
--    Action NVARCHAR(50),
--    BookCode INT,
--    ChangeDate DATETIME
--);

----	1.	Триггер журнала аудита
--GO
--CREATE TRIGGER AuditTrigger
--ON [Books]
--AFTER INSERT, UPDATE, DELETE
--AS
--BEGIN
--    SET NOCOUNT ON;

--    -- Определение действия (INSERT, UPDATE, DELETE)
--    DECLARE @Action NVARCHAR(10);
--    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
--        SET @Action = 'UPDATE';
--    ELSE IF EXISTS (SELECT * FROM inserted)
--        SET @Action = 'INSERT';
--    ELSE IF EXISTS (SELECT * FROM deleted)
--        SET @Action = 'DELETE';

--    -- Запись в журнал аудита
--    INSERT INTO AuditLog (Action, BookCode, ChangeDate)
--    SELECT 
--        @Action, 
--        ISNULL(i.[Book Code], d.[Book Code]),
--        GETDATE()
--    FROM inserted AS i
--    FULL OUTER JOIN deleted AS d ON i.[Book Code] = d.[Book Code];
--END;


----	2.	Триггер для реализации бизнес-правил
--GO
--CREATE TRIGGER BusinessRuleTrigger
--ON [Books]
--AFTER INSERT
--AS
--BEGIN
--    SET NOCOUNT ON;

--    -- Проверка правила
--    IF EXISTS (
--        SELECT * 
--        FROM inserted
--        WHERE [Year Of Publication] > YEAR(GETDATE())
--    )
--    BEGIN
--        RAISERROR ('Year Of Publication cannot exceed the current year.', 16, 1);
--        ROLLBACK TRANSACTION;
--    END;
--END;


----	3.	Триггер для обеспечения целостности
--GO
--CREATE TRIGGER IntegrityTrigger
--ON [Books]
--INSTEAD OF DELETE
--AS
--BEGIN
--    SET NOCOUNT ON;

--    IF EXISTS (
--        SELECT * 
--        FROM [Book Issuance Journal]
--        WHERE [Book Code] IN (SELECT [Book Code] FROM deleted)
--    )
--    BEGIN
--        RAISERROR ('Cannot delete books that are currently issued.', 16, 1);
--        ROLLBACK TRANSACTION;
--    END
--    ELSE
--    BEGIN
--        DELETE FROM Books
--        WHERE [Book Code] IN (SELECT [Book Code] FROM deleted);
--    END;
--END;
--GO


----	4.	Триггер для запрещения удаления триггеров
--CREATE TRIGGER PreventTriggerDeletion
--ON DATABASE
--FOR DROP_TRIGGER
--AS
--BEGIN
--    SET NOCOUNT ON;

--    -- Отклонение операции удаления триггера
--    RAISERROR ('Deleting triggers is not allowed.', 16, 1);
--    ROLLBACK TRANSACTION;
--END;
--GO

INSERT INTO Books (
    [Inventory Number], 
    [Author], 
    [Title], 
    [Year Of Publication], 
    [Publisher Code], 
    [Number Of Copies], 
    [Year Of Admission]
)
VALUES (
    123456, 
    'John Doe', 
    'SQL Basics', 
    2025, 
    1,      -- Publisher Code
    10,     -- Number Of Copies
    2026    -- Year Of Addmission
);

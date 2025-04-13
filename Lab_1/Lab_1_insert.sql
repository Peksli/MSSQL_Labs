USE LibraryDB


GO
INSERT INTO Readers ([Library Card Number], [Surname], [First Name], [Patronymic], [Phone], [Address])
VALUES 
(1001, 'Brown', 'John', 'Michael', '+1-123-456-7890', '456 Elm Street, Springfield'),
(1002, 'Smith', 'Emily', 'Rose', '+44-7900-123456', '32 King’s Road, London'),
(1003, 'Taylor', 'Michael', 'James', '+61-400-789-123', '78 Queen Street, Sydney'),
(1004, 'Davis', 'Olivia', 'Anne', '+1-987-654-3210', '123 Pine Avenue, Miami'),
(1005, 'Wilson', 'Sophia', 'Marie', '+49-151-23456789', '45 Hauptstraße, Berlin'),
(1006, 'Martinez', 'Isabella', 'Clara', '+33-6-12-34-56-78', '67 Rue de Rivoli, Paris'),
(1007, 'Lopez', 'David', 'Alexander', '+34-612-345-678', '23 Avenida Madrid, Madrid'),
(1008, 'Garcia', 'Benjamin', 'Victor', '+351-912-345-678', '89 Rua Nova, Lisbon'),
(1009, 'Johnson', 'Charlotte', 'Grace', '+81-90-1234-5678', '7-3-1 Ginza, Tokyo'),
(1010, 'Lewis', 'James', 'Oliver', '+1-234-567-8901', '891 Oak Lane, Austin');


GO 
INSERT INTO Publishers ([Publisher])
VALUES 
('Penguin Random House'),
('HarperCollins'),
('Simon & Schuster'),
('Macmillan Publishers'),
('Hachette Livre');


GO
INSERT INTO Books ([Inventory Number], [Author], [Title], [Year Of Publication], [Publisher Code], [Number Of Copies])
VALUES
(10101, 'George Orwell', '1984', 1949, 1, 50),
(20202, 'J.K. Rowling', 'Harry Potter and the Sorcerer''s Stone', 1997, 2, 100),
(30303, 'F. Scott Fitzgerald', 'The Great Gatsby', 1925, 3, 30),
(40404, 'Leo Tolstoy', 'War and Peace', 1869, 4, 20),
(50505, 'Gabriel Garcia Marquez', 'One Hundred Years of Solitude', 1967, 5, 40);


GO
INSERT INTO [Book Issuance Journal] ([Reader Code], [Book Code], [Date Of Issuance], [Return Deadline], [Date Of Return])
VALUES
(1, 1, '2025-03-01', '2025-03-15', '2025-03-10'),
(2, 2, '2025-03-02', '2025-03-16', '2025-03-12'),
(3, 3, '2025-03-03', '2025-03-17', NULL),
(4, 4, '2025-03-04', '2025-03-18', '2025-03-14'),
(5, 5, '2025-03-05', '2025-03-19', NULL);


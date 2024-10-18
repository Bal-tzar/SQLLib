# SQLLib
1. Databasdesign:  
    a) Skapa ett ER-diagram (Entity-Relationship diagram) för bibliotekssystemet.
   ![image](https://github.com/user-attachments/assets/fb8f3206-c730-44c5-aeb8-90f72d8e3a84)

    b) Normalisera din databasstruktur till åtminstone 3NF (tredje normalform).  
    c) Skapa ett UML-klassdiagram som representerar din slutliga databasstruktur.
   ![image](https://github.com/user-attachments/assets/5993d09d-7564-4782-9f5c-b11611f73cc5)


   
    
3. Implementering:  
    a) Skapa SQLite-tabeller baserat på din design.  
    b) Implementera lämpliga primärnycklar och främmande nycklar för att upprätthålla referensintegritet.


    
5. Datamanipulation:  
    a) Skriv SQL-frågor för att utföra CRUD-operationer (Create, Read, Update, Delete) på alla tabeller.


    ```sql
	-- CRUD Operations Books

	-- CREATE:

	INSERT INTO Books (Author, Title, PublicationYear, ISBN)
	VALUES ('Stephen King', 'The Stand', 1978, '978-1-44-472073-0');

	-- READ:

	SELECT * FROM Books;

	-- UPDATE: 

	UPDATE Books 
	SET Title = 'Bröderna Lejonhjärta'
	WHERE BookID = 3;

	-- DELETE:

	DELETE FROM Books
	WHERE Title = 'Bröderna Lejonhjärta';
   ```


```sql
	-- CRUD Operations Borrowers

	-- CREATE:

	INSERT INTO Borrowers (Name, Email, PhoneNum)
	VALUES ('Janne Josefsson', 'janne@ug.se', '08-1337-420');

	-- READ:

	SELECT * FROM Borrowers;

	-- UPDATE: 

	UPDATE Borrowers
	SET Name = 'David Bowie'
	WHERE BorrowerID = 4;

	-- DELETE:

	DELETE FROM Borrowers
	WHERE BorrowerID = 2;
```

```sql
	-- CRUD Operations Loans

	-- CREATE: 

	INSERT INTO Loans (LoanDate, DueDate, ReturnDate, BookID, BorrowerID) VALUES ('2024-10-18', '2024-11-18', NULL, 1, 2);

	-- READ:

	SELECT * FROM Loans;

	-- UPDATE:

	UPDATE Loans SET ReturnDate = '2024-10-25' WHERE LoanID = 2;

	-- DELETE: 

	DELETE FROM Loans WHERE LoanID = 3;
```

 
 b) Implementera minst två vyer (Views) som kombinerar data från flera tabeller.  
    **Store procedure är inte med i uppgiften**


    
7. Avancerade frågor:  
    a) Skriv en SQL-fråga som använder JOIN för att hämta data från minst tre tabeller.
   ``
    b) Implementera en fråga som använder en subquery.  
    c) Skapa en fråga som använder GROUP BY och HAVING för att analysera data.
    
9. Säkerhet:  
    a) Beskriv hur du skulle implementera en enkel inloggningsfunktion för bibliotekssystemet. Vilka säkerhetsaspekter bör du ta hänsyn till?  
    b) Förklara vad prepared statements är och varför de är viktiga för säkerheten i databasapplikationer. Ge ett exempel på hur de kan användas.  
    c) Identifiera och beskriv minst 1 vanlig attackvektorer mot databaser. Hur kan man skydda sig mot dessa?
    
10. Analys och reflektion: a) Analysera din databasdesign och identifiera potentiella förbättringsområden.  
    b) Reflektera över dina designval och motivera dem.
    
11. Dokumentation: a) Skriv en kort rapport som beskriver din databasstruktur, designval och implementering.  
    b) Inkludera instruktioner för hur man skapar och populerar databasen.  
    c) Inkludera SQL-skript för att skapa och populerar databasen samt beskriv vad varje skript gör.

    ```sql
   	CREATE DATABASE Library; 

		USE Library;

	CREATE TABLE Books (
		BookID INT AUTO_INCREMENT PRIMARY KEY,
		Author TEXT NOT NULL,
		Title TEXT NOT NULL,
		PublicationYear INT NOT NULL,
		ISBN TEXT NOT NULL
	);


	CREATE TABLE Borrowers (
		BorrowerID INT AUTO_INCREMENT PRIMARY KEY,
		Name TEXT NOT NULL,
		Email TEXT NOT NULL,
		PhoneNum TEXT NOT NULL
	);

	CREATE TABLE Loans (
		LoanID INT AUTO_INCREMENT PRIMARY KEY,
		LoanDate DATE NOT NULL,
		DueDate DATE NOT NULL,
		ReturnDate DATE,
		BookID INT NOT NULL,
		BorrowerID INT NOT NULL,
		FOREIGN KEY (BookID) REFERENCES Books(BookID),
		FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
	);
	-- Populate the Books table
	INSERT INTO Books (Author, Title, PublicationYear, ISBN)
	VALUES ('Stephen King', 'The Shining', 1977, '978-0-385-12167-6'), 
	('Stephen King', 'It', 1986, '978-0-670-81302-5'),
	('Stephen King', 'Misery', 1987, '978-0-0670-81364-3'),
	('Stephen King', '11/22/63', 2011, '978-1-4516-2728-2'),
	('Stephen King', 'Doctor Sleep', 2013, '978-1-4767-2765-3'),
	('Stephen Fry', 'The Liar', 1991, '978-0-099-13572-2'),
	('Stephen Fry', 'Mythos: The Greek Myths Retold', 2017, '978-0-718-18518-6'),
	('James P. Hogan', 'Inherit the Stars', 1977, '978-0-345-25434-8'),
	('James P. Hogan', 'The Genesis Machine', 1978, '978-0-345-26040-0'),
	('James P. Hogan', 'The Two Faces of Tomorrow', 1979, '978-0-671-25012-8'),
	('Neil Gaiman', 'American Gods', 2001, '978-0-380-97365-1'),
	('Andy Weir', 'The Martian', 2011, '978-0-8041-3902-1'),
	('J.R.R. Tolkien', 'The Hobbit', 1937, '978-0-618-00221-3'),
	('Herman Melville', 'Moby-Dick', 1851, '978-0-14-243724-7');

	-- Populate the Borrowers table
	INSERT INTO Borrowers (Name, Email, PhoneNum)
	VALUES ('Erik Eriksson', 'erik@eriksson.com', '123333432'),
	('Anna Annadotter', 'anniiizzzz@hetmail.se', '234435555'),
	('Tjorvar Nilsson', 'tjorven_cool@mailerz.se', '43556234'),
	('Aarto Saari', 'sk8aarto@flip.com', '666666'),
	('Stephen Fry', 'stephen.fry@podcast.com', '23200');

	-- Populate the Loans table

	INSERT INTO Loans (LoanDate, DueDate, ReturnDate, BookID, BorrowerID)
	VALUES ('2024-10-11', '2024-11-11', NULL, 7, 5),
	('2024-10-14', '2024-11-14', NULL, 4, 3),
	('2024-09-23', '2024-10-23', '2024-10-03', 9, 1),
	('2024-10-15', '2024-11-15', NULL, 1, 4),
	('2024-10-02', '2024-11-02', '2024-10-13', 13, 2);

```

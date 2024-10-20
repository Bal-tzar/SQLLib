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

 ```sql
	
    -- Create view for current loans

	CREATE VIEW CurrentLoans AS
	SELECT Books.BookID, Books.Title, Loans.LoanDate, Loans.DueDate, Borrowers.Name AS Borrower
	FROM Books
	JOIN Loans ON Books.BookID = Loans.BookID
	JOIN Borrowers ON Loans.BorrowerID = Borrowers.BorrowerID
	WHERE Loans.ReturnDate IS NULL;


	-- Create view for loans that are overdue

	CREATE VIEW OverdueLoans AS 
	SELECT Loans.LoanID, Books.Title, Borrowers.Name AS Borrower, Loans.DueDate
	FROM Loans
	INNER JOIN Books ON Loans.BookID = Books.BookID
	INNER JOIN Borrowers ON Loans.BorrowerID = Borrowers.BorrowerID
	WHERE Loans.ReturnDate IS NULL AND Loans.DueDate < CURRENT_DATE;
```


    
7. Avancerade frågor:  
    a) Skriv en SQL-fråga som använder JOIN för att hämta data från minst tre tabeller.
   ```sql
   	-- Join data from three tables to get loan details

	SELECT Loans.LoanID, Books.Title, Borrowers.Name AS Borrower, Loans.LoanDate, Loans.DueDate
	FROM Loans
	INNER JOIN Books ON Loans.BookID = Books.BookID
	INNER JOIN Borrowers ON Loans.BorrowerID = Borrowers.BorrowerID;
   ```

    b) Implementera en fråga som använder en subquery.
	```sql
 	-- Using subquery to find all borrowers who have borrowed 'The Shining'

	SELECT Name, Email
	FROM Borrowers
	WHERE BorrowerID IN ( 
		SELECT BorrowerID 
		FROM Loans 
		WHERE BookID = (
			SELECT BookID 
			FROM Books 
			WHERE Title = 'The Shining' 
		) 
	);
 	```
 
    c) Skapa en fråga som använder GROUP BY och HAVING för att analysera data.
   ```sql
   -- Count the number of loans each borrower has made and filter borrowers with more than one loan

	SELECT Borrowers.Name, COUNT(Loans.LoanID) AS LoanCount
	FROM Borrowers
	INNER JOIN Loans ON Borrowers.BorrowerID = Loans.BorrowerID
	GROUP BY Borrowers.Name
	HAVING COUNT(Loans.LoanID) > 1;
   ```

    
9. Säkerhet:  
    a) Beskriv hur du skulle implementera en enkel inloggningsfunktion för bibliotekssystemet. Vilka säkerhetsaspekter bör du ta hänsyn till?

	För att göra en inloggningsfunktion skulle jag låta användaren först skapa ett konto med användarnamn och lösenord. Användarens credentials sparas i en lista
	för att kunna jämföra vid senare inloggningsförsök. För att skydda inloggningsuppgifterna måste dessa krypteras så att de inte är i plain text.
	
    b) Förklara vad prepared statements är och varför de är viktiga för säkerheten i databasapplikationer. Ge ett exempel på hur de kan användas.

   	Ett prepared statement är en återanvändbar SQL-fråga för att till exempel låta en användare logga in på servern. 
	Prepared statements är viktiga eftersom det gör programmet mer effektivt, men också mer säkert genom att användaren inte
	kommer kunna ändra på SQL-frågan, utan endast på vissa förbestämda värden som till exempel lösenord och användarnamn.

    c) Identifiera och beskriv minst 1 vanlig attackvektorer mot databaser. Hur kan man skydda sig mot dessa?

   	En vanlig attackvektor är en så kallad SQL-injection. Där en användare kan skriva in SQL-frågor i till exempel inloggsrutan. 
	Detta gör det möjligt att till exempel logga in på servern som admin, få reda på alla inloggningsuppgifter, eller droppa hela databasen. 
	För att skydda sig mot en SQL-injection är det viktigt att använda sig av prepared statements, för att inte ge användaren för mycket frihet när hen matar in data i textrutorna. 
    
11. Analys och reflektion:
    a) Analysera din databasdesign och identifiera potentiella förbättringsområden.
	Min databasdesign är möjligtvis ganska simpel, och något noobig. Jag tror att med tiden kommer jag lära mig fler och bättre sätt att hantera data på. 
	Det kanske finns smidigare sätt att joina tabeller eller kanske bättre sätt att skapa en VIEW för att se om någon inte har lämnat tillbaka sitt lån i tid.

    b) Reflektera över dina designval och motivera dem.
	Jag valde att designa databasen på sättet jag gjorde det eftersom det är så jag har lärt mig göra det. Jag valde att ha FKs i Loans-tabellen eftersom det är mest logiskt att samla datan från
	Borrowers och Books där. En Borrower skapar ett nytt lån på en Book när hen lånar ut boken. Loans-tabellen är som bibliotiekarien som håller koll på vem som har lånat vad och när. 
	För att komma fram till designvalen tog jag hjälp av föreläsningsmaterial, ChatGPT och w3schools.com. Jag har lagt extra tid på att försöka förstå varför man göra vissa saker och i vilken ordning.  
    
13. Dokumentation: a) Skriv en kort rapport som beskriver din databasstruktur, designval och implementering.  
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

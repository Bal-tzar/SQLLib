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
```
    
5. Datamanipulation:  
    a) Skriv SQL-frågor för att utföra CRUD-operationer (Create, Read, Update, Delete) på alla tabeller.  
    b) Implementera minst två vyer (Views) som kombinerar data från flera tabeller.  
    **Store procedure är inte med i uppgiften**
    
6. Avancerade frågor:  
    a) Skriv en SQL-fråga som använder JOIN för att hämta data från minst tre tabeller.  
    b) Implementera en fråga som använder en subquery.  
    c) Skapa en fråga som använder GROUP BY och HAVING för att analysera data.
    
7. Säkerhet:  
    a) Beskriv hur du skulle implementera en enkel inloggningsfunktion för bibliotekssystemet. Vilka säkerhetsaspekter bör du ta hänsyn till?  
    b) Förklara vad prepared statements är och varför de är viktiga för säkerheten i databasapplikationer. Ge ett exempel på hur de kan användas.  
    c) Identifiera och beskriv minst 1 vanlig attackvektorer mot databaser. Hur kan man skydda sig mot dessa?
    
8. Analys och reflektion: a) Analysera din databasdesign och identifiera potentiella förbättringsområden.  
    b) Reflektera över dina designval och motivera dem.
    
9. Dokumentation: a) Skriv en kort rapport som beskriver din databasstruktur, designval och implementering.  
    b) Inkludera instruktioner för hur man skapar och populerar databasen.  
    c) Inkludera SQL-skript för att skapa och populerar databasen samt beskriv vad varje skript gör.

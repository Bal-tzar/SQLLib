-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Värd: mysql_container
-- Tid vid skapande: 15 okt 2024 kl 10:19
-- Serverversion: 9.0.1
-- PHP-version: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databas: `Library`
--

-- --------------------------------------------------------

--
-- Tabellstruktur `Books`
--

CREATE TABLE `Books` (
  `BookID` int NOT NULL,
  `Title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Author` text NOT NULL,
  `PublicationYear` int NOT NULL,
  `ISBN` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumpning av Data i tabell `Books`
--

INSERT INTO `Books` (`BookID`, `Title`, `Author`, `PublicationYear`, `ISBN`) VALUES
(1, 'The Shining', 'Stephen King', 1977, '978-0-385-12167-6'),
(2, 'It', 'Stephen King', 1986, '978-0-670-81302-5'),
(3, 'Misery', 'Stephen King', 1987, '978-0-0670-81364-3'),
(4, '11/22/63', 'Stephen King', 2011, '978-1-4516-2728-2'),
(5, 'Doctor Sleep', 'Stephen King', 2013, '978-1-4767-2765-3'),
(6, 'The Liar', 'Stephen Fry', 1991, '978-0-099-13572-2'),
(7, 'Mythos: The Greek Myths Retold', 'Stephen Fry', 2017, '978-0-718-18518-6'),
(8, 'Inherit the Stars', 'James P. Hogan', 1977, '978-0-345-25434-8'),
(9, 'The Genesis Machine', 'James P. Hogan', 1978, '978-0-345-26040-0'),
(10, 'The Two Faces of Tomorrow', 'James P. Hogan', 1979, '978-0-671-25012-8'),
(11, 'American Gods', 'Neil Gaiman', 2001, '978-0-380-97365-1'),
(12, 'The Martian', 'Andy Weir', 2011, '978-0-8041-3902-1'),
(13, 'The Hobbit', 'J.R.R. Tolkien', 1937, '978-0-618-00221-3'),
(14, 'Moby-Dick', 'Herman Melville', 1851, '978-0-14-243724-7');

-- --------------------------------------------------------

--
-- Tabellstruktur `Borrowers`
--

CREATE TABLE `Borrowers` (
  `BorrowerID` int NOT NULL,
  `Name` text NOT NULL,
  `PhoneNum` int NOT NULL,
  `Email` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumpning av Data i tabell `Borrowers`
--

INSERT INTO `Borrowers` (`BorrowerID`, `Name`, `PhoneNum`, `Email`) VALUES
(1, 'Erik Eriksson', 123333432, 'erik@eriksson.com'),
(2, 'Anna Annadotter', 234435555, 'anniiizzzz@hetmail.se'),
(3, 'Tjorvar Nilsson', 43556234, 'tjorven_cool@mailerz.se'),
(4, 'Aarto Saari', 666666, 'sk8aarto@flip.com'),
(5, 'Stephen Fry', 23200, 'stephen.fry@podcast.com');

-- --------------------------------------------------------

--
-- Tabellstruktur `Loans`
--

CREATE TABLE `Loans` (
  `LoanID` int NOT NULL,
  `LoanDate` date NOT NULL,
  `DueDate` date NOT NULL,
  `ReturnDate` date DEFAULT NULL,
  `BorrowerID` int NOT NULL,
  `BookID` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `Books`
--
ALTER TABLE `Books`
  ADD PRIMARY KEY (`BookID`);

--
-- Index för tabell `Borrowers`
--
ALTER TABLE `Borrowers`
  ADD PRIMARY KEY (`BorrowerID`);

--
-- Index för tabell `Loans`
--
ALTER TABLE `Loans`
  ADD PRIMARY KEY (`LoanID`),
  ADD KEY `BorrowerID` (`BorrowerID`),
  ADD KEY `BookID` (`BookID`);

--
-- AUTO_INCREMENT för dumpade tabeller
--

--
-- AUTO_INCREMENT för tabell `Books`
--
ALTER TABLE `Books`
  MODIFY `BookID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT för tabell `Borrowers`
--
ALTER TABLE `Borrowers`
  MODIFY `BorrowerID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT för tabell `Loans`
--
ALTER TABLE `Loans`
  MODIFY `LoanID` int NOT NULL AUTO_INCREMENT;

--
-- Restriktioner för dumpade tabeller
--

--
-- Restriktioner för tabell `Loans`
--
ALTER TABLE `Loans`
  ADD CONSTRAINT `Loans_ibfk_1` FOREIGN KEY (`BorrowerID`) REFERENCES `Borrowers` (`BorrowerID`),
  ADD CONSTRAINT `Loans_ibfk_2` FOREIGN KEY (`BookID`) REFERENCES `Books` (`BookID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

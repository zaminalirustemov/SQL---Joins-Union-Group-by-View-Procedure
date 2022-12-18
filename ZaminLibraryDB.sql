CREATE DATABASE ZaminLibrary

USE ZaminLibrary

CREATE TABLE Authors
(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(60) NOT NULL,
	Surname NVARCHAR(60) NOT NULL,
)

CREATE TABLE Books
(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(100) NOT NULL,
	PageCount INT NOT NULL,
	AuthorId INT FOREIGN KEY (AuthorId) REFERENCES Authors(Id)
)

INSERT INTO Authors
VALUES
('Fyodor Mixayloviç', 'Dostoyevski'),
('Fridrix', 'Nitsşe'),
('Mümin', 'Sekman'),
('Çingiz', 'Abdullayev'),
('Hikmet Anıl', 'Öztekin'),
('Aqata', 'Kristi')

INSERT INTO Books
VALUES
('Qumarbaz',175,1),
('Gizlindən Qeydlər',200,1),
('Zərdüşt belə deyirdi',448,2),
('Hər şey səninlə başlar',328,3),
('Davamlı öyrən',184,3),
('Fərdi ətalətlə mübarizə',160,3),
('Ümid külü',448,4),
('Ne İçin Varsan Onun İçin Yaşa',264,5),
('Əlifba sırası ilə qətl',255,6),
('Masadaki kartlar',300,6),
('On üç müəmma',312,6),
('Üç Pərdəli Faciə',248,6)

CREATE VIEW AuthorFullName
AS
(SELECT Name +' '+ Surname AS FullName FROM Authors )


CREATE VIEW vw_BooksInfo
AS
(
	SELECT B.Id,B.Name,B.PageCount,A.Name+' '+A.Surname AS FullName FROM Books AS B
	JOIN Authors AS A
	ON B.AuthorId=A.Id
)

CREATE PROCEDURE USP_FilteredBooks @value nvarchar(100)
AS
SELECT * FROM vw_BooksInfo 
WHERE vw_BooksInfo.Name like '%'+ @value+'%'
OR vw_BooksInfo.FullName like '%'+ @value+'%'

EXEC USP_FilteredBooks @value='da'


CREATE VIEW vw_AuthorInfo
AS
(
	SELECT vw_BooksInfo.FullName,COUNT(vw_BooksInfo.FullName)AS 'Books Count', MAX(vw_BooksInfo.PageCount) AS 'Max Page Count' FROM vw_BooksInfo
	GROUP BY vw_BooksInfo.FullName
)
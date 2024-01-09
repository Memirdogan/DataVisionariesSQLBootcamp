--------------------------------- --minimum �� ili�kili tablo olucak
------------TRIGGERS------------- --mant�kl� bir tane g�zel bir sorgu yazmal�y�z
--------------------------------- --pdf dosyas� ve raporlama ve sunumda kodlar haz�r olucak kodlar� yap��t�r�p anlat�az 7 dakika 3 tablo veritaban� de�il
--trigger tetikleyicidir          --ben bunu bunu yapt�m �unu yaz�yorum bu kodun mant��� bu bu �ekilde tetikleniyor 
insert into Students(name,email)   --veritaban�ndaki tablolar� d�zg�n ay�rmak rastgele veriler ct veya haftaya sal�
values('mahmut','musimusi') --@ i�areti olmad��� i�in hata verdi alttaki kod
---
CREATE TRIGGER trg_ValidateEmail --yeni kullan�c� kayd�nda e�er ki i�erisinde @ i�areti olmayan mail girilirse hata ver ve rollback �al��t�r
on Students --trigger stydent tablosunda olu�sun students tablosu tetikleyici olsun
after insert --yeni kay�t ekleme i�leminden sonra �al��t�r
as
begin 
	declare @StudentID int, @Email nvarchar(100)
	select @StudentID = StudentID, @Email = Email from inserted--�NSERTED?? hangi i�lemi neden yap�yosun --VAL�DASYON NE?
	IF (@Email NOT LIKE '%@%') --trigger mailin i�inde @ i�areti yoksa �al���cak
	begin	
		raiserror('Ge�ersiz E-Posta adresi',16,1)
		rollback transaction --kayd� iptal edicek ger�ekle�tirmiycek
	end
end
---------------------------------
------------FONKSION-------------
---------------------------------
CREATE FUNCTION GetAverageEnrollmentDateForCourse(    @courseID int)RETURNS dateASBEGIN    DECLARE @averageDate date    DECLARE @totalDays int        SELECT @totalDays = SUM(DATEDIFF(day, '19000101', EnrollmentDate))    FROM Enrollments    WHERE CourseID = @courseID           SELECT @averageDate = DATEADD(day, @totalDays / NULLIF(COUNT(*), 0), '19000101')    FROM Enrollments    WHERE CourseID = @courseID    RETURN @averageDateEND --kurs kay�t olma tarihi ortalamas�
-------------------------------
declare @count int
set @count = dbo.Setcoursecount(1)
print 'bu ��renci �u kadar kursa kat�lm��: ' + cast(@count as nvarchar(10))
-- atama yaparak fonksiyonu kullanma algoritmas�
-------------------------------------
create function Ogrencilistesi()
returns table -- �nemli k�s�m bu table fonksiyon table d�nd�r�r
...
..
.
------------------------------------
--databaseowner a��l�m� DBO
--fonksiyonlarda d�n�� de�eri bekleriz ama prosed�rlerde d�n�� de�eri olmasa da olur
--basit i�lemlerde fonksiyon daha kapsaml� kapsaml� i�lemlerde prosed�r kullan�l�r
--�a��rma y�ntemleri farkl�d�r biri select di�eri exec
--i�leme yetkisi veri manipilasyonu ve i�lem yapma yetkileri prosed�rlerde kullan�l�r
------------------------------------
select dbo.Toplama(15,5) as Sonuc

CREATE FUNCTION Toplama( --Toplama fonksiyonu olu�turuyoruz 
	@say�1 int, --fonksiyonda �a��rd���m�zda neler g�ndericez parametre olarak onu tan�t�yoruz
	@say�2 int
)
RETURNS INT --bu fonksiyon bize return vermesi istiyoruz bu y�zden
BEGIN
	DECLARE @SONUC INT
	SET @SONUC = @say�1 + @say�2
	return @SONUC
END
--------------------------------------
------------PROSED�RLER---------------
--fore�gn keylerde delete conflicte sebep olur hata al�r�z 
--prosed�r kullan�m�
exec AddCourse @Name = 'Ahmet', @Email = 'ahmetkaya@gmail.com' 
exec prosed�rad� --prosed�r� �a���rma
--------------------------------------
create procedure UpdateCourseInfo
	@CourseID int,
	@CourseName nvarchar(50),
	@Instructor nvarchar(50),
	@Description nvarchar(255)
as
begin
	update Courses
	set CourseName = @CourseName, Instructor = @Instructor, Description = @Description
	where CourseID = @CourseID
end
--------------------------------------
create procedure UpdateStudentInfo
	@StudentID int,
	@Name nvarchar(50),
	@Email nvarchar(100)
as
begin
	update Students
	set Name = @Name, Email = @Email
	where @StudentID = @StudentID
end
--------------------------------------
create procedure AddCourse
	@CourseName nvarchar(50),
	@Instructor nvarchar(50),
	@Description nvarchar(50)
as
begin
	insert into Courses(CourseName, Instructor, Description)
	values (@CourseName,@Instructor,@Description)
end
--------------------------------------
create procedure AddStudent
	@Name nvarchar(50),
	@Email nvarchar(100)
as
begin
	insert into Students(Name, Email)
	values (@Name,@Email)
end
--------------------------------------
create procedure InsertedEnrollment --prosed�r olu�turma ve ad�n� koyma
	@StudentID int,
	@CourseID int,
	@EnrollmentDate date
as
begin --i�ine girdik
	insert into Enrollments(StudentID,CourseID,EnrollmentDate)
	values (@StudentID,@CourseID,@EnrollmentDate)--girilen insert de�erlerinin olu�turdu�umuz prosed�rde nelere denk geliyo onlar� girdik
end
--------------------------------------
create table Students(
 StudentID int primary key identity,
 Name nvarchar(50),
 Email nvarchar(100)
)
create table Courses(
 CourseID int primary key identity,
 CourseName nvarchar(50),
 Instructor nvarchar(50),
 Description nvarchar(255)
)
create table Enrollments(
 EnrollmentID int primary key identity,
 StudentID int,
 CourseID int,
 EnrollmentDate date,
 foreign key (StudentID) references Students(StudentID),
 foreign key (CourseID) references Courses(CourseID)
)
*/
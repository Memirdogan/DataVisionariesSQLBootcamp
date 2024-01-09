--------------------------------- --minimum üç iliþkili tablo olucak
------------TRIGGERS------------- --mantýklý bir tane güzel bir sorgu yazmalýyýz
--------------------------------- --pdf dosyasý ve raporlama ve sunumda kodlar hazýr olucak kodlarý yapýþtýrýp anlatçaz 7 dakika 3 tablo veritabaný deðil
--trigger tetikleyicidir          --ben bunu bunu yaptým þunu yazýyorum bu kodun mantýðý bu bu þekilde tetikleniyor 
insert into Students(name,email)   --veritabanýndaki tablolarý düzgün ayýrmak rastgele veriler ct veya haftaya salý
values('mahmut','musimusi') --@ iþareti olmadýðý için hata verdi alttaki kod
---
CREATE TRIGGER trg_ValidateEmail --yeni kullanýcý kaydýnda eðer ki içerisinde @ iþareti olmayan mail girilirse hata ver ve rollback çalýþtýr
on Students --trigger stydent tablosunda oluþsun students tablosu tetikleyici olsun
after insert --yeni kayýt ekleme iþleminden sonra çalýþtýr
as
begin 
	declare @StudentID int, @Email nvarchar(100)
	select @StudentID = StudentID, @Email = Email from inserted--ÝNSERTED?? hangi iþlemi neden yapýyosun --VALÝDASYON NE?
	IF (@Email NOT LIKE '%@%') --trigger mailin içinde @ iþareti yoksa çalýþýcak
	begin	
		raiserror('Geçersiz E-Posta adresi',16,1)
		rollback transaction --kaydý iptal edicek gerçekleþtirmiycek
	end
end
---------------------------------
------------FONKSION-------------
---------------------------------
CREATE FUNCTION GetAverageEnrollmentDateForCourse(    @courseID int)RETURNS dateASBEGIN    DECLARE @averageDate date    DECLARE @totalDays int        SELECT @totalDays = SUM(DATEDIFF(day, '19000101', EnrollmentDate))    FROM Enrollments    WHERE CourseID = @courseID           SELECT @averageDate = DATEADD(day, @totalDays / NULLIF(COUNT(*), 0), '19000101')    FROM Enrollments    WHERE CourseID = @courseID    RETURN @averageDateEND --kurs kayýt olma tarihi ortalamasý
-------------------------------
declare @count int
set @count = dbo.Setcoursecount(1)
print 'bu öðrenci þu kadar kursa katýlmýþ: ' + cast(@count as nvarchar(10))
-- atama yaparak fonksiyonu kullanma algoritmasý
-------------------------------------
create function Ogrencilistesi()
returns table -- önemli kýsým bu table fonksiyon table döndürür
...
..
.
------------------------------------
--databaseowner açýlýmý DBO
--fonksiyonlarda dönüþ deðeri bekleriz ama prosedürlerde dönüþ deðeri olmasa da olur
--basit iþlemlerde fonksiyon daha kapsamlý kapsamlý iþlemlerde prosedür kullanýlýr
--çaðýrma yöntemleri farklýdýr biri select diðeri exec
--iþleme yetkisi veri manipilasyonu ve iþlem yapma yetkileri prosedürlerde kullanýlýr
------------------------------------
select dbo.Toplama(15,5) as Sonuc

CREATE FUNCTION Toplama( --Toplama fonksiyonu oluþturuyoruz 
	@sayý1 int, --fonksiyonda çaðýrdýðýmýzda neler göndericez parametre olarak onu tanýtýyoruz
	@sayý2 int
)
RETURNS INT --bu fonksiyon bize return vermesi istiyoruz bu yüzden
BEGIN
	DECLARE @SONUC INT
	SET @SONUC = @sayý1 + @sayý2
	return @SONUC
END
--------------------------------------
------------PROSEDÜRLER---------------
--foreýgn keylerde delete conflicte sebep olur hata alýrýz 
--prosedür kullanýmý
exec AddCourse @Name = 'Ahmet', @Email = 'ahmetkaya@gmail.com' 
exec prosedüradý --prosedürü çaðüýrma
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
create procedure InsertedEnrollment --prosedür oluþturma ve adýný koyma
	@StudentID int,
	@CourseID int,
	@EnrollmentDate date
as
begin --içine girdik
	insert into Enrollments(StudentID,CourseID,EnrollmentDate)
	values (@StudentID,@CourseID,@EnrollmentDate)--girilen insert deðerlerinin oluþturduðumuz prosedürde nelere denk geliyo onlarý girdik
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
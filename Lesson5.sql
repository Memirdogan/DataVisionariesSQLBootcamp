-------------------------------------------
DECLARE @dersid INT = 1

IF NOT EXISTS (SELECT 1 FROM Dersler WHERE DersID = @dersid)
BEGIN
    WAITFOR DELAY '00:00:05'

    INSERT INTO Dersler (DersID, Dersadı, OgretmenID) VALUES (@dersid, 'matematik', 1)
    PRINT 'ders eklendi'
END
ELSE
BEGIN
    PRINT 'ders mevcut'
END
-----------------------------------
declare @counter int = 1
declare @MaxCount int

select @MaxCount = COUNT(*) from Ogrenciler

while @counter <= @MaxCount
begin
	declare @adı nvarchar(50), @soyadı nvarchar(50), @sınıfı nvarchar(50), @notu int
	select @adı = adı, @soyadı = soyadı, @sınıfı = sınıfı, @notu = notu
	from Ogrenciler where OgrenciID = @counter

	if @notu >= 70
		print @adı + ' ' + @soyadı + ' dersi geçti'
	else
		print @adı + ' ' + @soyadı + ' dersten kaldı'

	set @counter = @counter + 1
end
---------------------------------------
declare @counter int = 1
declare @MaxCount int
select @MaxCount = COUNT(*) from Dersler

while @counter <= @MaxCount
begin
 declare @OgretmenID int
 declare @DersAdı nvarchar(50)

 select @OgretmenID = OgretmenID, @DersAdı = DersAdı from Dersler where DersID = @counter
 declare @OgretmenAdı nvarchar(50)
 select @OgretmenAdı = Adı + ' ' + Soyadı from Ogretmenler where OgretmenID = @OgretmenID

 print 'Öğretmen ' +@OgretmenAdı + ' ' + @DersAdı + ' dersini veriyor.'

 set @counter = @counter + 1

 end
---------------------------------------
select * from Ogrenciler 
GO

select * from dersler
go
--------------------------------------
declare @counter int = 1

while @counter <= 5
begin-- while begini
	if @counter = 3
	begin -- if begini
		set	@counter = @counter + 1
		continue
	end -- if endi

	print 'counter değeri : ' + cast(@counter as nvarchar)
	set @counter = @counter + 1
end -- while endi
-------------------------------------
declare @ogrenciıd int = 1
declare @ortalama int

while @ogrenciıd <= (select MAX(OgrenciID) from Ogrenciler)
begin
	select @ortalama = AVG(Notu) from Ogrenciler
	where OgrenciID = @ogrenciıd

	if @ortalama >= 70
		print 'öğrenci ID: ' + cast(@ogrenciıd as nvarchar) + ' başarılı'
	set @ogrenciıd = @ogrenciıd + 1
	end
------------------------------------
declare @counter int = 1

while @counter <= 5
begin
	print 'sayaç değeri: ' + cast(@counter as nvarchar)
	set @counter = @counter + 1
end
-------------------------------------
declare @ogrenciıd int
set @ogrenciıd = 2

declare @basarıdurumu nvarchar(20)

if(select notu from Ogrenciler where OgrenciID = @ogrenciıd) >= 70
	set @basarıdurumu = 'basarılı'
else
	set @basarıdurumu = 'basarısız'

select @basarıdurumu as 'basarıdurumu'
------------------------------------------
update Ogrenciler
set Notu =  CASE
	WHEN OgrenciID = 1 THEN 85 --WHEN İLE KOŞUL BELİRTİLİR ÖĞRENCİID 1 İSE THEN GERÇEKLEŞİRSE DEMEK THEN 85 ATA
	WHEN OgrenciID = 2 THEN 60
	WHEN OgrenciID = 3 THEN 75
	else null
	end
------------------------------------------
declare @durum int --int türünde durum adında değişken
set @durum = 75 --durum değişkenine değer atadık
if @durum >= 70 --bildiğimiz if else
	select 'başarılı' as durum
else if
	select 'orta' as durum
else
	select 'başarısız' as durum
--------------------------------------
declare @SilinenÖğrenciler table (OgrenciID int, adı nvarchar(50),soyadı nvarchar(50))

delete from Ogrenciler

output deleted.OgrenciID, deleted.adı, deleted.soyadı into @SilinenÖğrenciler --inser delete update gibi veritabanını etkileyen şeylerde yapılan değişikliklerin sonuçlarını ekrana yazdırır
where Sınıfı = '12A'
--deleted. kısmı takma ad oraya inserted vs de yazabilirsin
select * from @SilinenÖğrenciler --normalde delete işleminde sucsess yazardı ama bu output sayesinde yapılan işlemi görebiliyoruz
----------------------------------------
DECLARE @YeniOgrenciID table(ID int)

insert into Ogrenciler(Adı,Soyadı,Sınıfı)
output INSERTED.OgrenciID into @YeniOgrenciID
VALUES ('Ahmet','karalar','12A')


select * from @YeniOgrenciID*/
--------------------------------------------
Declare @ToplamÖğrenci int --int türünde değişken tanımladık

Select @ToplamÖğrenci = Count(*) from Ogrenciler --tanıdığımız değişkene değer atadık

Select 'Toplam Öğrenci Sayısı: ' + CAST(@ToplamÖğrenci as nvarchar) --ekrana yazı yazdırıyoruz ve toplam öğrenci değişkenini nvarchar olarak yazdırıyoruz CAST değişleni cast etmemize yarar

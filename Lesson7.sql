--11.01.2024 TEKRAR ÝZLENCEK--
------------------------------
-------------HASH-------------
------------------------------
declare @counter int
declare @KullaniciID int

set @counter = 0

while @counter < 100000
begin
 set @KullaniciID =(case when @counter % 4 = 0 then 1
       when @counter % 4 = 1 then 2
       when @counter % 4 = 2 then 3
       when @counter % 4 = 3 then 4     
      end)
 insert into Siparisler (SiparisID,KullaniciID,UrunAdi,Miktar,Tarih)
 values
  (NEWID(),@KullaniciID, 'Urun' + CAST(@counter + 1 as varchar(100)),FLOOR(RAND()*10) + 1, DATEADD(DAY,FLOOR(RAND()*365),'2024-01-01'))
 set @counter = @counter + 1
end
-----------------------------
declare @counter int
set @counter = 0
while @counter < 10000
begin
 declare @kullaniciID int
 set @kullaniciID = FLOOR(RAND()*10000) + 1 --1 ÝLE 10K ARASINDA DEGER ALIYO

 insert into Siparisler(SiparisID,KullaniciID,UrunAdi,Miktar,Tarih)
 values
 (NEWID(),@kullaniciID,'Urun' + CAST(@counter + 1 as varchar(100)),FLOOR(RAND()*10)*1,DATEADD(DAY,FLOOR(rand()*365),'2023-01-01'))
 set @counter = @counter + 1
end --KULLANICIYA YAPTIÐIMIZ ÞEYÝ SÝPARÝÞLERE TYAPTIK 

declare @counter int
set @counter = 0
while @counter < 10000
begin
	insert into Kullanicilar111 (Ad,Soyad)
	values
	('Ad' + CAST(@counter + 1 AS VARCHAR(50) ) ,'Soyad' + CAST(@counter + 1 AS VARCHAR(50) ) )
	SET @counter = @counter +1
END 

create table Siparisler111(
	SiparisID Uniqueidentifier primary key, --Uniqueidentifier bensersiz tanýmlayýcý olarak geçer 16 karakter alýr hash rastgele oluþturulan benzersiz deðerler
	KullaniciID int,
	UrunAdi varchar(100),
	Miktar int,
	Tarih date,
	foreign key (KullaniciID) references [dbo].[Kullanicilar111](Ku11aniciID)
	)
---------------------------------
-------------view----------------
---------------------------------

SELECT * FROM vw_KullaniciAdresSemt

CREATE VIEW vw_KullaniciAdresSemt as --view oluþturma
select
K.ID as KullaniciID,
K.KULLANICI_ADI,
K.ADSOYAD,
K.EMAIL,
A.ACIKADRES,
S.SEMT
FROM 
KULLANICILAR K
JOIN ADRES A ON K.ID = A.KULLANICI_ID
JOIN SEMTLER S ON S.ID = A.SEMT_ID;
------------
SELECT * FROM VW_KullaniciAdres

CREATE VIEW VW_KullaniciAdres as --view oluþturma
select
K.ID as KullaniciID,
K.KULLANICI_ADI,
K.ADSOYAD,
K.EMAIL,
A.ULKE_ID,
A.IL_ID,
A.ILCE_ID,
A.SEMT_ID,
A.ACIKADRES
FROM KULLANICILAR K
INNER JOIN ADRES A ON K.ID = A.KULLANICI_ID;
--------------------------------
--ders 7 trigger orneklerini tekrar izle dk 42 falan

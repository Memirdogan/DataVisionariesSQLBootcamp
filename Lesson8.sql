create schema MySchema
create table Myschema.Kullanicilar(
	kullan�c��d int primary key,
	ad� varchar(50),
	soyad� varchar(50)
)
------------------------
---------INDEX----------
------------------------
CREATE INDEX �DX_SIPARISLER_KULLANICIID on sipari�ler(Kullan�c�ID)
CREATE INDEX �DX_SIPARISLER_tar�h on siparisler(Tarih) --olu�turma �ekli
--indexi guncellemek olu�turmak ile ayn� sey

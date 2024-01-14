create schema MySchema
create table Myschema.Kullanicilar(
	kullanýcýýd int primary key,
	adý varchar(50),
	soyadý varchar(50)
)
------------------------
---------INDEX----------
------------------------
CREATE INDEX ÝDX_SIPARISLER_KULLANICIID on sipariþler(KullanýcýID)
CREATE INDEX ÝDX_SIPARISLER_tarýh on siparisler(Tarih) --oluþturma þekli
--indexi guncellemek oluþturmak ile ayný sey

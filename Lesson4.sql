begin transaction;--işlemi başlatır

insert into orders (CustomerID,ProductID,Quantity)
values (1,1,5)
UPDATE Product set Price = Price - 1500 where ProductID = 1

rollback --iptal etme komutu

commit --veritabanına kalıcı olarak kaydeder
SELECT * FROM Product
--commit yapmazsak işlemimiz veritabanına asla kaydolmaz yani begin transaction komutu geçici olarak işlemi başlatır
--ve commitlersen gerçekleşecek olan işlemi gösterir
--bir tane ürün varsa ve sen sepetine eklediysen ürün stoktan kalkar
------------------
SELECT DepartmanID FROM employees
except --farklılıkları getirir --ekrana getirir
intersect --ortak noktalar --ekrana getirir
union / union all -- dıstınct gibi tablodaki tekrarlanan veriyi yok eder
--------------
SELECT C.CustomerID, C.NameSurname, SUM(P.Price * O.Quantity) as totalspend
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Product P on O.ProductID = P.ProductID
GROUP BY C.CustomerID, C.NameSurname
HAVING SUM(P.Price * O.Quantity) > 5000
--belirli bir miktardan çok alışveriş yapan kullanıcılar
--------
SELECT DepartmentName ,AVG(Salary) AS AverageSalary 
FROM Departments D JOIN Employees E on E.DepartmanID = D.DepartmanID
GROUP BY DepartmentName
HAVING AVG(E.Salary) > 20000
--her departmanın çalışanlarının maaş ortalaması
------------------------
HAVING --group bydan sonra kullanılır grupladığız veriler üzerine kullanılır

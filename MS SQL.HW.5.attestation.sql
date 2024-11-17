/* Задание 1: Создание таблицы и изменение данных
Создайте таблицу EmployeeDetails для хранения информации о
сотрудниках. 
Таблица должна содержать следующие столбцы:
● EmployeeID (INTEGER, PRIMARY KEY)
● EmployeeName (TEXT)
● Position (TEXT)
● HireDate (DATE)
● Salary (NUMERIC)
После создания таблицы добавьте в неё три записи с произвольными данными о
сотрудниках.*/

create TABLE EmployeeDetails
(EmployeeID INT Primary KEY
 ,EmployeeName TEXT
 ,Position TEXT
 ,HireDate DATE
 ,Salary NUMERIC);
 
INSERT INTO EmployeeDetails (employeeid, employeename, position, hiredate, salary)
VALUES (1, 'Mike', 'Senior', '2020-03-13', 100000)
,(2, 'Viktor', 'Middle', '2021-04-23', 75000)
,(3, 'Mikhail', 'Junior', '2023-09-25', 50000);

/*Задание 2: Создание представления
Создайте представление HighValueOrders для отображения всех заказов,
сумма которых превышает 10000. 
В представлении должны быть следующие столбцы:
● OrderID (идентификатор заказа),
● OrderDate (дата заказа),
● TotalAmount (общая сумма заказа, вычисленная как сумма всех Quantity *
Price).
Используйте таблицы Orders, OrderDetails и Products.*/

CREATE VIEW HighValueOrders AS
SELECT
	o.OrderID
    ,o.OrderDate
    ,SUM(od.Quantity * p.Price) as TotalAmount
from Orders o 
join OrderDetails od on od.OrderID = o.OrderID
join Products p on p.ProductID = od.ProductID
GROUP by o.OrderID, o.OrderDate
HAVING SUM(od.Quantity * p.Price) > 10000;

/*Задание 3: Удаление данных и таблиц
Удалите все записи из таблицы EmployeeDetails, где Salary меньше
50000. Затем удалите таблицу EmployeeDetails из базы данных.*/

-- согласно моим данным меньше 50000 зарплаты нет, соответственно выбрано другое значение
DELETE from EmployeeDetails
WHERE salary < 75000;

drop TABLE if EXISTS EmployeeDetails;

/*Задание 4: Создание хранимой процедуры
Создайте хранимую процедуру GetProductSales с одним параметром
ProductID. Эта процедура должна возвращать список всех заказов, в которых
участвует продукт с заданным ProductID, включая следующие столбцы:
● OrderID (идентификатор заказа),
● OrderDate (дата заказа),
● CustomerID (идентификатор клиента).*/

CREATE PROCEDURE EmployeeDetails (@productid INT) AS
BEGIN
SELECt
	o.orderid
    ,o.orderdate
    ,o.customerid
from Orders o 
JOIN OrderDetails od on od.OrderID = o.OrderID
WHERE od.ProductID = @productid
END;

-- пример использования процедуры
EXEC EmployeeDetails @productid = 25
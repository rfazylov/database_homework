use snet1509
insert into users (id, name, surname, email, phone, gender, birthday, hometown, photo_id, pass, created_at) values (1, 'Иван', 'Иванов', 'dkfj2@kl.kd', 233242314, 'm', '1990-03-27', 'Москва', null, 'jsdhfksjdhf', '2020-06-15');

insert users (name, surname, email, phone, gender, birthday, hometown, photo_id, pass) values('Aleta','Feeney','vergie.blanda@example.com',21374868,'m','1997-08-10','Lake Dejahland','3','0cdb151b0ca8ad3a00140d84d668b707')

insert into users values
(3,'Carleton','Kris','kiana.ebert@example.org',987987,'m','1985-01-30','Pricemouth','7','d859dd5934858754d6ecdb41776d4e23','1971-05-05 09:39:45')

insert into users (id, name, surname, email, phone, gender, birthday, hometown, photo_id, pass, created_at)  values
(6,'Devonte','Predovic','adella84@example.net',77543,'f','1983-06-30','West Kyle','8','b564d65d9dbd20c093881266dae5e96b','2013-02-07 04:52:57'),
(7,'Reta','Herzog','ova.runolfsdottir@example.org',1483320590,'f','1977-05-07','North Ebony','9','e3284f3a5cea45c49ee77ac1085a4e95','2010-10-26 04:10:39'),
(8,'Irwin','Koss','adeline73@example.com',78778,'m','1970-12-04','East Delphine','8','5149b5c95012a7885f4038f2b02b6ce9','1998-07-16 18:04:09'),
(9,'Bridgette','Willms','bpagac@example.net',19879021,'m','1983-01-24','Lake Yasminchester','1','ecebe139df03b70fd865fa431f8fdee9','1984-02-26 22:05:50'),
(10,'Rachael','Dietrich','kendall82@example.com',532794,'m','2011-10-04','Herzogmouth','6','197f93e20021be933a824c6b269656b1','2015-01-09 19:55:00'),
(11,'Fidel','Runte','verlie82@example.org',9183749,'f','1976-01-13','Lake Shakira','8','df5c72ba8e9a4c2d1dbf3ba04fd18a74','2012-10-18 19:44:40'),
(12,'Beatrice','O\'Kon','remington.windler@example.com',987342,'f','1983-02-27','Predovichaven','9','5991af5f913172fe743797dc3d51535b','1990-10-15 11:15:09');

-- INSERT SET (когда нужна вствить одну строку и чтобы было видна что куда добавляется)

insert into users 
set
name='Роман', surname='Петров', email='petr@mnm.fj', phone='382746', gender='m', birthday='2011-10-04', hometown='Казань', pass='5991af5f913172fe743797dc3d51535b'


-- INSERT ... SELECT (Для добавления данных из др таблиц и др баз данных)

insert communities
select * from snet1.communities order by id; -- * - выбирает всю таблицу \ order by id asc(dsc) - сортировка по возрастанию(убыванию)

select * from communities;

set foreign_key_checks = 0; -- отключаем внеш ключи
truncate table users;
set foreign_key_checks = 1; -- включаем внеш ключи

insert into users select * from snet1.users; 

select name, surname, phone from users;

select * from users limit 10; -- выводит первые 10 
select * from users limit 10 offset 10; -- пропускает первые 10 и выводит следующие 10
select * from users limit 3 offset 8; -- 8 пропускает, 3 выбирает
select * from users limit 8,3; -- тоже самое, что и выше
select concat(surname, ' ', name) as person from users; -- выдает объединенные ячейки под назвнием person
select substring(name, 1,1) from users; -- выдает первую букву имени
select concat(substring(name, 1,1), '.', surname) from users;
select hometown from users;
select distinct hometown from users; -- список городов без повторений
select * from users where hometown = 'Челябинск'; -- пользовтаели из Челябинска
select name, surname, birthday from users where birthday >= '1985-01-01' order by birthday -- пользователи которые родились после 1984
select name, surname, birthday from users where birthday >= '1985-01-01' and birthday <= '1990-01-01'order by birthday -- между 1984 - 1990
select name, surname, birthday from users where birthday between '1985-01-01' and '1990-01-01' -- тоже самое что и сверху
select name, surname, hometown from users where hometown != 'Москва'; -- все кто не из Москвы
select name, surname, hometown from users where hometown <> 'Москва'; -- тоже самое что и сверху
select name, surname, hometown from users where hometown in ('Москва', 'Санкт-Петербург', 'Нижний Новгород'); -- все из трех городов
select name, surname, hometown, gender from users where (hometown = 'Москва' or hometown = 'Санкт-Петербург') and gender ='m'; -- нужно ставить скобки, иначе из-за приоретета логических операций результат будет не верен - выберет мужчин и женщин.
select name, surname, hometown from users where hometown = 'Москва' or hometown = 'Санкт-Петербург' or hometown = 'Нижний Новгород'; -- результат тотже что и сверху
select name, surname, hometown from users where hometown not in ('Москва', 'Санкт-Петербург', 'Нижний Новгород'); -- все кто не из этих городов
select name, surname from users where surname like 'Ки%'; -- все фамилии которые начниают на Ки. % - ноль или более значений. like - не зависит от регистра
select name, surname from users where surname like '%ко' order by surname; -- фамили которые заканчиваются на ко
select name, surname from users where surname like 'Ши_ко'; -- "_" один символ

-- агрегирующие функции:

select count(*) from users; -- сколько строк в таблице
select min(birthday) from users; -- дата рождения самого старшего польлзователя
select hometown, count(*) from users group by hometown; -- количество польлзователей из каждого города - группирует по городам и считает колическтво пользователей в группе
select hometown, count(*) from users group by hometown having count(*) >= '10' ; -- Города где кол-во пользователей >= 10 

-- UPDATE

update friend_requests
	set status = 'approved'
	where initiator_user_id = 1 and target_user_id = 2; -- меняем статус запроса на друзья на appruved. нужно обязательно добавлять where, иначе изменится вся таблица.

-- TRUNCATE

delete from communities where name = 'Биология клетки'; -- удаляет строку
delete from communities where id between '1' and '10'; -- удаляет строки с 1 по 10
delete from communities; -- удаляет всю таблиц. Но можно опять заполнить повторив команду выше: insert communities select * from snet1.communities  

insert communities (name)
select name from snet1.communities -- id начнеться с 31, так как при использовании delete при повторной вставке таблицы id запоминает прежние значения счетчик работает. delete - удаляет содержимое сторок(таблицы), но не сами строки(таблицу). Когда делаем TRUNCTE этого не происходит. id начется с 1. т.е. удаляется полностью - удаляет таблицу и пересоздает.

set foreign_key_checks = 0;
truncate table communities;
set foreign_key_checks = 1;





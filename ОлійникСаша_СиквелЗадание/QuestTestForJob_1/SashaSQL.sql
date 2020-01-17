--create database oa
go
use oa

IF OBJECT_ID(N'students', N'U') IS NOT NULL
alter table students drop constraint FK_id_book_tb_book
go
IF OBJECT_ID(N'students', N'U') IS NOT NULL
DROP TABLE students
IF OBJECT_ID(N'book', N'U') IS NOT NULL
DROP TABLE book


create table book (
	id_book int identity constraint PK_id_book Primary Key,
	name_book varchar(100),
	genre varchar(100),
	pages int,
	price decimal
)

create table students (
	id_student int identity constraint PK_id_sudent Primary Key,
	name_student varchar(100),
	id_book int, 
	date int,
	CONSTRAINT FK_id_book_tb_book Foreign Key (id_book) references book(id_book)
	on delete set null
)

insert into book values 
('InformaticForChild', 'Tech', 500, 100),
('InformaticForChild', 'Tech', 500, 100)

--select * from book
--select * from students
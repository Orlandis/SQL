CREATE DATABASE Archive
ON
   (NAME = Arch1,
    FILENAME = 'D:\SalesData\archdat1.mdf',
    SIZE = 10MB,
    MAXSIZE = 10)
LOG ON
  (NAME = Archlog1,
    FILENAME = 'D:\SalesData\archlog1.ldf',
    SIZE = 1MB,
    MAXSIZE = 1),
  (NAME = Archlog2,
    FILENAME = 'D:\SalesData\archlog2.ldf',
    SIZE = 1MB,
    MAXSIZE = 1);

	create table ArcTest (Num INT IDENTITY, Name VARCHAR(100), Age int)
	insert into ArcTest values ('Vasia', 21)
	select * from ArcTest
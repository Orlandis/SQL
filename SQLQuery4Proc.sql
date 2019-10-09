
   CREATE PROCEDURE TestProcedure 
   (
        --Входящие параметры
        @CategoryId INT,
        @ProductName VARCHAR(100),
        @Price MONEY = 0
   )
   AS
   BEGIN
        --Инструкции, реализующие Ваш алгоритм
        
        --Обработка входящих параметров
        --Удаление лишних пробелов в начале и в конце текстовой строки
        SET @ProductName = LTRIM(RTRIM(@ProductName));
        
        --Добавляем новую запись
        INSERT INTO TestTable(CategoryId, ProductName, Price)
                VALUES (@CategoryId, @ProductName, @Price)

        --Возвращаем данные
        SELECT * FROM TestTable
        WHERE CategoryId = @CategoryId
   END
  --***************************
   

   CREATE PROCEDURE TestProcedure 
   (
        --�������� ���������
        @CategoryId INT,
        @ProductName VARCHAR(100),
        @Price MONEY = 0
   )
   AS
   BEGIN
        --����������, ����������� ��� ��������
        
        --��������� �������� ����������
        --�������� ������ �������� � ������ � � ����� ��������� ������
        SET @ProductName = LTRIM(RTRIM(@ProductName));
        
        --��������� ����� ������
        INSERT INTO TestTable(CategoryId, ProductName, Price)
                VALUES (@CategoryId, @ProductName, @Price)

        --���������� ������
        SELECT * FROM TestTable
        WHERE CategoryId = @CategoryId
   END
  --***************************
   
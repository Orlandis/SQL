EXEC SP_Dynamic_Pivot @TableSRC = 'TestTable',  --Таблица источник (Представление)
                                          @ColumnName = 'YearSales',--Столбец, содержащий значения для столбцов в PIVOT
                                          @Field = 'Summa',         --Столбец, над которым проводить агрегацию
                                          @FieldRows = 'CategoryName',--Столбец для группировки по строкам
                                          @FunctionType = 'SUM'     --Агрегатная функция, по умолчанию SUM
										  
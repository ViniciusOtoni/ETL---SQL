CREATE TABLE raw.SalesData
(
    [Column1] INT,
    [Order ID] INT,
    [Product Category] VARCHAR(255),
    [Product] VARCHAR(255),
    [Quantity Ordered] INT,
    [Price Each] NUMERIC(10,2),
    [Order Date] DATETIME,
    [Purchase Address] VARCHAR(255),
    [Month] INT,
    [Sales] NUMERIC(10,2),
    [City] VARCHAR(255),
    [Hour] INT,
    [Time of Day] VARCHAR(255)
)


IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'SalesDataProcessed' AND schema_id = SCHEMA_ID('processed'))
BEGIN
    CREATE TABLE processed.SalesDataProcessed (
        id INT IDENTITY(1,1) PRIMARY KEY,
        ProductCategory VARCHAR(255),
        Product VARCHAR(255),
        QuantityOrdered INT,
        PriceEach DECIMAL(15, 4),
        OrderDate DATETIME,
        [Month] INT,
        Sales DECIMAL(15, 4),
        City VARCHAR(255),
        [Hour] INT, 
        TimeOfDay VARCHAR(50),
        TotalSalesCategory DECIMAL(15, 4),
        TotalSalesCategoryMonthly DECIMAL(15, 4),
        TotalQuantityCategory BIGINT,
        TotalQuantityCategoryMonthly BIGINT,
        TotalSalesMonthly DECIMAL(15, 4),
        TotalQuantityMonthly BIGINT,
        TotalSalesCity DECIMAL(15, 4),
        AverageSalesCity DECIMAL(15, 4),
        TotalSales DECIMAL(15, 4)
    );
END
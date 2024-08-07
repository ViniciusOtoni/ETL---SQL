CREATE TABLE IF NOT EXISTS raw.SalesData (
    Index INT,  
    OrderID INT,
    ProductCategory VARCHAR(255),
    Product VARCHAR(255),
    QuantityOrdered INT,
    PriceEach DECIMAL(10, 2),
    OrderDate TIMESTAMP,
    PurchaseAddress VARCHAR(255),
    Month INT,
    Sales DECIMAL(10, 2),
    City VARCHAR(255),
    Hour INT, 
    TimeOfDay VARCHAR(50) 
);



CREATE TABLE IF NOT EXISTS processed.SalesDataProcessed (
    id SERIAL PRIMARY KEY,
    ProductCategory VARCHAR(255),
    Product VARCHAR(255),
    QuantityOrdered INT,
    PriceEach DECIMAL(10, 2),
    OrderDate TIMESTAMP,
    "Month" INT,
    Sales DECIMAL(10, 2),
    City VARCHAR(255),
    "Hour" INT, 
    TimeOfDay VARCHAR(50),
	TotalSalesCategory DECIMAL(10, 2),
	TotalSalesCategoryMonthly DECIMAL(10, 2),
	TotalQuantityCategory BIGINT,
	TotalQunatityCategoryMonthly BIGINT,
	TotalSalesMonthly DECIMAL(10, 2),
	TotalQuantityMonthly BIGINT,
	TotalSalesCity DECIMAL(10, 2),
	AverageSalesCity DECIMAL(10, 2),
	TotalSales DECIMAL(10, 2)
);
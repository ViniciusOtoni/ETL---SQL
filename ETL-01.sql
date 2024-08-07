-- SELECT * FROM raw.SalesData

WITH rename_columns AS (
    SELECT "Column1" AS Index_column,
           "Order ID" AS Order_ID,
           "Product Category" AS Product_category,
           "Product",
           "Quantity Ordered" AS Quantity_ordered,
           "Price Each" AS Price_each,
           "Order Date" AS Order_date,
           "Purchase Address" AS Purchase_address,
           "Month",
           "Sales",
           "City",
           "Hour",
           "Time of Day" AS Time_of_day
    FROM raw.SalesData
), 
cleaned_data AS (
    SELECT Order_ID,
           Product_category,
           "Product",
           COALESCE(Quantity_ordered, 0) AS Quantity_ordered,
           COALESCE(Price_each, 0.00) AS Price_each,
           Order_date,
           COALESCE(Purchase_address, 'Unknown') AS Purchase_address,
           "Month",
           "Sales",
           "City",
           "Hour",
           Time_of_day
    FROM rename_columns
),
category_summary AS (
    SELECT Order_ID,
			Product_category,
			"Product",
			Quantity_ordered,
			Price_each,
			Order_date,
			Purchase_address,
			"Month",
			"Sales",
            "City",
            "Hour",
			Time_of_day,
           	SUM("Sales") OVER(PARTITION BY Product_category) AS Total_Sales_Category,
			SUM("Sales") OVER(PARTITION BY Product_category, "Month")  AS Total_Sales_Category_Monthly, 
			SUM(Quantity_ordered) OVER(PARTITION BY Product_category)  AS Total_Quantity_Category,
			SUM(Quantity_ordered) OVER(PARTITION BY Product_category, "Month")  AS Total_Quantity_Category_Monthly,
           	SUM("Sales") OVER() AS Total_Sales
    FROM cleaned_data
),
monthly_summary AS (
    SELECT Order_ID,
			Product_category,
			"Product",
			Quantity_ordered,
			Price_each,
			Order_date,
			Purchase_address,
			"Month",
			"Sales",
            "City",
            "Hour",
			Time_of_day,
			Total_Sales_Category,
			Total_Sales_Category_Monthly,
			Total_Quantity_Category,
			Total_Quantity_Category_Monthly,
           	SUM("Sales") OVER(PARTITION BY "Month") AS Total_Sales_Monthly,
			SUM(Quantity_ordered) OVER(PARTITION BY "Month")  AS Total_Quantity_Monthly,
           	Total_Sales
    FROM category_summary
),
city_sales_summary AS (
    SELECT Order_ID,
			Product_category,
			"Product",
			Quantity_ordered,
			Price_each,
			Order_date,
			Purchase_address,
			"Month",
			"Sales",
            "City",
            "Hour",
			Time_of_day,
			Total_Sales_Category,
			Total_Sales_Category_Monthly,
			Total_Quantity_Category,
			Total_Quantity_Category_Monthly,
           	Total_Sales_Monthly,
			Total_Quantity_Monthly,
			SUM("Sales") OVER(PARTITION BY "City") AS Total_Sales_City,
			AVG("Sales") OVER() AS Average_Sales_City,
           	Total_Sales
    FROM monthly_summary
)
	
 -- SELECT * FROM city_sales_summary


INSERT INTO processed.SalesDataProcessed (ProductCategory, Product, QuantityOrdered, PriceEach, OrderDate, 
	"Month",Sales,City,"Hour",TimeOfDay,TotalSalesCategory,TotalSalesCategoryMonthly,TotalQuantityCategory,
	TotalQunatityCategoryMonthly, TotalSalesMonthly, TotalQuantityMonthly, TotalSalesCity, AverageSalesCity, TotalSales)
SELECT
			Product_category,
			"Product",
			Quantity_ordered,
			Price_each,
			Order_date,
			"Month",
			"Sales",
            "City",
            "Hour",
			Time_of_day,
			Total_Sales_Category,
			Total_Sales_Category_Monthly,
			Total_Quantity_Category,
			Total_Quantity_Category_Monthly,
           	Total_Sales_Monthly,
			Total_Quantity_Monthly,
			Total_Sales_City,
			Average_Sales_City,
           	Total_Sales
FROM city_sales_summary

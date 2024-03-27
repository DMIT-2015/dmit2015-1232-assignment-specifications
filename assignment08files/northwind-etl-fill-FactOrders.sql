insert into FactOrders
    (OrderID, CustomerKey, EmployeeKey, ProductKey, OrderDateKey, RequiredDateKey, ShippedDateKey, PriceOnOrder, QuantityOnOrder)
SELECT
    Orders.OrderID
     , DimCustomers.CustomerKey
     , DimEmployees.EmployeeKey
     , DimProducts.ProductKey
     , OrderDateKey = OrderDate.DateKey
     , RequiredDateKey =  RequiredDate.DateKey
     , ShippedDateKey =  ShippedDate.DateKey
     , [PriceOnOrder] = Sum([Order Details].UnitPrice)
     , [QuantityOnOrder] = Sum([Order Details].Quantity)
FROM Northwind.Dbo.[Order Details]
         INNER JOIN Northwind.Dbo.Orders
                    ON Northwind.Dbo.[Order Details].OrderID = Northwind.Dbo.Orders.OrderID
         INNER JOIN dbo.DimCustomers
                    ON dbo.DimCustomers.CustomerID = Northwind.Dbo.Orders.CustomerID
         INNER JOIN dbo.DimEmployees
                    ON dbo.DimEmployees.EmployeeID = Northwind.Dbo.Orders.EmployeeID
         INNER JOIN dbo.DimProducts
                    ON dbo.DimProducts.ProductID = Northwind.Dbo.[Order Details].ProductID
         INNER JOIN dbo.DimDates AS OrderDate
                    ON  OrderDate.[Date] = IsNull(Northwind.Dbo.[Orders].OrderDate, '1900-01-01 00:00:00.000')
         INNER JOIN dbo.DimDates AS RequiredDate
                    ON  RequiredDate.[Date] = IsNull(Northwind.Dbo.[Orders].RequiredDate, '1900-01-01 00:00:00.000')
         INNER JOIN dbo.DimDates AS ShippedDate
                    ON  ShippedDate.[Date] = IsNull(Northwind.Dbo.[Orders].ShippedDate, '1900-01-01 00:00:00.000')
GROUP BY
    Orders.OrderID
       , DimCustomers.CustomerKey
       , DimEmployees.EmployeeKey
       , DimProducts.ProductKey
       , OrderDate.DateKey
       , RequiredDate.DateKey
       , ShippedDate.DateKey
